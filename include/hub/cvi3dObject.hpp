#ifndef RUSH_CVI3DOBJECT_HPP
#define RUSH_CVI3DOBJECT_HPP

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/graphics/vramSystem.h>
#include <game/math/cppMath.hpp>

// --------------------
// CONSTANTS/MACROS
// --------------------

#define CVI3DOBJECT_RESOURCE_NONE (u16)(-1)

// --------------------
// STRUCTS
// --------------------

class CVi3dObject
{
    void *vTable; // TODO: remove this when constructor/destructors are decompiled properly
public:
    // TODO: uncomment these when they are properly decompiled
    // CVi3dObject();
    // virtual ~CVi3dObject();

    // --------------------
    // ENUMS
    // --------------------

    enum RotationFlags
    {
        FLAG_NONE = 0x00,

        FLAG_TURNING = 1 << 0,
    };

    // --------------------
    // VARIABLES
    // --------------------

    u32 flags;
    CVector3 position;
    CVector3 worldPosition;
    CVector3 scale;
    CVector3 worldScale;
    u16 targetTurnAngle;
    u16 currentTurnAngle;
    u16 rotationY;
    u16 turnSpeed;
    u16 rotationX;
    u16 rotationZ;
    AnimatorMDL aniBody;
    u16 bodyModelSlot;
    u16 bodyAnim[B3D_ANIM_MAX];
    AnimatorMDL aniTail;
    u16 tailModelSlot;
    u16 tailAnim;
    BOOL isChild;
    void *resources[B3D_RESOURCE_MAX];
    BOOL setJoint;
    BOOL setMaterial;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void SetResources(void *resMdl, u16 bodyModelSlot, BOOL setJoint, BOOL setMaterial, void *resAnimJoint, void *resAnimMaterial, void *resAnimPattern, void *resAnimTexture,
                      void *resAnimVisibility, u16 tailModelSlot);
    void SetResources(CVi3dObject *other, u16 bodyModelSlot, BOOL setJoint, BOOL setMaterial, u16 tailModelSlot);
    void Release();
    void SetJointAnimForBody(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL forceApply);
    void SetJointAnimForTail(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL forceApply);
    void SetPatternAnimForBody(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL forceApply);
    void SetTextureAnimForBody(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL forceApply);
    void SetVisibilityAnimForBody(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL forceApply);
    void Process();
    void Draw();

    // --------------------
    // STATIC FUNCTIONS
    // --------------------
    
private:
    static void LoadAnimation(AnimatorMDL *animator, s32 resourceType, void *resource, u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, void *texResource);
};

class CVi3dArrow : public CVi3dObject
{
public:
    // TODO: uncomment these when they are properly decompiled
    // CVi3dArrow();
    // virtual ~CVi3dArrow();

    // --------------------
    // VARIABLES
    // --------------------

    void *materialAnimFile;
    void *modelFile;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void Init();
    void Release();
};

class CViShadow
{
    void *vTable; // TODO: remove this when constructor/destructors are decompiled properly
public:
    // TODO: uncomment these when they are properly decompiled
    // CViShadow();
    // virtual ~CViShadow();

    // --------------------
    // VARIABLES
    // --------------------

    void *archive;
    VRAMPixelKey texture;
    VRAMPaletteKey palette;
    fx32 scale;
    u16 alpha;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void Init();
    void Release();

    void Draw(VecFx32 *position);
};

extern "C"
{

NOT_DECOMPILED void _ZN11CVi3dObjectC1Ev(CVi3dObject *work);
NOT_DECOMPILED void _ZN11CVi3dObjectC2Ev(CVi3dObject *work);
NOT_DECOMPILED void _ZN11CVi3dObjectD0Ev(CVi3dObject *work);
NOT_DECOMPILED void _ZN11CVi3dObjectD1Ev(CVi3dObject *work);
NOT_DECOMPILED void _ZN11CVi3dObjectD2Ev(CVi3dObject *work);

NOT_DECOMPILED void _ZN9CViShadowC1Ev(CViShadow *work);
NOT_DECOMPILED void _ZN9CViShadowD0Ev(CViShadow *work);
NOT_DECOMPILED void _ZN9CViShadowD1Ev(CViShadow *work);

NOT_DECOMPILED void _ZN10CVi3dArrowC1Ev(CVi3dArrow *work);
NOT_DECOMPILED void _ZN10CVi3dArrowD0Ev(CVi3dArrow *work);
NOT_DECOMPILED void _ZN10CVi3dArrowD1Ev(CVi3dArrow *work);

}

#endif // RUSH_CVI3DOBJECT_HPP
