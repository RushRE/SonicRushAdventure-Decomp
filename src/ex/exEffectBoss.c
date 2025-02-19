#include <ex/effects/exBossHitEffect.h>
#include <ex/effects/exBossFireballShotEffect.h>
#include <ex/effects/exBossFireballEffect.h>
#include <ex/effects/exBossHomingEffect.h>
#include <ex/effects/exBossShotEffect.h>
#include <ex/effects/exBossFireEffect.h>
#include <ex/boss/exBossHelpers.h>
#include <ex/system/exSystem.h>
#include <game/file/binaryBundle.h>
#include <game/audio/audioSystem.h>

// Resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// VARIABLES
// --------------------

struct TEMP_STATIC_VARS
{
    s16 exBossEffectHomingTask__ActiveInstanceCount;
    s16 exBossEffectFireTask__ActiveInstanceCount;
    s16 exBossEffectShotTask__ActiveInstanceCount;
    s16 exBossEffectHitTask__ActiveInstanceCount;
    s16 exBossEffectFireBallTask__ActiveInstanceCount;
    s16 exBossEffectFireBallShotTask__ActiveInstanceCount;

    void *exBossEffectHitTask__unk_2175FD0;
    void *exBossEffectHitTask__unk_2175FD4;
    void *exBossEffectFireBallShotTask__unk_2175FD8;
    void *exBossEffectHitTask__unk_2175FDC;
    void *exBossEffectShotTask__dword_2175FE0;
    void *exBossEffectShotTask__unk_2175FE4;
    void *exBossEffectFireTask__TaskSingleton;
    void *exBossEffectFireTask__unk_2175FEC;
    void *exBossEffectFireTask__unk_2175FF0;
    void *exBossEffectFireBallTask__dword_2175FF4;
    void *exBossEffectFireTask__Ptr_2175FF8;
    void *exBossEffectFireTask__unk_2175FFC;
    void *exBossEffectHitTask__unk_2176000;
    void *exBossEffectShotTask__unk_2176004;
    void *exBossEffectShotTask__TaskSingleton;
    void *exBossEffectShotTask__unk_217600C;
    void *exBossEffectFireBallShotTask__unk_2176010;
    void *exBossEffectShotTask__unk_2176014;
    void *exBossEffectShotTask__unk_2176018;
    void *exBossEffectShotTask__dword_217601C;
    void *exBossEffectHitTask__dword_2176020;
    void *exBossEffectHomingTask__unk_2176024;
    void *exBossEffectHomingTask__TaskSingleton;
    void *exBossEffectHomingTask__unk_217602C;
    void *exBossEffectHomingTask__dword_2176030;
    void *exBossEffectHomingTask__unk_2176034;
    void *exBossEffectHomingTask__unk_2176038;
    void *exBossEffectHomingTask__unk_217603C;
    void *exBossEffectHomingTask__dword_2176040;
    void *exBossEffectHomingTask__unk_2176044;
    void *exBossEffectFireBallTask__TaskSingleton;
    void *exBossEffectFireBallTask__unk_217604C;
    void *exBossEffectFireTask__Value_2176050;
    void *exBossEffectHitTask__dword_2176054;
    void *exBossEffectFireBallTask__unk_2176058;
    void *exBossEffectFireBallTask__Ptr_217605C;
    void *exBossEffectHitTask__TaskSingleton;
    void *exBossEffectFireBallTask__unk_2176064;
    void *exBossEffectFireBallShotTask__TaskSingleton;
    void *exBossEffectFireBallShotTask__unk_217606C;
    void *exBossEffectFireBallShotTask__unk_2176070;
    void *exBossEffectFireBallShotTask__unk_2176074;

    void *exBossEffectFireBallShotTask__FileTable[2];
    void *exBossEffectHitTask__FileTable[2];
    void *exBossEffectShotTask__AnimTable[2];
    void *exBossEffectShotTask__FileTable[2];
    void *exBossEffectFireBallShotTask__AnimTable[2];
    void *exBossEffectHitTask__AnimTable[2];
    void *exBossEffectHomingTask__FileTable[4];
    void *exBossEffectFireTask__AnimTable[4];
    void *exBossEffectFireBallTask__AnimTable[4];
    void *exBossEffectFireTask__FileTable[4];
    void *exBossEffectFireBallTask__FileTable[4];
    void *exBossEffectHomingTask__AnimTable[4];
};

NOT_DECOMPILED s16 exBossEffectHomingTask__ActiveInstanceCount;
NOT_DECOMPILED s16 exBossEffectFireTask__ActiveInstanceCount;
NOT_DECOMPILED s16 exBossEffectShotTask__ActiveInstanceCount;
NOT_DECOMPILED s16 exBossEffectHitTask__ActiveInstanceCount;
NOT_DECOMPILED s16 exBossEffectFireBallTask__ActiveInstanceCount;
NOT_DECOMPILED s16 exBossEffectFireBallShotTask__ActiveInstanceCount;

