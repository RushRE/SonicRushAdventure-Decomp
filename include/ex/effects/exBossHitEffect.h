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

BOOL CreateExBossEffectHit(void);

#endif // RUSH_EXBOSSHITEFFECT_H
