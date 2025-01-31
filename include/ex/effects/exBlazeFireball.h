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

void exEffectBlzFireTask__LoadFireAssets(EX_ACTION_BAC3D_WORK *work, u16 anim);
void exEffectBlzFireTask__ReleaseFireAssets(EX_ACTION_BAC3D_WORK *work);
void exExEffectBlzFireTaMeTask__LoadFireTaMeAssets(EX_ACTION_NN_WORK *work);
void exExEffectBlzFireTaMeTask__ReleaseFireTaMeAssets(EX_ACTION_NN_WORK *work);
void exEffectBlzFireTask__LoadFireShotAssets(EX_ACTION_NN_WORK *work);
void exEffectBlzFireTask__ReleaseFireShotAssets(EX_ACTION_NN_WORK *work);
void exEffectBlzFireTask__Main(void);
void exEffectBlzFireTask__Func8(void);
void exEffectBlzFireTask__Destructor(void);
void exEffectBlzFireTask__Main_Active(void);
void exEffectBlzFireTask__HandleMovement(void);
void exEffectBlzFireTask__Main_21669D4(void);
BOOL exEffectBlzFireTask__Create(EX_ACTION_NN_WORK *parent);

void exExEffectBlzFireTaMeTask__Main(void);
void exExEffectBlzFireTaMeTask__Func8(void);
void exExEffectBlzFireTaMeTask__Destructor(void);
void exExEffectBlzFireTaMeTask__Main_Active(void);
BOOL exExEffectBlzFireTaMeTask__Create(EX_ACTION_NN_WORK *parent);

void exEffectBlzFireShotTask__Main(void);
void exEffectBlzFireShotTask__Func8(void);
void exEffectBlzFireShotTask__Destructor(void);
void exEffectBlzFireShotTask__Main_Charge(void);
BOOL exEffectBlzFireShotTask__Create(EX_ACTION_NN_WORK *parent);

#endif // RUSH_EXBLAZEFIREBALL_H
