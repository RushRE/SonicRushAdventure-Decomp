#include <game/util/akUtil.h>

// --------------------
// FUNCTIONS
// --------------------

void AkUtilFrameToTime(u32 frame, u16 *min, u16 *sec, u16 *msec)
{
    if (frame > AKUTIL_MAX_FRAME_TIME)
        frame = AKUTIL_MAX_FRAME_TIME;

    u16 minutes = FX_DivS32(frame, (60 * 60));
    frame -= (minutes * 60 * 60);

    u16 seconds = FX_DivS32(frame, 60);
    frame -= seconds * 60;

    // (frame * 433 >> 8) is roughly the same as (u32)(frame / (99.0 / 59.0)) aka converting from 0-59 -> 0-99
    u16 milliseconds = (frame * 433 >> 8);
    if (milliseconds >= 100)
        milliseconds = 99;

    if (min)
        *min = minutes;

    if (sec)
        *sec = seconds;

    if (msec)
        *msec = milliseconds;
}