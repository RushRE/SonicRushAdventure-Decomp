#ifndef RUSH_EXBOSSFIREBALLSHOTEFFECT_H
#define RUSH_EXBOSSFIREBALLSHOTEFFECT_H

#include <ex/boss/exBoss.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exBossEffectFireBallShotTask_
{
    s32 unused;
    EX_ACTION_NN_WORK aniShot;
    exBossSysAdminTask *parent;
} exBossEffectFireBallShotTask;

// --------------------
// FUNCTIONS
// --------------------

BOOL CreateExBossEffectFireballShot(void);
void DisableExBossEffectFireballShot(void);

#endif // RUSH_EXBOSSFIREBALLSHOTEFFECT_H

