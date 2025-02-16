#include <hub/cvi3dObject.hpp>
#include <game/math/cppMath.hpp>
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
NOT_DECOMPILED void _ZN9CViShadow7ReleaseEv(void);

NOT_DECOMPILED void _ZN10CVi3dArrow7ReleaseEv(void);

NOT_DECOMPILED void _ZN11CVi3dObject7ReleaseEv(void);
NOT_DECOMPILED void _ZN11CVi3dObject12Func_21680B8EP12AnimatorMDL_lPvtiiiS2_(void);

NOT_DECOMPILED void _ZdlPv(void);

NOT_DECOMPILED void _ZN8CVector3C1Ev(void);
NOT_DECOMPILED void _ZN8CVector3C1Elll(void);
NOT_DECOMPILED void _ZN8CVector3aSERKS_(void);

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
    this->flags = FLAG_NONE;

    this->position      = CVector3(0, 0, 0);
    this->worldPosition = this->position;
    this->scale         = CVector3(FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0));
    this->worldScale    = this->scale;

    this->targetTurnAngle               = 0;
    this->currentTurnAngle              = 0;
    this->rotationY                     = this->targetTurnAngle;
    this->turnSpeed                     = 0;
    this->rotationX                     = 0;
    this->rotationZ                     = 0;
    this->bodyModelSlot                 = CVI3DOBJECT_RESOURCE_NONE;
    this->bodyAnim[B3D_ANIM_JOINT_ANIM] = CVI3DOBJECT_RESOURCE_NONE;
    this->bodyAnim[B3D_ANIM_MAT_ANIM]   = CVI3DOBJECT_RESOURCE_NONE;
    this->bodyAnim[B3D_ANIM_PAT_ANIM]   = CVI3DOBJECT_RESOURCE_NONE;
    this->bodyAnim[B3D_ANIM_TEX_ANIM]   = CVI3DOBJECT_RESOURCE_NONE;
    this->bodyAnim[B3D_ANIM_VIS_ANIM]   = CVI3DOBJECT_RESOURCE_NONE;
    this->tailModelSlot                 = CVI3DOBJECT_RESOURCE_NONE;
    this->tailAnim                      = CVI3DOBJECT_RESOURCE_NONE;
    this->isChild                       = FALSE;
    this->resources[0]                  = NULL;
    this->resources[1]                  = NULL;
    this->resources[2]                  = NULL;
    this->resources[3]                  = NULL;
    this->resources[4]                  = NULL;
    this->resources[5]                  = NULL;
    this->setJoint                      = FALSE;
    this->setMaterial                   = FALSE;
    AnimatorMDL__Init(&this->aniBody, ANIMATOR_FLAG_NONE);
    AnimatorMDL__Init(&this->aniTail, ANIMATOR_FLAG_NONE);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	mov r4, r0
	ldr r1, =_ZTV11CVi3dObject+0x08
	add r0, r4, #8
	str r1, [r4]
	bl _ZN8CVector3C1Ev
	add r0, r4, #0x14
	bl _ZN8CVector3C1Ev
	add r0, r4, #0x20
	bl _ZN8CVector3C1Ev
	add r0, r4, #0x2c
	bl _ZN8CVector3C1Ev
	mov r1, #0
	add r0, sp, #0xc
	mov r2, r1
	mov r3, r1
	str r1, [r4, #4]
	bl _ZN8CVector3C1Elll
	add r0, r4, #8
	add r1, sp, #0xc
	bl _ZN8CVector3aSERKS_
	add r0, r4, #0x14
	add r1, r4, #8
	bl _ZN8CVector3aSERKS_
	mov r1, #0x1000
	add r0, sp, #0
	mov r2, r1
	mov r3, r1
	bl _ZN8CVector3C1Elll
	add r0, r4, #0x20
	add r1, sp, #0
	bl _ZN8CVector3aSERKS_
	add r0, r4, #0x2c
	add r1, r4, #0x20
	bl _ZN8CVector3aSERKS_
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
    this->flags = FLAG_NONE;

    this->position      = CVector3(0, 0, 0);
    this->worldPosition = this->position;
    this->scale         = CVector3(FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0));
    this->worldScale    = this->scale;

    this->targetTurnAngle               = 0;
    this->currentTurnAngle              = 0;
    this->rotationY                     = this->targetTurnAngle;
    this->turnSpeed                     = 0;
    this->rotationX                     = 0;
    this->rotationZ                     = 0;
    this->bodyModelSlot                 = CVI3DOBJECT_RESOURCE_NONE;
    this->bodyAnim[B3D_ANIM_JOINT_ANIM] = CVI3DOBJECT_RESOURCE_NONE;
    this->bodyAnim[B3D_ANIM_MAT_ANIM]   = CVI3DOBJECT_RESOURCE_NONE;
    this->bodyAnim[B3D_ANIM_PAT_ANIM]   = CVI3DOBJECT_RESOURCE_NONE;
    this->bodyAnim[B3D_ANIM_TEX_ANIM]   = CVI3DOBJECT_RESOURCE_NONE;
    this->bodyAnim[B3D_ANIM_VIS_ANIM]   = CVI3DOBJECT_RESOURCE_NONE;
    this->tailModelSlot                 = CVI3DOBJECT_RESOURCE_NONE;
    this->tailAnim                      = CVI3DOBJECT_RESOURCE_NONE;
    this->isChild                       = FALSE;
    this->resources[0]                  = NULL;
    this->resources[1]                  = NULL;
    this->resources[2]                  = NULL;
    this->resources[3]                  = NULL;
    this->resources[4]                  = NULL;
    this->resources[5]                  = NULL;
    this->setJoint                      = FALSE;
    this->setMaterial                   = FALSE;
    AnimatorMDL__Init(&this->aniBody, ANIMATOR_FLAG_NONE);
    AnimatorMDL__Init(&this->aniTail, ANIMATOR_FLAG_NONE);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	mov r4, r0
	ldr r1, =_ZTV11CVi3dObject+0x08
	add r0, r4, #8
	str r1, [r4]
	bl _ZN8CVector3C1Ev
	add r0, r4, #0x14
	bl _ZN8CVector3C1Ev
	add r0, r4, #0x20
	bl _ZN8CVector3C1Ev
	add r0, r4, #0x2c
	bl _ZN8CVector3C1Ev
	mov r1, #0
	add r0, sp, #0xc
	mov r2, r1
	mov r3, r1
	str r1, [r4, #4]
	bl _ZN8CVector3C1Elll
	add r0, r4, #8
	add r1, sp, #0xc
	bl _ZN8CVector3aSERKS_
	add r0, r4, #0x14
	add r1, r4, #8
	bl _ZN8CVector3aSERKS_
	mov r1, #0x1000
	add r0, sp, #0
	mov r2, r1
	mov r3, r1
	bl _ZN8CVector3C1Elll
	add r0, r4, #0x20
	add r1, sp, #0
	bl _ZN8CVector3aSERKS_
	add r0, r4, #0x2c
	add r1, r4, #0x20
	bl _ZN8CVector3aSERKS_
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
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV11CVi3dObject+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN11CVi3dObject7ReleaseEv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// NONMATCH_FUNC CVi3dObject::~CVi3dObject[virtual]()
NONMATCH_FUNC void _ZN11CVi3dObjectD1Ev(CVi3dObject *work)
{
#ifdef NON_MATCHING
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV11CVi3dObject+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN11CVi3dObject7ReleaseEv
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
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV11CVi3dObject+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN11CVi3dObject7ReleaseEv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

void CVi3dObject::SetResources(void *resMdl, u16 bodyModelSlot, BOOL setJoint, BOOL setMaterial, void *resAnimJoint, void *resAnimMaterial, void *resAnimPattern,
                               void *resAnimTexture, void *resAnimVisibility, u16 tailModelSlot)
{
    this->Release();

    this->isChild                            = FALSE;
    this->bodyModelSlot                      = bodyModelSlot;
    this->resources[B3D_RESOURCE_MODEL]      = resMdl;
    this->resources[B3D_RESOURCE_JOINT_ANIM] = resAnimJoint;
    this->resources[B3D_RESOURCE_MAT_ANIM]   = resAnimMaterial;
    this->resources[B3D_RESOURCE_PAT_ANIM]   = resAnimPattern;
    this->resources[B3D_RESOURCE_TEX_ANIM]   = resAnimTexture;
    this->resources[B3D_RESOURCE_VIS_ANIM]   = resAnimVisibility;
    this->setJoint                           = setJoint;
    this->setMaterial                        = setMaterial;
    this->tailModelSlot                      = tailModelSlot;

    NNS_G3dResDefaultSetup(this->resources[B3D_RESOURCE_MODEL]);
    AnimatorMDL__SetResource(&this->aniBody, (const NNSG3dResFileHeader *)this->resources[B3D_RESOURCE_MODEL], this->bodyModelSlot, this->setJoint, this->setMaterial);

    if (this->tailModelSlot != CVI3DOBJECT_RESOURCE_NONE)
        AnimatorMDL__SetResource(&this->aniTail, (const NNSG3dResFileHeader *)this->resources[B3D_RESOURCE_MODEL], this->tailModelSlot, this->setJoint, this->setMaterial);
}

void CVi3dObject::SetResources(CVi3dObject *other, u16 bodyModelSlot, BOOL setJoint, BOOL setMaterial, u16 tailModelSlot)
{
    this->Release();

    this->isChild                            = TRUE;
    this->bodyModelSlot                      = bodyModelSlot;
    this->resources[B3D_RESOURCE_MODEL]      = other->resources[B3D_RESOURCE_MODEL];
    this->resources[B3D_RESOURCE_JOINT_ANIM] = other->resources[B3D_RESOURCE_JOINT_ANIM];
    this->resources[B3D_RESOURCE_MAT_ANIM]   = other->resources[B3D_RESOURCE_MAT_ANIM];
    this->resources[B3D_RESOURCE_PAT_ANIM]   = other->resources[B3D_RESOURCE_PAT_ANIM];
    this->resources[B3D_RESOURCE_TEX_ANIM]   = other->resources[B3D_RESOURCE_TEX_ANIM];
    this->resources[B3D_RESOURCE_VIS_ANIM]   = other->resources[B3D_RESOURCE_VIS_ANIM];
    this->setJoint                           = setJoint;
    this->setMaterial                        = setMaterial;
    this->tailModelSlot                      = tailModelSlot;

    AnimatorMDL__SetResource(&this->aniBody, (const NNSG3dResFileHeader *)this->resources[B3D_RESOURCE_MODEL], this->bodyModelSlot, this->setJoint, this->setMaterial);

    if (this->tailModelSlot != CVI3DOBJECT_RESOURCE_NONE)
        AnimatorMDL__SetResource(&this->aniTail, (const NNSG3dResFileHeader *)this->resources[B3D_RESOURCE_MODEL], this->tailModelSlot, this->setJoint, this->setMaterial);
}

void CVi3dObject::Release()
{
    AnimatorMDL__Release(&this->aniBody);
    AnimatorMDL__Init(&this->aniBody, ANIMATOR_FLAG_NONE);

    if (this->tailModelSlot != CVI3DOBJECT_RESOURCE_NONE)
    {
        AnimatorMDL__Release(&this->aniTail);
        AnimatorMDL__Init(&this->aniTail, ANIMATOR_FLAG_NONE);
    }

    if (this->resources[B3D_RESOURCE_MODEL] != NULL && !this->isChild)
    {
        NNS_G3dResDefaultRelease(this->resources[B3D_RESOURCE_MODEL]);
    }

    this->flags = FLAG_NONE;

    this->position      = CVector3(0, 0, 0);
    this->worldPosition = this->position;
    this->scale         = CVector3(FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0));
    this->worldScale    = this->scale;

    this->targetTurnAngle                    = 0;
    this->currentTurnAngle                   = 0;
    this->rotationY                          = this->targetTurnAngle;
    this->turnSpeed                          = 0;
    this->rotationX                          = 0;
    this->rotationZ                          = 0;
    this->bodyModelSlot                      = CVI3DOBJECT_RESOURCE_NONE;
    this->bodyAnim[B3D_ANIM_JOINT_ANIM]      = CVI3DOBJECT_RESOURCE_NONE;
    this->bodyAnim[B3D_ANIM_MAT_ANIM]        = CVI3DOBJECT_RESOURCE_NONE;
    this->bodyAnim[B3D_ANIM_PAT_ANIM]        = CVI3DOBJECT_RESOURCE_NONE;
    this->bodyAnim[B3D_ANIM_TEX_ANIM]        = CVI3DOBJECT_RESOURCE_NONE;
    this->bodyAnim[B3D_ANIM_VIS_ANIM]        = CVI3DOBJECT_RESOURCE_NONE;
    this->tailModelSlot                      = CVI3DOBJECT_RESOURCE_NONE;
    this->tailAnim                           = CVI3DOBJECT_RESOURCE_NONE;
    this->isChild                            = FALSE;
    this->resources[B3D_RESOURCE_MODEL]      = NULL;
    this->resources[B3D_RESOURCE_JOINT_ANIM] = NULL;
    this->resources[B3D_RESOURCE_MAT_ANIM]   = NULL;
    this->resources[B3D_RESOURCE_PAT_ANIM]   = NULL;
    this->resources[B3D_RESOURCE_TEX_ANIM]   = NULL;
    this->resources[B3D_RESOURCE_VIS_ANIM]   = NULL;
    this->setJoint                           = FALSE;
    this->setMaterial                        = FALSE;
}

void CVi3dObject::SetJointAnimForBody(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL forceApply)
{
    if (forceApply || this->bodyAnim[B3D_ANIM_JOINT_ANIM] != animID)
    {
        this->bodyAnim[B3D_ANIM_JOINT_ANIM] = animID;
        CVi3dObject::LoadAnimation(&this->aniBody, B3D_ANIM_JOINT_ANIM, this->resources[B3D_RESOURCE_JOINT_ANIM], this->bodyAnim[B3D_ANIM_JOINT_ANIM], canLoop, blendAnims,
                                   keepFrame, NULL);
    }
}

void CVi3dObject::SetJointAnimForTail(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL forceApply)
{
    if (forceApply || this->tailAnim != animID)
    {
        this->tailAnim = animID;
        CVi3dObject::LoadAnimation(&this->aniTail, B3D_ANIM_JOINT_ANIM, this->resources[B3D_RESOURCE_JOINT_ANIM], this->tailAnim, canLoop, blendAnims, keepFrame, NULL);
    }
}

void CVi3dObject::SetPatternAnimForBody(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL forceApply)
{
    if (forceApply || this->bodyAnim[B3D_ANIM_PAT_ANIM] != animID)
    {
        this->bodyAnim[B3D_ANIM_PAT_ANIM] = animID;
        CVi3dObject::LoadAnimation(&this->aniBody, B3D_ANIM_MAT_ANIM, this->resources[B3D_RESOURCE_PAT_ANIM], this->bodyAnim[B3D_ANIM_PAT_ANIM], canLoop, blendAnims, keepFrame,
                                   NULL);
    }
}

void CVi3dObject::SetTextureAnimForBody(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL forceApply)
{
    if (forceApply || this->bodyAnim[B3D_ANIM_TEX_ANIM] != animID)
    {
        this->bodyAnim[B3D_ANIM_TEX_ANIM] = animID;
        CVi3dObject::LoadAnimation(&this->aniBody, B3D_ANIM_PAT_ANIM, this->resources[B3D_RESOURCE_TEX_ANIM], this->bodyAnim[B3D_ANIM_TEX_ANIM], canLoop, blendAnims, keepFrame,
                                   NNS_G3dGetTex((const NNSG3dResFileHeader *)this->resources[B3D_RESOURCE_MODEL]));
    }
}

void CVi3dObject::SetVisibilityAnimForBody(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL forceApply)
{
    if (forceApply || this->bodyAnim[B3D_ANIM_VIS_ANIM] != animID)
    {
        this->bodyAnim[B3D_ANIM_VIS_ANIM] = animID;
        CVi3dObject::LoadAnimation(&this->aniBody, B3D_ANIM_TEX_ANIM, this->resources[B3D_RESOURCE_VIS_ANIM], this->bodyAnim[B3D_ANIM_VIS_ANIM], canLoop, blendAnims, keepFrame,
                                   NULL);
    }
}

void CVi3dObject::Process()
{
    if ((this->flags & CVi3dObject::FLAG_TURNING) != 0)
    {
        if (this->targetTurnAngle != this->currentTurnAngle)
        {
            s32 targetTurnAngle = this->targetTurnAngle + FLOAT_DEG_TO_IDX(360.0);
            s32 currentAngle    = this->currentTurnAngle + FLOAT_DEG_TO_IDX(360.0);

            if (targetTurnAngle < currentAngle)
            {
                if (currentAngle - targetTurnAngle >= FLOAT_DEG_TO_IDX(180.0))
                {
                    currentAngle -= FLOAT_DEG_TO_IDX(360.0);
                }
            }
            else
            {
                if (targetTurnAngle - currentAngle >= FLOAT_DEG_TO_IDX(180.0))
                {
                    targetTurnAngle -= FLOAT_DEG_TO_IDX(360.0);
                }
            }

            if (currentAngle < targetTurnAngle)
            {
                currentAngle += this->turnSpeed;
                if (currentAngle > targetTurnAngle)
                    currentAngle = targetTurnAngle;
            }
            else if (currentAngle > targetTurnAngle)
            {
                currentAngle -= this->turnSpeed;
                if (currentAngle < targetTurnAngle)
                    currentAngle = targetTurnAngle;
            }

            this->currentTurnAngle = currentAngle;
        }
    }
    else
    {
        this->currentTurnAngle = this->targetTurnAngle;
    }

    AnimatorMDL__ProcessAnimation(&this->aniBody);
    if (this->tailModelSlot != CVI3DOBJECT_RESOURCE_NONE)
        AnimatorMDL__ProcessAnimation(&this->aniTail);
}

void CVi3dObject::Draw()
{
    this->aniBody.work.translation.x = this->position.x + this->worldPosition.x;
    this->aniBody.work.translation.y = this->position.y + this->worldPosition.y;
    this->aniBody.work.translation.z = this->position.z + this->worldPosition.z;
    this->aniBody.work.scale.x       = MultiplyFX(this->scale.x, this->worldScale.x);
    this->aniBody.work.scale.y       = MultiplyFX(this->scale.y, this->worldScale.y);
    this->aniBody.work.scale.z       = MultiplyFX(this->scale.z, this->worldScale.z);
    MTX_RotY33(&this->aniBody.work.matrix33, SinFX(this->currentTurnAngle + this->rotationY), CosFX(this->currentTurnAngle + this->rotationY));

    if (this->rotationX != FLOAT_DEG_TO_IDX(0.0))
    {
        MtxFx33 mtx;
        MTX_RotX33(&mtx, SinFX(this->rotationX), CosFX(this->rotationX));
        MTX_Concat33(&this->aniBody.work.matrix33, &mtx, &this->aniBody.work.matrix33);
    }

    if (this->rotationZ != FLOAT_DEG_TO_IDX(0.0))
    {
        MtxFx33 mtx;
        MTX_RotZ33(&mtx, SinFX(this->rotationZ), CosFX(this->rotationZ));
        MTX_Concat33(&this->aniBody.work.matrix33, &mtx, &this->aniBody.work.matrix33);
    }

    AnimatorMDL__Draw(&this->aniBody);

    if (this->tailModelSlot != CVI3DOBJECT_RESOURCE_NONE)
    {
        this->aniTail.work.translation.x = this->aniBody.work.translation.x;
        this->aniTail.work.translation.y = this->aniBody.work.translation.y;
        this->aniTail.work.translation.z = this->aniBody.work.translation.z;
        this->aniTail.work.scale.x       = this->aniBody.work.scale.x;
        this->aniTail.work.scale.y       = this->aniBody.work.scale.y;
        this->aniTail.work.scale.z       = this->aniBody.work.scale.z;
        MI_CpuCopy16(&this->aniBody.work.matrix33, &this->aniTail.work.matrix33, sizeof(this->aniBody.work.matrix33));

        AnimatorMDL__Draw(&this->aniTail);
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
    this->alpha   = GX_COLOR_FROM_888(0x7F);
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
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV9CViShadow+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN9CViShadow7ReleaseEv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// NONMATCH_FUNC CViShadow::~CViShadow()
NONMATCH_FUNC void _ZN9CViShadowD1Ev(CViShadow *work)
{
#ifdef NON_MATCHING
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV9CViShadow+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN9CViShadow7ReleaseEv
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

void CViShadow::Init()
{
    this->Release();

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

void CViShadow::Release()
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

    this->scale = FLOAT_TO_FX32(6.0);
    this->alpha = GX_COLOR_FROM_888(0x7F);
}

void CViShadow::Draw(VecFx32 &position)
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

    scale.x = position.x - (this->scale >> 1);
    scale.y = position.y + 1024;
    scale.z = position.z - (this->scale >> 1);
    NNS_G3dGlbSetBaseTrans(&scale);
    NNS_G3dGlbFlushVP();

    NNS_G3dGePolygonAttr(GX_LIGHTMASK_NONE, GX_POLYGONMODE_MODULATE, GX_CULL_NONE, 0, this->alpha, GX_POLYGON_ATTR_MISC_NONE);

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

void CVi3dObject::LoadAnimation(AnimatorMDL *animator, s32 resourceType, void *resource, u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, void *texResource)
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
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV10CVi3dArrow+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN10CVi3dArrow7ReleaseEv
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
    this->Release();
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =_ZTV10CVi3dArrow+0x08
	mov r4, r0
	str r1, [r4]
	bl _ZN10CVi3dArrow7ReleaseEv
	mov r0, r4
	bl _ZN11CVi3dObjectD2Ev
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

void CVi3dArrow::Init()
{
    this->Release();

    this->materialAnimFile = BundleFileUnknown__LoadFileFromBundle("bb/vi_npc.bb", BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_ARROW_NSBMD, BUNDLEFILEUNKNOWN_AUTO_ALLOC_HEAD);
    this->modelFile        = BundleFileUnknown__LoadFileFromBundle("bb/vi_npc.bb", BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_ARROW_NSBCA, BUNDLEFILEUNKNOWN_AUTO_ALLOC_HEAD);

    this->SetResources(this->materialAnimFile, 0, FALSE, FALSE, this->modelFile, NULL, NULL, NULL, NULL, CVI3DOBJECT_RESOURCE_NONE);
    this->SetJointAnimForBody(0, TRUE, FALSE, FALSE, FALSE);
}

void CVi3dArrow::Release()
{
    CVi3dObject::Release();

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