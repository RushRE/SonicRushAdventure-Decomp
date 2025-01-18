#ifndef RUSH_GHOSTTREE_H
#define RUSH_GHOSTTREE_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct GhostTree_
{
    GameObjectTask gameWork;
    OBS_ACTION3D_NN_WORK aniArm;
} GhostTree;

// --------------------
// FUNCTIONS
// --------------------

GhostTree *CreateGhostTree(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_GHOSTTREE_H