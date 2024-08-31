#ifndef RUSH2_ENEMYGLIDER_H
#define RUSH2_ENEMYGLIDER_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EnemyGlider_
{
    GameObjectTask gameWork;
    OBS_RECT_WORK collider;
    fx32 gravityStrength;
} EnemyGlider;

// --------------------
// FUNCTIONS
// --------------------

EnemyGlider *CreateEnemyGlider(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_ENEMYGLIDER_H