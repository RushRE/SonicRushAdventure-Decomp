#ifndef RUSH2_FLIPMUSHROOM_H
#define RUSH2_FLIPMUSHROOM_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct FlipMushroom_
{
    GameObjectTask gameWork;
    OBS_RECT_WORK colliders[4];
    s16 colliderCount;
    fx32 percent;
    fx32 lerpSpeed;
    fx32 targetOffset;
} FlipMushroom;

// --------------------
// FUNCTIONS
// --------------------

FlipMushroom *CreateFlipMushroom(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH2_FLIPMUSHROOM_H