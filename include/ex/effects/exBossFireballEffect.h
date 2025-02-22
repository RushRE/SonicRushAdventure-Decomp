#ifndef RUSH_EXBOSSFIREBALLEFFECT_H
#define RUSH_EXBOSSFIREBALLEFFECT_H

#include <ex/boss/exBoss.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exBossEffectFireBallTask_
{
    s32 unused;
    EX_ACTION_NN_WORK aniFire;
    exBossSysAdminTask *parent;
} exBossEffectFireBallTask;

// --------------------
// FUNCTIONS
// --------------------

BOOL CreateExBossEffectFireball(void);
void DisableExBossEffectFireball(void);

#endif // RUSH_EXBOSSFIREBALLEFFECT_H
