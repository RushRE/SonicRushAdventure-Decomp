#ifndef RUSH2_FIRESKULL_H
#define RUSH2_FIRESKULL_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EnemyFireSkull_
{
    GameObjectTask gameWork;
} EnemyFireSkull;

// --------------------
// FUNCTIONS
// --------------------

EnemyFireSkull *CreateEnemyFireSkull(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_FIRESKULL_H