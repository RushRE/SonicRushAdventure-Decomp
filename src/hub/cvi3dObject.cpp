#include <hub/cvi3dObject.hpp>
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
NOT_DECOMPILED void _ZN9CViShadow12Func_2167E9CEv(void);

NOT_DECOMPILED void _ZN10CVi3dArrow12Func_2168358Ev(void);

NOT_DECOMPILED void _ZN11CVi3dObject12Func_21677C4Ev(void);
NOT_DECOMPILED void _ZN11CVi3dObject12Func_21680B8EP12AnimatorMDL_lPvtiiiS2_(void);

NOT_DECOMPILED void _ZdlPv(void);

NOT_DECOMPILED void *_ZTV11CVi3dObject;
NOT_DECOMPILED void *_ZTV10CVi3dArrow;
NOT_DECOMPILED void *_ZTV9CViShadow;
}

// --------------------
// VARIABLES
// --------------------

// TODO: document commands instead of leaving it as a binary blob
static const u8 viShadow__dlList[] = {
    0x40, 0, 0x22, 0x24, 1,    0, 0,    0, 0,    0, 0, 0, 0,    0,    0, 0, 0,    0, 0, 0, 0x22, 0x24, 0x22, 0x24, 0, 0, 0x10, 0,
    0,    0, 0,    4,    0x10, 0, 0x10, 0, 0x40, 0, 0, 4, 0x22, 0x24, 0, 0, 0x10, 0, 0, 0, 0x40, 0,    0,    0,    0, 0, 0,    0,
};

// --------------------
// FUNCTIONS
// --------------------

