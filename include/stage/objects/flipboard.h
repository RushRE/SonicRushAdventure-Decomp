#ifndef RUSH2_FLIPBOARD_H
#define RUSH2_FLIPBOARD_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct Flipboard_
{
    GameObjectTask gameWork;
    AnimatorSpriteDS aniSnow;
} Flipboard;

// --------------------
// FUNCTIONS
// --------------------

Flipboard *CreateFlipboard(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_FLIPBOARD_H
