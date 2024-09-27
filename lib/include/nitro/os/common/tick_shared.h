#ifndef NITRO_OS_TICK_SHARED_H
#define NITRO_OS_TICK_SHARED_H

#include <nitro/types.h>

// --------------------
// TYPES
// --------------------

typedef u64 OSTick;

// --------------------
// CONSTANTS
// --------------------

#define OS_SYSTEM_CLOCK HW_SYSTEM_CLOCK

#define OSi_BOUND_SEC1  128154
#define OSi_BOUND_SEC2  128
#define OSi_BOUND_TICK1 67108
#define OSi_BOUND_TICK2 67108863

// --------------------
// MACROS
// --------------------

#define OS_MicroSecondsToTicks(usec)   ((OSTick)(((OS_SYSTEM_CLOCK / 1000) * (u64)(usec)) / 64 / 1000))
#define OS_MicroSecondsToTicks32(usec) ((OSTick)(((OS_SYSTEM_CLOCK / 1000) * (u32)(usec)) / 64 / 1000))

#define OS_MilliSecondsToTicks(msec)   ((OSTick)(((OS_SYSTEM_CLOCK / 1000) * (u64)(msec)) / 64))
#define OS_MilliSecondsToTicks32(msec) ((OSTick)(((OS_SYSTEM_CLOCK / 1000) * (u32)(msec)) / 64))

#define OS_SecondsToTicks(sec)   ((OSTick)((OS_SYSTEM_CLOCK * (u64)(sec)) / 64))
#define OS_SecondsToTicks32(sec) ((OSTick)((OS_SYSTEM_CLOCK * (u32)(sec)) / 64))

#define OS_TicksToMicroSeconds(tick)   (((u64)(tick) * 64 * 1000) / (OS_SYSTEM_CLOCK / 1000))
#define OS_TicksToMicroSeconds32(tick) (((u32)(tick) * 64 * 1000) / (OS_SYSTEM_CLOCK / 1000))

#define OS_TicksToMilliSeconds(tick)   (((u64)(tick) * 64) / (OS_SYSTEM_CLOCK / 1000))
#define OS_TicksToMilliSeconds32(tick) (((u32)(tick) * 64) / (OS_SYSTEM_CLOCK / 1000))

#define OS_TicksToSeconds(tick)   (((u64)(tick) * 64) / OS_SYSTEM_CLOCK)
#define OS_TicksToSeconds32(tick) (((u32)(tick) * 64) / OS_SYSTEM_CLOCK)

#endif // NITRO_OS_TICK_SHARED_H
