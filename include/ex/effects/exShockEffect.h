#ifndef RUSH_EXSHOCKEFFECT_H
#define RUSH_EXSHOCKEFFECT_H

#include <ex/boss/exBoss.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exEffectBiriBiriTask_
{
    VecFx32 targetPos;
    EX_ACTION_BAC3D_WORK aniShockEffect;
} exEffectBiriBiriTask;

// --------------------
// FUNCTIONS
// --------------------

BOOL CreateExShockEffect(VecFx32 *targetPos);

#endif // RUSH_EXSHOCKEFFECT_H