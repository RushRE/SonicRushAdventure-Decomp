#ifndef RUSH_EXMETEORMANAGER_H
#define RUSH_EXMETEORMANAGER_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>

// --------------------
// STRUCTS
// --------------------

struct exMeteorConfig
{
    s16 spawnDelay;
    float velocity;

    union
    {
        struct
        {
            u8 useColumnL4 : 1;
            u8 useColumnL3 : 1;
            u8 useColumnL2 : 1;
            u8 useColumnL1 : 1;
            u8 useColumnR1 : 1;
            u8 useColumnR2 : 1;
            u8 useColumnR3 : 1;
            u8 useColumnR4 : 1;
        };
        u32 field;
    } spawnPos;
};

typedef struct exEffectMeteoTask_
{
    BOOL isActive;
    VecFx32 velocity;
    VecU16 rotateDir;
    VecU16 rotateSpeed;
    EX_ACTION_NN_WORK aniMeteor;
    EX_ACTION_NN_WORK mdlMeteorBroken;
} exEffectMeteoTask;

typedef struct exEffectMeteoAdminTask_
{
    u16 tableID;
    u16 tablePos;
    u16 tableLoopCount;
    u16 tableSize;
    struct exMeteorConfig spawnConfig;
} exEffectMeteoAdminTask;

// --------------------
// FUNCTIONS
// --------------------

// ExMeteorManager
BOOL CreateExMeteorManager(void);
void DestroyExMeteorManager(void);

#endif // RUSH_EXMETEORMANAGER_H
