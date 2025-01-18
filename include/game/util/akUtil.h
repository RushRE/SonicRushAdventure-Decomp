#ifndef RUSH_AKUTIL_H
#define RUSH_AKUTIL_H

#include <global.h>

// --------------------
// MACROS
// --------------------

#define AKUTIL_TIME_TO_FRAMES(min, sec, msec) (u32)(((min) * (60 * 60)) + ((sec) * 60) + ((msec) * (60.0f / 100.0f)))

// --------------------
// CONSTANTS
// --------------------

#define AKUTIL_MAX_FRAME_TIME AKUTIL_TIME_TO_FRAMES(59, 59, 99)

// --------------------
// FUNCTIONS
// --------------------

// NOTE: Assumes 'frame' is calculated at 60FPS!!!
void AkUtilFrameToTime(u32 frame, u16 *min, u16 *sec, u16 *msec);

#endif // RUSH_AKUTIL_H
