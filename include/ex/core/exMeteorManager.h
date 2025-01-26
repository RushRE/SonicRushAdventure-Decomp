#ifndef RUSH_EXMETEORMANAGER_H
#define RUSH_EXMETEORMANAGER_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>

// --------------------
// STRUCTS
// --------------------

struct exMeteorConfig
{
    s32 spawnTimer;
    float moveVel;
    u32 spawnPos;
};

typedef struct exEffectMeteoTask_
{
    BOOL isActive;
    VecFx32 velocity;
    VecU16 field_10;
    VecU16 field_16;
    EX_ACTION_NN_WORK aniMeteor;
    EX_ACTION_NN_WORK mdlMeteorBroken;
} exEffectMeteoTask;

typedef struct exEffectMeteoAdminTask_
{
    u8 tableID;
    u16 tablePos;
    u16 tablePos2;
    u16 tableSize;
    struct exMeteorConfig spawnConfig;
} exEffectMeteoAdminTask;

// --------------------
// FUNCTIONS
// --------------------

// ExMeteorManager helpers
NOT_DECOMPILED void exEffectMeteoTask__LoadMeteoAssets(EX_ACTION_NN_WORK *work);
NOT_DECOMPILED void exEffectMeteoTask__ReleaseMeteoAssets(EX_ACTION_NN_WORK *work);
NOT_DECOMPILED void exEffectMeteoTask__LoadBrokenMeteoAssets(EX_ACTION_NN_WORK *work);
NOT_DECOMPILED void exEffectMeteoTask__ReleaseBrokenMeteoAssets(EX_ACTION_NN_WORK *work);

// ExMeteor
NOT_DECOMPILED void exEffectMeteoTask__Main(void);
NOT_DECOMPILED void exEffectMeteoTask__Func8(void);
NOT_DECOMPILED void exEffectMeteoTask__Destructor(void);
NOT_DECOMPILED void exEffectMeteoTask__Main_Moving(void);
NOT_DECOMPILED void exEffectMeteoTask__Action_Shatter(void);
NOT_DECOMPILED void exEffectMeteoTask__Main_Shatter(void);
NOT_DECOMPILED void exEffectMeteoTask__Action_Reflect(void);
NOT_DECOMPILED void exEffectMeteoTask__Main_Reflect(void);
NOT_DECOMPILED void exEffectMeteoTask__Create(void);

// ExMeteorManager
NOT_DECOMPILED void exEffectMeteoAdminTask__Main(void);
NOT_DECOMPILED void exEffectMeteoAdminTask__Func8(void);
NOT_DECOMPILED void exEffectMeteoAdminTask__Destructor(void);
NOT_DECOMPILED void exEffectMeteoAdminTask__Main_Active(void);
NOT_DECOMPILED void exEffectMeteoAdminTask__Func_2167F04(void);
NOT_DECOMPILED void exEffectMeteoAdminTask__Create(void);
NOT_DECOMPILED void exEffectMeteoAdminTask__Destroy_2168044(void);

#endif // RUSH_EXMETEORMANAGER_H
