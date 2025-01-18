#ifndef RUSH_MEDAL_H
#define RUSH_MEDAL_H

#include <stage/gameObject.h>

// --------------------
// CONSTANTS
// --------------------

// maximum of 8 medals per stage
#define MEDAL_STAGE_MAX 8

// --------------------
// STRUCTS
// --------------------

typedef struct Medal_
{
    GameObjectTask gameWork;
} Medal;

// --------------------
// FUNCTIONS
// --------------------

Medal *CreateMedal(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_MEDAL_H
