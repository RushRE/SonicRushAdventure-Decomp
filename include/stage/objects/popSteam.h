#ifndef RUSH_POP_STEAM_H
#define RUSH_POP_STEAM_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct PopSteam_
{
    GameObjectTask gameWork;
    OBS_ACTION2D_BAC_WORK animator;
    s16 steamSize;
    s16 hitboxRight;
    s32 duration1;
    s32 timer1;
    s32 duration2;
    s32 timer2;
} PopSteam;

// --------------------
// FUNCTIONS
// --------------------

PopSteam *PopSteam__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
void PopSteam__Destructor(Task *work);
void PopSteam__State_21668F8(PopSteam *work);
void PopSteam__OnDefend_2166B6C(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void PopSteam__OnDefend_2166C34(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void PopSteam__Draw(void);

#endif // RUSH_POP_STEAM_H
