#ifndef RUSH_BREAKABLE_H
#define RUSH_BREAKABLE_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct Breakable_
{
    GameObjectTask gameWork;
} Breakable;

// --------------------
// FUNCTIONS
// --------------------

Breakable *Breakable__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
void Breakable__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void Breakable__Destructor(Task *task);
void Breakable__State_Tutorial(Breakable *work);

#endif // RUSH_BREAKABLE_H