NOT_DECOMPILED void *exBossEffectHitTask__unk_2175FD0;
NOT_DECOMPILED void *exBossEffectHitTask__unk_2175FD4;
NOT_DECOMPILED void *exBossEffectFireBallShotTask__unk_2175FD8;
NOT_DECOMPILED void *exBossEffectHitTask__unk_2175FDC;
NOT_DECOMPILED void *exBossEffectShotTask__dword_2175FE0;
NOT_DECOMPILED void *exBossEffectShotTask__unk_2175FE4;
NOT_DECOMPILED void *exBossEffectFireTask__TaskSingleton;
NOT_DECOMPILED void *exBossEffectFireTask__unk_2175FEC;
NOT_DECOMPILED void *exBossEffectFireTask__unk_2175FF0;
NOT_DECOMPILED void *exBossEffectFireBallTask__dword_2175FF4;
NOT_DECOMPILED void *exBossEffectFireTask__Ptr_2175FF8;
NOT_DECOMPILED void *exBossEffectFireTask__unk_2175FFC;
NOT_DECOMPILED void *exBossEffectHitTask__unk_2176000;
NOT_DECOMPILED void *exBossEffectShotTask__unk_2176004;
NOT_DECOMPILED void *exBossEffectShotTask__TaskSingleton;
NOT_DECOMPILED void *exBossEffectShotTask__unk_217600C;
NOT_DECOMPILED void *exBossEffectFireBallShotTask__unk_2176010;
NOT_DECOMPILED void *exBossEffectShotTask__unk_2176014;
NOT_DECOMPILED void *exBossEffectShotTask__unk_2176018;
NOT_DECOMPILED void *exBossEffectShotTask__dword_217601C;
NOT_DECOMPILED void *exBossEffectHitTask__dword_2176020;
NOT_DECOMPILED void *exBossEffectHomingTask__unk_2176024;
NOT_DECOMPILED void *exBossEffectHomingTask__TaskSingleton;
NOT_DECOMPILED void *exBossEffectHomingTask__unk_217602C;
NOT_DECOMPILED void *exBossEffectHomingTask__dword_2176030;
NOT_DECOMPILED void *exBossEffectHomingTask__unk_2176034;
NOT_DECOMPILED void *exBossEffectHomingTask__unk_2176038;
NOT_DECOMPILED void *exBossEffectHomingTask__unk_217603C;
NOT_DECOMPILED void *exBossEffectHomingTask__dword_2176040;
NOT_DECOMPILED void *exBossEffectHomingTask__unk_2176044;
NOT_DECOMPILED void *exBossEffectFireBallTask__TaskSingleton;
NOT_DECOMPILED void *exBossEffectFireBallTask__unk_217604C;
NOT_DECOMPILED void *exBossEffectFireTask__Value_2176050;
NOT_DECOMPILED void *exBossEffectHitTask__dword_2176054;
NOT_DECOMPILED void *exBossEffectFireBallTask__unk_2176058;
NOT_DECOMPILED void *exBossEffectFireBallTask__Ptr_217605C;
NOT_DECOMPILED void *exBossEffectHitTask__TaskSingleton;
NOT_DECOMPILED void *exBossEffectFireBallTask__unk_2176064;
NOT_DECOMPILED void *exBossEffectFireBallShotTask__TaskSingleton;
NOT_DECOMPILED void *exBossEffectFireBallShotTask__unk_217606C;
NOT_DECOMPILED void *exBossEffectFireBallShotTask__unk_2176070;
NOT_DECOMPILED void *exBossEffectFireBallShotTask__unk_2176074;

NOT_DECOMPILED void *exBossEffectFireBallShotTask__FileTable[2];
NOT_DECOMPILED void *exBossEffectHitTask__FileTable[2];
NOT_DECOMPILED void *exBossEffectShotTask__AnimTable[2];
NOT_DECOMPILED void *exBossEffectShotTask__FileTable[2];
NOT_DECOMPILED void *exBossEffectFireBallShotTask__AnimTable[2];
NOT_DECOMPILED void *exBossEffectHitTask__AnimTable[2];
NOT_DECOMPILED void *exBossEffectHomingTask__FileTable[4];
NOT_DECOMPILED void *exBossEffectFireTask__AnimTable[4];
NOT_DECOMPILED void *exBossEffectFireBallTask__AnimTable[4];
NOT_DECOMPILED void *exBossEffectFireTask__FileTable[4];
NOT_DECOMPILED void *exBossEffectFireBallTask__FileTable[4];
NOT_DECOMPILED void *exBossEffectHomingTask__AnimTable[4];

