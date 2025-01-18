#ifndef RUSH_TIMER_SHUTTER_H
#define RUSH_TIMER_SHUTTER_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

typedef struct TimerShutter_
{
    GameObjectTask gameWork;
    AnimatorSpriteDS aniShutter;
    AnimatorSpriteDS aniTimeDigits[4];
    u32 closeTime;
} TimerShutter;

typedef struct TimerShutterWater_
{
    GameObjectTask gameWork;
    AnimatorSpriteDS aniWater;
} TimerShutterWater;

// --------------------
// FUNCTIONS
// --------------------

TimerShutter *CreateTimerShutter(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
TimerShutterWater *CreateTimerShutterWater(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_TIMER_SHUTTER_H
