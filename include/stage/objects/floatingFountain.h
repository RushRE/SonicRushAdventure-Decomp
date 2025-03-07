#ifndef RUSH_FLOATINGFOUNTAIN_H
#define RUSH_FLOATINGFOUNTAIN_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct FloatingFountain_
{
    GameObjectTask gameWork;
    AnimatorSpriteDS aniFountain;
} FloatingFountain;

// --------------------
// FUNCTIONS
// --------------------

FloatingFountain *CreateFloatingFountain(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_FLOATINGFOUNTAIN_H
