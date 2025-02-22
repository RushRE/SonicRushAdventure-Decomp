#ifndef RUSH_EXBOSSSHOTEFFECT_H
#define RUSH_EXBOSSSHOTEFFECT_H

#include <ex/boss/exBoss.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exBossEffectShotTask_
{
    s32 unused;
    EX_ACTION_NN_WORK aniShot;
    exBossSysAdminTask *parent;
} exBossEffectShotTask;

// --------------------
// FUNCTIONS
// --------------------

BOOL CreateExBossEffectShot(void);

#endif // RUSH_EXBOSSSHOTEFFECT_H
