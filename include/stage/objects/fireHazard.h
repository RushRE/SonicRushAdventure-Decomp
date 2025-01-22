#ifndef RUSH_FIREHAZARD_H
#define RUSH_FIREHAZARD_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct FireHazard_
{
    GameObjectTask gameWork;
} FireHazard;

// --------------------
// FUNCTIONS
// --------------------

FireHazard *CreateFireHazard(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_FIREHAZARD_H
