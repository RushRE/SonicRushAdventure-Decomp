#ifndef RUSH2_STEAMFAN_H
#define RUSH2_STEAMFAN_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SteamFan_
{
    GameObjectTask gameWork;
    u16 angle;
    u16 unknownAngle;
    u16 angleOffset;
} SteamFan;

// --------------------
// FUNCTIONS
// --------------------

SteamFan *CreateSteamFan(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_STEAMFAN_H