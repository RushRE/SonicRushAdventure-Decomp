#ifndef RUSH2_CRAB_H
#define RUSH2_CRAB_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EnemyCrab_
{
    GameObjectTask gameWork;
    fx32 xMin;
    fx32 field_368;
    fx32 xMax;
    fx32 field_370;
    fx32 maxDistance;
    fx32 startX;
    fx32 field_37C;
    fx32 velocityStore;
} EnemyCrab;

// --------------------
// FUNCTIONS
// --------------------

EnemyCrab *CreateCrab(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_CRAB_H