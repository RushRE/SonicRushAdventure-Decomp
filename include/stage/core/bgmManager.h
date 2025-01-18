#ifndef RUSH_STAGEBGM_MANAGER_H
#define RUSH_STAGEBGM_MANAGER_H

#include <game/system/task.h>

// --------------------
// FORWARD DECLS
// --------------------

struct StageTask_;

// --------------------
// ENUMS
// --------------------

enum ManagedSfxFlags_
{
    MANAGEDSFX_FLAG_NONE = 0x00,

    MANAGEDSFX_FLAG_HAS_DURATION        = 1 << 0,
    MANAGEDSFX_FLAG_HAS_DELAY           = 1 << 1,
    MANAGEDSFX_FLAG_HAS_PARENT          = 1 << 2,
    MANAGEDSFX_FLAG_DESTROY_WITH_PARENT = 1 << 3,
};
typedef u32 ManagedSfxFlags;

// --------------------
// STRUCTS
// --------------------

typedef struct StageBGMManager_
{
    BOOL usingUnderwaterBGM;
} StageBGMManager;

typedef struct ManagedSfx_
{
    NNSSndHandle *sndHandle;
    struct StageTask_ *parent;
    ManagedSfxFlags flags;
    s32 seqArcNo;
    s32 soundID;
    s32 playDuration;
    s32 playDelay;
} ManagedSfx;

// --------------------
// FUNCTIONS
// --------------------

// StageBGMManager
void InitStageBGM(void);
void ReleaseStageBGM(void);
void StartStageBGM(BOOL isInWater);
void StopStageBGM(void);
void FadeOutStageBGM(s32 fadeFrames);
void ChangeStageBGMVariant(BOOL isInWater);
void ChangeBossBGMVariant(BOOL pinchTrack);
void FadeStageBGMToTargetVolume(s32 volume, s32 duration, BOOL isInWater);

// ManagedSfx
void CreateManagedSfx(s32 seqArcNo, s32 soundID, ManagedSfxFlags flags, struct StageTask_ *parent, s32 duration, s32 delay);

#endif // RUSH_STAGEBGM_MANAGER_H
