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
    AnimatorMDL aniRope[2];
    AnimatorSpriteDS aniRopeSprite[2];
    VecFx32 ropePos;
    VecU16 direction2;
    VecU16 direction1;
    u32 dword750;
    s16 angleSpeed;
    s16 field_756;
    s32 angleDistance;
    u16 word75C;
    u16 word75E;
    u16 word760;
    u16 word762;
    u16 word764;
    u32 angleDistanceThreshold;
} AnchorRope;

// --------------------
// FUNCTIONS
// --------------------

AnchorRope *AnchorRope__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
void AnchorRope__Destructor(Task *task);
void AnchorRope__State_PlayerSpin(AnchorRope *work);
void AnchorRope__State_ReleasedPlayer(AnchorRope *work);
void AnchorRope__Draw(void);
void AnchorRope__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void AnchorRope__HandleRopePos(AnchorRope *work);

#endif // RUSH_ANCHOR_ROPE_H