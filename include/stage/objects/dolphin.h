#ifndef RUSH2_DOLPHIN_H
#define RUSH2_DOLPHIN_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct Dolphin_
{
    GameObjectTask gameWork;
    OBS_ACTION3D_NN_WORK aniDolphin;
} Dolphin;

typedef struct DolphinHoop_
{
    GameObjectTask gameWork;
    AnimatorSpriteDS aniRingBack;
    u16 type;
} DolphinHoop;

// --------------------
// FUNCTIONS
// --------------------

Dolphin *CreateDolphin(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
DolphinHoop *CreateDolphinHoop(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_DOLPHIN_H
