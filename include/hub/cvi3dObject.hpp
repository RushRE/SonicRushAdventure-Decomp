#ifndef RUSH_VI3DOBJECT_HPP
#define RUSH_VI3DOBJECT_HPP

#include <game/system/task.h>
#include <game/graphics/sprite.h>

// --------------------
// STRUCTS
// --------------------

class CVi3dObject
{
    void *vTable;

public:

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

    // --------------------
    // STATIC FUNCTIONS
    // --------------------
};

// --------------------
// FUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

NOT_DECOMPILED void Vi3dObject__Constructor(void);
NOT_DECOMPILED void Vi3dObject__VTableFunc_21675D4(void);
NOT_DECOMPILED void Vi3dObject__VTableFunc_21675F4(void);
NOT_DECOMPILED void Vi3dObject__Func_216761C(void);
NOT_DECOMPILED void Vi3dObject__Func_216763C(void);
NOT_DECOMPILED void Vi3dObject__Func_2167704(void);
NOT_DECOMPILED void Vi3dObject__Func_21677C4(void);
NOT_DECOMPILED void Vi3dObject__Func_2167900(void);
NOT_DECOMPILED void Vi3dObject__Func_2167958(void);
NOT_DECOMPILED void Vi3dObject__Func_21679B0(void);
NOT_DECOMPILED void Vi3dObject__Func_2167A0C(void);
NOT_DECOMPILED void Vi3dObject__Func_2167A80(void);
NOT_DECOMPILED void Vi3dObject__ProcessAnimation(CVi3dObject *work);
NOT_DECOMPILED void Vi3dObject__Draw(CVi3dObject *work);

#ifdef __cplusplus
}
#endif

#endif // RUSH_VI3DOBJECT_HPP
