#ifndef RUSH_WATERRUNTRIGGER_H
#define RUSH_WATERRUNTRIGGER_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct WaterRunTrigger_
{
    GameObjectTask gameWork;
} WaterRunTrigger;

// --------------------
// FUNCTIONS
// --------------------

WaterRunTrigger *CreateWaterRunTrigger(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_WATERRUNTRIGGER_H
