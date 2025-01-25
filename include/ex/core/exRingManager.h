#ifndef RUSH_EXRINGMANAGER_H
#define RUSH_EXRINGMANAGER_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>

// --------------------
// STRUCTS
// --------------------

struct exRingConfig
{
    s16 spawnTimer;
    s16 field_2;
    float moveVel;
    u32 spawnPos;
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
    u16 tablePos2;
    u16 tableSize;
    struct exRingConfig spawnConfig;
} exEffectRingAdminTask;

// --------------------
// FUNCTIONS
// --------------------

// ExRingManager helpers
NOT_DECOMPILED void exEffectLoopRingTask__InitRingSprite(EX_ACTION_BAC3D_WORK *work);
NOT_DECOMPILED void exEffectLoopRingTask__SetRingAnim(EX_ACTION_BAC3D_WORK *work, u16 anim);

// ExRingField
NOT_DECOMPILED void exEffectLoopRingTask__Destroy_2168190(void);
NOT_DECOMPILED void exEffectLoopRingTask__Main(void);
NOT_DECOMPILED void exEffectLoopRingTask__Func8(void);
NOT_DECOMPILED void exEffectLoopRingTask__Destructor(void);
NOT_DECOMPILED void exEffectLoopRingTask__Main_Animate(void);
NOT_DECOMPILED void exEffectLoopRingTask__Create(void);

// ExRing
NOT_DECOMPILED void exEffectRingTask__Main(void);
NOT_DECOMPILED void exEffectRingTask__Func8(void);
NOT_DECOMPILED void exEffectRingTask__Destructor(void);
NOT_DECOMPILED void exEffectRingTask__Main_Ring(void);
NOT_DECOMPILED void exEffectRingTask__Action_Collect(void);
NOT_DECOMPILED void exEffectRingTask__Main_Sparkle(void);
NOT_DECOMPILED BOOL exEffectRingTask__Create(fx32 x, fx32 y, fx32 z, fx32 velX, fx32 velY, fx32 velZ);

// ExRingManager
NOT_DECOMPILED void exEffectRingAdminTask__Main(void);
NOT_DECOMPILED void exEffectRingAdminTask__Func8(void);
NOT_DECOMPILED void exEffectRingAdminTask__Destructor(void);
NOT_DECOMPILED void exEffectRingAdminTask__Main_Active(void);
NOT_DECOMPILED void exEffectRingAdminTask__InitValues(void);
NOT_DECOMPILED void exEffectRingAdminTask__Create(void);
NOT_DECOMPILED void exEffectRingAdminTask__Destroy(void);

#endif // RUSH_EXRINGMANAGER_H
