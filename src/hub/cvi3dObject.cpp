#include <hub/cvi3dObject.hpp>
#include <hub/cviShadow.hpp>
#include <hub/cvi3dArrow.hpp>
#include <game/util/cppHelpers.hpp>
#include <game/file/fileUnknown.h>
#include <game/file/bundleFileUnknown.h>
#include <hub/cviDockNpc.hpp>

// resources
#include <resources/narc/vi_shadow_lz7.h>
#include <resources/bb/vi_npc.h>

// --------------------
// TEMP
// --------------------

extern "C"
{
NOT_DECOMPILED void _ZN9CViShadow12Func_21680B8Ev(void);
NOT_DECOMPILED void _ZN11CVi3dObject12Func_21677C4Ev(void);
}

// --------------------
// VARIABLES
// --------------------

static const u8 viShadow__dlList[] = {
    0x40, 0, 0x22, 0x24, 1,    0, 0,    0, 0,    0, 0, 0, 0,    0,    0, 0, 0,    0, 0, 0, 0x22, 0x24, 0x22, 0x24, 0, 0, 0x10, 0,
    0,    0, 0,    4,    0x10, 0, 0x10, 0, 0x40, 0, 0, 4, 0x22, 0x24, 0, 0, 0x10, 0, 0, 0, 0x40, 0,    0,    0,    0, 0, 0,    0,
};

// --------------------
// FUNCTIONS
// --------------------

// CVi3dObject
CVi3dObject::CVi3dObject()
{
    CPPHelpers__Func_2085EE8(&this->translation1);
    CPPHelpers__Func_2085EE8(&this->translation2);
    CPPHelpers__Func_2085EE8(&this->scale1);
    CPPHelpers__Func_2085EE8(&this->scale2);

    this->flags = 0;

    VecFx32 a1a;
    CPPHelpers__VEC_Set(&a1a, 0, 0, 0);
    CPPHelpers__Func_2085FA8(&this->translation1, &a1a);

    VecFx32 a2;
    CPPHelpers__Func_2085FA8(&this->translation2, &this->translation1);
    CPPHelpers__VEC_Set(&a2, FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0));
    CPPHelpers__Func_2085FA8(&this->scale1, &a2);
    CPPHelpers__Func_2085FA8(&this->scale2, &this->scale1);

    this->angle           = 0;
    this->rotationAngle   = 0;
    this->rotationY2      = this->angle;
    this->field_3E        = 0;
    this->rotationX       = 0;
    this->rotationZ       = 0;
    this->id1             = -1;
    this->animator1AnimID = -1;
    this->field_18C       = -1;
    this->field_18E       = -1;
    this->field_190       = -1;
    this->field_192       = -1;
    this->id2             = -1;
    this->animID2         = -1;
    this->field_2DC       = 0;
    this->resources[0]    = NULL;
    this->resources[1]    = NULL;
    this->resources[2]    = NULL;
    this->resources[3]    = NULL;
    this->resources[4]    = NULL;
    this->resources[5]    = NULL;
    this->setJoint        = FALSE;
    this->setMaterial     = FALSE;
    AnimatorMDL__Init(&this->animator1, 0);
    AnimatorMDL__Init(&this->animator2, 0);
}

CVi3dObject::~CVi3dObject()
{
    this->Func_21677C4();
}

