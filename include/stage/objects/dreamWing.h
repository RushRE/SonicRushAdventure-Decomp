#ifndef RUSH_DREAM_WING_H
#define RUSH_DREAM_WING_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct DreamWing_
{
    GameObjectTask gameWork;
    s32 field_364;
    s32 field_368;
} DreamWing;

typedef struct DreamWingPart_
{
    GameObjectTask gameWork;
} DreamWingPart;

// --------------------
// FUNCTIONS
// --------------------

DreamWing *DreamWing__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
DreamWingPart *DreamWingPart__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void DreamWing__State_21671CC(DreamWing *work);
void DreamWing__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void DreamWingPart__Draw(void);

#endif // RUSH_DREAM_WING_H
