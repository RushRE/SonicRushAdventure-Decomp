#ifndef RUSH2_CRUMBLINGFLOOR_H
#define RUSH2_CRUMBLINGFLOOR_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct CrumblingFloor_
{
    GameObjectTask gameWork;
} CrumblingFloor;

// --------------------
// FUNCTIONS
// --------------------

CrumblingFloor *CreateCrumblingFloor(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_CRUMBLINGFLOOR_H
