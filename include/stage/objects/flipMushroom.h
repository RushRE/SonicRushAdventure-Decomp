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

FlipMushroom *FlipMushroom__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
void FlipMushroom__State_Idle(FlipMushroom *work);
void FlipMushroom__Action_Use(FlipMushroom *work);
void FlipMushroom__State_Activated(FlipMushroom *work);
void FlipMushroom__Draw(void);
void FlipMushroom__Collide(void);
void FlipMushroom__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

#endif // RUSH2_FLIPMUSHROOM_H