NONMATCH_FUNC void CVi3dObject::Func_216763C(void *resMdl, u16 id1, BOOL setJoint, BOOL setMaterial, void *resAnimJoint, void *resAnimMaterial,
                                            void *resAnimPattern, void *resAnimTexture, void *resAnimVisibility, u16 id2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	mov r7, r1
	mov r6, r2
	mov r4, r3
	bl _ZN11CVi3dObject12Func_21677C4Ev
	mov r0, #0
	str r0, [r5, #0x2dc]
	add r0, r5, #0x100
	strh r6, [r0, #0x88]
	ldr r0, [sp, #0x1c]
	str r7, [r5, #0x2e0]
	str r0, [r5, #0x2e4]
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x24]
	str r1, [r5, #0x2e8]
	str r0, [r5, #0x2ec]
	ldr r1, [sp, #0x28]
	ldr r0, [sp, #0x2c]
	str r1, [r5, #0x2f0]
	str r0, [r5, #0x2f4]
	ldr r0, [sp, #0x18]
	str r4, [r5, #0x2f8]
	str r0, [r5, #0x2fc]
	ldrh r1, [sp, #0x30]
	add r0, r5, #0x200
	strh r1, [r0, #0xd8]
	ldr r0, [r5, #0x2e0]
	bl NNS_G3dResDefaultSetup
	ldr r1, [r5, #0x2fc]
	add r0, r5, #0x100
	str r1, [sp]
	ldrh r2, [r0, #0x88]
	ldr r1, [r5, #0x2e0]
	ldr r3, [r5, #0x2f8]
	add r0, r5, #0x44
	bl AnimatorMDL__SetResource
	add r0, r5, #0x200
	ldrh r2, [r0, #0xd8]
	ldr r0, =0x0000FFFF
	cmp r2, r0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r1, [r5, #0x2fc]
	add r0, r5, #0x194
	str r1, [sp]
	ldr r1, [r5, #0x2e0]
	ldr r3, [r5, #0x2f8]
	bl AnimatorMDL__SetResource
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CVi3dObject::Func_2167704(CVi3dObject *other, u16 id1, BOOL setJoint, BOOL setMaterial, u16 id2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r0
	mov r5, r1
	mov r7, r2
	mov r4, r3
	bl _ZN11CVi3dObject12Func_21677C4Ev
	mov r0, #1
	str r0, [r6, #0x2dc]
	add r2, r6, #0x100
	strh r7, [r2, #0x88]
	ldr r0, [r5, #0x2e0]
	ldr ip, [sp, #0x18]
	str r0, [r6, #0x2e0]
	ldr r0, [r5, #0x2e4]
	ldrh r3, [sp, #0x1c]
	str r0, [r6, #0x2e4]
	ldr r0, [r5, #0x2e8]
	add r1, r6, #0x200
	str r0, [r6, #0x2e8]
	ldr lr, [r5, #0x2ec]
	add r0, r6, #0x44
	str lr, [r6, #0x2ec]
	ldr lr, [r5, #0x2f0]
	str lr, [r6, #0x2f0]
	ldr r5, [r5, #0x2f4]
	str r5, [r6, #0x2f4]
	str r4, [r6, #0x2f8]
	str ip, [r6, #0x2fc]
	strh r3, [r1, #0xd8]
	ldr r1, [r6, #0x2fc]
	str r1, [sp]
	ldrh r2, [r2, #0x88]
	ldr r1, [r6, #0x2e0]
	ldr r3, [r6, #0x2f8]
	bl AnimatorMDL__SetResource
	add r0, r6, #0x200
	ldrh r2, [r0, #0xd8]
	ldr r0, =0x0000FFFF
	cmp r2, r0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r1, [r6, #0x2fc]
	add r0, r6, #0x194
	str r1, [sp]
	ldr r1, [r6, #0x2e0]
	ldr r3, [r6, #0x2f8]
	bl AnimatorMDL__SetResource
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CVi3dObject::Func_21677C4()
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	mov r4, r0
	add r0, r4, #0x44
	bl AnimatorMDL__Release
	add r0, r4, #0x44
	mov r1, #0
	bl AnimatorMDL__Init
	add r0, r4, #0x200
	ldrh r1, [r0, #0xd8]
	ldr r0, =0x0000FFFF
	cmp r1, r0
	beq _0216780C
	add r0, r4, #0x194
	bl AnimatorMDL__Release
	add r0, r4, #0x194
	mov r1, #0
	bl AnimatorMDL__Init
_0216780C:
	ldr r0, [r4, #0x2e0]
	cmp r0, #0
	beq _02167828
	ldr r1, [r4, #0x2dc]
	cmp r1, #0
	bne _02167828
	bl NNS_G3dResDefaultRelease
_02167828:
	mov r1, #0
	add r0, sp, #0xc
	mov r2, r1
	mov r3, r1
	str r1, [r4, #4]
	bl CPPHelpers__VEC_Set
	add r1, sp, #0xc
	add r0, r4, #8
	bl CPPHelpers__Func_2085FA8
	add r0, r4, #0x14
	add r1, r4, #8
	bl CPPHelpers__Func_2085FA8
	mov r1, #0x1000
	add r0, sp, #0
	mov r2, r1
	mov r3, r1
	bl CPPHelpers__VEC_Set
	add r0, r4, #0x20
	add r1, sp, #0
	bl CPPHelpers__Func_2085FA8
	add r0, r4, #0x2c
	add r1, r4, #0x20
	bl CPPHelpers__Func_2085FA8
	mov r3, #0
	strh r3, [r4, #0x38]
	strh r3, [r4, #0x3a]
	ldrh r2, [r4, #0x38]
	ldr r1, =0x0000FFFF
	add r0, r4, #0x100
	strh r2, [r4, #0x3c]
	strh r3, [r4, #0x3e]
	strh r3, [r4, #0x40]
	strh r3, [r4, #0x42]
	strh r1, [r0, #0x88]
	strh r1, [r0, #0x8a]
	strh r1, [r0, #0x8c]
	strh r1, [r0, #0x8e]
	strh r1, [r0, #0x90]
	strh r1, [r0, #0x92]
	add r0, r4, #0x200
	strh r1, [r0, #0xd8]
	strh r1, [r0, #0xda]
	str r3, [r4, #0x2dc]
	str r3, [r4, #0x2e0]
	str r3, [r4, #0x2e4]
	str r3, [r4, #0x2e8]
	str r3, [r4, #0x2ec]
	str r3, [r4, #0x2f0]
	str r3, [r4, #0x2f4]
	str r3, [r4, #0x2f8]
	str r3, [r4, #0x2fc]
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CVi3dObject::Func_2167900(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL a6)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	sub sp, sp, #0x10
	ldr ip, [sp, #0x1c]
	cmp ip, #0
	addeq ip, r0, #0x100
	ldreqh ip, [ip, #0x8a]
	cmpeq ip, r1
	addeq sp, sp, #0x10
	ldmeqia sp!, {r3, pc}
	add ip, r0, #0x100
	strh r1, [ip, #0x8a]
	ldr r1, [sp, #0x18]
	stmia sp, {r2, r3}
	str r1, [sp, #8]
	mov r1, #0
	str r1, [sp, #0xc]
	ldr r2, [r0, #0x2e4]
	ldrh r3, [ip, #0x8a]
	add r0, r0, #0x44
	bl _ZN9CViShadow12Func_21680B8Ev
	add sp, sp, #0x10
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CVi3dObject::Func_2167958(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL a6)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	sub sp, sp, #0x10
	ldr ip, [sp, #0x1c]
	cmp ip, #0
	addeq ip, r0, #0x200
	ldreqh ip, [ip, #0xda]
	cmpeq ip, r1
	addeq sp, sp, #0x10
	ldmeqia sp!, {r3, pc}
	add ip, r0, #0x200
	strh r1, [ip, #0xda]
	ldr r1, [sp, #0x18]
	stmia sp, {r2, r3}
	str r1, [sp, #8]
	mov r1, #0
	str r1, [sp, #0xc]
	ldr r2, [r0, #0x2e4]
	ldrh r3, [ip, #0xda]
	add r0, r0, #0x194
	bl _ZN9CViShadow12Func_21680B8Ev
	add sp, sp, #0x10
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CVi3dObject::Func_21679B0(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL a6)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	sub sp, sp, #0x10
	ldr ip, [sp, #0x1c]
	cmp ip, #0
	addeq ip, r0, #0x100
	ldreqh ip, [ip, #0x8e]
	cmpeq ip, r1
	addeq sp, sp, #0x10
	ldmeqia sp!, {r3, pc}
	add ip, r0, #0x100
	strh r1, [ip, #0x8e]
	ldr r1, [sp, #0x18]
	stmia sp, {r2, r3}
	str r1, [sp, #8]
	mov r1, #0
	str r1, [sp, #0xc]
	ldr r2, [r0, #0x2ec]
	ldrh r3, [ip, #0x8e]
	add r0, r0, #0x44
	mov r1, #1
	bl _ZN9CViShadow12Func_21680B8Ev
	add sp, sp, #0x10
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CVi3dObject::Func_2167A0C(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL a6)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	ldr ip, [sp, #0x24]
	mov r4, r0
	cmp ip, #0
	addeq r0, r4, #0x100
	ldreqh r0, [r0, #0x90]
	mov r6, r2
	mov r5, r3
	cmpeq r0, r1
	addeq sp, sp, #0x10
	ldmeqia sp!, {r4, r5, r6, pc}
	add r0, r4, #0x100
	strh r1, [r0, #0x90]
	ldr r0, [r4, #0x2e0]
	bl NNS_G3dGetTex
	str r6, [sp]
	ldr r1, [sp, #0x20]
	str r5, [sp, #4]
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	add r0, r4, #0x100
	ldrh r3, [r0, #0x90]
	ldr r2, [r4, #0x2f0]
	add r0, r4, #0x44
	mov r1, #2
	bl _ZN9CViShadow12Func_21680B8Ev
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CVi3dObject::Func_2167A80()
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	sub sp, sp, #0x10
	ldr ip, [sp, #0x1c]
	cmp ip, #0
	addeq ip, r0, #0x100
	ldreqh ip, [ip, #0x92]
	cmpeq ip, r1
	addeq sp, sp, #0x10
	ldmeqia sp!, {r3, pc}
	add ip, r0, #0x100
	strh r1, [ip, #0x92]
	ldr r1, [sp, #0x18]
	stmia sp, {r2, r3}
	str r1, [sp, #8]
	mov r1, #0
	str r1, [sp, #0xc]
	ldr r2, [r0, #0x2f4]
	ldrh r3, [ip, #0x92]
	add r0, r0, #0x44
	mov r1, #3
	bl _ZN9CViShadow12Func_21680B8Ev
	add sp, sp, #0x10
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CVi3dObject::ProcessAnimation()
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #4]
	tst r0, #1
	beq _02167B64
	ldrh r1, [r4, #0x3a]
	ldrh r0, [r4, #0x38]
	cmp r0, r1
	beq _02167B6C
	add r2, r0, #0x10000
	add r1, r1, #0x10000
	cmp r2, r1
	bge _02167B20
	sub r0, r1, r2
	cmp r0, #0x8000
	subge r1, r1, #0x10000
	b _02167B2C
_02167B20:
	sub r0, r2, r1
	cmp r0, #0x8000
	subge r2, r2, #0x10000
_02167B2C:
	cmp r1, r2
	bge _02167B48
	ldrh r0, [r4, #0x3e]
	add r1, r1, r0
	cmp r1, r2
	movgt r1, r2
	b _02167B5C
_02167B48:
	ble _02167B5C
	ldrh r0, [r4, #0x3e]
	sub r1, r1, r0
	cmp r1, r2
	movlt r1, r2
_02167B5C:
	strh r1, [r4, #0x3a]
	b _02167B6C
_02167B64:
	ldrh r0, [r4, #0x38]
	strh r0, [r4, #0x3a]
_02167B6C:
	add r0, r4, #0x44
	bl AnimatorMDL__ProcessAnimation
	add r0, r4, #0x200
	ldrh r1, [r0, #0xd8]
	ldr r0, =0x0000FFFF
	cmp r1, r0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x194
	bl AnimatorMDL__ProcessAnimation
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CVi3dObject::Draw()
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x48
	mov r4, r0
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x14]
	ldr r3, =FX_SinCosTable_
	add r0, r1, r0
	str r0, [r4, #0x8c]
	ldr r2, [r4, #0xc]
	ldr r1, [r4, #0x18]
	add r0, r4, #0x68
	add r1, r2, r1
	str r1, [r4, #0x90]
	ldr r2, [r4, #0x10]
	ldr r1, [r4, #0x1c]
	add r1, r2, r1
	str r1, [r4, #0x94]
	ldr r2, [r4, #0x20]
	ldr r1, [r4, #0x2c]
	smull ip, r1, r2, r1
	adds r2, ip, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0x5c]
	ldr r2, [r4, #0x24]
	ldr r1, [r4, #0x30]
	smull ip, r1, r2, r1
	adds r2, ip, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0x60]
	ldr r2, [r4, #0x28]
	ldr r1, [r4, #0x34]
	smull ip, r1, r2, r1
	adds r2, ip, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0x64]
	ldrh r2, [r4, #0x3a]
	ldrh r1, [r4, #0x3c]
	add r1, r2, r1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	ldrh r0, [r4, #0x40]
	cmp r0, #0
	beq _02167CB4
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0x24
	bl MTX_RotX33_
	add r0, r4, #0x68
	add r1, sp, #0x24
	mov r2, r0
	bl MTX_Concat33
_02167CB4:
	ldrh r0, [r4, #0x42]
	cmp r0, #0
	beq _02167CF8
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0
	bl MTX_RotZ33_
	add r0, r4, #0x68
	add r1, sp, #0
	mov r2, r0
	bl MTX_Concat33
_02167CF8:
	add r0, r4, #0x44
	bl AnimatorMDL__Draw
	add r0, r4, #0x200
	ldrh r1, [r0, #0xd8]
	ldr r0, =0x0000FFFF
	cmp r1, r0
	addeq sp, sp, #0x48
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x8c]
	add r0, r4, #0x68
	str r1, [r4, #0x1dc]
	ldr r2, [r4, #0x90]
	add r1, r4, #0x1b8
	str r2, [r4, #0x1e0]
	ldr r3, [r4, #0x94]
	mov r2, #0x24
	str r3, [r4, #0x1e4]
	ldr r3, [r4, #0x5c]
	str r3, [r4, #0x1ac]
	ldr r3, [r4, #0x60]
	str r3, [r4, #0x1b0]
	ldr r3, [r4, #0x64]
	str r3, [r4, #0x1b4]
	bl MIi_CpuCopy16
	add r0, r4, #0x194
	bl AnimatorMDL__Draw
	add sp, sp, #0x48
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

// CViShadow
CViShadow::CViShadow()
{
    this->archive = NULL;
    this->texture = NULL;
    this->palette = NULL;
    this->scale   = FLOAT_TO_FX32(6.0);
    this->word14  = 15;
}

CViShadow::~CViShadow()
{
    this->Func_2167E9C();
}

void CViShadow::LoadAssets()
{
    this->Func_2167E9C();

    this->archive = BundleFileUnknown__LoadFile("narc/vi_shadow_lz7.narc", BUNDLEFILEUNKNOWN_AUTO_ALLOC_TAIL);
    
    u32 textureSize = FileUnknown__GetAOUFileSize(this->archive, ARCHIVE_VI_SHADOW_LZ7_FILE_VI_SHADOW_NTFT);
    u32 shadowSize  = FileUnknown__GetAOUFileSize(this->archive, ARCHIVE_VI_SHADOW_LZ7_FILE_VI_SHADOW_NTFP);

    void *textureFile = FileUnknown__GetAOUFile(this->archive, ARCHIVE_VI_SHADOW_LZ7_FILE_VI_SHADOW_NTFT);
    void *shadowFile  = FileUnknown__GetAOUFile(this->archive, ARCHIVE_VI_SHADOW_LZ7_FILE_VI_SHADOW_NTFP);

    this->texture = VRAMSystem__AllocTexture(textureSize, FALSE);
    shadowSize >>= 1;
    this->palette = VRAMSystem__AllocPalette((u16)shadowSize, FALSE);

    QueueUncompressedPixels(textureFile, textureSize, PIXEL_MODE_TEXTURE, VRAMKEY_TO_ADDR(this->texture));
    QueueUncompressedPalette(shadowFile, shadowSize, PALETTE_MODE_TEXTURE, VRAMKEY_TO_KEY(this->palette));
}

void CViShadow::Func_2167E9C()
{
    if (this->archive != NULL)
    {
        HeapFree(HEAP_USER, this->archive);
        this->archive = NULL;
    }

    if ((VRAMKEY_TO_KEY(this->texture) & VRAMSYSTEM_FLAG_ALLOCATED) != 0)
    {
        VRAMSystem__FreeTexture(this->texture);
        this->texture = NULL;
    }

    if ((VRAMKEY_TO_KEY(this->palette) & VRAMSYSTEM_FLAG_ALLOCATED) != 0)
    {
        VRAMSystem__FreePalette(this->palette);
        this->palette = NULL;
    }

    this->scale  = FLOAT_TO_FX32(6.0);
    this->word14 = 15;
}

NONMATCH_FUNC void CViShadow::Func_2167F00()
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x7c
	mov r4, r1
	mov r5, r0
	mov r3, #2
	add r1, sp, #0x18
	mov r0, #0x10
	mov r2, #1
	str r3, [sp, #0x18]
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r2, r1
	mov r0, #0x11
	bl NNS_G3dGeBufferOP_N
	ldr r1, [r5, #0x10]
	mov r0, #0x1000
	str r0, [sp, #0x20]
	str r1, [sp, #0x1c]
	ldr r1, [r5, #0x10]
	add r0, sp, #0x1c
	str r1, [sp, #0x24]
	bl NNS_G3dGlbSetBaseScale
	add r0, sp, #0x28
	bl MTX_Identity33_
	ldr r1, =NNS_G3dGlb+0x000000BC
	add r0, sp, #0x28
	bl MI_Copy36B
	ldr r1, =NNS_G3dGlb
	add r0, sp, #0x1c
	ldr r2, [r1, #0xfc]
	bic r2, r2, #0xa4
	str r2, [r1, #0xfc]
	ldr r2, [r4, #0]
	ldr r1, [r5, #0x10]
	sub r1, r2, r1, asr #1
	str r1, [sp, #0x1c]
	ldr r1, [r4, #4]
	add r1, r1, #0x400
	str r1, [sp, #0x20]
	ldr r2, [r4, #8]
	ldr r1, [r5, #0x10]
	sub r1, r2, r1, asr #1
	str r1, [sp, #0x24]
	bl NNS_G3dGlbSetBaseTrans
	bl NNS_G3dGlbFlushVP
	ldrh r2, [r5, #0x14]
	mov r0, #0x29
	add r1, sp, #0x14
	mov r2, r2, lsl #0x10
	orr r2, r2, #0xc0
	str r2, [sp, #0x14]
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	ldr r2, [r5, #8]
	ldr r0, =0x0007FFFF
	ldr r1, =0x69B00000
	and r0, r2, r0
	orr r0, r1, r0, lsr #3
	str r0, [sp, #0x10]
	mov r0, #0x2a
	add r1, sp, #0x10
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	ldr r2, [r5, #0xc]
	ldr r1, =0x0001FFFF
	mov r0, #0x2b
	and r1, r2, r1
	mov r1, r1, lsr #3
	str r1, [sp, #0xc]
	add r1, sp, #0xc
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r0, #3
	str r0, [sp, #8]
	mov r0, #0x10
	add r1, sp, #8
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, sp, #0x4c
	bl MTX_Identity43_
	mov r3, #0x40000
	add r1, sp, #0x4c
	mov r0, #0x17
	mov r2, #0xc
	str r3, [sp, #0x4c]
	str r3, [sp, #0x5c]
	bl NNS_G3dGeBufferOP_N
	ldr r3, =0x00007FFF
	add r1, sp, #4
	mov r0, #0x20
	mov r2, #1
	str r3, [sp, #4]
	bl NNS_G3dGeBufferOP_N
	ldr r0, =viShadow__dlList
	mov r1, #0x38
	bl NNS_G3dGeSendDL
	mov r2, #1
	add r1, sp, #0
	mov r0, #0x12
	str r2, [sp]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0x7c
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CViShadow::Func_21680B8()
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	mov r5, r1
	mov r6, r0
	cmp r5, #4
	addls pc, pc, r5, lsl #2
	b _0216810C
_021680D4: // jump table
	b _021680E8 // case 0
	b _021680F8 // case 1
	b _02168100 // case 2
	b _02168108 // case 3
	b _021680F0 // case 4
_021680E8:
	mov r0, #1
	b _0216810C
_021680F0:
	mov r0, #0x10
	b _0216810C
_021680F8:
	mov r0, #2
	b _0216810C
_02168100:
	mov r0, #4
	b _0216810C
_02168108:
	mov r0, #8
_0216810C:
	ldr r1, [sp, #0x18]
	mov lr, #0
	cmp r1, #0
	mov ip, #1
	beq _0216814C
_02168120:
	tst r0, ip, lsl lr
	beq _0216813C
	add r1, r6, lr, lsl #1
	add r1, r1, #0x100
	ldrh r4, [r1, #0xc]
	orr r4, r4, #2
	strh r4, [r1, #0xc]
_0216813C:
	add lr, lr, #1
	cmp lr, #5
	blo _02168120
	b _02168174
_0216814C:
	tst r0, ip, lsl lr
	beq _02168168
	add r1, r6, lr, lsl #1
	add r1, r1, #0x100
	ldrh r4, [r1, #0xc]
	bic r4, r4, #2
	strh r4, [r1, #0xc]
_02168168:
	add lr, lr, #1
	cmp lr, #5
	blo _0216814C
_02168174:
	ldr r1, [sp, #0x1c]
	mov lr, #0
	cmp r1, #0
	mov ip, #1
	beq _021681B4
_02168188:
	tst r0, ip, lsl lr
	beq _021681A4
	add r1, r6, lr, lsl #1
	add r1, r1, #0x100
	ldrh r4, [r1, #0xc]
	orr r4, r4, #4
	strh r4, [r1, #0xc]
_021681A4:
	add lr, lr, #1
	cmp lr, #5
	blo _02168188
	b _021681DC
_021681B4:
	tst r0, ip, lsl lr
	beq _021681D0
	add r1, r6, lr, lsl #1
	add r1, r1, #0x100
	ldrh r4, [r1, #0xc]
	bic r4, r4, #4
	strh r4, [r1, #0xc]
_021681D0:
	add lr, lr, #1
	cmp lr, #5
	blo _021681B4
_021681DC:
	add r0, r6, r5, lsl #2
	ldr r0, [r0, #0xe4]
	mov r4, #0
	cmp r0, #0
	ldrne r4, [r0, #0]
	ldr ip, [sp, #0x24]
	mov r0, r6
	mov r1, r5
	str ip, [sp]
	bl AnimatorMDL__SetAnimation
	ldr r0, [sp, #0x20]
	cmp r0, #0
	addne r0, r6, r5, lsl #2
	ldrne r1, [r0, #0xe4]
	cmpne r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	ldr r0, [r1, #8]
	ldrh r0, [r0, #4]
	cmp r4, r0, lsl #12
	movgt r4, #0
	str r4, [r1]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

// CVi3dArrow
CVi3dArrow::CVi3dArrow()
{
    this->materialAnimFile = NULL;
    this->modelFile        = NULL;
}

CVi3dArrow::~CVi3dArrow()
{
    this->Func_2168358();
}

void CVi3dArrow::LoadAssets()
{
    this->Func_2168358();

    this->materialAnimFile = BundleFileUnknown__LoadFileFromBundle("bb/vi_npc.bb", BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_ARROW_NSBMD, BUNDLEFILEUNKNOWN_AUTO_ALLOC_HEAD);
    this->modelFile        = BundleFileUnknown__LoadFileFromBundle("bb/vi_npc.bb", BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_ARROW_NSBCA, BUNDLEFILEUNKNOWN_AUTO_ALLOC_HEAD);

    this->Func_216763C(this->materialAnimFile, 0, FALSE, FALSE, this->modelFile, NULL, NULL, NULL, NULL, 0xFFFF);
    this->Func_2167900(0, TRUE, FALSE, FALSE, FALSE);
}

void CVi3dArrow::Func_2168358()
{
    this->Func_21677C4();

    if (this->modelFile != NULL)
    {
        HeapFree(HEAP_USER, this->modelFile);
        this->modelFile = NULL;
    }

    if (this->materialAnimFile != NULL)
    {
        HeapFree(HEAP_USER, this->materialAnimFile);
        this->materialAnimFile = NULL;
    }
}