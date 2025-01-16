#ifndef RUSH2_SPRINGROPE_H
#define RUSH2_SPRINGROPE_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SpringRope_
{
    GameObjectTask gameWork;
    OBS_ACTION3D_NN_WORK aniRope;
} SpringRope;

typedef struct SpringRopeSpring_
{
    GameObjectTask gameWork;
} SpringRopeSpring;

typedef struct SpringRopeBase_
{
    GameObjectTask gameWork;
} SpringRopeBase;

// --------------------
// FUNCTIONS
// --------------------

SpringRope *CreateSpringRope(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
SpringRopeSpring *CreateSpringRopeSpring(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
SpringRopeBase *CreateSpringRopeBase(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_SPRINGROPE_H
