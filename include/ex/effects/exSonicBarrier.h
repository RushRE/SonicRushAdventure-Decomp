#ifndef RUSH_EXSONICBARRIER_H
#define RUSH_EXSONICBARRIER_H

#include <ex/boss/exBoss.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exEffectBarrierHitTask_
{
    s32 unused;
    VecFx32 targetPos;
    EX_ACTION_NN_WORK aniBarrier;
} exEffectBarrierHitTask;

typedef struct exEffectBarrierTask_
{
    s16 power;
    s16 field_2;
    u32 unused;
    EX_ACTION_BAC3D_WORK aniBarrier;
    EX_ACTION_NN_WORK *parent;
    Task *parentTask;
} exEffectBarrierTask;

typedef struct exExEffectSonicBarrierTaMeTask_
{
    fx32 scale;
    NNSSndHandle *sndHandle;
    EX_ACTION_NN_WORK aniTaMe;
    EX_ACTION_NN_WORK *parent;
    Task *parentTask;
} exExEffectSonicBarrierTaMeTask;

// --------------------
// FUNCTIONS
// --------------------

BOOL CreateExSonicBarrierHitEffect(VecFx32 *targetPos);
void CreateExSonicBarrierEffect(EX_ACTION_NN_WORK *parent);
BOOL CreateExSonicBarrierChargingEffect(EX_ACTION_NN_WORK *parent);

#endif // RUSH_EXSONICBARRIER_H