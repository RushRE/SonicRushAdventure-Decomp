#ifndef RUSH_EXDRAWFADE_H
#define RUSH_EXDRAWFADE_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>
#include <ex/boss/exBoss.h>

// --------------------
// STRUCTS
// --------------------

enum ExDrawFadeTaskFlags_
{
    EXDRAWFADETASK_FLAG_NONE = 0x00,

    EXDRAWFADETASK_FLAG_ON_ENGINE_A = 1 << 0,
    EXDRAWFADETASK_FLAG_ON_ENGINE_B = 1 << 1,
};
typedef u16 ExDrawFadeTaskFlags;

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
    u16 flags;
} exDrawFadeTask;

// --------------------
// FUNCTIONS
// --------------------

void ExDrawFadeTask_Main_Init(void);
void ExDrawFadeTask_OnCheckStageFinished(void);
void ExDrawFadeTask_Destructor(void);
void ExDrawFadeTask_Main_Active(void);
void CreateExDrawFadeTask(s32 brightness, s32 targetBrightness, s32 duration, s32 delay, ExDrawFadeTaskFlags flags);

#endif // RUSH_EXDRAWFADE_H
