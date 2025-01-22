#ifndef RUSH_BOSS7_H
#define RUSH_BOSS7_H

#include <stage/gameObject.h>

// --------------------
// CONSTANTS
// --------------------

// --------------------
// TYPES
// --------------------

typedef struct Boss7Stage_ Boss7Stage;
typedef struct Boss7_ Boss7;

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

struct Boss7Stage_
{
    GameObjectTask gameWork;
    
    // TODO: fill this out
};

struct Boss7_
{
    GameObjectTask gameWork;
    
    // TODO: fill this out
};

// --------------------
// FUNCTIONS
// --------------------

Boss7Stage *Boss7Stage__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss7 *Boss7__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

GameObjectTask *Boss7Whisker__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss7Rocket__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss7Unknown__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss7Johnny__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss7Saw__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

#endif // RUSH_BOSS7_H