#ifndef RUSH_DIVEBAT_H
#define RUSH_DIVEBAT_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EnemyDiveBat_
{
    GameObjectTask gameWork;
    OBS_RECT_WORK colliderDetect;
    fx32 xMin;
    fx32 xMax;
    Vec2Fx32 originPos;
    Vec2Fx32 returnPos;
    fx32 gravityStrength;
    u32 randSeed;
    u16 angle;
    u8 type;
} EnemyDiveBat;

// --------------------
// FUNCTIONS
// --------------------

EnemyDiveBat *CreateDiveBat(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_DIVEBAT_H