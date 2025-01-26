#ifndef RUSH_EXSYSTEM_H
#define RUSH_EXSYSTEM_H

#include <ex/system/exTask.h>

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

enum ExSysDifficulty_
{
    EXSYS_DIFFICULTY_NONE,
    EXSYS_DIFFICULTY_NORMAL,
    EXSYS_DIFFICULTY_EASY,
};
typedef u8 ExSysDifficulty;

enum ExSysTaskActComAnimIDs
{
    EX_ACTCOM_ANI_0,
    EX_ACTCOM_ANI_1,
    EX_ACTCOM_ANI_2,
    EX_ACTCOM_ANI_SHOCK_EFFECT,
    EX_ACTCOM_ANI_4,
    EX_ACTCOM_ANI_5,
    EX_ACTCOM_ANI_6,
    EX_ACTCOM_ANI_RING,
    EX_ACTCOM_ANI_RING_SPARKLE,
    EX_ACTCOM_ANI_BLAZE_FIRE,
    EX_ACTCOM_ANI_10,
    EX_ACTCOM_ANI_EXPLOSION_BIG,
    EX_ACTCOM_ANI_EXPLOSION_SMALL,
    EX_ACTCOM_ANI_HOMING_LASER,
    EX_ACTCOM_ANI_SUPERSONIC,
    EX_ACTCOM_ANI_BURNINGBLAZE,
    EX_ACTCOM_ANI_LIVES_BACKDROP,
    EX_ACTCOM_ANI_RINGS_BACKDROP,
    EX_ACTCOM_ANI_TIME_TEXT,
    EX_ACTCOM_ANI_LIVES_X,
    EX_ACTCOM_ANI_BOSSGAUGE_EDGE,
    EX_ACTCOM_ANI_BOSSGAUGE_BAR_0,
    EX_ACTCOM_ANI_BOSSGAUGE_BAR_1,
    EX_ACTCOM_ANI_BOSSGAUGE_BAR_2,
    EX_ACTCOM_ANI_BOSSGAUGE_BAR_3,
    EX_ACTCOM_ANI_BOSSGAUGE_BAR_4,
    EX_ACTCOM_ANI_BOSSGAUGE_BAR_5,
    EX_ACTCOM_ANI_BOSSGAUGE_BAR_6,
    EX_ACTCOM_ANI_BOSSGAUGE_BAR_7,
    EX_ACTCOM_ANI_BOSSGAUGE_BAR_8,
    EX_ACTCOM_ANI_BOSSGAUGE_NAME,
    EX_ACTCOM_ANI_COMMON_DIGIT_0,
    EX_ACTCOM_ANI_COMMON_DIGIT_1,
    EX_ACTCOM_ANI_COMMON_DIGIT_2,
    EX_ACTCOM_ANI_COMMON_DIGIT_3,
    EX_ACTCOM_ANI_COMMON_DIGIT_4,
    EX_ACTCOM_ANI_COMMON_DIGIT_5,
    EX_ACTCOM_ANI_COMMON_DIGIT_6,
    EX_ACTCOM_ANI_COMMON_DIGIT_7,
    EX_ACTCOM_ANI_COMMON_DIGIT_8,
    EX_ACTCOM_ANI_COMMON_DIGIT_9,
    EX_ACTCOM_ANI_COMMA_1,
    EX_ACTCOM_ANI_COMMA_2,
    EX_ACTCOM_ANI_ALERT_DIGIT_0,
    EX_ACTCOM_ANI_ALERT_DIGIT_1,
    EX_ACTCOM_ANI_ALERT_DIGIT_2,
    EX_ACTCOM_ANI_ALERT_DIGIT_3,
    EX_ACTCOM_ANI_ALERT_DIGIT_4,
    EX_ACTCOM_ANI_ALERT_DIGIT_5,
    EX_ACTCOM_ANI_ALERT_DIGIT_6,
    EX_ACTCOM_ANI_ALERT_DIGIT_7,
    EX_ACTCOM_ANI_ALERT_DIGIT_8,
    EX_ACTCOM_ANI_ALERT_DIGIT_9,
    EX_ACTCOM_ANI_ALERT_COMMA_1,
    EX_ACTCOM_ANI_ALERT_COMMA_2,
    EX_ACTCOM_ANI_LIFE_DIGIT_0,
    EX_ACTCOM_ANI_LIFE_DIGIT_1,
    EX_ACTCOM_ANI_LIFE_DIGIT_2,
    EX_ACTCOM_ANI_LIFE_DIGIT_3,
    EX_ACTCOM_ANI_LIFE_DIGIT_4,
    EX_ACTCOM_ANI_LIFE_DIGIT_5,
    EX_ACTCOM_ANI_LIFE_DIGIT_6,
    EX_ACTCOM_ANI_LIFE_DIGIT_7,
    EX_ACTCOM_ANI_LIFE_DIGIT_8,
    EX_ACTCOM_ANI_LIFE_DIGIT_9,
    EX_ACTCOM_ANI_TITLECARD_BACKDROP,
    EX_ACTCOM_ANI_TITLECARD_ICON,
    EX_ACTCOM_ANI_TITLECARD_ACT_BANNER,
    EX_ACTCOM_ANI_TITLECARD_LETTER_E,
    EX_ACTCOM_ANI_TITLECARD_LETTER_X,
    EX_ACTCOM_ANI_TITLECARD_LETTER_T,
    EX_ACTCOM_ANI_TITLECARD_LETTER_R,
    EX_ACTCOM_ANI_TITLECARD_LETTER_A,
    EX_ACTCOM_ANI_TITLECARD_GO_TEXT,
    EX_ACTCOM_ANI_TITLECARD_READY_TEXT,
    EX_ACTCOM_ANI_TITLECARD_ZONE_NAME_TEXT_JP,
    EX_ACTCOM_ANI_TUTORIAL_TEXT_BACKDROP,
    EX_ACTCOM_ANI_TUTORIAL_TEXT_SONIC_JPN,
    EX_ACTCOM_ANI_TUTORIAL_TEXT_BLAZE_JPN,
    EX_ACTCOM_ANI_TUTORIAL_TEXT_SONIC_ENG,
    EX_ACTCOM_ANI_TUTORIAL_TEXT_BLAZE_ENG,
    EX_ACTCOM_ANI_TUTORIAL_TEXT_SONIC_FRA,
    EX_ACTCOM_ANI_TUTORIAL_TEXT_BLAZE_FRA,
    EX_ACTCOM_ANI_TUTORIAL_TEXT_SONIC_DEU,
    EX_ACTCOM_ANI_TUTORIAL_TEXT_BLAZE_DEU,
    EX_ACTCOM_ANI_TUTORIAL_TEXT_SONIC_ITA,
    EX_ACTCOM_ANI_TUTORIAL_TEXT_BLAZE_ITA,
    EX_ACTCOM_ANI_TUTORIAL_TEXT_SONIC_SPA,
    EX_ACTCOM_ANI_TUTORIAL_TEXT_BLAZE_SPA,
    EX_ACTCOM_ANI_PAUSE_TEXT_JPN,
    EX_ACTCOM_ANI_CONTINUE_BUTTON_JPN,
    EX_ACTCOM_ANI_CONTINUE_BUTTON_SELECTED_JPN,
    EX_ACTCOM_ANI_BACK_BUTTON_JPN,
    EX_ACTCOM_ANI_BACK_BUTTON_SELECTED_JPN,
    EX_ACTCOM_ANI_PAUSE_TEXT_ENG,
    EX_ACTCOM_ANI_CONTINUE_BUTTON_ENG,
    EX_ACTCOM_ANI_CONTINUE_BUTTON_SELECTED_ENG,
    EX_ACTCOM_ANI_BACK_BUTTON_ENG,
    EX_ACTCOM_ANI_BACK_BUTTON_SELECTED_ENG,
    EX_ACTCOM_ANI_PAUSE_TEXT_FRA,
    EX_ACTCOM_ANI_CONTINUE_BUTTON_FRA,
    EX_ACTCOM_ANI_CONTINUE_BUTTON_SELECTED_FRA,
    EX_ACTCOM_ANI_BACK_BUTTON_FRA,
    EX_ACTCOM_ANI_BACK_BUTTON_SELECTED_FRA,
    EX_ACTCOM_ANI_PAUSE_TEXT_DEU,
    EX_ACTCOM_ANI_CONTINUE_BUTTON_DEU,
    EX_ACTCOM_ANI_CONTINUE_BUTTON_SELECTED_DEU,
    EX_ACTCOM_ANI_BACK_BUTTON_DEU,
    EX_ACTCOM_ANI_BACK_BUTTON_SELECTED_DEU,
    EX_ACTCOM_ANI_PAUSE_TEXT_ITA,
    EX_ACTCOM_ANI_CONTINUE_BUTTON_ITA,
    EX_ACTCOM_ANI_CONTINUE_BUTTON_SELECTED_ITA,
    EX_ACTCOM_ANI_BACK_BUTTON_ITA,
    EX_ACTCOM_ANI_BACK_BUTTON_SELECTED_ITA,
    EX_ACTCOM_ANI_PAUSE_TEXT_SPA,
    EX_ACTCOM_ANI_CONTINUE_BUTTON_SPA,
    EX_ACTCOM_ANI_CONTINUE_BUTTON_SELECTED_SPA,
    EX_ACTCOM_ANI_BACK_BUTTON_SPA,
    EX_ACTCOM_ANI_BACK_BUTTON_SELECTED_SPA,
};

// --------------------
// STRUCTS
// --------------------

typedef struct exSysTaskTime_
{
    u16 field_0;
    u16 minutes;
    u16 tenSeconds;
    u16 seconds;
    u16 frameCounter;
    u16 centiseconds;
} exSysTaskTime;

typedef struct exSysTaskStatus_
{
    ExSysDifficulty difficulty;
    u8 finishMode;
    u8 timeLimitMode;
    ExSysTaskState state;
    u8 lives;
    u16 rings;
    exSysTaskTime time;
} exSysTaskStatus;

typedef struct exSysTask_
{
    void *drawState;
    void *archiveCommon;
    void *sndArc;
    s16 timer;
    u16 field_10;
} exSysTask;

// --------------------
// FUNCTIONS
// --------------------

s32 GetExSystemLifeCount(void);
void LoseExSystemLife(void);
void InitExSystemStatus(void);
exSysTaskStatus *GetExSystemStatus(void);
BOOL GetExSystemFlag_2178650(void);

void CreateExSystem(void);
void *LoadExSystemFile(u16 id);
void *GetExSystemDrawState(void);

#endif // RUSH_EXSYSTEM_H
