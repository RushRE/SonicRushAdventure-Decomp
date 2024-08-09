#ifndef RUSH2_WATERRUNTRIGGER_H
#define RUSH2_WATERRUNTRIGGER_H

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

#endif // RUSH2_WATERRUNTRIGGER_H
