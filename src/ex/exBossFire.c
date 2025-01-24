#include <ex/exBossFireRed.h>
#include <ex/exBossFireBlue.h>
#include <ex/exPlayerHelpers.h>
#include <ex/exSysTask.h>
#include <game/audio/audioSystem.h>
#include <game/file/binaryBundle.h>

// --------------------
// VARIABLES
// --------------------

struct ExBossFire_StaticVars
{
    u16 exBossFireBlueTask__ActiveInstanceCount;
    u16 exBossFireRedTask__ActiveInstanceCount;
    void *exBossFireRedTask__unk_217610C;
    Task *exBossFireRedTask__TaskSingleton;
    Task *exBossFireBlueTask__TaskSingleton;
    void *exBossFireRedTask__dword_2176118;
    void *exBossFireRedTask__unk_217611C;
    void *exBossFireBlueTask__unk_2176120;
    void *exBossFireRedTask__unk_2176124;
    void *exBossFireRedTask__unk_2176128;
    void *exBossFireBlueTask__dword_217612C;
    void *exBossFireBlueTask__unk_2176130;
    void *exBossFireBlueTask__unk_2176134;
    void *exBossFireBlueTask__unk_2176138;
    void *exBossFireRedTask__FileTable;
    void *exBossFireRedTask__AnimTable;
    void *exBossFireBlueTask__AnimTable;
};

extern struct ExBossFire_StaticVars exBossFireTask__sVars;

// NOT_DECOMPILED void *exBossFireBlueTask__ActiveInstanceCount;
NOT_DECOMPILED void *exBossFireRedTask__ActiveInstanceCount;
NOT_DECOMPILED void *exBossFireRedTask__unk_217610C;
NOT_DECOMPILED Task *exBossFireRedTask__TaskSingleton;
NOT_DECOMPILED Task *exBossFireBlueTask__TaskSingleton;
NOT_DECOMPILED void *exBossFireRedTask__dword_2176118;
NOT_DECOMPILED void *exBossFireRedTask__unk_217611C;
NOT_DECOMPILED void *exBossFireBlueTask__unk_2176120;
NOT_DECOMPILED void *exBossFireRedTask__unk_2176124;
NOT_DECOMPILED void *exBossFireRedTask__unk_2176128;
NOT_DECOMPILED void *exBossFireBlueTask__dword_217612C;
NOT_DECOMPILED void *exBossFireBlueTask__unk_2176130;
NOT_DECOMPILED void *exBossFireBlueTask__unk_2176134;
NOT_DECOMPILED void *exBossFireBlueTask__unk_2176138;
NOT_DECOMPILED void *exBossFireRedTask__FileTable;
NOT_DECOMPILED void *exBossFireRedTask__AnimTable;
NOT_DECOMPILED void *exBossFireBlueTask__AnimTable;
NOT_DECOMPILED void *exBossFireBlueTask__FileTable;

