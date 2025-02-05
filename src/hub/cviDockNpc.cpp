#include <hub/cviDockNpc.hpp>
#include <hub/dockHelpers.h>
#include <game/util/cppHelpers.hpp>
#include <game/file/bundleFileUnknown.h>

// --------------------
// TEMP
// --------------------

extern "C"
{

NOT_DECOMPILED void *_N_ZTV10CViDockNpc;
NOT_DECOMPILED void *ovl05_0217305C;
NOT_DECOMPILED void *aBbViNpcBb_ovl05;
NOT_DECOMPILED void *ViDockNpc__MaterialAnimlList;
NOT_DECOMPILED void *ViDockNpc__JointAnimList;
NOT_DECOMPILED void *ViDockNpc__ModelList;
NOT_DECOMPILED void *ViDockNpc__AssetInfoList;

NOT_DECOMPILED void _ZN11CVi3dObject12Func_2167A80Ev(void);
NOT_DECOMPILED void _ZN11CVi3dObject12Func_2167A0CEtiiii(void);
NOT_DECOMPILED void _ZN11CVi3dObject12Func_21679B0Etiiii(void);
NOT_DECOMPILED void _ZN11CVi3dObject12Func_2167958Etiiii(void);
NOT_DECOMPILED void _ZN11CVi3dObject12Func_2167900Etiiii(void);
NOT_DECOMPILED void _ZN11CVi3dObject12Func_216763CEPvtiiS0_S0_S0_S0_S0_t(void);
NOT_DECOMPILED void _ZN11CVi3dObject12Func_21677C4Ev(void);
}

// --------------------
// VARIABLES
// --------------------

// --------------------
// FUNCTIONS
// --------------------

// --------------------
// FUNCTIONS
// --------------------

