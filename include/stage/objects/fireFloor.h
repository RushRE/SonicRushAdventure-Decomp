#ifndef RUSH_FIREFLOOR_H
#define RUSH_FIREFLOOR_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct FireFloor_
{
    GameObjectTask gameWork;
} FireFloor;

// --------------------
// FUNCTIONS
// --------------------

FireFloor *CreateFireFloor(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_FIREFLOOR_H
