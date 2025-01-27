#include <ex/core/exMeteorManager.h>
#include <ex/system/exSystem.h>
#include <ex/player/exPlayerHelpers.h>
#include <game/file/binaryBundle.h>

// --------------------
// VARIABLES
// --------------------

struct TEMP_STATIC_VARS
{
    u32 exEffectMeteoTask__ActiveInstanceCount;
    u16 exEffectMeteoTask__unk_2176552;

    void *exEffectMeteoTask__unk_2176554;
    void *exEffectMeteoTask__dword_2176558;
    void *exEffectMeteoAdminTask__TaskSingleton;
    void *exEffectMeteoTask__dword_2176560;
    void *exEffectMeteoTask__unk_2176564;
    void *exEffectMeteoTask__unk_2176568;
    void *exEffectMeteoTask__unk_217656C;
    void *exEffectMeteoTask__unk_2176570;
    void *exEffectMeteoTask__unk_2176574;
    void *exEffectMeteoTask__unk_2176578;
    void *exEffectMeteoTask__dword_217657C;
    void *exEffectMeteoTask__AnimTable;
    void *exEffectMeteoTask__FileTable;
};

NOT_DECOMPILED struct TEMP_STATIC_VARS exEffectMeteoTask__sVars;

// NOT_DECOMPILED u32 exEffectMeteoTask__ActiveInstanceCount;
// NOT_DECOMPILED u16 exEffectMeteoTask__unk_2176552;

// NOT_DECOMPILED void *exEffectMeteoTask__unk_2176554;
// NOT_DECOMPILED void *exEffectMeteoTask__dword_2176558;
// NOT_DECOMPILED void *exEffectMeteoAdminTask__TaskSingleton;
// NOT_DECOMPILED void *exEffectMeteoTask__dword_2176560;
// NOT_DECOMPILED void *exEffectMeteoTask__unk_2176564;
// NOT_DECOMPILED void *exEffectMeteoTask__unk_2176568;
// NOT_DECOMPILED void *exEffectMeteoTask__unk_217656C;
// NOT_DECOMPILED void *exEffectMeteoTask__unk_2176570;
// NOT_DECOMPILED void *exEffectMeteoTask__unk_2176574;
// NOT_DECOMPILED void *exEffectMeteoTask__unk_2176578;
// NOT_DECOMPILED void *exEffectMeteoTask__dword_217657C;
// NOT_DECOMPILED void *exEffectMeteoTask__AnimTable;
// NOT_DECOMPILED void *exEffectMeteoTask__FileTable;

NOT_DECOMPILED void *_021745A8;
NOT_DECOMPILED void *_021745AC;

NOT_DECOMPILED void *_021745B4;
NOT_DECOMPILED void *_02174638;

NOT_DECOMPILED void *aExtraExBb_9;
NOT_DECOMPILED void *aExeffectmeteot;
NOT_DECOMPILED void *aExeffectmeteoa;

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void _f_ftoi(void);
NOT_DECOMPILED void _f_sub(void);
NOT_DECOMPILED void _fadd(void);
NOT_DECOMPILED void _f_mul(void);
NOT_DECOMPILED void _fgr(void);

// --------------------
// FUNCTIONS
// --------------------

