#ifndef RUSH_EXBLAZEFIREBALL_H
#define RUSH_EXBLAZEFIREBALL_H

#include <ex/boss/exBoss.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exEffectBlzFireShotTask_
{
    s32 unused;
    EX_ACTION_NN_WORK aniShot;
    EX_ACTION_NN_WORK *parent;
    Task *parentTask;
} exEffectBlzFireShotTask;

typedef struct exEffectBlzFireTask_
{
    fx32 scale;
    VecFx32 velocity;
    EX_ACTION_BAC3D_WORK aniFire;
    EX_ACTION_NN_WORK *parent;
    Task *parentTask;
} exEffectBlzFireTask;

typedef struct exExEffectBlzFireTaMeTask_
{
    fx32 scale;
    NNSSndHandle *handle;
    EX_ACTION_NN_WORK aniTaMe;
    EX_ACTION_NN_WORK *parent;
    Task *parentTask;
} exExEffectBlzFireTaMeTask;

// --------------------
// FUNCTIONS
// --------------------

BOOL CreateExBlazeFireballEffect(EX_ACTION_NN_WORK *parent);
BOOL CreateExBlazeFireballChargingEffect(EX_ACTION_NN_WORK *parent);
BOOL CreateExBlazeFireballShotEffect(EX_ACTION_NN_WORK *parent);

#endif // RUSH_EXBLAZEFIREBALL_H
