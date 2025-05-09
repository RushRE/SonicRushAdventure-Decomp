#ifndef RUSH_TRICK_CONFETTI_H
#define RUSH_TRICK_CONFETTI_H

#include <stage/stageTask.h>

// --------------------
// CONSTANTS
// --------------------

#define TRICKCONFETTI_PARTICLE_LIST_SIZE 32

#define TRICKCONFETTI_PARTICLE_TYPE_COUNT 6

// --------------------
// STRUCTS
// --------------------

typedef struct TrickConfettiParticle_
{
    struct TrickConfettiParticle_ *prev;
    struct TrickConfettiParticle_ *next;
    Vec2Fx32 position;
    Vec2Fx32 velocity;
    s16 animID;
    s16 flags;
} TrickConfettiParticle;

typedef struct TrickConfetti_
{
    AnimatorSpriteDS animators[TRICKCONFETTI_PARTICLE_TYPE_COUNT];
    u32 particleCount;
    TrickConfettiParticle *particleListStart;
    TrickConfettiParticle *particleListEnd;
    TrickConfettiParticle particleStorage[TRICKCONFETTI_PARTICLE_LIST_SIZE];
    TrickConfettiParticle *activeParticleList[TRICKCONFETTI_PARTICLE_LIST_SIZE];
} TrickConfetti;

// --------------------
// FUNCTIONS
// --------------------

void TrickConfetti__Create(void);
void TrickConfetti__Destroy(void);
void TrickConfetti__Main(void);
TrickConfettiParticle *TrickConfetti__RemoveLastParticle(TrickConfetti *work);
void TrickConfetti__AddParticle(TrickConfetti *work, TrickConfettiParticle *particle);

#endif // RUSH_TRICK_CONFETTI_H