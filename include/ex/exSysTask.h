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

NOT_DECOMPILED void ovl09_21729EC(void);
NOT_DECOMPILED void ovl09_2172A18(void);
NOT_DECOMPILED void ovl09_2172A28(void);
NOT_DECOMPILED void ovl09_2172A38(void);
NOT_DECOMPILED void ovl09_2172A50(void);
NOT_DECOMPILED ExSysTaskStatus *exSysTask__GetStatus(void);
NOT_DECOMPILED BOOL ovl09_2172AE0(void);
NOT_DECOMPILED void exSysTask__Main(void);
NOT_DECOMPILED void exSysTask__Func8(void);
NOT_DECOMPILED void exSysTask__Destructor(void);
NOT_DECOMPILED void ovl09_2172D30(void);
NOT_DECOMPILED void ovl09_2172D6C(void);
NOT_DECOMPILED void ovl09_2172D98(void);
NOT_DECOMPILED void ovl09_2172E48(void);
NOT_DECOMPILED void ovl09_2172E7C(void);
NOT_DECOMPILED void ovl09_2172EF8(void);
NOT_DECOMPILED void ovl09_2172F30(void);
NOT_DECOMPILED void ovl09_2172FA4(void);
NOT_DECOMPILED void ovl09_2173000(void);
NOT_DECOMPILED void ovl09_2173074(void);
NOT_DECOMPILED void ovl09_21730D0(void);
NOT_DECOMPILED void ovl09_2173158(void);
NOT_DECOMPILED void ovl09_21731DC(void);
NOT_DECOMPILED void ovl09_217323C(void);
NOT_DECOMPILED void ovl09_21732E4(void);
NOT_DECOMPILED void ovl09_2173338(void);
NOT_DECOMPILED void exSysTask__Create(void);
NOT_DECOMPILED void ovl09_21733D4(void);
NOT_DECOMPILED void ovl09_2173424(void);
NOT_DECOMPILED void ovl09_2173438(void);
NOT_DECOMPILED void ovl09_2173500(void);

#endif // RUSH_EXSYSTASK_H
