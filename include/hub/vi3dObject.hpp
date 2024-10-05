#ifndef RUSH2_VI3DOBJECT_HPP
#define RUSH2_VI3DOBJECT_HPP

#include <game/system/task.h>
#include <game/graphics/sprite.h>

// --------------------
// STRUCTS
// --------------------

class Vi3dObject
{
    void *vTable;

public:
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
};

// --------------------
// FUNCTIONS
// --------------------

#endif // RUSH2_VI3DOBJECT_HPP
