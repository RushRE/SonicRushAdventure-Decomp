#ifndef RUSH_EXBOSSHOMINGEFFECT_H
#define RUSH_EXBOSSHOMINGEFFECT_H

#include <ex/boss/exBoss.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exBossEffectHomingTask_
{
    s32 unused;
    EX_ACTION_NN_WORK aniHoming;
    exBossSysAdminTask *parent;
} exBossEffectHomingTask;

// --------------------
// FUNCTIONS
// --------------------

BOOL CreateExBossEffectHoming(void);
void DisableExBossEffectHoming(void);

#endif // RUSH_EXBOSSHOMINGEFFECT_H
