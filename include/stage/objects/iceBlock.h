#ifndef RUSH2_ICEBLOCK_H
#define RUSH2_ICEBLOCK_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct IceBlock_
{
    GameObjectTask gameWork;
} IceBlock;

// --------------------
// FUNCTIONS
// --------------------

IceBlock *CreateIceBlock(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_ICEBLOCK_H
