#ifndef RUSH_BREAKABLEWALL_H
#define RUSH_BREAKABLEWALL_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct BreakableWall_
{
    GameObjectTask gameWork;
    Vec2Fx32 blockPos[16];
    Vec2Fx32 blockVel[16];
} BreakableWall;

// --------------------
// FUNCTIONS
// --------------------

BreakableWall *BreakableWall__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
void BreakableWall__OnDefend_2160518(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void BreakableWall__OnDefend_21608E0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void BreakableWall__OnDefend_2160A88(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void BreakableWall__State_Broken(BreakableWall *work);
void BreakableWall__Draw_Broken(void);

#endif // RUSH_BREAKABLEWALL_H