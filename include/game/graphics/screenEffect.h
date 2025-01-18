#ifndef RUSH_SCREENEFFECT_H
#define RUSH_SCREENEFFECT_H

#include <game/system/task.h>

// --------------------
// STRUCTS
// --------------------

typedef struct ScreenEffectEvent_
{
    u16 color;
    u8 type;
    u8 duration;
} ScreenEffectEvent;

typedef struct ScreenEffect_
{
    u16 field_0;
    u16 timer;
    u32 visiblePlane[2];
    const ScreenEffectEvent *controller;
} ScreenEffect;

// --------------------
// FUNCTIONS
// --------------------

void CreateScreenEffect(const ScreenEffectEvent *controller);

#endif // RUSH_SCREENEFFECT_H
