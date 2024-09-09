#ifndef RUSH2_SKYMOON_H
#define RUSH2_SKYMOON_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EnemySkymoon_
{
    GameObjectTask gameWork;
    OBS_RECT_WORK collcolliderDetectider;
    fx32 xMin;
    fx32 xMax;
    s32 timer;
    u16 angle;
} EnemySkymoon;

typedef struct EnemySkymoonLaser_
{
    GameObjectTask gameWork;
} EnemySkymoonLaser;

// --------------------
// FUNCTIONS
// --------------------

EnemySkymoon *CreateSkymoon(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
EnemySkymoonLaser *CreateSkymoonLaser(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_SKYMOON_H