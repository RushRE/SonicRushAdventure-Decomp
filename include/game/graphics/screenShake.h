#ifndef RUSH_SCREENSHAKE_H
#define RUSH_SCREENSHAKE_H

#include <game/system/task.h>

// --------------------
// MACROS
// --------------------

// Calculate deceleration value based on a given power & duration for SCREENSHAKE_CYCLE type
#define SCREENSHAKE_DECEL_FROM_TIME(power, duration) ((power) / (duration))

// --------------------
// ENUMS
// --------------------

enum ScreenShakeType_
{
    // Stops the active screen shake
    SCREENSHAKE_STOP,

    SCREENSHAKE_TINY_SHORT,
    SCREENSHAKE_SMALL_SHORT,
    SCREENSHAKE_MEDIUM_SHORT,
    SCREENSHAKE_BIG_SHORT,
    SCREENSHAKE_MASSIVE_SHORT,

    SCREENSHAKE_TINY_MIDDLE,
    SCREENSHAKE_SMALL_MIDDLE,
    SCREENSHAKE_MEDIUM_MIDDLE,
    SCREENSHAKE_BIG_MIDDLE,
    SCREENSHAKE_MASSIVE_MIDDLE,

    SCREENSHAKE_TINY_LONG,
    SCREENSHAKE_SMALL_LONG,
    SCREENSHAKE_MEDIUM_LONG,
    SCREENSHAKE_BIG_LONG,
    SCREENSHAKE_MASSIVE_LONG,

    SCREENSHAKE_CYCLE,

    // Returns the active screen shake
    SCREENSHAKE_GET_ACTIVE,
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
    fx32 power;
    s32 angleSpeed;
    fx32 deceleration;
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
ScreenShake *ShakeScreenCycle(fx32 power, s32 angleSpeed, fx32 deceleration);
s32 GetScreenShakeOffsetX(void);
s32 GetScreenShakeOffsetY(void);

#endif // RUSH_SCREENSHAKE_H
