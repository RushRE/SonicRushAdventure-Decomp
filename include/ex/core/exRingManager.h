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
void exEffectLoopRingTask__InitRingSprite(EX_ACTION_BAC3D_WORK *work);
void exEffectLoopRingTask__SetRingAnim(EX_ACTION_BAC3D_WORK *work, u16 anim);

// ExRingField
void exEffectLoopRingTask__Destroy_2168190(void);
void exEffectLoopRingTask__Main(void);
void exEffectLoopRingTask__Func8(void);
void exEffectLoopRingTask__Destructor(void);
void exEffectLoopRingTask__Main_Animate(void);
void exEffectLoopRingTask__Create(void);

// ExRing
void exEffectRingTask__Main(void);
void exEffectRingTask__Func8(void);
void exEffectRingTask__Destructor(void);
void exEffectRingTask__Main_Ring(void);
void exEffectRingTask__Action_Collect(void);
void exEffectRingTask__Main_Sparkle(void);
BOOL exEffectRingTask__Create(fx32 x, fx32 y, fx32 z, fx32 velX, fx32 velY, fx32 velZ);

// ExRingManager
void exEffectRingAdminTask__Main(void);
void exEffectRingAdminTask__Func8(void);
void exEffectRingAdminTask__Destructor(void);
void exEffectRingAdminTask__Main_Active(void);
void exEffectRingAdminTask__InitValues(void);
void exEffectRingAdminTask__Create(void);
void exEffectRingAdminTask__Destroy(void);

#endif // RUSH_EXRINGMANAGER_H
