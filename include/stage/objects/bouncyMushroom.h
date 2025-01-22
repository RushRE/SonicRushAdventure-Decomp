#ifndef RUSH_BOUNCYMUSHROOM_H
#define RUSH_BOUNCYMUSHROOM_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct BouncyMushroom_
{
    GameObjectTask gameWork;
    OBS_RECT_WORK colliders[4];
    s16 colliderCount;
    fx32 percent;
    fx32 lerpSpeed;
    fx32 targetOffset;
} BouncyMushroom;

// --------------------
// FUNCTIONS
// --------------------

BouncyMushroom *CreateBouncyMushroom(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_BOUNCYMUSHROOM_H