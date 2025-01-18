#ifndef RUSH_SPRINGBOARD_H
#define RUSH_SPRINGBOARD_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct Springboard_
{
    GameObjectTask gameWork;
} Springboard;

// --------------------
// FUNCTIONS
// --------------------

Springboard *CreateSpringboard(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_SPRINGBOARD_H
