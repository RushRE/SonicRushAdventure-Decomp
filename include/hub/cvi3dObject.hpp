#ifndef RUSH_CVI3DOBJECT_HPP
#define RUSH_CVI3DOBJECT_HPP

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/graphics/vramSystem.h>

// --------------------
// STRUCTS
// --------------------

class CVi3dObject
{
public:
    CVi3dObject();
    virtual ~CVi3dObject();

    // --------------------
    // VARIABLES
    // --------------------

    u32 flags;
    VecFx32 translation1;
    VecFx32 translation2;
    VecFx32 scale1;
    VecFx32 scale2;
    u16 angle;
    u16 rotationAngle;
    u16 rotationY2;
    u16 field_3E;
    u16 rotationX;
    u16 rotationZ;
    AnimatorMDL animator1;
    u16 id1;
    u16 animator1AnimID;
    u16 field_18C;
    u16 field_18E;
    u16 field_190;
    u16 field_192;
    AnimatorMDL animator2;
    u16 id2;
    u16 animID2;
    u32 field_2DC;
    void *resources[6];
    BOOL setJoint;
    BOOL setMaterial;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void Func_216763C(void *resMdl, u16 id1, BOOL setJoint, BOOL setMaterial, void *resAnimJoint, void *resAnimMaterial, void *resAnimPattern, void *resAnimTexture,
                      void *resAnimVisibility, u16 id2);
    void Func_2167704(CVi3dObject *other, u16 id1, BOOL setJoint, BOOL setMaterial, u16 id2);
    void Func_21677C4();
    void Func_2167900(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL a6);
    void Func_2167958(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL a6);
    void Func_21679B0(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL a6);
    void Func_2167A0C(u16 animID, BOOL canLoop, BOOL blendAnims, BOOL keepFrame, BOOL a6);
    void Func_2167A80();
    void ProcessAnimation();
    void Draw();

    // --------------------
    // STATIC FUNCTIONS
    // --------------------
};

class CVi3dArrow : public CVi3dObject
{
public:
    CVi3dArrow();
    virtual ~CVi3dArrow();

    // --------------------
    // VARIABLES
    // --------------------

    void *materialAnimFile;
    void *modelFile;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void LoadAssets();
    void Func_2168358();

    // --------------------
    // STATIC FUNCTIONS
    // --------------------
};

class CViShadow
{
public:
    CViShadow();
    virtual ~CViShadow();

    // --------------------
    // VARIABLES
    // --------------------

    void *archive;
    VRAMPixelKey texture;
    VRAMPaletteKey palette;
    fx32 scale;
    u16 word14;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void LoadAssets();
    void Func_2167E9C();

    void Func_2167F00();
    void Func_21680B8();

    // --------------------
    // STATIC FUNCTIONS
    // --------------------
};

#endif // RUSH_CVI3DOBJECT_HPP
