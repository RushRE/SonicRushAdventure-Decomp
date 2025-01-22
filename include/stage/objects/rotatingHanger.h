#ifndef RUSH_ROTATING_HANGER_H
#define RUSH_ROTATING_HANGER_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct RotatingHanger_
{
    GameObjectTask gameWork;
} RotatingHanger;

// --------------------
// FUNCTIONS
// --------------------

RotatingHanger *RotatingHanger__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
void RotatingHanger__State_Active(RotatingHanger *work);
void RotatingHanger__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

#endif // RUSH_ROTATING_HANGER_H
