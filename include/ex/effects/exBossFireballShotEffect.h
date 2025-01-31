#ifndef RUSH_EXBOSSFIREBALLSHOTEFFECT_H
#define RUSH_EXBOSSFIREBALLSHOTEFFECT_H

#include <ex/boss/exBoss.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exEffectBlzFireShotTask_
{
    s32 unused;
    EX_ACTION_NN_WORK aniShot;
    EX_ACTION_NN_WORK *parent;
    Task *parentTask;
} exEffectBlzFireShotTask;

// --------------------
// FUNCTIONS
// --------------------

void exBossEffectFireBallShotTask__Func_21560E0(void);
void exBossEffectFireBallShotTask__Func_215632C(void);
void exBossEffectFireBallShotTask__Main(void);
void exBossEffectFireBallShotTask__Func8(void);
void exBossEffectFireBallShotTask__Destructor(void);
void exBossEffectFireBallShotTask__Func_215649C(void);
void exBossEffectFireBallShotTask__Create(void);

#endif // RUSH_EXBOSSFIREBALLSHOTEFFECT_H

