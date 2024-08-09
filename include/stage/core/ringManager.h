#ifndef RUSH2_RINGMANAGER_H
#define RUSH2_RINGMANAGER_H

#include <stage/stageTask.h>
#include <game/stage/mapSys.h>
#include <stage/player/player.h>

// --------------------
// CONSTANTS
// --------------------

#define RINGMANAGER_RING_LIST_COUNT 128

#define RINGMANAGER_RING_SPILL_MAX      64
#define RINGMANAGER_RING_SPILL_LIFETIME 256
#define RINGMANAGER_RING_SPILL_COOLDOWN 40

#define RINGMANAGER_PLAYER_ATTRACT_SIZE 72

#define RINGMANAGER_RING_SPARKLE_LIFETIME 18

// --------------------
// ENUMS
// --------------------

enum RingFlag_
{
    RING_FLAG_NONE = 0,

    RING_FLAG_ATTRACT_P2      = 1 << 0,
    RING_FLAG_USE_PLANE_B     = 1 << 1,
    RING_FLAG_REVERSE_GRAVITY = 1 << 2,
    RING_FLAG_IS_SPILLRING    = 1 << 3,
};
typedef u16 RingFlag;

enum RingFlagManager_
{
    RINGMANAGER_FLAG_NONE = 0,

    RINGMANAGER_FLAG_INACTIVE          = 1 << 0,
    RINGMANAGER_FLAG_PENALTY_ACTIVE_P1 = 1 << 24,
    RINGMANAGER_FLAG_PENALTY_ACTIVE_P2 = 1 << 25,
};
typedef u32 RingManagerFlag;

enum RingAnimID_
{
    RING_ANI_RING,
    RING_ANI_SPARKLE,
};

// --------------------
// STRUCTS
// --------------------

typedef struct Ring_
{
    VecFx32 position;
    VecFx32 scale;
    Vec2Fx32 velocity;
    s16 timer;
    RingFlag flag;
    MapRing *eveRef;
    struct Ring_ *prev;
    struct Ring_ *next;
    StageTask *ductObject;
} Ring;

typedef struct RingManager_
{
    RingManagerFlag flags;
    void (*drawRing)(Ring *ring);
    void (*drawSparkle)(Ring *ring);
    BOOL (*rectCollideFunc)(OBS_RECT *rect1, OBS_RECT *rect2);
    void (*stageCollideFunc)(Ring *ring);
    AnimatorSpriteDS aniRing;
    AnimatorSpriteDS aniRingSparkle;
    AnimatorSprite3D aniRing3D;
    AnimatorSprite3D aniRingSparkle3D;
    u8 ringPenaltyCount[PLAYER_COUNT];
    u8 playerCount;
    s16 penaltyMultiplier;
    Ring *stageListStart;
    Ring *stageListEnd;
    Ring *twinkleListStart;
    Ring *twinkleListEnd;
    Ring *spillListStart;
    Ring *spillListEnd;
    Ring *attractRingListStart;
    Ring *attractRingListEnd;
    s32 usedRingCount;
    Ring *ringList[RINGMANAGER_RING_LIST_COUNT];
    Ring ringListStorage[RINGMANAGER_RING_LIST_COUNT];
} RingManager;

// --------------------
// FUNCTIONS
// --------------------

// Creation
RingManager *CreateRingManager(void);
Ring *CreateSpillRing(fx32 x, fx32 y, fx32 z, fx32 velocityX, fx32 velocityY, RingFlag flag);
Ring *CreateStageRing3D(MapRing *ring, fx32 x, fx32 y, fx32 z);
Ring *CreateStageRing2D(MapRing *ring, fx32 x, fx32 y);
void CreateLoseRingEffect(Player *player, s32 rings);

// Extra helpers
RingManager *GetRingManagerWork(void);
void SetStageRingScale(fx32 scale);
fx32 GetStageRingScale(void);
void HandleRingMagnetEffect(Player *player);

#endif // RUSH2_RINGMANAGER_H