// CVi3dObject
// NONMATCH_FUNC CVi3dObject::CVi3dObject[base]()
NONMATCH_FUNC void _ZN11CVi3dObjectC1Ev(CVi3dObject *work)
{
#ifdef NON_MATCHING
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
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	mov r4, r0
	ldr r1, =_ZTV11CVi3dObject+0x08
	add r0, r4, #8
	str r1, [r4]
	bl CPPHelpers__Func_2085EE8
	add r0, r4, #0x14
	bl CPPHelpers__Func_2085EE8
	add r0, r4, #0x20
	bl CPPHelpers__Func_2085EE8
	add r0, r4, #0x2c
	bl CPPHelpers__Func_2085EE8
	mov r1, #0
	add r0, sp, #0xc
	mov r2, r1
	mov r3, r1
	str r1, [r4, #4]
	bl CPPHelpers__VEC_Set
	add r0, r4, #8
	add r1, sp, #0xc
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
	mov r1, #0
	strh r1, [r4, #0x38]
	strh r1, [r4, #0x3a]
	ldrh r3, [r4, #0x38]
	ldr r2, =0x0000FFFF
	add r0, r4, #0x100
	strh r3, [r4, #0x3c]
	strh r1, [r4, #0x3e]
	strh r1, [r4, #0x40]
	strh r1, [r4, #0x42]
	strh r2, [r0, #0x88]
	strh r2, [r0, #0x8a]
	strh r2, [r0, #0x8c]
	strh r2, [r0, #0x8e]
	strh r2, [r0, #0x90]
	strh r2, [r0, #0x92]
	add r0, r4, #0x200
	strh r2, [r0, #0xd8]
	strh r2, [r0, #0xda]
	str r1, [r4, #0x2dc]
	str r1, [r4, #0x2e0]
	str r1, [r4, #0x2e4]
	str r1, [r4, #0x2e8]
	str r1, [r4, #0x2ec]
	str r1, [r4, #0x2f0]
	str r1, [r4, #0x2f4]
	str r1, [r4, #0x2f8]
	add r0, r4, #0x44
	str r1, [r4, #0x2fc]
	bl AnimatorMDL__Init
	add r0, r4, #0x194
	mov r1, #0
	bl AnimatorMDL__Init
	mov r0, r4
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// NONMATCH_FUNC CVi3dObject::CVi3dObject()
NONMATCH_FUNC void _ZN11CVi3dObjectC2Ev(CVi3dObject *work)
{
#ifdef NON_MATCHING
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
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	mov r4, r0
	ldr r1, =_ZTV11CVi3dObject+0x08
	add r0, r4, #8
	str r1, [r4]
	bl CPPHelpers__Func_2085EE8
	add r0, r4, #0x14
	bl CPPHelpers__Func_2085EE8
	add r0, r4, #0x20
	bl CPPHelpers__Func_2085EE8
	add r0, r4, #0x2c
	bl CPPHelpers__Func_2085EE8
	mov r1, #0
	add r0, sp, #0xc
	mov r2, r1
	mov r3, r1
	str r1, [r4, #4]
	bl CPPHelpers__VEC_Set
	add r0, r4, #8
	add r1, sp, #0xc
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
	mov r1, #0
	strh r1, [r4, #0x38]
	strh r1, [r4, #0x3a]
	ldrh r3, [r4, #0x38]
	ldr r2, =0x0000FFFF
	add r0, r4, #0x100
	strh r3, [r4, #0x3c]
	strh r1, [r4, #0x3e]
	strh r1, [r4, #0x40]
	strh r1, [r4, #0x42]
	strh r2, [r0, #0x88]
	strh r2, [r0, #0x8a]
	strh r2, [r0, #0x8c]
	strh r2, [r0, #0x8e]
	strh r2, [r0, #0x90]
	strh r2, [r0, #0x92]
	add r0, r4, #0x200
	strh r2, [r0, #0xd8]
	strh r2, [r0, #0xda]
	str r1, [r4, #0x2dc]
	str r1, [r4, #0x2e0]
	str r1, [r4, #0x2e4]
	str r1, [r4, #0x2e8]
	str r1, [r4, #0x2ec]
	str r1, [r4, #0x2f0]
	str r1, [r4, #0x2f4]
	str r1, [r4, #0x2f8]
	add r0, r4, #0x44
	str r1, [r4, #0x2fc]
	bl AnimatorMDL__Init
	add r0, r4, #0x194
	mov r1, #0
	bl AnimatorMDL__Init
	mov r0, r4
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// NONMATCH_FUNC CVi3dObject::~CVi3dObject()
NONMATCH_FUNC void _ZN11CVi3dObjectD0Ev(CVi3dObject *work)
{
#ifdef NON_MATCHING
    this->Func_21677C4();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV11CVi3dObject+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN11CVi3dObject12Func_21677C4Ev
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// NONMATCH_FUNC CVi3dObject::~CVi3dObject[virtual]()
NONMATCH_FUNC void _ZN11CVi3dObjectD1Ev(CVi3dObject *work)
{
#ifdef NON_MATCHING
    this->Func_21677C4();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV11CVi3dObject+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN11CVi3dObject12Func_21677C4Ev
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// NONMATCH_FUNC CVi3dObject::~CVi3dObject[base]()
NONMATCH_FUNC void _ZN11CVi3dObjectD2Ev(CVi3dObject *work)
{
#ifdef NON_MATCHING
    this->Func_21677C4();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV11CVi3dObject+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN11CVi3dObject12Func_21677C4Ev
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

void CVi3dObject::Func_216763C(void *resMdl, u16 id1, BOOL setJoint, BOOL setMaterial, void *resAnimJoint, void *resAnimMaterial, void *resAnimPattern, void *resAnimTexture,
                               void *resAnimVisibility, u16 id2)
{
    this->Func_21677C4();

    this->field_2DC                          = FALSE;
    this->id1                                = id1;
    this->resources[B3D_RESOURCE_MODEL]      = resMdl;
    this->resources[B3D_RESOURCE_JOINT_ANIM] = resAnimJoint;
    this->resources[B3D_RESOURCE_MAT_ANIM]   = resAnimMaterial;
    this->resources[B3D_RESOURCE_PAT_ANIM]   = resAnimPattern;
    this->resources[B3D_RESOURCE_TEX_ANIM]   = resAnimTexture;
    this->resources[B3D_RESOURCE_VIS_ANIM]   = resAnimVisibility;
    this->setJoint                           = setJoint;
    this->setMaterial                        = setMaterial;
    this->id2                                = id2;

    NNS_G3dResDefaultSetup(this->resources[B3D_RESOURCE_MODEL]);
    AnimatorMDL__SetResource(&this->animator1, (const NNSG3dResFileHeader *)this->resources[B3D_RESOURCE_MODEL], this->id1, this->setJoint, this->setMaterial);

    if (this->id2 != 0xFFFF)
        AnimatorMDL__SetResource(&this->animator2, (const NNSG3dResFileHeader *)this->resources[B3D_RESOURCE_MODEL], this->id2, this->setJoint, this->setMaterial);
}

void CVi3dObject::Func_2167704(CVi3dObject *other, u16 id1, BOOL setJoint, BOOL setMaterial, u16 id2)
{
    this->Func_21677C4();

    this->field_2DC                          = TRUE;
    this->id1                                = id1;
    this->resources[B3D_RESOURCE_MODEL]      = other->resources[B3D_RESOURCE_MODEL];
    this->resources[B3D_RESOURCE_JOINT_ANIM] = other->resources[B3D_RESOURCE_JOINT_ANIM];
    this->resources[B3D_RESOURCE_MAT_ANIM]   = other->resources[B3D_RESOURCE_MAT_ANIM];
    this->resources[B3D_RESOURCE_PAT_ANIM]   = other->resources[B3D_RESOURCE_PAT_ANIM];
    this->resources[B3D_RESOURCE_TEX_ANIM]   = other->resources[B3D_RESOURCE_TEX_ANIM];
    this->resources[B3D_RESOURCE_VIS_ANIM]   = other->resources[B3D_RESOURCE_VIS_ANIM];
    this->setJoint                           = setJoint;
    this->setMaterial                        = setMaterial;
    this->id2                                = id2;

    AnimatorMDL__SetResource(&this->animator1, (const NNSG3dResFileHeader *)this->resources[B3D_RESOURCE_MODEL], this->id1, this->setJoint, this->setMaterial);

    if (this->id2 != 0xFFFF)
        AnimatorMDL__SetResource(&this->animator2, (const NNSG3dResFileHeader *)this->resources[B3D_RESOURCE_MODEL], this->id2, this->setJoint, this->setMaterial);
}

void CVi3dObject::Func_21677C4()
{
    AnimatorMDL__Release(&this->animator1);
    AnimatorMDL__Init(&this->animator1, ANIMATOR_FLAG_NONE);

    if (this->id2 != 0xFFFF)
    {
        AnimatorMDL__Release(&this->animator2);
        AnimatorMDL__Init(&this->animator2, ANIMATOR_FLAG_NONE);
    }

    if (this->resources[B3D_RESOURCE_MODEL] != NULL && !this->field_2DC)
    {
        NNS_G3dResDefaultRelease(this->resources[B3D_RESOURCE_MODEL]);
    }

    this->flags = 0;

    VecFx32 a1;
    CPPHelpers__VEC_Set(&a1, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0));
    CPPHelpers__Func_2085FA8(&this->translation1, &a1);
    CPPHelpers__Func_2085FA8(&this->translation2, &this->translation1);

    VecFx32 a2;
    CPPHelpers__VEC_Set(&a2, FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0));
    CPPHelpers__Func_2085FA8(&this->scale1, &a2);
    CPPHelpers__Func_2085FA8(&this->scale2, &this->scale1);

    this->angle                              = 0;
    this->rotationAngle                      = 0;
    this->rotationY2                         = this->angle;
    this->field_3E                           = 0;
    this->rotationX                          = 0;
    this->rotationZ                          = 0;
    this->id1                                = -1;
    this->animator1AnimID                    = -1;
    this->field_18C                          = -1;
    this->field_18E                          = -1;
    this->field_190                          = -1;
    this->field_192                          = -1;
    this->id2                                = -1;
    this->animID2                            = -1;
    this->field_2DC                          = 0;
    this->resources[B3D_RESOURCE_MODEL]      = NULL;
    this->resources[B3D_RESOURCE_JOINT_ANIM] = NULL;
    this->resources[B3D_RESOURCE_MAT_ANIM]   = NULL;
    this->resources[B3D_RESOURCE_PAT_ANIM]   = NULL;
    this->resources[B3D_RESOURCE_TEX_ANIM]   = NULL;
    this->resources[B3D_RESOURCE_VIS_ANIM]   = NULL;
    this->setJoint                           = FALSE;
    this->setMaterial                        = FALSE;
}

void CVi3dObject::Func_2167900(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL forceApply)
{
    if (forceApply || this->animator1AnimID != animID)
    {
        this->animator1AnimID = animID;
        CVi3dObject::Func_21680B8(&this->animator1, B3D_ANIM_JOINT_ANIM, this->resources[B3D_RESOURCE_JOINT_ANIM], this->animator1AnimID, canLoop, blendAnims, keepFrame, NULL);
    }
}

void CVi3dObject::Func_2167958(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL forceApply)
{
    if (forceApply || this->animID2 != animID)
    {
        this->animID2 = animID;
        CVi3dObject::Func_21680B8(&this->animator2, B3D_ANIM_JOINT_ANIM, this->resources[B3D_RESOURCE_JOINT_ANIM], this->animID2, canLoop, blendAnims, keepFrame, NULL);
    }
}

void CVi3dObject::Func_21679B0(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL forceApply)
{
    if (forceApply || this->field_18E != animID)
    {
        this->field_18E = animID;
        CVi3dObject::Func_21680B8(&this->animator1, B3D_ANIM_MAT_ANIM, this->resources[B3D_RESOURCE_PAT_ANIM], this->field_18E, canLoop, blendAnims, keepFrame, NULL);
    }
}

void CVi3dObject::Func_2167A0C(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL forceApply)
{
    if (forceApply || this->field_190 != animID)
    {
        this->field_190 = animID;
        CVi3dObject::Func_21680B8(&this->animator1, B3D_ANIM_PAT_ANIM, this->resources[B3D_RESOURCE_TEX_ANIM], this->field_190, canLoop, blendAnims, keepFrame,
                                  NNS_G3dGetTex((const NNSG3dResFileHeader *)this->resources[B3D_RESOURCE_MODEL]));
    }
}

void CVi3dObject::Func_2167A80(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL forceApply)
{
    if (forceApply || this->field_192 != animID)
    {
        this->field_192 = animID;
        CVi3dObject::Func_21680B8(&this->animator1, B3D_ANIM_TEX_ANIM, this->resources[B3D_RESOURCE_VIS_ANIM], this->field_192, canLoop, blendAnims, keepFrame, NULL);
    }
}

void CVi3dObject::ProcessAnimation()
{
    if ((this->flags & 1) != 0)
    {
        if (this->angle != this->rotationAngle)
        {
            s32 targetAngle  = this->angle + FLOAT_DEG_TO_IDX(360.0);
            s32 currentAngle = this->rotationAngle + FLOAT_DEG_TO_IDX(360.0);

            if (targetAngle < currentAngle)
            {
                if (currentAngle - targetAngle >= FLOAT_DEG_TO_IDX(180.0))
                {
                    currentAngle -= FLOAT_DEG_TO_IDX(360.0);
                }
            }
            else
            {
                if (targetAngle - currentAngle >= FLOAT_DEG_TO_IDX(180.0))
                {
                    targetAngle -= FLOAT_DEG_TO_IDX(360.0);
                }
            }

            if (currentAngle < targetAngle)
            {
                currentAngle += this->field_3E;
                if (currentAngle > targetAngle)
                    currentAngle = targetAngle;
            }
            else if (currentAngle > targetAngle)
            {
                currentAngle -= this->field_3E;
                if (currentAngle < targetAngle)
                    currentAngle = targetAngle;
            }

            this->rotationAngle = currentAngle;
        }
    }
    else
    {
        this->rotationAngle = this->angle;
    }

    AnimatorMDL__ProcessAnimation(&this->animator1);
    if (this->id2 != 0xFFFF)
        AnimatorMDL__ProcessAnimation(&this->animator2);
}

void CVi3dObject::Draw()
{
    this->animator1.work.translation.x = this->translation1.x + this->translation2.x;
    this->animator1.work.translation.y = this->translation1.y + this->translation2.y;
    this->animator1.work.translation.z = this->translation1.z + this->translation2.z;
    this->animator1.work.scale.x       = MultiplyFX(this->scale1.x, this->scale2.x);
    this->animator1.work.scale.y       = MultiplyFX(this->scale1.y, this->scale2.y);
    this->animator1.work.scale.z       = MultiplyFX(this->scale1.z, this->scale2.z);
    MTX_RotY33(&this->animator1.work.matrix33, SinFX(this->rotationAngle + this->rotationY2), CosFX(this->rotationAngle + this->rotationY2));

    if (this->rotationX != FLOAT_DEG_TO_IDX(0.0))
    {
        MtxFx33 mtx;
        MTX_RotX33(&mtx, SinFX(this->rotationX), CosFX(this->rotationX));
        MTX_Concat33(&this->animator1.work.matrix33, &mtx, &this->animator1.work.matrix33);
    }

    if (this->rotationZ != FLOAT_DEG_TO_IDX(0.0))
    {
        MtxFx33 mtx;
        MTX_RotZ33(&mtx, SinFX(this->rotationZ), CosFX(this->rotationZ));
        MTX_Concat33(&this->animator1.work.matrix33, &mtx, &this->animator1.work.matrix33);
    }

    AnimatorMDL__Draw(&this->animator1);

    if (this->id2 != 0xFFFF)
    {
        this->animator2.work.translation.x = this->animator1.work.translation.x;
        this->animator2.work.translation.y = this->animator1.work.translation.y;
        this->animator2.work.translation.z = this->animator1.work.translation.z;
        this->animator2.work.scale.x       = this->animator1.work.scale.x;
        this->animator2.work.scale.y       = this->animator1.work.scale.y;
        this->animator2.work.scale.z       = this->animator1.work.scale.z;
        MI_CpuCopy16(&this->animator1.work.matrix33, &this->animator2.work.matrix33, sizeof(this->animator1.work.matrix33));

        AnimatorMDL__Draw(&this->animator2);
    }
}

// CViShadow
// NONMATCH_FUNC CViShadow::CViShadow()
NONMATCH_FUNC void _ZN9CViShadowC1Ev(CViShadow *work)
{
#ifdef NON_MATCHING
    this->archive = NULL;
    this->texture = NULL;
    this->palette = NULL;
    this->scale   = FLOAT_TO_FX32(6.0);
    this->word14  = 15;
#else
    // clang-format off
	ldr r2, =_ZTV9CViShadow+0x08
	mov r1, #0
	str r2, [r0]
	str r1, [r0, #4]
	str r1, [r0, #8]
	str r1, [r0, #0xc]
	mov r1, #0x6000
	str r1, [r0, #0x10]
	mov r1, #0xf
	strh r1, [r0, #0x14]
	bx lr
// clang-format on
#endif
}

// NONMATCH_FUNC CViShadow::~CViShadow()
NONMATCH_FUNC void _ZN9CViShadowD0Ev(CViShadow *work)
{
#ifdef NON_MATCHING
    this->Func_2167E9C();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV9CViShadow+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN9CViShadow12Func_2167E9CEv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// NONMATCH_FUNC CViShadow::~CViShadow()
NONMATCH_FUNC void _ZN9CViShadowD1Ev(CViShadow *work)
{
#ifdef NON_MATCHING
    this->Func_2167E9C();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV9CViShadow+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN9CViShadow12Func_2167E9CEv
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
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

void CViShadow::Func_2167F00(VecFx32 *position)
{
    MtxFx43 mtx;
    MtxFx33 mtxRot;
    VecFx32 scale;

    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION_VECTOR);
    NNS_G3dGePushMtx();

    scale.x = this->scale;
    scale.y = FLOAT_TO_FX32(1.0);
    scale.z = this->scale;
    NNS_G3dGlbSetBaseScale(&scale);

    MTX_Identity33(&mtxRot);
    NNS_G3dGlbSetBaseRot(&mtxRot);

    scale.x = position->x - (this->scale >> 1);
    scale.y = position->y + 1024;
    scale.z = position->z - (this->scale >> 1);
    NNS_G3dGlbSetBaseTrans(&scale);
    NNS_G3dGlbFlushVP();

    NNS_G3dGePolygonAttr(GX_LIGHTMASK_NONE, GX_POLYGONMODE_MODULATE, GX_CULL_NONE, 0, this->word14, GX_POLYGON_ATTR_MISC_NONE);

    NNS_G3dGeTexImageParam(GX_TEXFMT_PLTT4, GX_TEXGEN_TEXCOORD, GX_TEXSIZE_S64, GX_TEXSIZE_T64, GX_TEXREPEAT_NONE, GX_TEXFLIP_NONE, GX_TEXPLTTCOLOR0_TRNS,
                           VRAMKEY_TO_KEY(this->texture) & 0x7FFFF);

    NNS_G3dGeTexPlttBase(VRAMKEY_TO_KEY(this->palette) & 0x1FFFF, GX_TEXFMT_PLTT4);

    NNS_G3dGeMtxMode(GX_MTXMODE_TEXTURE);
    MTX_Identity43(&mtx);
    mtx.m[0][0] = FLOAT_TO_FX32(64.0);
    mtx.m[1][1] = FLOAT_TO_FX32(64.0);
    NNS_G3dGeLoadMtx43(&mtx);

    NNS_G3dGeColor(GX_RGB_888(0xFF, 0xFF, 0xFF));
    NNS_G3dGeSendDL(viShadow__dlList, sizeof(viShadow__dlList));

    NNS_G3dGePopMtx(1);
}

void CVi3dObject::Func_21680B8(AnimatorMDL *animator, s32 resourceType, void *resource, u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, void *texResource)
{
    u32 resourceFlags;
    switch (resourceType)
    {
        case B3D_ANIM_JOINT_ANIM:
            resourceFlags = B3D_ANIM_FLAG_JOINT_ANIM;
            break;

        case B3D_ANIM_VIS_ANIM:
            resourceFlags = B3D_ANIM_FLAG_VIS_ANIM;
            break;

        case B3D_ANIM_MAT_ANIM:
            resourceFlags = B3D_ANIM_FLAG_MAT_ANIM;
            break;

        case B3D_ANIM_PAT_ANIM:
            resourceFlags = B3D_ANIM_FLAG_PAT_ANIM;
            break;

        case B3D_ANIM_TEX_ANIM:
            resourceFlags = B3D_ANIM_FLAG_TEX_ANIM;
            break;
    }

    if (canLoop)
    {
        for (u32 r = 0; r < B3D_ANIM_MAX; r++)
        {
            if ((resourceFlags & (1 << r)) != 0)
                animator->animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
        }
    }
    else
    {
        for (u32 r = 0; r < B3D_ANIM_MAX; r++)
        {
            if ((resourceFlags & (1 << r)) != 0)
                animator->animFlags[r] &= ~ANIMATORMDL_FLAG_CAN_LOOP;
        }
    }

    if (blendAnims)
    {
        for (u32 r = 0; r < B3D_ANIM_MAX; r++)
        {
            if ((resourceFlags & (1 << r)) != 0)
                animator->animFlags[r] |= ANIMATORMDL_FLAG_BLEND_ANIMATIONS;
        }
    }
    else
    {
        for (u32 r = 0; r < B3D_ANIM_MAX; r++)
        {
            if ((resourceFlags & (1 << r)) != 0)
                animator->animFlags[r] &= ~ANIMATORMDL_FLAG_BLEND_ANIMATIONS;
        }
    }

    fx32 frame = FLOAT_TO_FX32(0.0);
    if (animator->currentAnimObj[resourceType] != NULL)
        frame = animator->currentAnimObj[resourceType]->frame;

    AnimatorMDL__SetAnimation(animator, resourceType, (const NNSG3dResFileHeader *)resource, animID, (const NNSG3dResTex *)texResource);

    if (keepFrame && animator->currentAnimObj[resourceType] != NULL)
    {
        if (frame > NNS_G3dAnmObjGetNumFrame(animator->currentAnimObj[resourceType]))
            frame = FLOAT_TO_FX32(0.0);

        animator->currentAnimObj[resourceType]->frame = frame;
    }
}

// CVi3dArrow
// NONMATCH_FUNC CVi3dArrow::CVi3dArrow()
NONMATCH_FUNC void _ZN10CVi3dArrowC1Ev(CVi3dArrow *work)
{
#ifdef NON_MATCHING
    this->materialAnimFile = NULL;
    this->modelFile        = NULL;
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl _ZN11CVi3dObjectC1Ev
	ldr r0, =_ZTV10CVi3dArrow+0x08
	mov r1, #0
	str r0, [r4]
	str r1, [r4, #0x300]
	mov r0, r4
	str r1, [r4, #0x304]
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// NONMATCH_FUNC CVi3dArrow::~CVi3dArrow()
NONMATCH_FUNC void _ZN10CVi3dArrowD0Ev(CVi3dArrow *work)
{
#ifdef NON_MATCHING
    this->Func_2168358();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV10CVi3dArrow+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN10CVi3dArrow12Func_2168358Ev
	mov r0, r4
	bl _ZN11CVi3dObjectD2Ev
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// NONMATCH_FUNC CVi3dArrow::~CVi3dArrow()
NONMATCH_FUNC void _ZN10CVi3dArrowD1Ev(CVi3dArrow *work)
{
#ifdef NON_MATCHING
    this->Func_2168358();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV10CVi3dArrow+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN10CVi3dArrow12Func_2168358Ev
	mov r0, r4
	bl _ZN11CVi3dObjectD2Ev
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
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