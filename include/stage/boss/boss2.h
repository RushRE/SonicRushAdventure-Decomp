#ifndef RUSH_BOSS2_H
#define RUSH_BOSS2_H

#include <stage/gameObject.h>

// --------------------
// CONSTANTS
// --------------------

// --------------------
// TYPES
// --------------------

typedef struct Boss2Stage_ Boss2Stage;
typedef struct Boss2_ Boss2;

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

struct Boss2Stage_
{
    GameObjectTask gameWork;
    
    // TODO: fill this out
};

struct Boss2_
{
    GameObjectTask gameWork;
    
    // TODO: fill this out
};

// --------------------
// FUNCTIONS
// --------------------

Boss2Stage *Boss2Stage__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss2 *Boss2__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss2Arm__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss2Drop__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss2Ball__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss2Bomb__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss2Wave__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

#endif // RUSH_BOSS2_H