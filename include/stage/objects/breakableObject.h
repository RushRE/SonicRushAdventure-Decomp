#ifndef RUSH_BREAKABLEOBJECT_H
#define RUSH_BREAKABLEOBJECT_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct BreakableObject_
{
    GameObjectTask gameWork;
} BreakableObject;

// --------------------
// FUNCTIONS
// --------------------

BreakableObject *BreakableObject__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
void BreakableObject__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void BreakableObject__Destructor(Task *task);
void BreakableObject__State_Tutorial(BreakableObject *work);

#endif // RUSH_BREAKABLEOBJECT_H