#ifndef RUSH_EXSYSTASK_H
#define RUSH_EXSYSTASK_H

#include <ex/exTask.h>

// --------------------
// ENUMS
// --------------------

enum ExSysTaskState_
{
    EXSYSTASK_STATE_0,
    EXSYSTASK_STATE_1,
    EXSYSTASK_STATE_2,
    EXSYSTASK_STATE_3,
    EXSYSTASK_STATE_4,
    EXSYSTASK_STATE_5,
    EXSYSTASK_STATE_6,
    EXSYSTASK_STATE_7,
    EXSYSTASK_STATE_8,
    EXSYSTASK_STATE_9,
    EXSYSTASK_STATE_10,
    EXSYSTASK_STATE_11,
};
typedef u8 ExSysTaskState;

// --------------------
// STRUCTS
// --------------------

typedef struct ExSysTaskTime_
{
    u16 field_0;
    u16 minutes;
    u16 tenSeconds;
    u16 seconds;
    u16 frameCounter;
    u16 centiseconds;
} ExSysTaskTime;

typedef struct ExSysTaskStatus_
{
    u8 difficulty;
    u8 finishMode;
    u8 timeLimitMode;
    ExSysTaskState state;
    u8 lives;
    u16 rings;
    ExSysTaskTime time;
} ExSysTaskStatus;

typedef struct ExSysTask_
{
    u32 field_0;
    void *archive;
    u32 field_8;
    s16 timer;
    u16 field_10;
} ExSysTask;

// --------------------
// VARIABLES
// --------------------

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED ExSysTaskStatus *exSysTask__GetStatus(void);

#endif // RUSH_EXSYSTASK_H
