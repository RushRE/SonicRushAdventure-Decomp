#ifndef RUSH_ANCHOR_ROPE_H
#define RUSH_ANCHOR_ROPE_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct AnchorRope_
{
    GameObjectTask gameWork;
    NNSG3dResFileHeader *resAnchorRope;

    union
    {
        AnimatorMDL aniRope3D[2];

        struct
        {
            AnimatorMDL aniAnchor3D;
            AnimatorMDL aniRopeString3D;
        };
    };

    union
    {
        AnimatorSpriteDS aniRope2D[2];

        struct
        {
            AnimatorSpriteDS aniAnchor2D;
            AnimatorSpriteDS aniRopeString2D;
        };
    };

    VecFx32 ropePos;
    VecU16 anchorAngle;
    VecU16 ropeAngle;
    fx32 anchorPos;
    s16 angleSpeed;
    s32 angleDistance;
    VecU16 targetAnchorAngle;
    VecU16 targetRopeAngle;
    u32 angleDistanceThreshold;
} AnchorRope;

// --------------------
// FUNCTIONS
// --------------------

AnchorRope *CreateAnchorRope(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_ANCHOR_ROPE_H