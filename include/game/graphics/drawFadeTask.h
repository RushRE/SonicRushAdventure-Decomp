#ifndef RUSH_DRAWFADETASK_H
#define RUSH_DRAWFADETASK_H

#include <game/system/task.h>

// --------------------
// ENUMS
// --------------------

enum DrawFadeTaskFlags_
{
    DRAW_FADE_TASK_FLAG_NONE = 0,

    DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS         = 1 << 0,
    DRAW_FADE_TASK_FLAG_FADE_TO_BLACK              = 1 << 1,
    DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED        = 1 << 2,
    DRAW_FADE_TASK_FLAG_INIT_WITH_FADE             = 1 << 3,
    DRAW_FADE_TASK_FLAG_ALWAYS_INIT                = 1 << 4,
    DRAW_FADE_TASK_FLAG_FINISHED                   = 1 << 5,
    DRAW_FADE_TASK_FLAG_APPLY_BRIGHTNESS_TO_SYSTEM = 1 << 6,
    DRAW_FADE_TASK_FLAG_UNUSED                     = 1 << 7,
    DRAW_FADE_TASK_FLAG_ENGINEA_ONLY               = 1 << 8,
    DRAW_FADE_TASK_FLAG_ENGINEB_ONLY               = 1 << 9,
};
typedef u16 DrawFadeTaskFlags;

// --------------------
// STRUCTS
// --------------------

typedef struct DrawFadeTask_
{
    fx32 brightness;
    fx32 fadeSpeed;
    DrawFadeTaskFlags flags;
    s16 delay;
} DrawFadeTask;

// --------------------
// FUNCTIONS
// --------------------

DrawFadeTask *CreateDrawFadeTask(DrawFadeTaskFlags flags, fx32 fadeSpeed);
void DestroyDrawFadeTask(void);
BOOL IsDrawFadeTaskFinished(void);

#endif // RUSH_DRAWFADETASK_H