CViDockNpc::CViDockNpc()
{
#ifndef NON_MATCHING
    this->model         = NULL;
    this->aniJoints     = NULL;
    this->aniMaterial   = NULL;
    this->aniVisibility = NULL;
    this->aniTexture    = NULL;
    ViDockNpc__Func_2166F10(this);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl _ZN11CVi3dObjectC2Ev
	ldr r0, =_N_ZTV10CViDockNpc+0x08
	mov r1, #0
	str r0, [r4]
	str r1, [r4, #0x314]
	str r1, [r4, #0x318]
	str r1, [r4, #0x31c]
	str r1, [r4, #0x320]
	mov r0, r4
	str r1, [r4, #0x324]
	bl ViDockNpc__Func_2166F10
	mov r0, r4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

CViDockNpc::~CViDockNpc()
{
#ifndef NON_MATCHING
    ViDockNpc__Func_2166F10(this);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_N_ZTV10CViDockNpc+0x08
	mov r4, r0
	str r1, [r4]
	bl ViDockNpc__Func_2166F10
	mov r0, r4
	bl _ZN11CVi3dObjectD2Ev
	mov r0, r4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDockNpc__LoadAssets(CViDockNpc *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x1c
	mov r4, r1
	mov r7, r0
	mov r6, r2
	mov r5, r3
	bl ViDockNpc__Func_2166F10
	mov r0, r4, lsl #0x10
	str r4, [r7, #0x300]
	mov r0, r0, lsr #0x10
	bl DockHelpers__GetNpcConfig
	ldrh r2, [r0, #0]
	add r0, r7, #0x300
	mov r1, #0xc
	strh r2, [r0, #0x12]
	mul r0, r2, r1
	ldr r3, =ViDockNpc__AssetInfoList
	sub r2, r1, #0xd
	add r4, r3, r0
	ldrb r3, [r3, r0]
	ldr r1, =ViDockNpc__ModelList
	ldr r0, =aBbViNpcBb_ovl05
	mov r3, r3, lsl #1
	ldrh r1, [r1, r3]
	bl BundleFileUnknown__LoadFileFromBundle
	str r0, [r7, #0x314]
	ldrb r3, [r4, #1]
	ldr r1, =ViDockNpc__JointAnimList
	ldr r0, =aBbViNpcBb_ovl05
	mov r3, r3, lsl #1
	ldrh r1, [r1, r3]
	mvn r2, #0
	bl BundleFileUnknown__LoadFileFromBundle
	str r0, [r7, #0x318]
	ldrb r1, [r4, #2]
	cmp r1, #0xff
	beq _02166CE0
	ldr r0, =ViDockNpc__MaterialAnimlList
	mov r1, r1, lsl #1
	ldrh r1, [r0, r1]
	ldr r0, =aBbViNpcBb_ovl05
	mvn r2, #0
	bl BundleFileUnknown__LoadFileFromBundle
	str r0, [r7, #0x31c]
_02166CE0:
	ldrb r1, [r4, #3]
	cmp r1, #0xff
	beq _02166D08
	ldr r0, =ViDockNpc__MaterialAnimlList
	mov r1, r1, lsl #1
	ldrh r1, [r0, r1]
	ldr r0, =aBbViNpcBb_ovl05
	mvn r2, #0
	bl BundleFileUnknown__LoadFileFromBundle
	str r0, [r7, #0x320]
_02166D08:
	ldrb r1, [r4, #4]
	cmp r1, #0xff
	beq _02166D30
	ldr r0, =ViDockNpc__MaterialAnimlList
	mov r1, r1, lsl #1
	ldrh r1, [r0, r1]
	ldr r0, =aBbViNpcBb_ovl05
	mvn r2, #0
	bl BundleFileUnknown__LoadFileFromBundle
	str r0, [r7, #0x324]
_02166D30:
	ldrb r1, [r4, #7]
	mov r0, #0xc
	ldr r2, =ovl05_0217305C
	smulbb r1, r1, r0
	ldr r0, [r2, r1]
	add r1, r2, r1
	str r0, [r7, #0x328]
	ldr r0, [r1, #4]
	mov r2, #0
	str r0, [r7, #0x32c]
	ldr r0, [r1, #8]
	str r0, [r7, #0x330]
	ldrb r0, [r4, #8]
	cmp r0, #0xff
	str r2, [sp]
	bne _02166DC8
	ldr r0, [r7, #0x318]
	ldr r1, =0x0000FFFF
	stmib sp, {r0, r2}
	ldr r3, [r7, #0x31c]
	mov r0, r7
	str r3, [sp, #0xc]
	ldr ip, [r7, #0x324]
	mov r3, r2
	str ip, [sp, #0x10]
	ldr ip, [r7, #0x320]
	str ip, [sp, #0x14]
	str r1, [sp, #0x18]
	ldr r1, [r7, #0x314]
	bl _ZN11CVi3dObject12Func_216763CEPvtiiS0_S0_S0_S0_S0_t
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	ldrb r1, [r4, #5]
	mov r0, r7
	mov r2, #1
	bl _ZN11CVi3dObject12Func_2167900Etiiii
	b _02166E38
_02166DC8:
	ldr r0, [r7, #0x318]
	mov r1, #1
	stmib sp, {r0, r2}
	ldr r3, [r7, #0x31c]
	mov r0, r7
	str r3, [sp, #0xc]
	ldr ip, [r7, #0x324]
	mov r3, r2
	str ip, [sp, #0x10]
	ldr ip, [r7, #0x320]
	str ip, [sp, #0x14]
	str r1, [sp, #0x18]
	ldr r1, [r7, #0x314]
	bl _ZN11CVi3dObject12Func_216763CEPvtiiS0_S0_S0_S0_S0_t
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	ldrb r1, [r4, #5]
	mov r0, r7
	mov r2, #1
	bl _ZN11CVi3dObject12Func_2167900Etiiii
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	ldrb r1, [r4, #8]
	mov r0, r7
	mov r2, #1
	bl _ZN11CVi3dObject12Func_2167958Etiiii
_02166E38:
	ldr r0, [r7, #0x31c]
	cmp r0, #0
	beq _02166E60
	mov r1, #0
	str r1, [sp]
	mov r0, r7
	mov r3, r1
	mov r2, #1
	str r1, [sp, #4]
	bl _ZN11CVi3dObject12Func_21679B0Etiiii
_02166E60:
	ldr r0, [r7, #0x320]
	cmp r0, #0
	beq _02166E88
	mov r1, #0
	str r1, [sp]
	mov r0, r7
	mov r3, r1
	mov r2, #1
	str r1, [sp, #4]
	bl _ZN11CVi3dObject12Func_2167A80Ev
_02166E88:
	ldr r0, [r7, #0x324]
	cmp r0, #0
	beq _02166EB0
	mov r1, #0
	str r1, [sp]
	mov r0, r7
	mov r3, r1
	mov r2, #1
	str r1, [sp, #4]
	bl _ZN11CVi3dObject12Func_2167A0CEtiiii
_02166EB0:
	mov r1, r6
	add r0, r7, #8
	bl CPPHelpers__VEC_Copy_Alt
	strh r5, [r7, #0x38]
	ldrh r1, [r7, #0x38]
	mov r2, #0x5b0
	add r0, r7, #0x300
	strh r1, [r7, #0x3a]
	ldr r3, [r7, #4]
	ldr r1, [sp, #0x30]
	orr r3, r3, #1
	str r3, [r7, #4]
	strh r2, [r7, #0x3e]
	strh r5, [r0, #0x10]
	str r1, [r7, #0x334]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDockNpc__Func_2166F10(CViDockNpc *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl _ZN11CVi3dObject12Func_21677C4Ev
	ldr r0, [r4, #0x314]
	cmp r0, #0
	beq _02166F34
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x314]
_02166F34:
	ldr r0, [r4, #0x318]
	cmp r0, #0
	beq _02166F4C
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x318]
_02166F4C:
	ldr r0, [r4, #0x31c]
	cmp r0, #0
	beq _02166F64
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x31c]
_02166F64:
	ldr r0, [r4, #0x320]
	cmp r0, #0
	beq _02166F7C
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x320]
_02166F7C:
	ldr r0, [r4, #0x324]
	cmp r0, #0
	beq _02166F94
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x324]
_02166F94:
	mov r0, #0xc
	mov r1, #0
	str r0, [r4, #0x304]
	str r1, [r4, #0x308]
	sub r0, r1, #1
	str r0, [r4, #0x30c]
	str r1, [r4, #0x328]
	str r1, [r4, #0x32c]
	str r1, [r4, #0x330]
	add r0, r4, #0x300
	strh r1, [r0, #0x10]
	mov r1, #0xe
	strh r1, [r0, #0x12]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDockNpc__Func_2166FCC(CViDockNpc *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x334]
	mov r2, #1
	cmp r0, #0
	strneh r1, [r4, #0x38]
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	add r0, r4, #0x300
	ldrh r1, [r0, #0x12]
	mov r0, #0xc
	mul r3, r1, r0
	ldr r1, =0x021730AE
	mov r0, r4
	ldrb r1, [r1, r3]
	mov r3, r2
	bl _ZN11CVi3dObject12Func_2167900Etiiii
	add r0, r4, #0x300
	ldrh r2, [r0, #0x12]
	mov r0, #0xc
	ldr r1, =0x021730B1
	mul r0, r2, r0
	ldrb r1, [r1, r0]
	cmp r1, #0xff
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov ip, #0
	mov r2, #1
	str ip, [sp]
	mov r0, r4
	mov r3, r2
	str ip, [sp, #4]
	bl _ZN11CVi3dObject12Func_2167958Etiiii
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViDockNpc__Func_2167068(CViDockNpc *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x334]
	mov r2, #1
	cmp r0, #0
	addne r0, r4, #0x300
	ldrneh r0, [r0, #0x10]
	strneh r0, [r4, #0x38]
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	add r0, r4, #0x300
	ldrh r1, [r0, #0x12]
	mov r0, #0xc
	mul r3, r1, r0
	ldr r1, =0x021730AD
	mov r0, r4
	ldrb r1, [r1, r3]
	mov r3, r2
	bl _ZN11CVi3dObject12Func_2167900Etiiii
	add r0, r4, #0x300
	ldrh r2, [r0, #0x12]
	mov r0, #0xc
	ldr r1, =0x021730B0
	mul r0, r2, r0
	ldrb r1, [r1, r0]
	cmp r1, #0xff
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov ip, #0
	mov r2, #1
	str ip, [sp]
	mov r0, r4
	mov r3, r2
	str ip, [sp, #4]
	bl _ZN11CVi3dObject12Func_2167958Etiiii
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL ViDockNpc__Func_216710C(CViDockNpc *work, VecFx32 *a2, VecFx32 *a3, VecFx32 *a4, fx32 a5)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r5, r2
	ldr r2, [r5, #0]
	mov r4, r3
	str r2, [r4]
	ldr r2, [r5, #4]
	mov r6, r1
	str r2, [r4, #4]
	ldr r1, [r5, #8]
	mov r7, r0
	str r1, [r4, #8]
	ldr r1, [r6, #0]
	ldr r0, [r5, #0]
	cmp r1, r0
	ldreq r1, [r6, #4]
	ldreq r0, [r5, #4]
	cmpeq r1, r0
	ldreq r1, [r6, #8]
	ldreq r0, [r5, #8]
	cmpeq r1, r0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r9, [sp, #0x20]
	ldr r1, [r7, #0x328]
	ldr r0, [r7, #0x330]
	smull r2, r3, r1, r9
	adds r8, r2, #0x800
	smull r2, r1, r0, r9
	adc r3, r3, #0
	adds r0, r2, #0x800
	mov r9, r8, lsr #0xc
	adc r1, r1, #0
	mov r8, r0, lsr #0xc
	add r0, r7, #8
	orr r9, r9, r3, lsl #20
	orr r8, r8, r1, lsl #20
	bl CPPHelpers__Func_2085F9C
	ldr r1, [r0, #0]
	add r0, r7, #8
	sub r10, r1, r9
	bl CPPHelpers__Func_2085F9C
	ldr r1, [r0, #0]
	add r0, r7, #8
	add r9, r9, r1
	bl CPPHelpers__Func_2085F9C
	ldr r1, [r0, #8]
	add r0, r7, #8
	sub r7, r1, r8
	bl CPPHelpers__Func_2085F9C
	ldr r1, [r0, #8]
	ldr r0, [r5, #0]
	add r1, r8, r1
	cmp r0, r10
	ble _02167200
	cmp r0, r9
	bge _02167200
	ldr r0, [r5, #8]
	cmp r0, r7
	ble _02167200
	cmp r0, r1
	blt _02167208
_02167200:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02167208:
	ldr r0, [r6, #0]
	cmp r0, r10
	strle r10, [r4]
	ble _0216723C
	cmp r0, r9
	strge r9, [r4]
	bge _0216723C
	ldr r0, [r6, #8]
	cmp r0, r7
	strle r7, [r4, #8]
	ble _0216723C
	cmp r0, r1
	strge r1, [r4, #8]
_0216723C:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL ViDockNpc__Func_2167244(CViDockNpc *work, VecFx32 *position, s32 a3, s32 a4, BOOL *flag)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r9, r0
	mov r8, r1
	add r0, r9, #8
	mov r7, r2
	mov r6, r3
	ldr r5, [sp, #0x20]
	bl CPPHelpers__Func_2085F9C
	ldr r2, [r0, #0]
	ldr r1, [r8, #0]
	add r0, r9, #8
	sub r4, r2, r1
	bl CPPHelpers__Func_2085F9C
	add r2, r9, #0x300
	ldr r10, [r0, #8]
	ldr r0, [r8, #8]
	smull r3, r1, r4, r4
	sub ip, r10, r0
	adds r3, r3, #0x800
	ldrh r2, [r2, #0x12]
	mov r9, #0xc
	smull lr, r0, ip, ip
	mul r8, r2, r9
	ldr r2, =0x021730AF
	mov r3, r3, lsr #0xc
	ldrb r8, [r2, r8]
	adc r2, r1, #0
	adds r1, lr, #0x800
	smulbb r8, r8, r9
	ldr r9, =ovl05_0217305C
	adc r10, r0, #0
	mov r1, r1, lsr #0xc
	add lr, r9, r8
	ldr r0, [r9, r8]
	ldr r8, [lr, #8]
	orr r3, r3, r2, lsl #20
	orr r1, r1, r10, lsl #20
	cmp r0, r8
	movlt r0, r8
	add r1, r3, r1
	smull r3, r2, r0, r6
	adds r3, r3, #0x800
	mov r0, #0
	adc r2, r2, r0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r6, r3, r3, asr #1
	smull r3, r2, r6, r6
	adds r3, r3, #0x800
	adc r2, r2, r0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	cmp r1, r3
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, r7, asr #4
	mov r2, r0, lsl #1
	ldr r1, =FX_SinCosTable_
	mov r0, r2, lsl #1
	ldrsh r0, [r1, r0]
	add r2, r2, #1
	mov r2, r2, lsl #1
	muls r0, r4, r0
	ldrsh r0, [r1, r2]
	bmi _0216734C
	muls r0, ip, r0
	bpl _0216735C
_0216734C:
	cmp r5, #0
	movne r0, #0
	strne r0, [r5]
	b _02167368
_0216735C:
	cmp r5, #0
	movne r0, #1
	strne r0, [r5]
_02167368:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL ViDockNpc__Func_216737C(CViDockNpc *work, s32 a2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r0, #1
	bx lr

// clang-format on
#endif
}
