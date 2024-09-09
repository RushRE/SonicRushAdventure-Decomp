#ifndef RUSH2_GLIDER_H
#define RUSH2_GLIDER_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EnemyGlider_
{
    GameObjectTask gameWork;
    OBS_RECT_WORK colliderDetect;
    fx32 gravityStrength;
} EnemyGlider;

// --------------------
// FUNCTIONS
// --------------------

EnemyGlider *CreateGlider(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_GLIDER_H