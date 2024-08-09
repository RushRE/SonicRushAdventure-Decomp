/*
 * NOTE:
 * This file is shared between ARM9 and ARM7
 * DO NOT PUT PROC SPECIFIC CODE IN HERE
 * Thank You!
 */

/*
 * DO NOT INCLUDE THIS FILE DIRECTLY
 * Include OS_alarm.h from the specific proc's lib
 */

#ifndef NITRO_OS_ALARM_SHARED_H
#define NITRO_OS_ALARM_SHARED_H

#include <nitro/types.h>
#include <nitro/os/common/tick_shared.h>
#include <nitro/os/common/thread_shared.h>

// --------------------
// TYPES
// --------------------

typedef void (*OSAlarmHandler)(void *);

// --------------------
// STRUCTS
// --------------------

struct OSiAlarm
{
    OSAlarmHandler handler;
    void *arg;

    u32 tag;
    OSTick fire;
    OSAlarm *prev;
    OSAlarm *next;

    OSTick period;
    OSTick start;
};

// --------------------
// FUNCTIONS
// --------------------

void OS_InitAlarm(void);
BOOL OS_IsAlarmAvailable(void);
void OS_CreateAlarm(OSAlarm *alarm);
void OS_SetAlarm(OSAlarm *alarm, OSTick tick, OSAlarmHandler handler, void *arg);
void OS_CancelAlarm(OSAlarm *alarm);

#endif // NITRO_OS_ALARM_SHARED_H
