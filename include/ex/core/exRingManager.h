#ifndef RUSH_EXRINGMANAGER_H
#define RUSH_EXRINGMANAGER_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>

// --------------------
// ENUMS
// --------------------

enum ExRingConfigFlags
{
    EXRINGCONFIG_SPAWN_NONE = 0x00,

    EXRINGCONFIG_SPAWN_L8 = 1 << 0,
    EXRINGCONFIG_SPAWN_L7 = 1 << 1,
    EXRINGCONFIG_SPAWN_L6 = 1 << 2,
    EXRINGCONFIG_SPAWN_L5 = 1 << 3,
    EXRINGCONFIG_SPAWN_L4 = 1 << 4,
    EXRINGCONFIG_SPAWN_L3 = 1 << 5,
    EXRINGCONFIG_SPAWN_L2 = 1 << 6,
    EXRINGCONFIG_SPAWN_L1 = 1 << 7,

    EXRINGCONFIG_SPAWN_R1 = 1 << 8,
    EXRINGCONFIG_SPAWN_R2 = 1 << 9,
    EXRINGCONFIG_SPAWN_R3 = 1 << 10,
    EXRINGCONFIG_SPAWN_R4 = 1 << 11,
    EXRINGCONFIG_SPAWN_R5 = 1 << 12,
    EXRINGCONFIG_SPAWN_R6 = 1 << 13,
    EXRINGCONFIG_SPAWN_R7 = 1 << 14,
    EXRINGCONFIG_SPAWN_R8 = 1 << 15,
};

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