NOT_DECOMPILED void *aExtraExBb_3;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC void exBossFireBlueTask__BossFunc_21581C0(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r0, =0x02175FC4
	mov r1, #0
	str r1, [r0, #0x20]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void exBossFireBlueTask__LoadAssets(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, =exBossFireTask__sVars
	mov r5, r0
	str r5, [r1, #0x18]
	ldr r0, [r1, #0x2c]
	cmp r0, #0
	ldrne r0, [r1, #0x28]
	cmpne r0, #0
	beq _02158250
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, =exBossFireTask__sVars
	ldr r1, [r1, #0x2c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, =exBossFireTask__sVars
	ldr r1, [r1, #0x28]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, =exBossFireTask__sVars
	ldr r1, [r1, #0x2c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02158250:
	mov r0, r5
	bl exDrawReqTask__InitModel
	ldr r0, =exBossFireTask__sVars
	ldrsh r0, [r0, #0]
	cmp r0, #0
	bne _02158314
	mov r1, #9
	ldr r0, =aExtraExBb_3
	sub r2, r1, #0xa
	bl ReadFileFromBundle
	mov r4, r0
	ldr r0, [r4, #0]
	ldr r1, =exBossFireTask__sVars
	mov r0, r0, lsr #8
	str r0, [r1, #0x2c]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, =exBossFireTask__sVars
	mov r0, r4
	str r1, [r2, #0x24]
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
	mov r0, #0x1c
	bl exSysTask__LoadExFile
	ldr r1, =exBossFireTask__sVars
	mov r2, #1
	str r0, [r1, #0x64]
	mov r0, #0x1f
	str r2, [r1, #0x54]
	bl exSysTask__LoadExFile
	ldr r1, =exBossFireTask__sVars
	mov r2, #4
	str r0, [r1, #0x68]
	mov r0, #0x1e
	str r2, [r1, #0x58]
	bl exSysTask__LoadExFile
	ldr r1, =exBossFireTask__sVars
	mov r2, #3
	str r0, [r1, #0x6c]
	mov r0, #0x1d
	str r2, [r1, #0x5c]
	bl exSysTask__LoadExFile
	ldr r1, =exBossFireTask__sVars
	mov r2, #2
	str r0, [r1, #0x70]
	str r2, [r1, #0x60]
	ldr r0, [r1, #0x24]
	bl Asset3DSetup__Create
_02158314:
	add r0, r5, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, =exBossFireTask__sVars
	str r2, [sp]
	ldr r1, [r0, #0x24]
	mov r3, r2
	add r0, r5, #0x20
	bl AnimatorMDL__SetResource
	mov r4, #0
	ldr r7, =exBossFireBlueTask__AnimTable
	ldr r6, =exBossFireBlueTask__FileTable
	mov r8, r4
_0215834C:
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
	blo _0215834C
	ldr r0, =exBossFireTask__sVars
	ldr r0, [r0, #0x24]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r1, =exBossFireBlueTask__AnimTable
	ldr r0, =exBossFireBlueTask__FileTable
	ldr r1, [r1, r4, lsl #2]
	ldr r2, [r0, r4, lsl #2]
	add r0, r5, #0x20
	mov r3, #0
	bl AnimatorMDL__SetAnimation
	ldr r1, =exBossFireTask__sVars
	add r0, r5, #0x300
	ldr r2, [r1, #0x54]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x54]
	mov r2, #1
	add r0, r5, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r5, #0x344]
_021583CC:
	mov r0, r2, lsl r3
	tst r0, #0x1e
	beq _021583EC
	add r0, r5, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_021583EC:
	add r3, r3, #1
	cmp r3, #5
	blo _021583CC
	mov r0, #0
	str r0, [r5, #0x358]
	mov r0, #0x1000
	str r0, [r5, #0x368]
	str r0, [r5, #0x36c]
	ldr r1, =0x00003FFC
	str r0, [r5, #0x370]
	add r0, r5, #0x300
	strh r1, [r0, #0x4a]
	mov r0, #1
	strb r0, [r5]
	ldrb r3, [r5, #2]
	mov r1, #0x4000
	add r2, r5, #0x350
	orr r3, r3, #4
	strb r3, [r5, #2]
	str r1, [r5, #0xc]
	str r1, [r5, #0x10]
	str r1, [r5, #0x14]
	ldr r1, =exBossFireTask__sVars
	str r2, [r5, #0x18]
	ldrsh r2, [r1, #0]
	add r2, r2, #1
	strh r2, [r1]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossFireBlueTask__Func_2158474(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =exBossFireTask__sVars
	mov r4, r0
	ldrsh r0, [r1, #0]
	cmp r0, #1
	bgt _0215850C
	ldr r0, [r1, #0x24]
	cmp r0, #0
	beq _0215849C
	bl NNS_G3dResDefaultRelease
_0215849C:
	ldr r0, =exBossFireTask__sVars
	ldr r0, [r0, #0x64]
	cmp r0, #0
	beq _021584B0
	bl NNS_G3dResDefaultRelease
_021584B0:
	ldr r0, =exBossFireTask__sVars
	ldr r0, [r0, #0x68]
	cmp r0, #0
	beq _021584C4
	bl NNS_G3dResDefaultRelease
_021584C4:
	ldr r0, =exBossFireTask__sVars
	ldr r0, [r0, #0x6c]
	cmp r0, #0
	beq _021584D8
	bl NNS_G3dResDefaultRelease
_021584D8:
	ldr r0, =exBossFireTask__sVars
	ldr r0, [r0, #0x70]
	cmp r0, #0
	beq _021584EC
	bl NNS_G3dResDefaultRelease
_021584EC:
	ldr r0, =exBossFireTask__sVars
	ldr r0, [r0, #0x24]
	cmp r0, #0
	beq _02158500
	bl _FreeHEAP_USER
_02158500:
	ldr r0, =exBossFireTask__sVars
	mov r1, #0
	str r1, [r0, #0x24]
_0215850C:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, =exBossFireTask__sVars
	ldrsh r1, [r0, #0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossFireBlueTask__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, =exBossFireTask__sVars
	str r0, [r1, #0xc]
	add r0, r4, #0x2c
	bl exBossFireBlueTask__LoadAssets
	add r0, r4, #0x3b8
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x3b8
	bl exDrawReqTask__Func_2164218
	ldr r0, [r4, #0x28]
	mov ip, #0xc3
	ldr r1, [r0, #0x3ec]
	mov lr, #0x3c000
	str r1, [r4, #0x37c]
	ldr r1, [r4, #0x28]
	mov r0, #0
	ldr r2, [r1, #0x3f0]
	sub r1, ip, #0xc4
	str r2, [r4, #0x380]
	ldr r3, [r4, #0x28]
	mov r2, r1
	ldr r5, [r3, #0x3f4]
	mov r3, r1
	str r5, [r4, #0x384]
	ldr r5, [r4, #0x28]
	ldr r5, [r5, #0x48]
	str r5, [r4, #0x10]
	ldr r5, [r4, #0x28]
	ldr r5, [r5, #0x4c]
	str r5, [r4, #0x14]
	str lr, [r4, #0x18]
	stmia sp, {r0, ip}
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, =exBossFireBlueTask__Main_215862C
	str r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossFireBlueTask__Func8(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exSysTask__GetFlag_2178650
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

void exBossFireBlueTask__Destructor(void)
{
    exBossFireBlueTask *work = ExTaskGetWorkCurrent(exBossFireBlueTask);

    exBossFireBlueTask__Func_2158474(&work->animator);
    exBossFireTask__sVars.exBossFireBlueTask__TaskSingleton = NULL;
}

NONMATCH_FUNC void exBossFireBlueTask__Main_215862C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x2c
	bl exDrawReqTask__Model__Animate
	ldrb r1, [r4, #0x32]
	mov r0, r1, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _02158670
	ldrb r0, [r4, #0x2c]
	cmp r0, #2
	bne _02158664
	bl exBossFireBlueTask__Func_21589B8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02158664:
	bic r0, r1, #1
	strb r0, [r4, #0x32]
	b _0215868C
_02158670:
	mov r0, r1, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _0215868C
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0215868C:
	ldr r3, [r4, #0x37c]
	ldr r0, [r4, #0x10]
	ldr ip, =0x0000019A
	sub r0, r0, r3
	umull r2, r1, r0, ip
	mov lr, #0
	mla r1, r0, lr, r1
	mov r0, r0, asr #0x1f
	adds r2, r2, #0x800
	mla r1, r0, ip, r1
	adc r0, r1, #0
	mov r5, r2, lsr #0xc
	orr r5, r5, r0, lsl #20
	ldr r2, [r4, #0x380]
	ldr r1, [r4, #0x384]
	add r0, r3, r5
	str r0, [r4, #0x37c]
	ldr r0, [r4, #0x380]
	ldr r5, [r4, #0x14]
	sub r5, r5, r0
	umull r7, r6, r5, ip
	mla r6, r5, lr, r6
	mov r5, r5, asr #0x1f
	mla r6, r5, ip, r6
	adds r7, r7, #0x800
	adc r5, r6, #0
	mov r6, r7, lsr #0xc
	orr r6, r6, r5, lsl #20
	add r0, r0, r6
	str r0, [r4, #0x380]
	ldr r0, [r4, #0x384]
	ldr r5, [r4, #0x18]
	sub r6, r5, r0
	umull r8, r7, r6, ip
	mla r7, r6, lr, r7
	mov r5, r6, asr #0x1f
	mla r7, r5, ip, r7
	adds r6, r8, #0x800
	adc r5, r7, #0
	mov r6, r6, lsr #0xc
	orr r6, r6, r5, lsl #20
	add r0, r0, r6
	str r0, [r4, #0x384]
	ldr r0, [r4, #0x37c]
	mov ip, #0
	sub r0, r0, r3
	str r0, [r4, #4]
	ldr r0, [r4, #0x380]
	sub r0, r0, r2
	str r0, [r4, #8]
	ldr r0, [r4, #0x384]
	sub r0, r0, r1
	str r0, [r4, #0xc]
	ldr r3, [r4, #0x380]
	ldr r1, [r4, #0x14]
	ldr r2, [r4, #0x37c]
	ldr r0, [r4, #0x10]
	sub r1, r3, r1
	subs r0, r2, r0
	rsbmi r0, r0, #0
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r0, r1
	ldr r2, =0x00000F5E
	ldr r3, =0x0000065D
	ble _021587DC
	umull lr, r7, r0, r2
	mla r7, r0, ip, r7
	umull r6, r5, r1, r3
	mov r0, r0, asr #0x1f
	mla r7, r0, r2, r7
	adds lr, lr, #0x800
	adc r7, r7, #0
	adds r2, r6, #0x800
	mov r6, lr, lsr #0xc
	mla r5, r1, ip, r5
	mov r0, r1, asr #0x1f
	mla r5, r0, r3, r5
	adc r0, r5, #0
	mov r1, r2, lsr #0xc
	orr r6, r6, r7, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r6, r1
	b _02158820
_021587DC:
	umull r7, r6, r1, r2
	mla r6, r1, ip, r6
	umull r5, lr, r0, r3
	mla lr, r0, ip, lr
	mov r1, r1, asr #0x1f
	mov r0, r0, asr #0x1f
	mla r6, r1, r2, r6
	adds r7, r7, #0x800
	adc r2, r6, #0
	adds r1, r5, #0x800
	mla lr, r0, r3, lr
	mov r5, r7, lsr #0xc
	adc r0, lr, #0
	mov r1, r1, lsr #0xc
	orr r5, r5, r2, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r5, r1
_02158820:
	cmp r0, #0xf000
	bge _02158830
	bl exBossFireBlueTask__Func_2158888
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02158830:
	ldr r0, [r4, #0xc]
	ldr r1, [r4, #8]
	bl exPlayerHelpers__Func_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0x76]
	ldmib r4, {r0, r1}
	bl exPlayerHelpers__Func_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0x7a]
	add r0, r4, #0x2c
	add r1, r4, #0x3b8
	bl exDrawReqTask__AddRequest
	add r0, r4, #0x2c
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossFireBlueTask__Func_2158888(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r1, =exBossFireBlueTask__Main_21588A8
	str r1, [r0]
	bl exBossFireBlueTask__Main_21588A8
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossFireBlueTask__Main_21588A8(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x2c
	bl exDrawReqTask__Model__Animate
	ldrb r1, [r4, #0x32]
	mov r0, r1, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _021588EC
	ldrb r0, [r4, #0x2c]
	cmp r0, #2
	bne _021588E0
	bl exBossFireBlueTask__Func_21589B8
	ldmia sp!, {r4, pc}
_021588E0:
	bic r0, r1, #1
	strb r0, [r4, #0x32]
	b _02158908
_021588EC:
	mov r0, r1, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _02158908
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02158908:
	ldr r1, [r4, #0x37c]
	ldr r0, [r4, #4]
	add r0, r1, r0
	str r0, [r4, #0x37c]
	ldr r1, [r4, #0x380]
	ldr r0, [r4, #8]
	add r0, r1, r0
	str r0, [r4, #0x380]
	ldr r0, [r4, #0xc]
	ldr r1, [r4, #8]
	bl exPlayerHelpers__Func_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0x76]
	ldmib r4, {r0, r1}
	bl exPlayerHelpers__Func_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0x7a]
	ldr r1, [r4, #0x37c]
	cmp r1, #0x5a000
	bge _02158980
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ble _02158980
	ldr r1, [r4, #0x380]
	cmp r1, #0xc8000
	bge _02158980
	add r0, r0, #0x1e000
	cmp r1, r0
	bgt _02158990
_02158980:
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02158990:
	add r0, r4, #0x2c
	add r1, r4, #0x3b8
	bl exDrawReqTask__AddRequest
	add r0, r4, #0x2c
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossFireBlueTask__Func_21589B8(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldrb r1, [r4, #0x32]
	mov r0, #0
	bic r1, r1, #1
	strb r1, [r4, #0x32]
	ldrb r1, [r4, #0x30]
	orr r1, r1, #2
	strb r1, [r4, #0x30]
	str r0, [r4, #4]
	bl exSysTask__GetStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _02158A5C
	ldrsh r0, [r4, #0x34]
	ldr r2, [r4, #8]
	cmp r0, #6
	bne _02158A2C
	mov r1, r2, asr #0x1f
	mov r0, #0x800
	mov r1, r1, lsl #0xe
	adds r3, r0, r2, lsl #14
	orr r1, r1, r2, lsr #18
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
	b _02158AD0
_02158A2C:
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
	b _02158AD0
_02158A5C:
	bl exSysTask__GetStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	bne _02158AD0
	ldrsh r0, [r4, #0x34]
	ldr r2, [r4, #8]
	cmp r0, #7
	bne _02158AA4
	mov r1, r2, asr #0x1f
	mov r0, #0x800
	mov r1, r1, lsl #0xe
	adds r3, r0, r2, lsl #14
	orr r1, r1, r2, lsr #18
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
	b _02158AD0
_02158AA4:
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
_02158AD0:
	ldr r1, [r4, #8]
	mov r0, #0
	rsb r1, r1, #0
	str r1, [r4, #8]
	ldr r2, =0x00007FF8
	str r0, [r4, #0xc]
	add r1, r4, #0x300
	strh r2, [r1, #0x76]
	strh r0, [r1, #0x78]
	strh r0, [r1, #0x7a]
	ldr r2, =0x00001554
	ldr r3, =_mt_math_rand
	strh r2, [r4, #0x20]
	ldr ip, [r3]
	ldr r1, =0x00196225
	ldr r2, =0x3C6EF35F
	mla lr, ip, r1, r2
	mov r1, lr, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, r1, lsr #0x1f
	rsb r1, r2, r1, lsl #31
	adds r1, r2, r1, ror #31
	str lr, [r3]
	movne r0, #1
	str r0, [r4, #0x24]
	bl GetExTaskCurrent
	ldr r1, =exBossFireBlueTask__Main_2158B64
	str r1, [r0]
	bl exBossFireBlueTask__Main_2158B64
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossFireBlueTask__Main_2158B64(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x2c
	bl exDrawReqTask__Model__Animate
	ldrb r0, [r4, #0x32]
	mov r1, r0, lsl #0x1f
	movs r1, r1, lsr #0x1f
	beq _02158B98
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02158B98:
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _02158BB4
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02158BB4:
	ldr r0, [r4, #0x24]
	cmp r0, #0
	add r0, r4, #0x300
	ldreqh r2, [r0, #0x7a]
	ldreqh r1, [r4, #0x20]
	subeq r1, r2, r1
	beq _02158BDC
	ldrh r2, [r0, #0x7a]
	ldrh r1, [r4, #0x20]
	add r1, r2, r1
_02158BDC:
	strh r1, [r0, #0x7a]
	ldr r1, [r4, #0x380]
	ldr r0, [r4, #8]
	add r0, r1, r0
	str r0, [r4, #0x380]
	ldr r1, [r4, #0x37c]
	cmp r1, #0x5a000
	bge _02158C24
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ble _02158C24
	ldr r1, [r4, #0x380]
	cmp r1, #0xc8000
	bge _02158C24
	add r0, r0, #0x1e000
	cmp r1, r0
	bgt _02158C34
_02158C24:
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02158C34:
	add r0, r4, #0x2c
	add r1, r4, #0x3b8
	bl exDrawReqTask__AddRequest
	add r0, r4, #0x2c
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

s32 exBossFireBlueTask__Create(void)
{
    Task *task =
        ExTaskCreate(exBossFireBlueTask__Main, exBossFireBlueTask__Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR, exBossFireBlueTask);

    exBossFireBlueTask *work = ExTaskGetWork(task, exBossFireBlueTask);
    TaskInitWork8(work);

    work->parent           = ExTaskGetWorkCurrent(exBossSysAdminTask);
    GetExTask(task)->func8 = exBossFireBlueTask__Func8;

    return 1;
}

NONMATCH_FUNC void exBossFireRedTask__LoadAssets(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, =0x02176108
	mov r5, r0
	str r5, [r1, #0x14]
	ldr r0, [r1, #0x10]
	cmp r0, #0
	ldrne r0, [r1, #4]
	cmpne r0, #0
	beq _02158D60
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, =0x02176108
	ldr r1, [r1, #0x10]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, =0x02176108
	ldr r1, [r1, #4]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, =0x02176108
	ldr r1, [r1, #0x10]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02158D60:
	mov r0, r5
	bl exDrawReqTask__InitModel
	ldr r0, =0x02176108
	ldrsh r0, [r0, #2]
	cmp r0, #0
	bne _02158E24
	mov r1, #8
	ldr r0, =aExtraExBb_3
	sub r2, r1, #9
	bl ReadFileFromBundle
	mov r4, r0
	ldr r0, [r4, #0]
	ldr r1, =0x02176108
	mov r0, r0, lsr #8
	str r0, [r1, #0x10]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, =0x02176108
	mov r0, r4
	str r1, [r2, #0x1c]
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
	mov r0, #0x18
	bl exSysTask__LoadExFile
	ldr r1, =0x02176108
	mov r2, #1
	str r0, [r1, #0x34]
	mov r0, #0x1b
	str r2, [r1, #0x44]
	bl exSysTask__LoadExFile
	ldr r1, =0x02176108
	mov r2, #4
	str r0, [r1, #0x38]
	mov r0, #0x1a
	str r2, [r1, #0x48]
	bl exSysTask__LoadExFile
	ldr r1, =0x02176108
	mov r2, #3
	str r0, [r1, #0x3c]
	mov r0, #0x19
	str r2, [r1, #0x4c]
	bl exSysTask__LoadExFile
	ldr r1, =0x02176108
	mov r2, #2
	str r0, [r1, #0x40]
	str r2, [r1, #0x50]
	ldr r0, [r1, #0x1c]
	bl Asset3DSetup__Create
_02158E24:
	add r0, r5, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, =0x02176108
	str r2, [sp]
	ldr r1, [r0, #0x1c]
	mov r3, r2
	add r0, r5, #0x20
	bl AnimatorMDL__SetResource
	mov r4, #0
	ldr r7, =0x0217614C
	ldr r6, =0x0217613C
	mov r8, r4
_02158E5C:
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
	blo _02158E5C
	ldr r0, =0x02176108
	ldr r0, [r0, #0x1c]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r1, =0x0217614C
	ldr r0, =0x0217613C
	ldr r1, [r1, r4, lsl #2]
	ldr r2, [r0, r4, lsl #2]
	add r0, r5, #0x20
	mov r3, #0
	bl AnimatorMDL__SetAnimation
	ldr r1, =0x02176108
	add r0, r5, #0x300
	ldr r2, [r1, #0x44]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x44]
	mov r2, #1
	add r0, r5, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r5, #0x344]
_02158EDC:
	mov r0, r2, lsl r3
	tst r0, #0x1e
	beq _02158EFC
	add r0, r5, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_02158EFC:
	add r3, r3, #1
	cmp r3, #5
	blo _02158EDC
	mov r0, #0
	str r0, [r5, #0x358]
	mov r0, #0x1000
	str r0, [r5, #0x368]
	str r0, [r5, #0x36c]
	ldr r1, =0x00003FFC
	str r0, [r5, #0x370]
	add r0, r5, #0x300
	strh r1, [r0, #0x4a]
	mov r0, #1
	strb r0, [r5]
	ldrb r3, [r5, #2]
	mov r1, #0x4000
	add r2, r5, #0x350
	orr r3, r3, #2
	strb r3, [r5, #2]
	str r1, [r5, #0xc]
	str r1, [r5, #0x10]
	str r1, [r5, #0x14]
	ldr r1, =0x02176108
	str r2, [r5, #0x18]
	ldrsh r2, [r1, #2]
	add r2, r2, #1
	strh r2, [r1, #2]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossFireRedTask__ReleaseAssets(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =0x02176108
	mov r4, r0
	ldrsh r0, [r1, #2]
	cmp r0, #1
	bgt _0215901C
	ldr r0, [r1, #0x1c]
	cmp r0, #0
	beq _02158FAC
	bl NNS_G3dResDefaultRelease
_02158FAC:
	ldr r0, =0x02176108
	ldr r0, [r0, #0x34]
	cmp r0, #0
	beq _02158FC0
	bl NNS_G3dResDefaultRelease
_02158FC0:
	ldr r0, =0x02176108
	ldr r0, [r0, #0x38]
	cmp r0, #0
	beq _02158FD4
	bl NNS_G3dResDefaultRelease
_02158FD4:
	ldr r0, =0x02176108
	ldr r0, [r0, #0x3c]
	cmp r0, #0
	beq _02158FE8
	bl NNS_G3dResDefaultRelease
_02158FE8:
	ldr r0, =0x02176108
	ldr r0, [r0, #0x40]
	cmp r0, #0
	beq _02158FFC
	bl NNS_G3dResDefaultRelease
_02158FFC:
	ldr r0, =0x02176108
	ldr r0, [r0, #0x1c]
	cmp r0, #0
	beq _02159010
	bl _FreeHEAP_USER
_02159010:
	ldr r0, =0x02176108
	mov r1, #0
	str r1, [r0, #0x1c]
_0215901C:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, =0x02176108
	ldrsh r1, [r0, #2]
	sub r1, r1, #1
	strh r1, [r0, #2]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void exBossFireRedTask__Main(void)
{
    exBossFireRedTask *work = ExTaskGetWorkCurrent(exBossFireRedTask);

    exBossFireTask__sVars.exBossFireRedTask__TaskSingleton = GetCurrentTask();
    exBossFireRedTask__LoadAssets(&work->animator);
    exDrawReqTask__SetConfigPriority(&work->animator.config, 0xA800);
    exDrawReqTask__Func_2164218(&work->animator.config);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_FIREBALL);

    work->animator.model.translation.x = work->parent->field_6C.model.field_364.x;
    work->animator.model.translation.y = work->parent->field_6C.model.field_364.y;
    work->animator.model.translation.z = work->parent->field_6C.model.field_364.z;

    work->field_10.x                 = work->parent->field_48;
    work->field_10.y                 = work->parent->field_4C;
    work->field_10.z                 = 0x3C000;

    GetExTaskCurrent()->main = exBossFireRedTask__Main_2159140;
}

void exBossFireRedTask__Func8(void)
{
    exBossFireRedTask *work = ExTaskGetWorkCurrent(exBossFireRedTask);

    if (exSysTask__GetFlag_2178650())
        GetExTaskCurrent()->main = ExTask_State_Destroy;
}

void exBossFireRedTask__Destructor(void)
{
    exBossFireRedTask *work = ExTaskGetWorkCurrent(exBossFireRedTask);

    exBossFireRedTask__ReleaseAssets(&work->animator);
    exBossFireTask__sVars.exBossFireRedTask__TaskSingleton = NULL;
}

NONMATCH_FUNC void exBossFireRedTask__Main_2159140(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x2c
	bl exDrawReqTask__Model__Animate
	ldrb r0, [r4, #0x32]
	mov r1, r0, lsl #0x1f
	movs r1, r1, lsr #0x1f
	beq _02159178
	ldrb r0, [r4, #0x2c]
	cmp r0, #2
	bne _02159194
	bl exBossFireRedTask__Func_21594B0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02159178:
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _02159194
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02159194:
	ldr r3, [r4, #0x37c]
	ldr r0, [r4, #0x10]
	mov lr, #0
	sub r0, r0, r3
	mov ip, #0xcd
	umull r2, r1, r0, ip
	mla r1, r0, lr, r1
	mov r0, r0, asr #0x1f
	adds r2, r2, #0x800
	mla r1, r0, ip, r1
	adc r0, r1, #0
	mov r5, r2, lsr #0xc
	orr r5, r5, r0, lsl #20
	ldr r2, [r4, #0x380]
	ldr r1, [r4, #0x384]
	add r0, r3, r5
	str r0, [r4, #0x37c]
	ldr r0, [r4, #0x380]
	ldr r5, [r4, #0x14]
	sub r5, r5, r0
	umull r7, r6, r5, ip
	mla r6, r5, lr, r6
	mov r5, r5, asr #0x1f
	mla r6, r5, ip, r6
	adds r7, r7, #0x800
	adc r5, r6, #0
	mov r6, r7, lsr #0xc
	orr r6, r6, r5, lsl #20
	add r0, r0, r6
	str r0, [r4, #0x380]
	ldr r0, [r4, #0x384]
	ldr r5, [r4, #0x18]
	sub r6, r5, r0
	umull r8, r7, r6, ip
	mla r7, r6, lr, r7
	mov r5, r6, asr #0x1f
	mla r7, r5, ip, r7
	adds r6, r8, #0x800
	adc r5, r7, #0
	mov r6, r6, lsr #0xc
	orr r6, r6, r5, lsl #20
	add r0, r0, r6
	str r0, [r4, #0x384]
	ldr r0, [r4, #0x37c]
	mov ip, #0
	sub r0, r0, r3
	str r0, [r4, #4]
	ldr r0, [r4, #0x380]
	sub r0, r0, r2
	str r0, [r4, #8]
	ldr r0, [r4, #0x384]
	sub r0, r0, r1
	str r0, [r4, #0xc]
	ldr r3, [r4, #0x380]
	ldr r1, [r4, #0x14]
	ldr r2, [r4, #0x37c]
	ldr r0, [r4, #0x10]
	sub r1, r3, r1
	subs r0, r2, r0
	rsbmi r0, r0, #0
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r0, r1
	ldr r2, =0x00000F5E
	ldr r3, =0x0000065D
	ble _021592E4
	umull lr, r7, r0, r2
	mla r7, r0, ip, r7
	umull r6, r5, r1, r3
	mov r0, r0, asr #0x1f
	mla r7, r0, r2, r7
	adds lr, lr, #0x800
	adc r7, r7, #0
	adds r2, r6, #0x800
	mov r6, lr, lsr #0xc
	mla r5, r1, ip, r5
	mov r0, r1, asr #0x1f
	mla r5, r0, r3, r5
	adc r0, r5, #0
	mov r1, r2, lsr #0xc
	orr r6, r6, r7, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r6, r1
	b _02159328
_021592E4:
	umull r7, r6, r1, r2
	mla r6, r1, ip, r6
	umull r5, lr, r0, r3
	mla lr, r0, ip, lr
	mov r1, r1, asr #0x1f
	mov r0, r0, asr #0x1f
	mla r6, r1, r2, r6
	adds r7, r7, #0x800
	adc r2, r6, #0
	adds r1, r5, #0x800
	mla lr, r0, r3, lr
	mov r5, r7, lsr #0xc
	adc r0, lr, #0
	mov r1, r1, lsr #0xc
	orr r5, r5, r2, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r5, r1
_02159328:
	cmp r0, #0xf000
	bge _02159338
	bl ovl09_215938C
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02159338:
	ldr r0, [r4, #0xc]
	ldr r1, [r4, #8]
	bl exPlayerHelpers__Func_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0x76]
	ldmib r4, {r0, r1}
	bl exPlayerHelpers__Func_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0x7a]
	add r0, r4, #0x2c
	add r1, r4, #0x3b8
	bl exDrawReqTask__AddRequest
	add r0, r4, #0x2c
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ovl09_215938C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r1, =exBossFireRedTask__Func_21593AC
	str r1, [r0]
	bl exBossFireRedTask__Func_21593AC
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossFireRedTask__Func_21593AC(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x2c
	bl exDrawReqTask__Model__Animate
	ldrb r0, [r4, #0x32]
	mov r1, r0, lsl #0x1f
	movs r1, r1, lsr #0x1f
	beq _021593E4
	ldrb r0, [r4, #0x2c]
	cmp r0, #2
	bne _02159400
	bl exBossFireRedTask__Func_21594B0
	ldmia sp!, {r4, pc}
_021593E4:
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _02159400
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02159400:
	ldr r1, [r4, #0x37c]
	ldr r0, [r4, #4]
	add r0, r1, r0
	str r0, [r4, #0x37c]
	ldr r1, [r4, #0x380]
	ldr r0, [r4, #8]
	add r0, r1, r0
	str r0, [r4, #0x380]
	ldr r0, [r4, #0xc]
	ldr r1, [r4, #8]
	bl exPlayerHelpers__Func_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0x76]
	ldmib r4, {r0, r1}
	bl exPlayerHelpers__Func_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0x7a]
	ldr r1, [r4, #0x37c]
	cmp r1, #0x5a000
	bge _02159478
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ble _02159478
	ldr r1, [r4, #0x380]
	cmp r1, #0xc8000
	bge _02159478
	add r0, r0, #0x1e000
	cmp r1, r0
	bgt _02159488
_02159478:
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02159488:
	add r0, r4, #0x2c
	add r1, r4, #0x3b8
	bl exDrawReqTask__AddRequest
	add r0, r4, #0x2c
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossFireRedTask__Func_21594B0(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldrb r1, [r4, #0x32]
	mov r0, #0
	bic r1, r1, #1
	strb r1, [r4, #0x32]
	ldrb r1, [r4, #0x30]
	orr r1, r1, #2
	strb r1, [r4, #0x30]
	str r0, [r4, #4]
	bl exSysTask__GetStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _02159554
	ldrsh r0, [r4, #0x34]
	ldr r2, [r4, #8]
	cmp r0, #6
	bne _02159524
	mov r1, r2, asr #0x1f
	mov r0, #0x800
	mov r1, r1, lsl #0xe
	adds r3, r0, r2, lsl #14
	orr r1, r1, r2, lsr #18
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
	b _021595C8
_02159524:
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
	b _021595C8
_02159554:
	bl exSysTask__GetStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	bne _021595C8
	ldrsh r0, [r4, #0x34]
	ldr r2, [r4, #8]
	cmp r0, #7
	bne _0215959C
	mov r1, r2, asr #0x1f
	mov r0, #0x800
	mov r1, r1, lsl #0xe
	adds r3, r0, r2, lsl #14
	orr r1, r1, r2, lsr #18
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
	b _021595C8
_0215959C:
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
_021595C8:
	ldr r1, [r4, #8]
	mov r0, #0
	rsb r1, r1, #0
	str r1, [r4, #8]
	ldr r2, =0x00007FF8
	str r0, [r4, #0xc]
	add r1, r4, #0x300
	strh r2, [r1, #0x76]
	strh r0, [r1, #0x78]
	strh r0, [r1, #0x7a]
	ldr r2, =0x00001554
	ldr r3, =_mt_math_rand
	strh r2, [r4, #0x20]
	ldr ip, [r3]
	ldr r1, =0x00196225
	ldr r2, =0x3C6EF35F
	mla lr, ip, r1, r2
	mov r1, lr, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, r1, lsr #0x1f
	rsb r1, r2, r1, lsl #31
	adds r1, r2, r1, ror #31
	str lr, [r3]
	movne r0, #1
	str r0, [r4, #0x24]
	bl GetExTaskCurrent
	ldr r1, =exBossFireRedTask__Main_215965C
	str r1, [r0]
	bl exBossFireRedTask__Main_215965C
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exBossFireRedTask__Main_215965C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x2c
	bl exDrawReqTask__Model__Animate
	ldrb r0, [r4, #0x32]
	mov r1, r0, lsl #0x1f
	movs r1, r1, lsr #0x1f
	beq _02159690
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02159690:
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _021596AC
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021596AC:
	ldr r0, [r4, #0x24]
	cmp r0, #0
	add r0, r4, #0x300
	ldreqh r2, [r0, #0x7a]
	ldreqh r1, [r4, #0x20]
	subeq r1, r2, r1
	beq _021596D4
	ldrh r2, [r0, #0x7a]
	ldrh r1, [r4, #0x20]
	add r1, r2, r1
_021596D4:
	strh r1, [r0, #0x7a]
	ldr r1, [r4, #0x380]
	ldr r0, [r4, #8]
	add r0, r1, r0
	str r0, [r4, #0x380]
	ldr r1, [r4, #0x37c]
	cmp r1, #0x5a000
	bge _0215971C
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ble _0215971C
	ldr r1, [r4, #0x380]
	cmp r1, #0xc8000
	bge _0215971C
	add r0, r0, #0x1e000
	cmp r1, r0
	bgt _0215972C
_0215971C:
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215972C:
	add r0, r4, #0x2c
	add r1, r4, #0x3b8
	bl exDrawReqTask__AddRequest
	add r0, r4, #0x2c
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

s32 exBossFireRedTask__Create(void)
{
    Task *task =
        ExTaskCreate(exBossFireRedTask__Main, exBossFireRedTask__Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR, exBossFireRedTask);

    exBossFireRedTask *work = ExTaskGetWork(task, exBossFireRedTask);
    TaskInitWork8(work);

    work->parent           = ExTaskGetWorkCurrent(exBossSysAdminTask);
    GetExTask(task)->func8 = exBossFireRedTask__Func8;

    return 1;
}
