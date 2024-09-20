#ifndef RUSH2_AVALANCHE_H
#define RUSH2_AVALANCHE_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct Avalanche_
{
    GameObjectTask gameWork;
} Avalanche;

typedef struct AvalancheTree_
{
    GameObjectTask gameWork;
} AvalancheTree;

// --------------------
// FUNCTIONS
// --------------------

Avalanche *CreateAvalanche(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
AvalancheTree *CreateAvalancheTree(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_AVALANCHE_H