NOT_DECOMPILED void *aExtraExBb_2;
NOT_DECOMPILED void *aExbosseffecthi;
NOT_DECOMPILED void *aExbosseffectfi_0;
NOT_DECOMPILED void *aExbosseffectfi_1;
NOT_DECOMPILED void *aExbosseffectho;
NOT_DECOMPILED void *aExbosseffectsh;
NOT_DECOMPILED void *aExbosseffectfi;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC void exBossEffectHitTask__LoadAssets(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r4, r0
	str r4, [r1, #0x10]
	ldr r0, [r1, #0x5c]
	cmp r0, #0
	ldrne r0, [r1, #0x3c]
	cmpne r0, #0
	beq _02155CA4
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x5c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x3c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x5c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02155CA4:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldrsh r0, [r0, #6]
	cmp r0, #0
	bne _02155D38
	mov r1, #0x21
	ldr r0, =aExtraExBb_2
	sub r2, r1, #0x22
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r0, r0, lsr #8
	str r0, [r1, #0x5c]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, =exBossEffectHomingTask__ActiveInstanceCount
	mov r0, r5
	str r1, [r2, #0x90]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x57
	bl LoadExSystemFile
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #0
	str r0, [r1, #0xbc]
	mov r0, #0x58
	str r2, [r1, #0xdc]
	bl LoadExSystemFile
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #3
	str r0, [r1, #0xc0]
	str r2, [r1, #0xe0]
	ldr r0, [r1, #0x90]
	bl Asset3DSetup__Create
_02155D38:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	str r2, [sp]
	ldr r1, [r0, #0x90]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, =exBossEffectHitTask__AnimTable
	ldr r5, =exBossEffectHitTask__FileTable
	mov r7, r8
_02155D70:
	str r7, [sp]
	ldr r1, [r6, r8, lsl #2]
	ldr r2, [r5, r8, lsl #2]
	mov r3, r7
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #2
	blo _02155D70
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	add r0, r4, #0x300
	ldr r2, [r1, #0xdc]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0xdc]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_02155DC4:
	mov r0, r2, lsl r3
	tst r0, #9
	beq _02155DE4
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_02155DE4:
	add r3, r3, #1
	cmp r3, #5
	blo _02155DC4
	mov r3, #0
	str r3, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r2, =0x0000BFF4
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	strb r3, [r4]
	ldrb r2, [r4, #4]
	add r0, r4, #0x350
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	orr r2, r2, #0x40
	strb r2, [r4, #4]
	str r3, [r4, #0xc]
	str r3, [r4, #0x10]
	str r3, [r4, #0x14]
	str r0, [r4, #0x18]
	ldrsh r2, [r1, #6]
	mov r0, #1
	add r2, r2, #1
	strh r2, [r1, #6]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectHitTask__Destroy_2155E74(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r4, r0
	ldrsh r0, [r1, #6]
	cmp r0, #1
	bgt _02155EE4
	ldr r0, [r1, #0x90]
	cmp r0, #0
	beq _02155E9C
	bl NNS_G3dResDefaultRelease
_02155E9C:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0xbc]
	cmp r0, #0
	beq _02155EB0
	bl NNS_G3dResDefaultRelease
_02155EB0:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0xc0]
	cmp r0, #0
	beq _02155EC4
	bl NNS_G3dResDefaultRelease
_02155EC4:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x90]
	cmp r0, #0
	beq _02155ED8
	bl _FreeHEAP_USER
_02155ED8:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x90]
_02155EE4:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldrsh r1, [r0, #6]
	sub r1, r1, #1
	strh r1, [r0, #6]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectHitTask__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	str r0, [r1, #0x9c]
	add r0, r4, #4
	bl exBossEffectHitTask__LoadAssets
	add r0, r4, #0x390
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x390
	bl exDrawReqTask__Func_21641F0
	ldr r1, [r4, #0x4e0]
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r2, [r1, #0x3c8]
	mov r1, #1
	str r2, [r4, #0x354]
	ldr r2, [r4, #0x4e0]
	ldr r2, [r2, #0x3cc]
	str r2, [r4, #0x358]
	ldr r2, [r4, #0x4e0]
	ldr r2, [r2, #0x3d0]
	str r2, [r4, #0x35c]
	str r1, [r0, #0x18]
	bl GetExTaskCurrent
	ldr r1, =exBossEffectHitTask__Main_2155FE4
	str r1, [r0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectHitTask__Func8(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	beq _02155FA0
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
_02155FA0:
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	ldmneia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectHitTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #4
	bl exBossEffectHitTask__Destroy_2155E74
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x9c]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectHitTask__Main_2155FE4(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	bl GetExBossTask
	cmp r0, #0
	bne _02156014
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02156014:
	add r0, r4, #4
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02156034
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02156034:
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

NONMATCH_FUNC void exBossEffectHitTask__Create(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, =0x000004E4
	str r4, [sp]
	ldr r0, =aExbosseffecthi
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =exBossEffectHitTask__Main
	ldr r1, =exBossEffectHitTask__Destructor
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, =0x000004E4
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	bl GetExBossTask
	bl GetExTaskWork_
	str r0, [r4, #0x4e0]
	mov r0, r5
	bl GetExTask
	ldr r1, =exBossEffectHitTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

// exBossEffectFireBallShot
NONMATCH_FUNC void exBossEffectFireBallShotTask__Func_21560E0(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r4, r0
	str r4, [r1, #0x14]
	ldr r0, [r1, #0x4c]
	cmp r0, #0
	ldrne r0, [r1, #0xa8]
	cmpne r0, #0
	beq _0215615C
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x4c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0xa8]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x4c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_0215615C:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldrsh r0, [r0, #0xa]
	cmp r0, #0
	bne _021561F0
	mov r1, #0x20
	ldr r0, =aExtraExBb_2
	sub r2, r1, #0x21
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r0, r0, lsr #8
	str r0, [r1, #0x4c]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, =exBossEffectHomingTask__ActiveInstanceCount
	mov r0, r5
	str r1, [r2, #0xac]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x55
	bl LoadExSystemFile
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #0
	str r0, [r1, #0xb4]
	mov r0, #0x56
	str r2, [r1, #0xd4]
	bl LoadExSystemFile
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #4
	str r0, [r1, #0xb8]
	str r2, [r1, #0xd8]
	ldr r0, [r1, #0xac]
	bl Asset3DSetup__Create
_021561F0:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	str r2, [sp]
	ldr r1, [r0, #0xac]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, =exBossEffectFireBallShotTask__AnimTable
	ldr r5, =exBossEffectFireBallShotTask__FileTable
	mov r7, r8
_02156228:
	str r7, [sp]
	ldr r1, [r6, r8, lsl #2]
	ldr r2, [r5, r8, lsl #2]
	mov r3, r7
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #2
	blo _02156228
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	add r0, r4, #0x300
	ldr r2, [r1, #0xd4]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0xd4]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_0215627C:
	mov r0, r2, lsl r3
	tst r0, #0x11
	beq _0215629C
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0215629C:
	add r3, r3, #1
	cmp r3, #5
	blo _0215627C
	mov r0, #0
	str r0, [r4, #0x358]
	mov ip, #0x1000
	str ip, [r4, #0x368]
	str ip, [r4, #0x36c]
	ldr r2, =0x0000BFF4
	str ip, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r0, #1
	strb r0, [r4]
	ldrb r3, [r4, #1]
	add r2, r4, #0x350
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	orr r3, r3, #0x10
	strb r3, [r4, #1]
	str ip, [r4, #0xc]
	str ip, [r4, #0x10]
	str ip, [r4, #0x14]
	str r2, [r4, #0x18]
	ldrsh r2, [r1, #0xa]
	add r2, r2, #1
	strh r2, [r1, #0xa]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireBallShotTask__Func_215632C(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r4, r0
	ldrsh r0, [r1, #0xa]
	cmp r0, #1
	bgt _0215639C
	ldr r0, [r1, #0xac]
	cmp r0, #0
	beq _02156354
	bl NNS_G3dResDefaultRelease
_02156354:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0xb4]
	cmp r0, #0
	beq _02156368
	bl NNS_G3dResDefaultRelease
_02156368:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0xb8]
	cmp r0, #0
	beq _0215637C
	bl NNS_G3dResDefaultRelease
_0215637C:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0xac]
	cmp r0, #0
	beq _02156390
	bl _FreeHEAP_USER
_02156390:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0xac]
_0215639C:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldrsh r1, [r0, #0xa]
	sub r1, r1, #1
	strh r1, [r0, #0xa]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireBallShotTask__Main(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	str r0, [r1, #0xa4]
	add r0, r4, #4
	bl exBossEffectFireBallShotTask__Func_21560E0
	add r0, r4, #0x390
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x390
	bl exDrawReqTask__Func_21641F0
	ldr r1, [r4, #0x4e0]
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r2, [r1, #0x3ec]
	mov r1, #1
	str r2, [r4, #0x354]
	ldr r2, [r4, #0x4e0]
	ldr r2, [r2, #0x3f0]
	str r2, [r4, #0x358]
	ldr r2, [r4, #0x4e0]
	ldr r2, [r2, #0x3f4]
	str r2, [r4, #0x35c]
	str r1, [r0, #0xa0]
	bl GetExTaskCurrent
	ldr r1, =exBossEffectFireBallShotTask__Func_215649C
	str r1, [r0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireBallShotTask__Func8(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	beq _02156458
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
_02156458:
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	ldmneia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireBallShotTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #4
	bl exBossEffectFireBallShotTask__Func_215632C
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0xa4]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireBallShotTask__Func_215649C(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	bl GetExBossTask
	cmp r0, #0
	bne _021564CC
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021564CC:
	add r0, r4, #4
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _021564EC
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021564EC:
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

NONMATCH_FUNC void exBossEffectFireBallShotTask__Create(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, =0x000004E4
	str r4, [sp]
	ldr r0, =aExbosseffectfi_0
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =exBossEffectFireBallShotTask__Main
	ldr r1, =exBossEffectFireBallShotTask__Destructor
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, =0x000004E4
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x4e0]
	mov r0, r5
	bl GetExTask
	ldr r1, =exBossEffectFireBallShotTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

// exBossEffectFireBall
NONMATCH_FUNC void exBossEffectFireBallTask__Func_2156594(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0xa0]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireBallTask__Func_21565A8(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r5, r0
	str r5, [r1, #0x94]
	ldr r0, [r1, #0x30]
	cmp r0, #0
	ldrne r0, [r1, #0x88]
	cmpne r0, #0
	beq _02156624
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x30]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x88]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x30]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02156624:
	mov r0, r5
	bl exDrawReqTask__InitModel
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldrsh r0, [r0, #8]
	cmp r0, #0
	bne _021566E8
	mov r1, #0x1f
	ldr r0, =aExtraExBb_2
	sub r2, r1, #0x20
	bl ReadFileFromBundle
	mov r4, r0
	ldr r0, [r4, #0]
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r0, r0, lsr #8
	str r0, [r1, #0x30]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, =exBossEffectHomingTask__ActiveInstanceCount
	mov r0, r4
	str r1, [r2, #0x98]
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
	mov r0, #0x51
	bl LoadExSystemFile
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #0
	str r0, [r1, #0x124]
	mov r0, #0x52
	str r2, [r1, #0x104]
	bl LoadExSystemFile
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #1
	str r0, [r1, #0x128]
	mov r0, #0x53
	str r2, [r1, #0x108]
	bl LoadExSystemFile
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #3
	str r0, [r1, #0x12c]
	mov r0, #0x54
	str r2, [r1, #0x10c]
	bl LoadExSystemFile
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #2
	str r0, [r1, #0x130]
	str r2, [r1, #0x110]
	ldr r0, [r1, #0x98]
	bl Asset3DSetup__Create
_021566E8:
	add r0, r5, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	str r2, [sp]
	ldr r1, [r0, #0x98]
	mov r3, r2
	add r0, r5, #0x20
	bl AnimatorMDL__SetResource
	mov r4, #0
	ldr r7, =exBossEffectFireBallTask__AnimTable
	ldr r6, =exBossEffectFireBallTask__FileTable
	mov r8, r4
_02156720:
	str r8, [sp]
	ldr r1, [r7, r4, lsl #2]
	ldr r2, [r6, r4, lsl #2]
	mov r3, r8
	add r0, r5, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r4, #1
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	cmp r4, #3
	blo _02156720
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x98]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r1, =exBossEffectFireBallTask__AnimTable
	ldr r0, =exBossEffectFireBallTask__FileTable
	ldr r1, [r1, r4, lsl #2]
	ldr r2, [r0, r4, lsl #2]
	add r0, r5, #0x20
	mov r3, #0
	bl AnimatorMDL__SetAnimation
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	add r0, r5, #0x300
	ldr r2, [r1, #0x104]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x104]
	mov r2, #1
	add r0, r5, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r5, #0x344]
_021567A0:
	mov r0, r2, lsl r3
	tst r0, #0xf
	beq _021567C0
	add r0, r5, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_021567C0:
	add r3, r3, #1
	cmp r3, #5
	blo _021567A0
	mov r0, #0
	str r0, [r5, #0x358]
	mov r4, #0x1000
	str r4, [r5, #0x368]
	str r4, [r5, #0x36c]
	ldr r2, =0x0000BFF4
	str r4, [r5, #0x370]
	add r0, r5, #0x300
	ldr r1, =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r0, #1
	strb r0, [r5]
	ldrb r3, [r5, #1]
	add r2, r5, #0x350
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	orr r3, r3, #0x20
	strb r3, [r5, #1]
	str r4, [r5, #0xc]
	str r4, [r5, #0x10]
	str r4, [r5, #0x14]
	str r2, [r5, #0x18]
	ldrsh r2, [r1, #8]
	add r2, r2, #1
	strh r2, [r1, #8]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireBallTask__Func_2156850(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r7, #0
	ldr r5, =exBossEffectFireBallTask__AnimTable
	ldr r4, =exBossEffectFireBallTask__FileTable
	mov r9, r0
	mov r8, r1
	mov r6, r7
_0215686C:
	str r6, [sp]
	ldr r1, [r5, r7, lsl #2]
	ldr r2, [r4, r7, lsl #2]
	mov r3, r8
	add r0, r9, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #3
	blo _0215686C
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x98]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r1, =exBossEffectFireBallTask__AnimTable
	ldr r0, =exBossEffectFireBallTask__FileTable
	ldr r1, [r1, r7, lsl #2]
	ldr r2, [r0, r7, lsl #2]
	mov r3, r8
	add r0, r9, #0x20
	bl AnimatorMDL__SetAnimation
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	add r0, r9, #0x300
	ldr r2, [r1, #0x104]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x104]
	mov r2, #1
	add r0, r9, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r9, #0x344]
_021568EC:
	mov r0, r2, lsl r3
	tst r0, #0xf
	beq _0215690C
	add r0, r9, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0215690C:
	add r3, r3, #1
	cmp r3, #5
	blo _021568EC
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireBallTask__Destroy_2156928(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r4, r0
	ldrsh r0, [r1, #8]
	cmp r0, #1
	bgt _021569C0
	ldr r0, [r1, #0x98]
	cmp r0, #0
	beq _02156950
	bl NNS_G3dResDefaultRelease
_02156950:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x124]
	cmp r0, #0
	beq _02156964
	bl NNS_G3dResDefaultRelease
_02156964:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x128]
	cmp r0, #0
	beq _02156978
	bl NNS_G3dResDefaultRelease
_02156978:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x12c]
	cmp r0, #0
	beq _0215698C
	bl NNS_G3dResDefaultRelease
_0215698C:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x130]
	cmp r0, #0
	beq _021569A0
	bl NNS_G3dResDefaultRelease
_021569A0:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x98]
	cmp r0, #0
	beq _021569B4
	bl _FreeHEAP_USER
_021569B4:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x98]
_021569C0:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldrsh r1, [r0, #8]
	sub r1, r1, #1
	strh r1, [r0, #8]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireBallTask__Main(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	str r0, [r1, #0x84]
	add r0, r4, #4
	bl exBossEffectFireBallTask__Func_21565A8
	add r0, r4, #0x390
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x390
	bl exDrawReqTask__Func_21641F0
	mov r2, #1
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r0, #0
	str r2, [r1, #0x80]
	str r0, [sp]
	mov r1, #0xbf
	str r1, [sp, #4]
	sub r1, r1, #0xc0
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, =exBossEffectFireBallTask__Func_2156AC4
	str r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireBallTask__Func8(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	beq _02156A80
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
_02156A80:
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	ldmneia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireBallTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #4
	bl exBossEffectFireBallTask__Destroy_2156928
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x84]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireBallTask__Func_2156AC4(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	bl GetExBossTask
	cmp r0, #0
	bne _02156AF4
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02156AF4:
	ldr r1, [r4, #0x4e0]
	add r0, r4, #4
	ldr r1, [r1, #0x3ec]
	str r1, [r4, #0x354]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f0]
	str r1, [r4, #0x358]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f4]
	str r1, [r4, #0x35c]
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02156B30
	bl exBossEffectFireBallTask__Func_2156B50
	ldmia sp!, {r4, pc}
_02156B30:
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

NONMATCH_FUNC void exBossEffectFireBallTask__Func_2156B50(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	mov r1, #1
	bl exBossEffectFireBallTask__Func_2156850
	add r0, r4, #0x390
	bl exDrawReqTask__Func_2164218
	bl GetExTaskCurrent
	ldr r1, =exBossEffectFireBallTask__Func_2156B88
	str r1, [r0]
	bl exBossEffectFireBallTask__Func_2156B88
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireBallTask__Func_2156B88(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	bl GetExBossTask
	cmp r0, #0
	bne _02156BB8
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02156BB8:
	ldr r1, [r4, #0x4e0]
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x3ec]
	str r1, [r4, #0x354]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f0]
	str r1, [r4, #0x358]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f4]
	str r1, [r4, #0x35c]
	ldr r0, [r0, #0x80]
	cmp r0, #0
	bne _02156BF4
	bl exBossEffectFireBallTask__Func_2156C18
	ldmia sp!, {r4, pc}
_02156BF4:
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

NONMATCH_FUNC void exBossEffectFireBallTask__Func_2156C18(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	mov r1, #2
	bl exBossEffectFireBallTask__Func_2156850
	add r0, r4, #0x390
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, =exBossEffectFireBallTask__Func_2156C50
	str r1, [r0]
	bl exBossEffectFireBallTask__Func_2156C50
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireBallTask__Func_2156C50(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	bl GetExBossTask
	cmp r0, #0
	bne _02156C80
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02156C80:
	ldr r1, [r4, #0x4e0]
	add r0, r4, #4
	ldr r1, [r1, #0x3ec]
	str r1, [r4, #0x354]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f0]
	str r1, [r4, #0x358]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f4]
	str r1, [r4, #0x35c]
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02156CC4
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02156CC4:
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

NONMATCH_FUNC void exBossEffectFireBallTask__Create(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, =0x000004E4
	str r4, [sp]
	ldr r0, =aExbosseffectfi_1
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =exBossEffectFireBallTask__Main
	ldr r1, =exBossEffectFireBallTask__Destructor
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, =0x000004E4
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x4e0]
	mov r0, r5
	bl GetExTask
	ldr r1, =exBossEffectFireBallTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

// exBossEffectHoming
NONMATCH_FUNC void exBossEffectHomingTask__Func_2156D6C(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x80]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectHomingTask__Func_2156D80(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r4, r0
	str r4, [r1, #0x70]
	ldr r0, [r1, #0x7c]
	cmp r0, #0
	ldrne r0, [r1, #0x68]
	cmpne r0, #0
	beq _02156DFC
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x7c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x68]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x7c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02156DFC:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldrsh r0, [r0, #0]
	cmp r0, #0
	bne _02156EC0
	mov r1, #0xe
	ldr r0, =aExtraExBb_2
	sub r2, r1, #0xf
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r0, r0, lsr #8
	str r0, [r1, #0x7c]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, =exBossEffectHomingTask__ActiveInstanceCount
	mov r0, r5
	str r1, [r2, #0x6c]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x29
	bl LoadExSystemFile
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #0
	str r0, [r1, #0xe4]
	mov r0, #0x2a
	str r2, [r1, #0x134]
	bl LoadExSystemFile
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #1
	str r0, [r1, #0xe8]
	mov r0, #0x2b
	str r2, [r1, #0x138]
	bl LoadExSystemFile
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #3
	str r0, [r1, #0xec]
	mov r0, #0x2c
	str r2, [r1, #0x13c]
	bl LoadExSystemFile
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #2
	str r0, [r1, #0xf0]
	str r2, [r1, #0x140]
	ldr r0, [r1, #0x6c]
	bl Asset3DSetup__Create
_02156EC0:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	str r2, [sp]
	ldr r1, [r0, #0x6c]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, =exBossEffectHomingTask__AnimTable
	ldr r5, =exBossEffectHomingTask__FileTable
	mov r7, r8
_02156EF8:
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
	blo _02156EF8
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x6c]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r2, =exBossEffectHomingTask__ActiveInstanceCount
	add r0, r4, #0x20
	ldr r1, [r2, #0x140]
	ldr r2, [r2, #0xf0]
	mov r3, #0
	bl AnimatorMDL__SetAnimation
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	add r0, r4, #0x300
	ldr r2, [r1, #0x134]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x134]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_02156F74:
	mov r0, r2, lsl r3
	tst r0, #0xf
	beq _02156F94
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_02156F94:
	add r3, r3, #1
	cmp r3, #5
	blo _02156F74
	mov r0, #0
	str r0, [r4, #0x358]
	mov ip, #0x1000
	str ip, [r4, #0x368]
	str ip, [r4, #0x36c]
	ldr r2, =0x0000BFF4
	str ip, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r0, #1
	strb r0, [r4]
	ldrb r3, [r4, #1]
	add r2, r4, #0x350
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	orr r3, r3, #8
	strb r3, [r4, #1]
	str ip, [r4, #0xc]
	str ip, [r4, #0x10]
	str ip, [r4, #0x14]
	str r2, [r4, #0x18]
	ldrsh r2, [r1, #0]
	add r2, r2, #1
	strh r2, [r1]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectHomingTask__Func_2157024(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r9, #0
	ldr r7, =exBossEffectHomingTask__AnimTable
	ldr r6, =exBossEffectHomingTask__FileTable
	mov r5, r0
	mov r4, r1
	mov r8, r9
_02157040:
	str r8, [sp]
	ldr r1, [r7, r9, lsl #2]
	ldr r2, [r6, r9, lsl #2]
	mov r3, r4
	add r0, r5, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #3
	blo _02157040
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x6c]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	mov r3, r4
	ldr r1, [r0, #0x140]
	ldr r2, [r0, #0xf0]
	add r0, r5, #0x20
	bl AnimatorMDL__SetAnimation
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	add r0, r5, #0x300
	ldr r2, [r1, #0x134]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x134]
	mov r2, #1
	add r0, r5, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r5, #0x344]
_021570BC:
	mov r0, r2, lsl r3
	tst r0, #0xf
	beq _021570DC
	add r0, r5, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_021570DC:
	add r3, r3, #1
	cmp r3, #5
	blo _021570BC
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectHomingTask__Destroy_21570F8(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r4, r0
	ldrsh r0, [r1, #0]
	cmp r0, #1
	bgt _02157190
	ldr r0, [r1, #0x6c]
	cmp r0, #0
	beq _02157120
	bl NNS_G3dResDefaultRelease
_02157120:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0xe4]
	cmp r0, #0
	beq _02157134
	bl NNS_G3dResDefaultRelease
_02157134:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0xe8]
	cmp r0, #0
	beq _02157148
	bl NNS_G3dResDefaultRelease
_02157148:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0xec]
	cmp r0, #0
	beq _0215715C
	bl NNS_G3dResDefaultRelease
_0215715C:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0xf0]
	cmp r0, #0
	beq _02157170
	bl NNS_G3dResDefaultRelease
_02157170:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x6c]
	cmp r0, #0
	beq _02157184
	bl _FreeHEAP_USER
_02157184:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x6c]
_02157190:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldrsh r1, [r0, #0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectHomingTask__Main(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	str r0, [r1, #0x64]
	add r0, r4, #4
	bl exBossEffectHomingTask__Func_2156D80
	add r0, r4, #0x390
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x390
	bl exDrawReqTask__Func_21641F0
	mov r2, #1
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r0, #0
	str r2, [r1, #0x60]
	str r0, [sp]
	mov r1, #0xc4
	str r1, [sp, #4]
	sub r1, r1, #0xc5
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, =exBossEffectHomingTask__Func_2157294
	str r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectHomingTask__Func8(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	beq _02157250
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
_02157250:
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	ldmneia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectHomingTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #4
	bl exBossEffectHomingTask__Destroy_21570F8
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x64]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectHomingTask__Func_2157294(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	bl GetExBossTask
	cmp r0, #0
	bne _021572C4
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021572C4:
	ldr r1, [r4, #0x4e0]
	add r0, r4, #4
	ldr r1, [r1, #0x3ec]
	str r1, [r4, #0x354]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f0]
	str r1, [r4, #0x358]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f4]
	str r1, [r4, #0x35c]
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02157300
	bl exBossEffectHomingTask__Func_2157320
	ldmia sp!, {r4, pc}
_02157300:
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

NONMATCH_FUNC void exBossEffectHomingTask__Func_2157320(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	mov r1, #1
	bl exBossEffectHomingTask__Func_2157024
	add r0, r4, #0x390
	bl exDrawReqTask__Func_2164218
	bl GetExTaskCurrent
	ldr r1, =exBossEffectHomingTask__Func_2157358
	str r1, [r0]
	bl exBossEffectHomingTask__Func_2157358
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectHomingTask__Func_2157358(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	bl GetExBossTask
	cmp r0, #0
	bne _02157388
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02157388:
	ldr r1, [r4, #0x4e0]
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x3ec]
	str r1, [r4, #0x354]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f0]
	str r1, [r4, #0x358]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f4]
	str r1, [r4, #0x35c]
	ldr r0, [r0, #0x60]
	cmp r0, #0
	bne _021573C4
	bl exBossEffectHomingTask__Func_21573E8
	ldmia sp!, {r4, pc}
_021573C4:
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

NONMATCH_FUNC void exBossEffectHomingTask__Func_21573E8(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	mov r1, #2
	bl exBossEffectHomingTask__Func_2157024
	add r0, r4, #0x390
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, =exBossEffectHomingTask__Func_2157420
	str r1, [r0]
	bl exBossEffectHomingTask__Func_2157420
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectHomingTask__Func_2157420(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	bl GetExBossTask
	cmp r0, #0
	bne _02157450
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02157450:
	ldr r1, [r4, #0x4e0]
	add r0, r4, #4
	ldr r1, [r1, #0x3ec]
	str r1, [r4, #0x354]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f0]
	str r1, [r4, #0x358]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f4]
	str r1, [r4, #0x35c]
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02157494
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02157494:
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

NONMATCH_FUNC void exBossEffectHomingTask__Create(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, =0x000004E4
	str r4, [sp]
	ldr r0, =aExbosseffectho
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =exBossEffectHomingTask__Main
	ldr r1, =exBossEffectHomingTask__Destructor
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, =0x000004E4
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x4e0]
	mov r0, r5
	bl GetExTask
	ldr r1, =exBossEffectHomingTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

// exBossEffectShot
NONMATCH_FUNC void exBossEffectShotTask__Func_215753C(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x60]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectShotTask__Func_2157550(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r4, r0
	str r4, [r1, #0x54]
	ldr r0, [r1, #0x1c]
	cmp r0, #0
	ldrne r0, [r1, #0x48]
	cmpne r0, #0
	beq _021575CC
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x1c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x48]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x1c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_021575CC:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldrsh r0, [r0, #4]
	cmp r0, #0
	bne _02157660
	mov r1, #0x13
	ldr r0, =aExtraExBb_2
	sub r2, r1, #0x14
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r0, r0, lsr #8
	str r0, [r1, #0x1c]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, =exBossEffectHomingTask__ActiveInstanceCount
	mov r0, r5
	str r1, [r2, #0x58]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x39
	bl LoadExSystemFile
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #0
	str r0, [r1, #0xcc]
	mov r0, #0x3a
	str r2, [r1, #0xc4]
	bl LoadExSystemFile
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #4
	str r0, [r1, #0xd0]
	str r2, [r1, #0xc8]
	ldr r0, [r1, #0x58]
	bl Asset3DSetup__Create
_02157660:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	str r2, [sp]
	ldr r1, [r0, #0x58]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, =exBossEffectShotTask__AnimTable
	ldr r5, =exBossEffectShotTask__FileTable
	mov r7, r8
_02157698:
	str r7, [sp]
	ldr r1, [r6, r8, lsl #2]
	ldr r2, [r5, r8, lsl #2]
	mov r3, r7
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #2
	blo _02157698
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	add r0, r4, #0x300
	ldr r2, [r1, #0xc4]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0xc4]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_021576EC:
	mov r0, r2, lsl r3
	tst r0, #0x11
	beq _0215770C
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0215770C:
	add r3, r3, #1
	cmp r3, #5
	blo _021576EC
	mov r0, #0
	str r0, [r4, #0x358]
	mov ip, #0x1000
	str ip, [r4, #0x368]
	str ip, [r4, #0x36c]
	ldr r2, =0x0000BFF4
	str ip, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r0, #1
	strb r0, [r4]
	ldrb r3, [r4, #1]
	add r2, r4, #0x350
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	orr r3, r3, #4
	strb r3, [r4, #1]
	str ip, [r4, #0xc]
	str ip, [r4, #0x10]
	str ip, [r4, #0x14]
	str r2, [r4, #0x18]
	ldrsh r2, [r1, #4]
	add r2, r2, #1
	strh r2, [r1, #4]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectShotTask__Func_215779C(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r4, r0
	ldrsh r0, [r1, #4]
	cmp r0, #1
	bgt _0215780C
	ldr r0, [r1, #0x58]
	cmp r0, #0
	beq _021577C4
	bl NNS_G3dResDefaultRelease
_021577C4:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0xcc]
	cmp r0, #0
	beq _021577D8
	bl NNS_G3dResDefaultRelease
_021577D8:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0xd0]
	cmp r0, #0
	beq _021577EC
	bl NNS_G3dResDefaultRelease
_021577EC:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x58]
	cmp r0, #0
	beq _02157800
	bl _FreeHEAP_USER
_02157800:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x58]
_0215780C:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldrsh r1, [r0, #4]
	sub r1, r1, #1
	strh r1, [r0, #4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectShotTask__Main(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	str r0, [r1, #0x44]
	add r0, r4, #4
	bl exBossEffectShotTask__Func_2157550
	add r0, r4, #0x390
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x390
	bl exDrawReqTask__Func_21641F0
	ldr r1, [r4, #0x4e0]
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r2, [r1, #0x3ec]
	mov r1, #1
	str r2, [r4, #0x354]
	ldr r2, [r4, #0x4e0]
	ldr r2, [r2, #0x3f0]
	str r2, [r4, #0x358]
	ldr r2, [r4, #0x4e0]
	ldr r2, [r2, #0x3f4]
	str r2, [r4, #0x35c]
	str r1, [r0, #0x40]
	bl GetExTaskCurrent
	ldr r1, =exBossEffectShotTask__Func_215790C
	str r1, [r0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectShotTask__Func8(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	beq _021578C8
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
_021578C8:
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	ldmneia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectShotTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #4
	bl exBossEffectShotTask__Func_215779C
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x44]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectShotTask__Func_215790C(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	bl GetExBossTask
	cmp r0, #0
	bne _0215793C
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215793C:
	add r0, r4, #4
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0215795C
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215795C:
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

NONMATCH_FUNC void exBossEffectShotTask__Create(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, =0x000004E4
	str r4, [sp]
	ldr r0, =aExbosseffectsh
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =exBossEffectShotTask__Main
	ldr r1, =exBossEffectShotTask__Destructor
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, =0x000004E4
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x4e0]
	mov r0, r5
	bl GetExTask
	ldr r1, =exBossEffectShotTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

// exBossEffectShot
NONMATCH_FUNC void exBossEffectFireTask__Func_2157A04(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r4, r0
	str r4, [r1, #0x38]
	ldr r0, [r1, #0x8c]
	cmp r0, #0
	ldrne r0, [r1, #0x28]
	cmpne r0, #0
	beq _02157A80
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x8c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x28]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x8c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02157A80:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldrsh r0, [r0, #2]
	cmp r0, #0
	bne _02157B44
	mov r1, #0xd
	ldr r0, =aExtraExBb_2
	sub r2, r1, #0xe
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r0, r0, lsr #8
	str r0, [r1, #0x8c]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, =exBossEffectHomingTask__ActiveInstanceCount
	mov r0, r5
	str r1, [r2, #0x34]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x25
	bl LoadExSystemFile
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #0
	str r0, [r1, #0x114]
	mov r0, #0x26
	str r2, [r1, #0xf4]
	bl LoadExSystemFile
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #1
	str r0, [r1, #0x118]
	mov r0, #0x27
	str r2, [r1, #0xf8]
	bl LoadExSystemFile
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #3
	str r0, [r1, #0x11c]
	mov r0, #0x28
	str r2, [r1, #0xfc]
	bl LoadExSystemFile
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #2
	str r0, [r1, #0x120]
	str r2, [r1, #0x100]
	ldr r0, [r1, #0x34]
	bl Asset3DSetup__Create
_02157B44:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	str r2, [sp]
	ldr r1, [r0, #0x34]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, =exBossEffectFireTask__AnimTable
	ldr r5, =exBossEffectFireTask__FileTable
	mov r7, r8
_02157B7C:
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
	blo _02157B7C
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x34]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r2, =exBossEffectHomingTask__ActiveInstanceCount
	add r0, r4, #0x20
	ldr r1, [r2, #0x100]
	ldr r2, [r2, #0x120]
	mov r3, #0
	bl AnimatorMDL__SetAnimation
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	add r0, r4, #0x300
	ldr r2, [r1, #0xf4]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0xf4]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_02157BF8:
	mov r0, r2, lsl r3
	tst r0, #0xf
	beq _02157C18
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_02157C18:
	add r3, r3, #1
	cmp r3, #5
	blo _02157BF8
	mov r0, #0
	str r0, [r4, #0x358]
	mov ip, #0x1000
	str ip, [r4, #0x368]
	str ip, [r4, #0x36c]
	ldr r2, =0x0000BFF4
	str ip, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r0, #1
	strb r0, [r4]
	ldrb r3, [r4, #1]
	add r2, r4, #0x350
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	orr r3, r3, #2
	strb r3, [r4, #1]
	str ip, [r4, #0xc]
	str ip, [r4, #0x10]
	str ip, [r4, #0x14]
	str r2, [r4, #0x18]
	ldrsh r2, [r1, #2]
	add r2, r2, #1
	strh r2, [r1, #2]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireTask__Func_2157CA8(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r9, #0
	ldr r7, =exBossEffectFireTask__AnimTable
	ldr r6, =exBossEffectFireTask__FileTable
	mov r5, r0
	mov r4, r1
	mov r8, r9
_02157CC4:
	str r8, [sp]
	ldr r1, [r7, r9, lsl #2]
	ldr r2, [r6, r9, lsl #2]
	mov r3, r4
	add r0, r5, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #3
	blo _02157CC4
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x34]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	mov r3, r4
	ldr r1, [r0, #0x100]
	ldr r2, [r0, #0x120]
	add r0, r5, #0x20
	bl AnimatorMDL__SetAnimation
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	add r0, r5, #0x300
	ldr r2, [r1, #0xf4]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0xf4]
	mov r2, #1
	add r0, r5, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r5, #0x344]
_02157D40:
	mov r0, r2, lsl r3
	tst r0, #0xf
	beq _02157D60
	add r0, r5, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_02157D60:
	add r3, r3, #1
	cmp r3, #5
	blo _02157D40
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireTask__Func_2157D7C(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r4, r0
	ldrsh r0, [r1, #2]
	cmp r0, #1
	bgt _02157E14
	ldr r0, [r1, #0x34]
	cmp r0, #0
	beq _02157DA4
	bl NNS_G3dResDefaultRelease
_02157DA4:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x114]
	cmp r0, #0
	beq _02157DB8
	bl NNS_G3dResDefaultRelease
_02157DB8:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x118]
	cmp r0, #0
	beq _02157DCC
	bl NNS_G3dResDefaultRelease
_02157DCC:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x11c]
	cmp r0, #0
	beq _02157DE0
	bl NNS_G3dResDefaultRelease
_02157DE0:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x120]
	cmp r0, #0
	beq _02157DF4
	bl NNS_G3dResDefaultRelease
_02157DF4:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x34]
	cmp r0, #0
	beq _02157E08
	bl _FreeHEAP_USER
_02157E08:
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x34]
_02157E14:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldrsh r1, [r0, #2]
	sub r1, r1, #1
	strh r1, [r0, #2]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireTask__Main(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	str r0, [r1, #0x24]
	add r0, r4, #4
	bl exBossEffectFireTask__Func_2157A04
	add r0, r4, #0x390
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x390
	bl exDrawReqTask__Func_21641F0
	mov r2, #1
	ldr r1, =exBossEffectHomingTask__ActiveInstanceCount
	mov r0, #0
	str r2, [r1, #0x20]
	str r0, [sp]
	mov r1, #0xbf
	str r1, [sp, #4]
	sub r1, r1, #0xc0
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, =exBossEffectFireTask__Func_2157F18
	str r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireTask__Func8(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	beq _02157ED4
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
_02157ED4:
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	ldmneia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #4
	bl exBossEffectFireTask__Func_2157D7C
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x24]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireTask__Func_2157F18(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	bl GetExBossTask
	cmp r0, #0
	bne _02157F48
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02157F48:
	ldr r1, [r4, #0x4e0]
	add r0, r4, #4
	ldr r1, [r1, #0x3ec]
	str r1, [r4, #0x354]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f0]
	str r1, [r4, #0x358]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f4]
	str r1, [r4, #0x35c]
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02157F84
	bl exBossEffectFireTask__Func_2157FA4
	ldmia sp!, {r4, pc}
_02157F84:
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

NONMATCH_FUNC void exBossEffectFireTask__Func_2157FA4(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	mov r1, #1
	bl exBossEffectFireTask__Func_2157CA8
	add r0, r4, #0x390
	bl exDrawReqTask__Func_2164218
	bl GetExTaskCurrent
	ldr r1, =exBossEffectFireTask__Func_2157FDC
	str r1, [r0]
	bl exBossEffectFireTask__Func_2157FDC
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireTask__Func_2157FDC(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	bl GetExBossTask
	cmp r0, #0
	bne _0215800C
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215800C:
	ldr r1, [r4, #0x4e0]
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x3ec]
	str r1, [r4, #0x354]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f0]
	str r1, [r4, #0x358]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f4]
	str r1, [r4, #0x35c]
	ldr r0, [r0, #0x20]
	cmp r0, #0
	bne _02158048
	bl exBossEffectFireTask__Func_215806C
	ldmia sp!, {r4, pc}
_02158048:
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

NONMATCH_FUNC void exBossEffectFireTask__Func_215806C(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	mov r1, #2
	bl exBossEffectFireTask__Func_2157CA8
	add r0, r4, #0x390
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, =exBossEffectFireTask__Func_21580A4
	str r1, [r0]
	bl exBossEffectFireTask__Func_21580A4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireTask__Func_21580A4(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	bl GetExBossTask
	cmp r0, #0
	bne _021580D4
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021580D4:
	ldr r1, [r4, #0x4e0]
	add r0, r4, #4
	ldr r1, [r1, #0x3ec]
	str r1, [r4, #0x354]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f0]
	str r1, [r4, #0x358]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f4]
	str r1, [r4, #0x35c]
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02158118
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02158118:
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

NONMATCH_FUNC void exBossEffectFireTask__Create(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, =0x000004E4
	str r4, [sp]
	ldr r0, =aExbosseffectfi
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =exBossEffectFireTask__Main
	ldr r1, =exBossEffectFireTask__Destructor
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, =0x000004E4
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x4e0]
	mov r0, r5
	bl GetExTask
	ldr r1, =exBossEffectFireTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossEffectFireTask__Func_21581C0(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	ldr r0, =exBossEffectHomingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x20]
	bx lr

// clang-format on
#endif
}