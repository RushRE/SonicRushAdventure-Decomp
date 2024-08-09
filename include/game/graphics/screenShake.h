#ifndef RUSH2_SCREENSHAKE_H
#define RUSH2_SCREENSHAKE_H

#include <game/system/task.h>

// --------------------
// ENUMS
// --------------------

enum ScreenShakeType_
{
    SCREENSHAKE_STOP,
    SCREENSHAKE_A_SHORT,
    SCREENSHAKE_B_SHORT,
    SCREENSHAKE_C_SHORT,
    SCREENSHAKE_D_SHORT,
    SCREENSHAKE_E_SHORT,
    SCREENSHAKE_A_LONG,
    SCREENSHAKE_B_LONG,
    SCREENSHAKE_C_LONG,
    SCREENSHAKE_D_LONG,
    SCREENSHAKE_E_LONG,
    SCREENSHAKE_A_LOOP,
    SCREENSHAKE_B_LOOP,
    SCREENSHAKE_C_LOOP,
    SCREENSHAKE_D_LOOP,
    SCREENSHAKE_E_LOOP,
    SCREENSHAKE_COSINE_WAVE,
    SCREENSHAKE_CUSTOM,
};
typedef u8 ScreenShakeType;

enum ScreenShakeFlags_
{
    SCREENSHAKE_FLAG_NONE = 0,

    SCREENSHAKE_FLAG_ACTIVE = 1 << 0,
    SCREENSHAKE_FLAG_UNUSED = 1 << 1, // didn't exist in rush, not used here!
    SCREENSHAKE_FLAG_PAUSED = 1 << 2,
};
typedef u16 ScreenShakeFlags;

// --------------------
// STRUCTS
// --------------------

typedef struct ScreenShake_
{
    s32 lifetime;
    s32 rotSpeed;
    s32 lifetimeDrain;
    s32 angle;
    u8 type;
    ScreenShakeFlags flags;
    s16 timer;
    Vec2Fx32 offset;
} ScreenShake;

// --------------------
// FUNCTIONS
// --------------------

ScreenShake *ShakeScreen(ScreenShakeType type);
ScreenShake *ShakeScreenEx(s32 lifetime, s32 rotSpeed, s32 lifetimeDrain);
s32 GetScreenShakeOffsetX(void);
s32 GetScreenShakeOffsetY(void);

#endif // RUSH2_SCREENSHAKE_H
