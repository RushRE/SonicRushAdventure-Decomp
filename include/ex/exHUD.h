#ifndef RUSH_EXTIMEGAMEPLAY_H
#define RUSH_EXTIMEGAMEPLAY_H

#include <ex/exTask.h>
#include <ex/exDrawReq.h>
#include <ex/exBoss.h>

// --------------------
// STRUCTS
// --------------------

struct exFixTimeTaskUnknown
{
    u16 isWarning;
    Vec2Fx16 minutePos;
    Vec2Fx16 tenSecondsPos;
    Vec2Fx16 secondsPos;
    Vec2Fx16 frameCounterPos;
    Vec2Fx16 centisecondsPos;
    EX_ACTION_BAC2D_WORK aniTimeText;
    EX_ACTION_BAC2D_WORK aniComma1[2];
    EX_ACTION_BAC2D_WORK aniComma2[2];
    EX_ACTION_BAC2D_WORK aniDigit[2][10];
};

typedef struct exFixTimeTask_
{
    struct exFixTimeTaskUnknown *worker;
} exFixTimeTask;

typedef struct exFixRemainderTask_
{
    Vec2Fx16 digit1Pos;
    Vec2Fx16 digit2Pos;
    EX_ACTION_BAC2D_WORK aniPlayerIcon;
    EX_ACTION_BAC2D_WORK aniX;
    EX_ACTION_BAC2D_WORK aniNumbers[10];
} exFixRemainderTask;

typedef struct exFixBossLifeGaugeTask_
{
    exBossSysAdminTask *boss;
    s16 field_4;
    s16 segmentCount;
    s16 segmentPos;
    s16 health;
    s16 healthChange;
    s16 field_E;
    float healthChangeF;
    EX_ACTION_BAC2D_WORK aniBossName;
    EX_ACTION_BAC2D_WORK aniCapL;
    EX_ACTION_BAC2D_WORK aniCapR;
    EX_ACTION_BAC2D_WORK aniLifeGauge[9];
} exFixBossLifeGaugeTask;

typedef struct exFixRingTask_
{
    u16 ringLossTimer;
    Vec2Fx16 digit1Pos;
    Vec2Fx16 digit2Pos;
    Vec2Fx16 digit3Pos;
    u16 field_E;
    EX_ACTION_BAC2D_WORK aniRingBackdrop;
    EX_ACTION_BAC2D_WORK aniNumbers[10];
    EX_ACTION_BAC2D_WORK aniNumbersWarning[10];
} exFixRingTask;

typedef struct exFixAdminTask_
{
    u16 field_0;
} exFixAdminTask;

// --------------------
// FUNCTIONS
// --------------------

void exFixAdminTask__LoadSprite(EX_ACTION_BAC2D_WORK *work);
void exFixAdminTask__ReleaseSprite(EX_ACTION_BAC2D_WORK *work);

void exFixTimeTask__Main(void);
void exFixTimeTask__Func8(void);
void exFixTimeTask__Destructor(void);
void exFixTimeTask__Func_216944C(void);
BOOL exFixTimeTask__Create(void);
void exFixTimeTask__Destroy(void);

void exFixRingTask__Main(void);
void exFixRingTask__Func8(void);
void exFixRingTask__Destructor(void);
void exFixRingTask__Main_Active(void);
BOOL exFixRingTask__Create(void);
void exFixRingTask__Destroy(void);

void exFixRemainderTask__Main(void);
void exFixRemainderTask__Func8(void);
void exFixRemainderTask__Destructor(void);
void exFixRemainderTask__Main_Active(void);
BOOL exFixRemainderTask__Create(void);
void exFixRemainderTask__Destroy(void);

void exFixBossLifeGaugeTask__Main(void);
void exFixBossLifeGaugeTask__Func8(void);
void exFixBossLifeGaugeTask__Destructor(void);
void exFixBossLifeGaugeTask__Main_Active(void);
void exFixBossLifeGaugeTask__Main_216A624(void);
BOOL exFixBossLifeGaugeTask__Create(void);
void exFixBossLifeGaugeTask__Destroy(void);

void exFixAdminTask__Main(void);
void exFixAdminTask__Func8(void);
void exFixAdminTask__Destructor(void);
void exFixAdminTask__Main_WaitForCommonHUD(void);
void exFixAdminTask__Action_CreateCommonHUD(void);
void exFixAdminTask__Main_WaitForBossHUD(void);
void exFixAdminTask__Action_CreateBossHUD(void);
void exFixAdminTask__Main_Idle(void);
BOOL exFixAdminTask__Create(void);
void exFixAdminTask__Destroy(void);

#endif // RUSH_EXTIMEGAMEPLAY_H
