#ifndef RUSH_SAILRINGMANAGER_H
#define RUSH_SAILRINGMANAGER_H

#include <stage/stageTask.h>

// --------------------
// CONSTANTS
// --------------------

#define SAILRINGMANAGER_RING_LIST_SIZE 64

#define SAILRINGMANAGER_RING_HEAL_AMOUNT FLOAT_TO_FX32(0.25)

// --------------------
// ENUMS
// --------------------

enum SailRingFlags_
{
    SAILRING_FLAG_NONE = 0x00,

    SAILRING_FLAG_ALLOCATED              = 1 << 0,
    SAILRING_FLAG_INVISIBLE              = 1 << 1, // logic exists for it, but doesn't seem to actually ever be set?
    SAILRING_FLAG_DISABLE_OBJ_COLLISIONS = 1 << 2,
    SAILRING_FLAG_IS_SPARKLE             = 1 << 3,
    SAILRING_FLAG_UNUSED                 = 1 << 4, // never referenced, never set.
    SAILRING_FLAG_USE_OWN_VELOCITY       = 1 << 5,
};
typedef u16 SailRingFlags;

// --------------------
// STRUCTS
// --------------------

typedef struct SailRing_
{
    SailRingFlags flags;
    s16 timer;
    VecFx32 position;
    VecFx32 velocity;
} SailRing;

typedef struct SailRingManager_
{
    SailRing rings[SAILRINGMANAGER_RING_LIST_SIZE];
    AnimatorSprite3D aniRing;
    AnimatorSprite3D aniRingSparkle;
    u16 ringTextureSize;
} SailRingManager;

// --------------------
// FUNCTIONS
// --------------------

SailRingManager *CreateSailRingManager(void);

SailRing *SailRingManager_CreateStageRing(VecFx32 *position);
SailRing *SailRingManager_CreateObjectRing(VecFx32 *position, VecFx32 *velocity);
void SailRingManager_DestroyRing(SailRing *ring);

void SailRingManager_CheckPlayerCollisions(SailRingManager *work, StageTask *player);

#endif // !RUSH_SAILRINGMANAGER_H