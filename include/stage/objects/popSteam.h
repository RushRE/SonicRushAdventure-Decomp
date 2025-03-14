#ifndef RUSH_POP_STEAM_H
#define RUSH_POP_STEAM_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct PopSteam_
{
    GameObjectTask gameWork;
    OBS_ACTION2D_BAC_WORK aniCork;
    s16 steamSize;
    s16 steamPos;
    s32 durationS;
    s32 timerS;
    s32 durationL;
    s32 timerL;
} PopSteam;

// --------------------
// FUNCTIONS
// --------------------

PopSteam *PopSteam__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
void PopSteam__Destructor(Task *task);
void PopSteam__State_Active(PopSteam *work);
void PopSteam__OnDefend_Steam(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void PopSteam__OnDefend_Cork(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void PopSteam__Draw(void);

#endif // RUSH_POP_STEAM_H
