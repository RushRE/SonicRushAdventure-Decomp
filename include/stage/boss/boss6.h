#ifndef RUSH_BOSS6_H
#define RUSH_BOSS6_H

#include <stage/gameObject.h>

// --------------------
// CONSTANTS
// --------------------

// --------------------
// TYPES
// --------------------

typedef struct Boss6Stage_ Boss6Stage;
typedef struct Boss6_ Boss6;

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

struct Boss6Stage_
{
    GameObjectTask gameWork;
    
    // TODO: fill this out
};

struct Boss6_
{
    GameObjectTask gameWork;
    
    // TODO: fill this out
};

// --------------------
// FUNCTIONS
// --------------------

Boss6Stage *Boss6Stage__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss6 *Boss6__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

GameObjectTask *Boss6Platform__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss6EnemyA__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss6EnemyB__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss6Missile__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss6Ring__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

#endif // RUSH_BOSS6_H