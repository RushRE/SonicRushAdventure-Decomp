#ifndef RUSH_EXHUD_H
#define RUSH_EXHUD_H

#include <ex/exTask.h>
#include <ex/exDrawReq.h>
#include <ex/exBoss.h>

// --------------------
// STRUCTS
// --------------------

struct exFixTimeTaskWorker
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
    struct exFixTimeTaskWorker *worker;
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
    s16 totalSegmentCount;
    s16 healthSegmentCount;
    s16 healthSegmentPos;
    s16 health;
    s16 healthChange;
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
    EX_ACTION_BAC2D_WORK aniRingBackdrop;
    EX_ACTION_BAC2D_WORK aniNumbers[10];
    EX_ACTION_BAC2D_WORK aniNumbersWarning[10];
} exFixRingTask;

typedef struct exFixAdminTask_
{
    u16 unused;
} exFixAdminTask;

// --------------------
// FUNCTIONS
// --------------------

// ExHUD Helpers
void SetupExHUDSprite(EX_ACTION_BAC2D_WORK *work);
void ReleaseExHUDSprite(EX_ACTION_BAC2D_WORK *work);

// ExHUD
BOOL CreateExHUD(void);
void DestroyExHUD(void);

#endif // RUSH_EXHUD_H