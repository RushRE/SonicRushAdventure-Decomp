#ifndef RUSH2_FALLINGANCHOR_H
#define RUSH2_FALLINGANCHOR_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct FallingAnchor_
{
    GameObjectTask gameWork;
    AnimatorSpriteDS aniChain;
    fx32 originPos;
} FallingAnchor;

// --------------------
// FUNCTIONS
// --------------------

FallingAnchor *CreateFallingAnchor(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_FALLINGANCHOR_H
