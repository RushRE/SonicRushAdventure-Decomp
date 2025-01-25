#ifndef RUSH_EXDRAWFADE_H
#define RUSH_EXDRAWFADE_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>
#include <ex/boss/exBoss.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exDrawFadeTask_
{
    BOOL hasStarted;
    u16 timer;
    s16 brightness;
    s16 targetBrightness;
    u16 duration;
    u16 delay;
    s16 flags;
} exDrawFadeTask;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void exDrawFadeTask__Main(void);
NOT_DECOMPILED void exDrawFadeTask__Func8(void);
NOT_DECOMPILED void exDrawFadeTask__Destructor(void);
NOT_DECOMPILED void exDrawFadeTask__Main_2163C48(void);
NOT_DECOMPILED void exDrawFadeTask__Create(s32 brightness, s32 targetBrightness, s32 duration, s32 delay, u32 flags);

#endif // RUSH_EXDRAWFADE_H
