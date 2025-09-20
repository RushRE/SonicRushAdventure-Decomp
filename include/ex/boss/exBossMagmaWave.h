#ifndef RUSH_EXBOSSMAGMAWAVE_H
#define RUSH_EXBOSSMAGMAWAVE_H

#include <ex/boss/exBoss.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exBossMagmaAttackTask_
{
    s16 timer;
    VecFx32 velocity;
    exBossSysAdminTask *parent;
    EX_ACTION_NN_WORK animator;
} exBossMagmaAttackTask;

typedef struct exBossMagmeWaveTask_
{
    s16 timer;
    VecFx32 velocity;
    exBossSysAdminTask *parent;
    EX_ACTION_NN_WORK animator;
} exBossMagmeWaveTask;

// --------------------
// FUNCTIONS
// --------------------

BOOL CreateExBossMagmaEruption(void);
BOOL CreateExBossMagmaWave(void);

#endif // RUSH_EXBOSSMAGMAWAVE_H