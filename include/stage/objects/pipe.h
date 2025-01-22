#ifndef RUSH_PIPE_H
#define RUSH_PIPE_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct PipeFlow_
{
    GameObjectTask gameWork;
} PipeFlow;

typedef struct PipeSteam_
{
    GameObjectTask gameWork;
} PipeSteam;

// --------------------
// FUNCTIONS
// --------------------

PipeFlow *PipeFlow__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
PipeSteam *PipeSteam__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void PipeSteam__State_2161728(PipeSteam *work);
void PipeFlow__OnDefend_216174C(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void PipeSteam__OnDefend_21617B0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void PipeFlow__OnDefend_2161854(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void PipeFlow__OnDefend_216188C(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

void PipeSteam__State_2161B64(PipeSteam *work);
void PipeSteam__State_2161BB0(PipeSteam *work);
void PipeSteam__State_2161D20(PipeSteam *work);
void PipeSteam__OnDefend_2161DA0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void PipeSteam__OnDefend_2161DE0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

#endif // RUSH_PIPE_H
