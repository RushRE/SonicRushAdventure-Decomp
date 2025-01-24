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

NOT_DECOMPILED void exStageTask__Destroy(void);
NOT_DECOMPILED void exSysTask__GetSingleton(void);
NOT_DECOMPILED s32 exSysTask__GetLifeCount(void);
NOT_DECOMPILED void exSysTask__Func_2172A38(void);
NOT_DECOMPILED void exSysTask__InitStatus(void);
NOT_DECOMPILED ExSysTaskStatus *exSysTask__GetStatus(void);
NOT_DECOMPILED BOOL exSysTask__GetFlag_2178650(void);
NOT_DECOMPILED void exSysTask__Main(void);
NOT_DECOMPILED void exSysTask__Func8(void);
NOT_DECOMPILED void exSysTask__Destructor(void);
NOT_DECOMPILED void exSysTask__Main_2172D30(void);
NOT_DECOMPILED void exSysTask__Func_2172D6C(void);
NOT_DECOMPILED void exSysTask__Main_2172D98(void);
NOT_DECOMPILED void exSysTask__Action_Pause(void);
NOT_DECOMPILED void exSysTask__Main_IsPaused(void);
NOT_DECOMPILED void exSysTask__Main_2172EF8(void);
NOT_DECOMPILED void exSysTask__Func_2172F30(void);
NOT_DECOMPILED void exSysTask__Main_2172FA4(void);
NOT_DECOMPILED void exSysTask__Func_2173000(void);
NOT_DECOMPILED void exSysTask__Main_2173074(void);
NOT_DECOMPILED void exSysTask__Func_21730D0(void);
NOT_DECOMPILED void exSysTask__Main_2173158(void);
NOT_DECOMPILED void exSysTask__Main_21731DC(void);
NOT_DECOMPILED void exSysTask__Main_217323C(void);
NOT_DECOMPILED void exSysTask__Main_21732E4(void);
NOT_DECOMPILED void exSysTask__Main_2173338(void);
NOT_DECOMPILED void exSysTask__Create(void);
NOT_DECOMPILED void *exSysTask__LoadExFile(u16 id);
NOT_DECOMPILED void exSysTask__GetSingleton_Unknown1(void);
NOT_DECOMPILED void exSysTask__LoadAssets(void);
NOT_DECOMPILED void exSysTask__SetupDisplay(void);

#endif // RUSH_EXSYSTASK_H
