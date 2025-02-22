#ifndef RUSH_EXBOSSFIREEFFECT_H
#define RUSH_EXBOSSFIREEFFECT_H

#include <ex/boss/exBoss.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exBossEffectFireTask_
{
    s32 unused;
    EX_ACTION_NN_WORK aniFire;
    exBossSysAdminTask *parent;
} exBossEffectFireTask;

// --------------------
// FUNCTIONS
// --------------------

BOOL CreateExBossEffectFire(void);
void DisableExBossEffectFire(void);

#endif // RUSH_EXBOSSFIREEFFECT_H