// ExMeteorManager helpers
NONMATCH_FUNC void exEffectMeteoTask__LoadMeteoAssets(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, =0x02176550
	mov r4, r0
	str r4, [r1, #0x28]
	ldr r0, [r1, #8]
	cmp r0, #0
	ldrne r0, [r1, #0x1c]
	cmpne r0, #0
	beq _021670C0
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, =0x02176550
	ldr r1, [r1, #8]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, =0x02176550
	ldr r1, [r1, #0x1c]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, =0x02176550
	ldr r1, [r1, #8]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
_021670C0:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, =0x02176550
	ldrsh r0, [r0, #0]
	cmp r0, #0
	bne _02167128
	mov r1, #0xb
	ldr r0, =aExtraExBb_9
	sub r2, r1, #0xc
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, =0x02176550
	mov r0, r0, lsr #8
	str r0, [r1, #8]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, =0x02176550
	mov r0, r5
	str r1, [r2, #0x2c]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	ldr r0, =0x02176550
	ldr r0, [r0, #0x2c]
	bl Asset3DSetup__Create
_02167128:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, =0x02176550
	str r2, [sp]
	ldr r1, [r0, #0x2c]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
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
	mov r0, #5
	strb r0, [r4]
	ldrb r2, [r4, #4]
	mov r1, #0x3000
	add r0, r4, #0x350
	orr r2, r2, #0x10
	strb r2, [r4, #4]
	str r1, [r4, #0xc]
	str r1, [r4, #0x10]
	str r1, [r4, #0x14]
	ldr r1, =0x02176550
	str r0, [r4, #0x18]
	ldrsh r2, [r1, #0]
	mov r0, #1
	add r2, r2, #1
	strh r2, [r1]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectMeteoTask__ReleaseMeteoAssets(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =0x02176550
	mov r4, r0
	ldrsh r0, [r1, #0]
	cmp r0, #1
	bgt _02167218
	ldr r0, [r1, #0x2c]
	cmp r0, #0
	beq _021671F8
	bl NNS_G3dResDefaultRelease
_021671F8:
	ldr r0, =0x02176550
	ldr r0, [r0, #0x2c]
	cmp r0, #0
	beq _0216720C
	bl _FreeHEAP_USER
_0216720C:
	ldr r0, =0x02176550
	mov r1, #0
	str r1, [r0, #0x2c]
_02167218:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, =0x02176550
	ldrsh r1, [r0, #0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectMeteoTask__LoadBrokenMeteoAssets(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, =0x02176550
	mov r4, r0
	str r4, [r1, #4]
	ldr r0, [r1, #0x10]
	cmp r0, #0
	ldrne r0, [r1, #0x14]
	cmpne r0, #0
	beq _021672A4
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, =0x02176550
	ldr r1, [r1, #0x10]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, =0x02176550
	ldr r1, [r1, #0x14]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, =0x02176550
	ldr r1, [r1, #0x10]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
_021672A4:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, =0x02176550
	ldrsh r0, [r0, #2]
	cmp r0, #0
	bne _02167338
	mov r1, #0xc
	ldr r0, =aExtraExBb_9
	sub r2, r1, #0xd
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, =0x02176550
	mov r0, r0, lsr #8
	str r0, [r1, #0x10]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, =0x02176550
	mov r0, r5
	str r1, [r2, #0x20]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x23
	bl LoadExSystemFile
	ldr r1, =0x02176550
	mov r2, #0
	str r0, [r1, #0x38]
	mov r0, #0x24
	str r2, [r1, #0x30]
	bl LoadExSystemFile
	ldr r1, =0x02176550
	mov r2, #4
	str r0, [r1, #0x3c]
	str r2, [r1, #0x34]
	ldr r0, [r1, #0x20]
	bl Asset3DSetup__Create
_02167338:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, =0x02176550
	str r2, [sp]
	ldr r1, [r0, #0x20]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r3, #0
	ldr r0, =0x02176550
	str r3, [sp]
	ldr r1, [r0, #0x30]
	ldr r2, [r0, #0x38]
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	mov r3, #0
	ldr r2, =0x02176550
	str r3, [sp]
	ldr r1, [r2, #0x34]
	ldr r2, [r2, #0x3c]
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	ldr r1, =0x02176550
	add r0, r4, #0x300
	ldr r2, [r1, #0x30]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x30]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_021673C0:
	mov r0, r2, lsl r3
	tst r0, #0x11
	beq _021673E0
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_021673E0:
	add r3, r3, #1
	cmp r3, #5
	blo _021673C0
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
	mov r0, #5
	strb r0, [r4]
	ldrb r2, [r4, #4]
	mov r1, #0x3000
	add r0, r4, #0x350
	orr r2, r2, #0x20
	strb r2, [r4, #4]
	str r1, [r4, #0xc]
	str r1, [r4, #0x10]
	str r1, [r4, #0x14]
	ldr r1, =0x02176550
	str r0, [r4, #0x18]
	ldrsh r2, [r1, #2]
	mov r0, #1
	add r2, r2, #1
	strh r2, [r1, #2]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectMeteoTask__ReleaseBrokenMeteoAssets(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =0x02176550
	mov r4, r0
	ldrsh r0, [r1, #2]
	cmp r0, #1
	bgt _021674DC
	ldr r0, [r1, #0x20]
	cmp r0, #0
	beq _02167494
	bl NNS_G3dResDefaultRelease
_02167494:
	ldr r0, =0x02176550
	ldr r0, [r0, #0x38]
	cmp r0, #0
	beq _021674A8
	bl NNS_G3dResDefaultRelease
_021674A8:
	ldr r0, =0x02176550
	ldr r0, [r0, #0x3c]
	cmp r0, #0
	beq _021674BC
	bl NNS_G3dResDefaultRelease
_021674BC:
	ldr r0, =0x02176550
	ldr r0, [r0, #0x20]
	cmp r0, #0
	beq _021674D0
	bl _FreeHEAP_USER
_021674D0:
	ldr r0, =0x02176550
	mov r1, #0
	str r1, [r0, #0x20]
_021674DC:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, =0x02176550
	ldrsh r1, [r0, #2]
	sub r1, r1, #1
	strh r1, [r0, #2]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

// ExMeteor
NONMATCH_FUNC void exEffectMeteoTask__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetExTaskWorkCurrent_
	ldr r1, [r0, #0]
	cmp r1, #0
	bne _02167520
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02167520:
	ldr lr, =_mt_math_rand
	ldr r1, =0x00196225
	ldr r3, [lr]
	ldr r2, =0x3C6EF35F
	ldr ip, =0x55555556
	mla r4, r3, r1, r2
	mov r3, r4, lsr #0x10
	mov r5, r3, lsl #0x10
	mov r6, r5, lsr #0x10
	smull r3, r7, ip, r6
	add r7, r7, r6, lsr #31
	mov r3, #3
	smull r6, r7, r3, r7
	str r4, [lr]
	rsb r7, r6, r5, lsr #16
	strh r7, [r0, #0x10]
	ldr r5, [lr]
	mla r4, r5, r1, r2
	mov r5, r4, lsr #0x10
	mov r5, r5, lsl #0x10
	mov r7, r5, lsr #0x10
	smull r6, r8, ip, r7
	add r8, r8, r7, lsr #31
	smull r6, r7, r3, r8
	str r4, [lr]
	rsb r8, r6, r5, lsr #16
	strh r8, [r0, #0x12]
	ldr r4, [lr]
	mla r8, r4, r1, r2
	mov r4, r8, lsr #0x10
	mov r4, r4, lsl #0x10
	mov r6, r4, lsr #0x10
	smull r5, r7, ip, r6
	add r7, r7, r6, lsr #31
	smull r5, r6, r3, r7
	str r8, [lr]
	rsb r7, r5, r4, lsr #16
	strh r7, [r0, #0x14]
	ldr r4, [lr]
	mla r5, r4, r1, r2
	mov r4, r5, lsr #0x10
	mov r4, r4, lsl #0x10
	mov r6, r4, lsr #0x10
	str r5, [lr]
	smull r5, r7, ip, r6
	add r7, r7, r6, lsr #31
	smull r5, r6, r3, r7
	rsb r7, r5, r4, lsr #16
	strh r7, [r0, #0x16]
	ldr r4, [lr]
	mla r5, r4, r1, r2
	mov r4, r5, lsr #0x10
	mov r4, r4, lsl #0x10
	mov r6, r4, lsr #0x10
	str r5, [lr]
	smull r5, r7, ip, r6
	add r7, r7, r6, lsr #31
	smull r5, r6, r3, r7
	rsb r7, r5, r4, lsr #16
	strh r7, [r0, #0x18]
	ldr r4, [lr]
	mla r1, r4, r1, r2
	str r1, [lr]
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r4, r1, lsr #0x10
	smull r2, r5, ip, r4
	add r5, r5, r4, lsr #31
	smull r2, r4, r3, r5
	rsb r5, r2, r1, lsr #16
	strh r5, [r0, #0x1a]
	bl GetExTaskCurrent
	ldr r1, =exEffectMeteoTask__Main_Moving
	str r1, [r0]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectMeteoTask__Func8(void)
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

NONMATCH_FUNC void exEffectMeteoTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x1c
	bl exEffectMeteoTask__ReleaseMeteoAssets
	add r0, r4, #0xf8
	add r0, r0, #0x400
	bl exEffectMeteoTask__ReleaseBrokenMeteoAssets
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectMeteoTask__Main_Moving(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x1c
	bl exDrawReqTask__Model__Animate
	add r0, r4, #0x66
	add r0, r0, #0x300
	add r1, r4, #0x10
	add r2, r4, #0x16
	mov r3, #0
	bl exPlayerHelpers__Func_2152D28
	add r0, r4, #0x66
	add r0, r0, #0x300
	add r1, r4, #0x10
	add r2, r4, #0x16
	mov r3, #1
	bl exPlayerHelpers__Func_2152D28
	add r0, r4, #0x66
	add r0, r0, #0x300
	add r1, r4, #0x10
	add r2, r4, #0x16
	mov r3, #2
	bl exPlayerHelpers__Func_2152D28
	ldr r1, [r4, #0x370]
	ldr r0, [r4, #8]
	sub r0, r1, r0
	str r0, [r4, #0x370]
	ldr r1, [r4, #0x36c]
	cmp r1, #0x5a000
	bge _02167744
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ldrgt r1, [r4, #0x370]
	addgt r0, r0, #0x1e000
	cmpgt r1, r0
	bgt _02167754
_02167744:
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02167754:
	ldrb r1, [r4, #0x22]
	mov r0, r1, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _02167794
	ldrb r0, [r4, #0x1c]
	cmp r0, #2
	bne _0216778C
	mov r0, r1, lsl #0x1e
	movs r0, r0, lsr #0x1f
	beq _02167784
	bl exEffectMeteoTask__Action_Shatter
	ldmia sp!, {r4, pc}
_02167784:
	bl exEffectMeteoTask__Action_Reflect
	ldmia sp!, {r4, pc}
_0216778C:
	bl exEffectMeteoTask__Action_Shatter
	ldmia sp!, {r4, pc}
_02167794:
	add r0, r4, #0x1c
	add r1, r4, #0x3a8
	bl exDrawReqTask__AddRequest
	add r0, r4, #0x1c
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectMeteoTask__Action_Shatter(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldrb r1, [r0, #0x22]
	bic r1, r1, #1
	strb r1, [r0, #0x22]
	ldr r1, [r0, #0x36c]
	str r1, [r0, #0x848]
	ldr r1, [r0, #0x370]
	str r1, [r0, #0x84c]
	ldr r1, [r0, #0x374]
	str r1, [r0, #0x850]
	bl GetExTaskCurrent
	ldr r1, =exEffectMeteoTask__Main_Shatter
	str r1, [r0]
	bl exEffectMeteoTask__Main_Shatter
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectMeteoTask__Main_Shatter(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0xf8
	add r0, r0, #0x400
	bl exDrawReqTask__Model__Animate
	add r0, r4, #0xf8
	add r0, r0, #0x400
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0216783C
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0216783C:
	add r0, r4, #0xf8
	add r1, r4, #0x84
	add r0, r0, #0x400
	add r1, r1, #0x800
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectMeteoTask__Action_Reflect(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldrb r0, [r4, #0x22]
	bic r0, r0, #1
	strb r0, [r4, #0x22]
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _021678F4
	ldrsh r0, [r4, #0x24]
	ldr r2, [r4, #8]
	cmp r0, #6
	bne _021678C4
	mov r1, r2, asr #0x1f
	mov r0, #0x800
	mov r1, r1, lsl #0xe
	adds r3, r0, r2, lsl #14
	orr r1, r1, r2, lsr #18
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
	b _02167968
_021678C4:
	mov r0, #0x6000
	mov r1, #0
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r2, ip, #0x800
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
	b _02167968
_021678F4:
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	bne _02167968
	ldrsh r0, [r4, #0x24]
	ldr r2, [r4, #8]
	cmp r0, #7
	bne _0216793C
	mov r1, r2, asr #0x1f
	mov r0, #0x800
	mov r1, r1, lsl #0xe
	adds r3, r0, r2, lsl #14
	orr r1, r1, r2, lsr #18
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
	b _02167968
_0216793C:
	mov r0, #0x6000
	mov r1, #0
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r2, ip, #0x800
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
_02167968:
	bl GetExTaskCurrent
	ldr r1, =exEffectMeteoTask__Main_Reflect
	str r1, [r0]
	bl exEffectMeteoTask__Main_Reflect
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectMeteoTask__Main_Reflect(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x1c
	bl exDrawReqTask__Model__Animate
	ldr r1, [r4, #0x370]
	ldr r0, [r4, #8]
	add r0, r1, r0
	str r0, [r4, #0x370]
	ldr r1, [r4, #0x36c]
	cmp r1, #0x5a000
	bge _021679CC
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ble _021679CC
	ldr r0, [r4, #0x370]
	cmp r0, #0xc8000
	blt _021679DC
_021679CC:
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021679DC:
	add r0, r4, #0x1c
	add r1, r4, #0x3a8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectMeteoTask__Create(VecFx32 position, VecFx32 velocity){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, =0x000009D4
	str r4, [sp]
	str r1, [sp, #4]
	ldr r0, =aExeffectmeteot
	ldr r1, =exEffectMeteoTask__Destructor
	str r0, [sp, #8]
	ldr r0, =exEffectMeteoTask__Main
	mov r2, #0x4000
	mov r3, #5
	str r4, [sp, #0xc]
	ldr r7, [sp, #0x2c]
	ldr r6, [sp, #0x38]
	ldr r5, [sp, #0x3c]
	bl ExTaskCreate_
	mov r8, r0
	bl GetExTaskWork_
	mov r1, r4
	ldr r2, =0x000009D4
	mov r4, r0
	bl MI_CpuFill8
	mov r0, r8
	bl GetExTask
	ldr r1, =exEffectMeteoTask__Func8
	str r1, [r0, #8]
	add r0, r4, #0x1c
	bl exEffectMeteoTask__LoadMeteoAssets
	cmp r0, #0
	bne _02167A98
	mov r0, #0
	str r0, [r4]
	add sp, sp, #0x10
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	add sp, sp, #0x10
	bx lr
_02167A98:
	mov r2, #1
	add r0, r4, #0x3a8
	mov r1, #0xa800
	str r2, [r4]
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x3a8
	bl exDrawReqTask__Func_21641F0
	add r0, r4, #0xf8
	add r0, r0, #0x400
	bl exEffectMeteoTask__LoadBrokenMeteoAssets
	cmp r0, #0
	bne _02167AE4
	mov r0, #0
	str r0, [r4]
	add sp, sp, #0x10
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	add sp, sp, #0x10
	bx lr
_02167AE4:
	add r0, r4, #0x84
	mov r2, #1
	add r0, r0, #0x800
	mov r1, #0xa800
	str r2, [r4]
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x84
	add r0, r0, #0x800
	bl exDrawReqTask__Func_21641F0
	ldr r1, [sp, #0x28]
	ldr r0, [sp, #0x34]
	str r1, [r4, #0x36c]
	str r7, [r4, #0x370]
	stmib r4, {r0, r6}
	str r5, [r4, #0xc]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	add sp, sp, #0x10
	bx lr

// clang-format on
#endif
}

// ExMeteorManager
NONMATCH_FUNC void exEffectMeteoAdminTask__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, =exEffectMeteoTask__sVars
	str r0, [r1, #0xc]
	bl exEffectMeteoAdminTask__Func_2167F04
	mov r0, #0
	strh r0, [r4, #2]
	strh r0, [r4, #4]
	ldrh r2, [r4, #0]
	ldr r0, =_021745AC
	ldrh r1, [r4, #2]
	ldr r2, [r0, r2, lsl #2]
	mov r0, #0xc
	mla r0, r1, r0, r2
	add r3, r4, #8
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldrh r1, [r4, #0]
	ldr r0, =_021745A8
	mov r1, r1, lsl #1
	ldrh r0, [r0, r1]
	strh r0, [r4, #6]
	bl GetExTaskCurrent
	ldr r1, =exEffectMeteoAdminTask__Main_Active
	str r1, [r0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectMeteoAdminTask__Func8(void)
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

NONMATCH_FUNC void exEffectMeteoAdminTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, =exEffectMeteoTask__sVars
	mov r1, #0
	str r1, [r0, #0xc]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectMeteoAdminTask__Main_Active(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x20
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, pc}
	ldrsh r1, [r4, #8]
	sub r0, r1, #1
	strh r0, [r4, #8]
	cmp r1, #0
	bge _02167EE4
	ldr r0, [r4, #0xc]
	mov r1, #0
	mov r2, #0xbe000
	str r1, [sp, #0x14]
	str r2, [sp, #0x18]
	str r1, [sp, #0x1c]
	str r1, [sp, #8]
	bl _fgr
	ldr r1, [r4, #0xc]
	ldr r0, =0x45800000
	bls _02167C84
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _02167C90
_02167C84:
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_02167C90:
	bl _f_ftoi
	ldrb r1, [r4, #0x10]
	mov r2, #0
	str r0, [sp, #0xc]
	mov r0, r1, lsl #0x1f
	str r2, [sp, #0x10]
	movs r0, r0, lsr #0x1f
	beq _02167CD8
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x28000
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectMeteoTask__Create
_02167CD8:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	beq _02167D10
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x1e000
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectMeteoTask__Create
_02167D10:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	beq _02167D48
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x14000
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectMeteoTask__Create
_02167D48:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	beq _02167D80
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0xa000
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectMeteoTask__Create
_02167D80:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _02167DBC
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0xa000
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectMeteoTask__Create
_02167DBC:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	beq _02167DF8
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x14000
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectMeteoTask__Create
_02167DF8:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x19
	movs r0, r0, lsr #0x1f
	beq _02167E34
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x1e000
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectMeteoTask__Create
_02167E34:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1f
	beq _02167E70
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x28000
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectMeteoTask__Create
_02167E70:
	ldrh r0, [r4, #2]
	add r0, r0, #1
	strh r0, [r4, #2]
	ldrh ip, [r4, #2]
	ldrh r0, [r4, #6]
	cmp ip, r0
	bhs _02167EB0
	ldrh r2, [r4, #0]
	ldr r1, =_021745AC
	mov r0, #0xc
	ldr r1, [r1, r2, lsl #2]
	add r3, r4, #8
	mla r0, ip, r0, r1
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	b _02167EE4
_02167EB0:
	ldrh r0, [r4, #4]
	mov ip, #0
	ldr r1, =_021745AC
	add r0, r0, #1
	strh r0, [r4, #4]
	strh ip, [r4, #2]
	ldrh r2, [r4, #0]
	mov r0, #0xc
	add r3, r4, #8
	ldr r1, [r1, r2, lsl #2]
	mla r0, ip, r0, r1
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
_02167EE4:
	bl exEffectMeteoAdminTask__Func_2167F04
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	add sp, sp, #0x20
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectMeteoAdminTask__Func_2167F04(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	mov r5, #0
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _02167F78
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xa
	addls pc, pc, r0, lsl #2
	b _02167FCC
_02167F38: // jump table
	b _02167FCC // case 0
	b _02167F64 // case 1
	b _02167F64 // case 2
	b _02167FCC // case 3
	b _02167F64 // case 4
	b _02167FCC // case 5
	b _02167F68 // case 6
	b _02167FCC // case 7
	b _02167F68 // case 8
	b _02167FCC // case 9
	b _02167F68 // case 10
_02167F64:
	b _02167FCC
_02167F68:
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	b _02167FCC
_02167F78:
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xa
	addls pc, pc, r0, lsl #2
	b _02167FCC
_02167F8C: // jump table
	b _02167FCC // case 0
	b _02167FB8 // case 1
	b _02167FB8 // case 2
	b _02167FCC // case 3
	b _02167FB8 // case 4
	b _02167FCC // case 5
	b _02167FC0 // case 6
	b _02167FCC // case 7
	b _02167FC0 // case 8
	b _02167FCC // case 9
	b _02167FC0 // case 10
_02167FB8:
	mov r5, #1
	b _02167FCC
_02167FC0:
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
_02167FCC:
	strh r5, [r4]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectMeteoAdminTask__Create(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0x14
	ldr r0, =aExeffectmeteoa
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =exEffectMeteoAdminTask__Main
	ldr r1, =exEffectMeteoAdminTask__Destructor
	mov r2, #0x4000
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	mov r0, r4
	bl GetExTask
	ldr r1, =exEffectMeteoAdminTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectMeteoAdminTask__Destroy(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =exEffectMeteoTask__sVars
	ldr r0, [r0, #0xc]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTask
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}
