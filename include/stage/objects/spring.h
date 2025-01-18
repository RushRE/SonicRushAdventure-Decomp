#ifndef RUSH_SPRING_H
#define RUSH_SPRING_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct Spring_
{
    GameObjectTask gameWork;
} Spring;

// --------------------
// FUNCTIONS
// --------------------

Spring *CreateSpring(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_SPRING_H
