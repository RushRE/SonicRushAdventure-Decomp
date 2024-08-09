#ifndef RUSH2_MISSIONRING_H
#define RUSH2_MISSIONRING_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct MissionRing_
{
    GameObjectTask gameWork;
} MissionRing;

// --------------------
// FUNCTIONS
// --------------------

MissionRing *CreateMissionRing(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_MISSIONRING_H
