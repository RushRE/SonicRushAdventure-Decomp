#ifndef RUSH_DASHRING_H
#define RUSH_DASHRING_H

#include <stage/gameObject.h>

// --------------------
// ENUMS
// --------------------

enum DashRingFlags_
{
    DASHRING_FLAG_NONE = 0,
    DASHRING_FLAG_RAINBOW = 1 << 0,
};
typedef u32 DashRingFlags;

enum DashRingVelocity_
{
    DASHRING_VEL_RIGHT,
    DASHRING_VEL_DOWN_RIGHT,
    DASHRING_VEL_DOWN,
    DASHRING_VEL_DOWN_LEFT,
    DASHRING_VEL_LEFT,
    DASHRING_VEL_UP_LEFT,
    DASHRING_VEL_UP,
    DASHRING_VEL_UP_RIGHT,
};
typedef u32 DashRingVelocity;

// --------------------
// STRUCTS
// --------------------

typedef struct DashRing_
{
    GameObjectTask gameWork;
    OBS_ACTION2D_BAC_WORK aniRing;
    DashRingFlags flags;
    DashRingVelocity velocity;
} DashRing;

// --------------------
// FUNCTIONS
// --------------------

DashRing *CreateDashRing(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
DashRing *CreateDashRingRainbow(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_DASHRING_H
