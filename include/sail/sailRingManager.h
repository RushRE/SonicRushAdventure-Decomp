#ifndef RUSH_SAILRINGMANAGER_H
#define RUSH_SAILRINGMANAGER_H

#include <stage/stageTask.h>

// --------------------
// CONSTANTS
// --------------------

#define SAILRINGMANAGER_RING_LIST_SIZE 64

// --------------------
// STRUCTS
// --------------------

typedef struct SailRing_
{
    u16 flags;
    s16 timer;
    VecFx32 position;
    VecFx32 velocity;
} SailRing;

typedef struct SailRingManager_
{
    SailRing rings[SAILRINGMANAGER_RING_LIST_SIZE];
    AnimatorSprite3D aniRing;
    AnimatorSprite3D aniRing2;
    u16 field_908;
} SailRingManager;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED SailRingManager *SailRingManager_Create(void);
NOT_DECOMPILED SailRing *SailRingManager_CreateStageRing(VecFx32 *position);
NOT_DECOMPILED SailRing *SailRingManager_CreateObjectRing(VecFx32 *position, VecFx32 *velocity);
NOT_DECOMPILED void SailRingManager_CollectSailRing(SailRing *ring);

NOT_DECOMPILED void SailRingManager_Destructor(Task *task);
NOT_DECOMPILED void SailRingManager_Main(void);
NOT_DECOMPILED void SailRingManager_UpdateRings(SailRingManager *work);
NOT_DECOMPILED void SailRingManager_Func_2156AB4(SailRingManager *work, StageTask *player);
NOT_DECOMPILED void SailRingManager_CheckCollisions(SailRingManager *work, StageTask *player);
NOT_DECOMPILED void SailRingManager_GivePlayerRing(SailRing *ring, StageTask *player);
NOT_DECOMPILED void SailRingManager_DrawRings(SailRingManager *work);
NOT_DECOMPILED void SailRingManager_Func_21571C4(SailRingManager *work);

#endif // !RUSH_SAILRINGMANAGER_H