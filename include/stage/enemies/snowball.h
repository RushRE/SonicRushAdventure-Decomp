#ifndef RUSH2_SNOWBALL_H
#define RUSH2_SNOWBALL_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EnemySnowball_
{
    GameObjectTask gameWork;
    OBS_RECT_WORK colliderDetect;
    u8 isExposed;
    u16 field_3A6;
    fx32 xMin;
    fx32 field_3AC;
    fx32 xMax;
    fx32 field_3B4;
    fx32 startX;
    fx32 field_3BC;
    OBS_RECT_ON_DEF exposedOnDefendFunc;
} EnemySnowball;

typedef struct EnemySnowballShot_
{
    GameObjectTask gameWork;
} EnemySnowballShot;

// --------------------
// FUNCTIONS
// --------------------

EnemySnowball *CreateSnowball(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
EnemySnowballShot *CreateSnowballShot(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_SNOWBALL_H