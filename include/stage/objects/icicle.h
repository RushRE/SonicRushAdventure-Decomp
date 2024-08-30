#ifndef RUSH2_ICICLE_H
#define RUSH2_ICICLE_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct Icicle_
{
    GameObjectTask gameWork;
    OBS_ACTION3D_BAC_WORK animator;
} Icicle;

// --------------------
// FUNCTIONS
// --------------------

Icicle *CreateIcicle(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_ICICLE_H
