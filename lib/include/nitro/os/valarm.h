#ifndef NITRO_OS_VALARM_H
#define NITRO_OS_VALARM_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// TYPES
// --------------------

typedef void (*OSVAlarmHandler)(void *);

// --------------------
// STRUCTS
// --------------------

typedef struct OSiVAlarm OSVAlarm;
struct OSiVAlarm
{
    OSVAlarmHandler handler;
    void *arg;
    u32 tag;
    u32 frame;
    s16 fire;
    s16 delay;
    OSVAlarm *prev;
    OSVAlarm *next;
    BOOL period;
    BOOL finish;
    BOOL canceled;
};

// --------------------
// FUNCTIONS
// --------------------

void OS_InitVAlarm(void);
void OS_CreateVAlarm(OSVAlarm *alarm);
void OS_SetVAlarm(OSVAlarm *alarm, s16 count, s16 delay, OSVAlarmHandler handler, void *arg);
void OS_CancelVAlarm(OSVAlarm *alarm);

#ifdef __cplusplus
}
#endif

#endif // NITRO_OS_VALARM_H
