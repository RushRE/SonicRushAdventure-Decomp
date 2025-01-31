#ifndef RUSH_EXBOSSHITEFFECT_H
#define RUSH_EXBOSSHITEFFECT_H

#include <ex/boss/exBoss.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exBossEffectHitTask_
{
    s32 unused;
    EX_ACTION_NN_WORK aniHit;
    exBossSysAdminTask *parent;
} exBossEffectHitTask;

// --------------------
// FUNCTIONS
// --------------------

void exBossEffectHitTask__LoadAssets(EX_ACTION_NN_WORK *work);
void exBossEffectHitTask__Destroy_2155E74(EX_ACTION_NN_WORK *work);
void exBossEffectHitTask__Main(void);
void exBossEffectHitTask__Func8(void);
void exBossEffectHitTask__Destructor(void);
void exBossEffectHitTask__Main_2155FE4(void);
void exBossEffectHitTask__Create(void);

#endif // RUSH_EXBOSSHITEFFECT_H
