#ifndef RUSH_EXBLAZEFIREBALL_H
#define RUSH_EXBLAZEFIREBALL_H

#include <ex/boss/exBoss.h>

// --------------------
// STRUCTS
// --------------------

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

NOT_DECOMPILED void exEffectBlzFireTask__LoadFireAssets(void);
NOT_DECOMPILED void exEffectBlzFireTask__ReleaseFireAssets(void);
NOT_DECOMPILED void exExEffectBlzFireTaMeTask__LoadFireTaMeAssets(void);
NOT_DECOMPILED void exExEffectBlzFireTaMeTask__ReleaseFireTaMeAssets(void);
NOT_DECOMPILED void exEffectBlzFireTask__LoadFireShotAssets(void);
NOT_DECOMPILED void exEffectBlzFireTask__ReleaseFireShotAssets(void);
NOT_DECOMPILED void exEffectBlzFireTask__Main(void);
NOT_DECOMPILED void exEffectBlzFireTask__Func8(void);
NOT_DECOMPILED void exEffectBlzFireTask__Destructor(void);
NOT_DECOMPILED void exEffectBlzFireTask__Main_Active(void);
NOT_DECOMPILED void exEffectBlzFireTask__HandleMovement(void);
NOT_DECOMPILED void exEffectBlzFireTask__Main_21669D4(void);
NOT_DECOMPILED void exEffectBlzFireTask__Create(EX_ACTION_NN_WORK *parent);

NOT_DECOMPILED void exExEffectBlzFireTaMeTask__Main(void);
NOT_DECOMPILED void exExEffectBlzFireTaMeTask__Func8(void);
NOT_DECOMPILED void exExEffectBlzFireTaMeTask__Destructor(void);
NOT_DECOMPILED void exExEffectBlzFireTaMeTask__Main_Active(void);
NOT_DECOMPILED void exExEffectBlzFireTaMeTask__Create(EX_ACTION_NN_WORK *parent);

#endif // RUSH_EXBLAZEFIREBALL_H
