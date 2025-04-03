#ifndef RUSH_BARREL_H
#define RUSH_BARREL_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct Barrel_
{
    GameObjectTask gameWork;
    AnimatorSpriteDS aniChain;
    AnimatorSpriteDS aniEyes;
    fx32 barrelPos;
    s32 dropDistance;
    fx32 barrelSpeed;
    s16 angleVelocity;
} Barrel;

// --------------------
// FUNCTIONS
// --------------------

Barrel *CreateBarrel(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_BARREL_H
