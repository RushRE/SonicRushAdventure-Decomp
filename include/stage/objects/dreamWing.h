#ifndef RUSH_DREAM_WING_H
#define RUSH_DREAM_WING_H

#include <stage/gameObject.h>

// --------------------
// ENUMS
// --------------------

enum DreamWingPlayerFlag
{
    DREAMWING_PLAYERFLAG_NONE = 0x00,

    DREAMWING_PLAYERFLAG_ALLOW_GRAVITY = 1 << 0,
    DREAMWING_PLAYERFLAG_EXHAUST_ACTIVE = 1 << 1,
};

// --------------------
// STRUCTS
// --------------------

typedef struct DreamWing_
{
    GameObjectTask gameWork;
    s32 playerBurstCount;
    s32 burstSteamPuffTimer;
} DreamWing;

typedef struct DreamWingHangChain_
{
    GameObjectTask gameWork;
} DreamWingHangChain;

// --------------------
// FUNCTIONS
// --------------------

DreamWing *CreateDreamWing(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
DreamWingHangChain *CreateDreamWingHangChain(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_DREAM_WING_H
