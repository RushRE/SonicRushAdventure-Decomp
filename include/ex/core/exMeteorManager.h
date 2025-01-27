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
void exEffectMeteoTask__LoadMeteoAssets(EX_ACTION_NN_WORK *work);
void exEffectMeteoTask__ReleaseMeteoAssets(EX_ACTION_NN_WORK *work);
void exEffectMeteoTask__LoadBrokenMeteoAssets(EX_ACTION_NN_WORK *work);
void exEffectMeteoTask__ReleaseBrokenMeteoAssets(EX_ACTION_NN_WORK *work);

// ExMeteor
void exEffectMeteoTask__Main(void);
void exEffectMeteoTask__Func8(void);
void exEffectMeteoTask__Destructor(void);
void exEffectMeteoTask__Main_Moving(void);
void exEffectMeteoTask__Action_Shatter(void);
void exEffectMeteoTask__Main_Shatter(void);
void exEffectMeteoTask__Action_Reflect(void);
void exEffectMeteoTask__Main_Reflect(void);
void exEffectMeteoTask__Create(VecFx32 position, VecFx32 velocity);

// ExMeteorManager
void exEffectMeteoAdminTask__Main(void);
void exEffectMeteoAdminTask__Func8(void);
void exEffectMeteoAdminTask__Destructor(void);
void exEffectMeteoAdminTask__Main_Active(void);
void exEffectMeteoAdminTask__Func_2167F04(void);
void exEffectMeteoAdminTask__Create(void);
void exEffectMeteoAdminTask__Destroy(void);

#endif // RUSH_EXMETEORMANAGER_H
