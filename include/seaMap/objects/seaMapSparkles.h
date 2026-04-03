#ifndef RUSH_SEAMAPSPARKLES_H
#define RUSH_SEAMAPSPARKLES_H

#include <seaMap/seaMapEventManager.h>
#include <game/graphics/sprite.h>

// --------------------
// ENUMS/CONSTANTS
// --------------------

#define SEAMAPSPARKLES_PARTICLE_COUNT 64

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapSparkles_
{
    SeaMapObject objWork;
    volatile GraphicsEngine useEngineB;
    AnimatorSprite animators[SEAMAPSPARKLES_PARTICLE_COUNT];
    void *vramPixels[4];
    Vec2Fx32 positions[SEAMAPSPARKLES_PARTICLE_COUNT];
    fx32 velocity[SEAMAPSPARKLES_PARTICLE_COUNT];
    u16 angles[SEAMAPSPARKLES_PARTICLE_COUNT];
    u16 timers[SEAMAPSPARKLES_PARTICLE_COUNT];
    u16 animIDs[SEAMAPSPARKLES_PARTICLE_COUNT];
    fx32 initialVelocity;
    u16 initialLifeTime;
    u16 spawnDuration;
    u16 emitterLifeTime;
    u16 spriteCount;
    u16 timer;
    u16 spawnTimer;
} SeaMapSparkles;

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapSparkles(const SeaMapLayoutObjectType *objectType, SeaMapLayoutObject *mapObject);

#endif // RUSH_SEAMAPSPARKLES_H