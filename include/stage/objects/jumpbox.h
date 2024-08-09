#ifndef RUSH2_JUMPBOX_H
#define RUSH2_JUMPBOX_H

#include <stage/gameObject.h>

// --------------------
// ENUMS
// --------------------

enum JumpBoxState
{
    JUMPBOX_STATE_CLIMBING,
    JUMPBOX_STATE_VAULTING,
    JUMPBOX_STATE_VAULTED,
    JUMPBOX_STATE_EXIT,
};

// --------------------
// STRUCTS
// --------------------

typedef struct JumpBox_
{
    GameObjectTask gameWork;
    AnimatorSpriteDS aniJumpBox;
} JumpBox;

typedef struct PlaneSwitchSpring_
{
    GameObjectTask gameWork;
    AnimatorSpriteDS aniSpring;
} PlaneSwitchSpring;

// --------------------
// FUNCTIONS
// --------------------

JumpBox *CreateJumpBox(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
PlaneSwitchSpring *CreatePlaneSwitchSpring(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_JUMPBOX_H
