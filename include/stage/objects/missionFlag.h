#ifndef RUSH_MISSIONFLAG_H
#define RUSH_MISSIONFLAG_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct MissionFlag_
{
    GameObjectTask gameWork;
    AnimatorSpriteDS aniDigit[2];
    s16 digitCount;
    Vec2Fx32 digitPosition[2];
    fx32 scale;
} MissionFlag;

// --------------------
// FUNCTIONS
// --------------------

MissionFlag *CreateMissionFlag(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_MISSIONFLAG_H
