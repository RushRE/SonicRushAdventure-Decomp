#ifndef RUSH_STALACTITE_H
#define RUSH_STALACTITE_H

#include <stage/gameObject.h>

// --------------------
// CONSTANTS
// --------------------

#define STALACTITE_PARTICLE_COUNT 32

// --------------------
// STRUCTS
// --------------------

typedef struct StalactiteParticle_
{
    u16 type;
    u16 displayFlag;
    VecFx32 position;
    VecFx32 velocity;
    struct StalactiteParticle_ *next;
} StalactiteParticle;

typedef struct FallingStalactite_
{
    GameObjectTask gameWork;
    StageTaskCollisionObj collisionWork1;
    StageTaskCollisionObj collisionWork2;
    StageTaskCollisionObj collisionWork3;
} FallingStalactite;

typedef struct Stalactite_
{
    GameObjectTask gameWork;
    void (*stateWeakPoint)(struct Stalactite_ *work);
    AnimatorSpriteDS aniWeakPoint;
    FallingStalactite *fallingStalactite;
    StageTaskCollisionObj collisionWork1;
    AnimatorSpriteDS aniDebris[3];
    StalactiteParticle particleStorage[32];
    StalactiteParticle *particleList[32];
    StalactiteParticle *particleListStart;
    u32 availableParticleCount;
} Stalactite;

// --------------------
// FUNCTIONS
// --------------------

Stalactite *CreateStalactite(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
FallingStalactite *CreateFallingStalactite(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_STALACTITE_H