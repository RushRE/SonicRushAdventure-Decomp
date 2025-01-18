#ifndef RUSH_WINCH_H
#define RUSH_WINCH_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct Winch_
{
    GameObjectTask gameWork;
    AnimatorSpriteDS aniHook;
    AnimatorSpriteDS aniLine;
    VecFx32 hookOffset;
    fx32 maxLineLength;
    fx32 speed;
    fx32 lineLength;
    fx32 spinSpeed;
    u16 hookAngle;
    u16 centerAngle;
} Winch;

// --------------------
// FUNCTIONS
// --------------------

Winch *CreateWinch(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_WINCH_H
