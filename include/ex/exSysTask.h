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

enum ExSysTaskActComAnimIDs
{
    EX_ACTCOM_ANI_0,
    EX_ACTCOM_ANI_1,
    EX_ACTCOM_ANI_2,
    EX_ACTCOM_ANI_3,
    EX_ACTCOM_ANI_4,
    EX_ACTCOM_ANI_5,
    EX_ACTCOM_ANI_6,
    EX_ACTCOM_ANI_7,
    EX_ACTCOM_ANI_8,
    EX_ACTCOM_ANI_9,
    EX_ACTCOM_ANI_10,
    EX_ACTCOM_ANI_11,
    EX_ACTCOM_ANI_12,
    EX_ACTCOM_ANI_13,
    EX_ACTCOM_ANI_14,
    EX_ACTCOM_ANI_15,
    EX_ACTCOM_ANI_16,
    EX_ACTCOM_ANI_17,
    EX_ACTCOM_ANI_18,
    EX_ACTCOM_ANI_19,
    EX_ACTCOM_ANI_20,
    EX_ACTCOM_ANI_21,
    EX_ACTCOM_ANI_22,
    EX_ACTCOM_ANI_23,
    EX_ACTCOM_ANI_24,
    EX_ACTCOM_ANI_25,
    EX_ACTCOM_ANI_26,
    EX_ACTCOM_ANI_27,
    EX_ACTCOM_ANI_28,
    EX_ACTCOM_ANI_29,
    EX_ACTCOM_ANI_30,
    EX_ACTCOM_ANI_31,
    EX_ACTCOM_ANI_32,
    EX_ACTCOM_ANI_33,
    EX_ACTCOM_ANI_34,
    EX_ACTCOM_ANI_35,
    EX_ACTCOM_ANI_36,
    EX_ACTCOM_ANI_37,
    EX_ACTCOM_ANI_38,
    EX_ACTCOM_ANI_39,
    EX_ACTCOM_ANI_40,
    EX_ACTCOM_ANI_41,
    EX_ACTCOM_ANI_42,
    EX_ACTCOM_ANI_43,
    EX_ACTCOM_ANI_44,
    EX_ACTCOM_ANI_45,
    EX_ACTCOM_ANI_46,
    EX_ACTCOM_ANI_47,
    EX_ACTCOM_ANI_48,
    EX_ACTCOM_ANI_49,
    EX_ACTCOM_ANI_50,
    EX_ACTCOM_ANI_51,
    EX_ACTCOM_ANI_52,
    EX_ACTCOM_ANI_53,
    EX_ACTCOM_ANI_54,
    EX_ACTCOM_ANI_55,
    EX_ACTCOM_ANI_56,
    EX_ACTCOM_ANI_57,
    EX_ACTCOM_ANI_58,
    EX_ACTCOM_ANI_59,
    EX_ACTCOM_ANI_60,
    EX_ACTCOM_ANI_61,
    EX_ACTCOM_ANI_62,
    EX_ACTCOM_ANI_63,
    EX_ACTCOM_ANI_64,
    EX_ACTCOM_ANI_65,
    EX_ACTCOM_ANI_66,
    EX_ACTCOM_ANI_67,
    EX_ACTCOM_ANI_68,
    EX_ACTCOM_ANI_69,
    EX_ACTCOM_ANI_70,
    EX_ACTCOM_ANI_71,
    EX_ACTCOM_ANI_72,
    EX_ACTCOM_ANI_73,
    EX_ACTCOM_ANI_74,
    EX_ACTCOM_ANI_75,
    EX_ACTCOM_ANI_76,
    EX_ACTCOM_ANI_77,
    EX_ACTCOM_ANI_78,
    EX_ACTCOM_ANI_79,
    EX_ACTCOM_ANI_80,
    EX_ACTCOM_ANI_81,
    EX_ACTCOM_ANI_82,
    EX_ACTCOM_ANI_83,
    EX_ACTCOM_ANI_84,
    EX_ACTCOM_ANI_85,
    EX_ACTCOM_ANI_86,
    EX_ACTCOM_ANI_87,
    EX_ACTCOM_ANI_88,
    EX_ACTCOM_ANI_89,
    EX_ACTCOM_ANI_90,
    EX_ACTCOM_ANI_91,
    EX_ACTCOM_ANI_92,
    EX_ACTCOM_ANI_93,
    EX_ACTCOM_ANI_94,
    EX_ACTCOM_ANI_95,
    EX_ACTCOM_ANI_96,
    EX_ACTCOM_ANI_97,
    EX_ACTCOM_ANI_98,
    EX_ACTCOM_ANI_99,
    EX_ACTCOM_ANI_100,
    EX_ACTCOM_ANI_101,
    EX_ACTCOM_ANI_102,
    EX_ACTCOM_ANI_103,
    EX_ACTCOM_ANI_104,
    EX_ACTCOM_ANI_105,
    EX_ACTCOM_ANI_106,
    EX_ACTCOM_ANI_107,
    EX_ACTCOM_ANI_108,
    EX_ACTCOM_ANI_109,
    EX_ACTCOM_ANI_110,
    EX_ACTCOM_ANI_111,
    EX_ACTCOM_ANI_112,
    EX_ACTCOM_ANI_113,
    EX_ACTCOM_ANI_114,
    EX_ACTCOM_ANI_115,
    EX_ACTCOM_ANI_116,
    EX_ACTCOM_ANI_117,
    EX_ACTCOM_ANI_118,
};

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
