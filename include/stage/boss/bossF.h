#ifndef RUSH_BOSSF_H
#define RUSH_BOSSF_H

#include <stage/gameObject.h>

// --------------------
// CONSTANTS
// --------------------

// --------------------
// TYPES
// --------------------

typedef struct BossFStage_ BossFStage;
typedef struct BossF_ BossF;

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

struct BossFStage_
{
    GameObjectTask gameWork;
    
    // TODO: fill this out
};

struct BossF_
{
    GameObjectTask gameWork;
    
    // TODO: fill this out
};

// --------------------
// FUNCTIONS
// --------------------

BossFStage *BossFStage__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
BossF *BossF__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

GameObjectTask *BossFArm__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *BossFBodyCannon__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *BossFShipCannon__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *BossFMissileGreen__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
GameObjectTask *BossFMissileRed__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

#endif // RUSH_BOSSF_H