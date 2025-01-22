#ifndef RUSH_PIPE_H
#define RUSH_PIPE_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct FlowerPipe_
{
    GameObjectTask gameWork;
} FlowerPipe;

typedef struct SteamPipe_
{
    GameObjectTask gameWork;
} SteamPipe;

// --------------------
// FUNCTIONS
// --------------------

FlowerPipe *FlowerPipe__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
SteamPipe *SteamPipe__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void SteamPipe__State_2161728(SteamPipe *work);
void FlowerPipe__OnDefend_216174C(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void SteamPipe__OnDefend_21617B0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void FlowerPipe__OnDefend_2161854(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void FlowerPipe__OnDefend_216188C(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

void SteamPipe__State_2161B64(SteamPipe *work);
void SteamPipe__State_2161BB0(SteamPipe *work);
void SteamPipe__State_2161D20(SteamPipe *work);
void SteamPipe__OnDefend_2161DA0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void SteamPipe__OnDefend_2161DE0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

#endif // RUSH_PIPE_H
