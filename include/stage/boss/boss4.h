#ifndef RUSH_BOSS4_H
#define RUSH_BOSS4_H

#include <stage/gameObject.h>

// --------------------
// CONSTANTS
// --------------------

// --------------------
// TYPES
// --------------------

typedef struct Boss4Stage_ Boss4Stage;
typedef struct Boss4_ Boss4;

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

struct Boss4Stage_
{
    GameObjectTask gameWork;
    
    // TODO: fill this out
};

struct Boss4_
{
    GameObjectTask gameWork;
    
    // TODO: fill this out
};

// --------------------
// FUNCTIONS
// --------------------

Boss4Stage *Boss4Stage__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss4 *Boss4__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

GameObjectTask *Boss4Core__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss4Ship__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss4Pulley__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss4FireColumn__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss4FireBall__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

#endif // RUSH_BOSS4_H