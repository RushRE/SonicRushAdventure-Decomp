#ifndef RUSH_BOSS3_H
#define RUSH_BOSS3_H

#include <stage/gameObject.h>

// --------------------
// CONSTANTS
// --------------------

// --------------------
// TYPES
// --------------------

typedef struct Boss3Stage_ Boss3Stage;
typedef struct Boss3_ Boss3;

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

struct Boss3Stage_
{
    GameObjectTask gameWork;
    
    // TODO: fill this out
};

struct Boss3_
{
    GameObjectTask gameWork;
    
    // TODO: fill this out
};

// --------------------
// FUNCTIONS
// --------------------

Boss3Stage *Boss3Stage__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss3 *Boss3__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

GameObjectTask *Boss3Arm__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss3SplatInk__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss3DimInk__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss3InkSmoke__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss3ScreenSplatInk__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

#endif // RUSH_BOSS3_H