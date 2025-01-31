#ifndef RUSH_EXBIGEXPLOSION_H
#define RUSH_EXBIGEXPLOSION_H

#include <ex/boss/exBoss.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exEffectBigBombTask_
{
    VecFx32 targetPos;
    EX_ACTION_BAC3D_WORK aniExplosion;
} exEffectBigBombTask;

// --------------------
// FUNCTIONS
// --------------------

BOOL CreateExExplosion(VecFx32 *targetPos);

#endif // RUSH_EXBIGEXPLOSION_H