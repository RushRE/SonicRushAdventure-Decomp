#ifndef RUSH_WATERLEVELTRIGGER_H
#define RUSH_WATERLEVELTRIGGER_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct WaterLevelTrigger_
{
    GameObjectTask gameWork;
    s8 targetPlayers[2];
    u16 waterLevel;
} WaterLevelTrigger;

// --------------------
// FUNCTIONS
// --------------------

WaterLevelTrigger *CreateWaterLevelTrigger(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_WATERLEVELTRIGGER_H
