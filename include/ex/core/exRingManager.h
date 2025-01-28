#ifndef RUSH_EXRINGMANAGER_H
#define RUSH_EXRINGMANAGER_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>

// --------------------
// STRUCTS
// --------------------

struct exRingConfig
{
    s16 spawnDelay;
    float velocity;

    union
    {
        struct
        {
            u8 useColumnL8 : 1;
            u8 useColumnL7 : 1;
            u8 useColumnL6 : 1;
            u8 useColumnL5 : 1;
            u8 useColumnL4 : 1;
            u8 useColumnL3 : 1;
            u8 useColumnL2 : 1;
            u8 useColumnL1 : 1;
            u8 useColumnR1 : 1;
            u8 useColumnR2 : 1;
            u8 useColumnR3 : 1;
            u8 useColumnR4 : 1;
            u8 useColumnR5 : 1;
            u8 useColumnR6 : 1;
            u8 useColumnR7 : 1;
            u8 useColumnR8 : 1;
        };
        u32 field;
    } spawnPos;
};

struct exRingTableConfig
{
    u8 tableID;
    u16 tableSizes[12];
};

typedef struct exEffectLoopRingTask_
{
    EX_ACTION_BAC3D_WORK aniRing;
} exEffectLoopRingTask;

typedef struct exEffectRingTask_
{
    VecFx32 velocity;
    BOOL active;
    EX_ACTION_BAC3D_WORK aniRing;
} exEffectRingTask;

typedef struct exEffectRingAdminTask_
{
    u8 tableID;
    u16 tablePos;
    u16 tableLoopCount;
    u16 tableSize;
    struct exRingConfig spawnConfig;
} exEffectRingAdminTask;

// --------------------
// FUNCTIONS
// --------------------

// ExRingManager
void CreateExRingManager(void);
void DestroyExRingManager(void);

#endif // RUSH_EXRINGMANAGER_H
