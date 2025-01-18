#ifndef RUSH_FIRESKULL_H
#define RUSH_FIRESKULL_H

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

EnemyFireSkull *CreateFireSkull(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_FIRESKULL_H