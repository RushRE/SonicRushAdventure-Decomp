#ifndef RUSH_BOSS5_H
#define RUSH_BOSS5_H

#include <stage/gameObject.h>

// --------------------
// CONSTANTS
// --------------------

// --------------------
// TYPES
// --------------------

typedef struct Boss5Stage_ Boss5Stage;
typedef struct Boss5_ Boss5;

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

struct Boss5Stage_
{
    GameObjectTask gameWork;
    
    // TODO: fill this out
};

struct Boss5_
{
    GameObjectTask gameWork;
    
    // TODO: fill this out
};

// --------------------
// FUNCTIONS
// --------------------

Boss5Stage *Boss5Stage__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss5 *Boss5__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

GameObjectTask *Boss5MapChunk__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5Icicle2__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5FreezeArea__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5Unknown2174578__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5Unknown2174200__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5Core__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5Unknown21748C4__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5EnemyFish__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5LifeSupport__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5Shutter__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5Battery__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5Sea__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5Missile__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *CreateBoss5Icicle(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5PlayerFreezeEffect__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *Boss5EnemyFish2__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

#endif // RUSH_BOSS5_H