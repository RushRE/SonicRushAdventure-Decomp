#ifndef RUSH2_SEAMAPSPARKLES_H
#define RUSH2_SEAMAPSPARKLES_H

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
    BOOL useEngineB;
    AnimatorSprite animators[SEAMAPSPARKLES_PARTICLE_COUNT];
    void *vramPixels[4];
    Vec2Fx32 positions[SEAMAPSPARKLES_PARTICLE_COUNT];
    u32 velocity[SEAMAPSPARKLES_PARTICLE_COUNT];
    u16 angles[SEAMAPSPARKLES_PARTICLE_COUNT];
    u16 timers[SEAMAPSPARKLES_PARTICLE_COUNT];
    u16 animIDs[SEAMAPSPARKLES_PARTICLE_COUNT];
    u32 field_1DA4;
    u16 field_1DA8;
    u16 spawnDuration;
    u16 lifeDuration;
    u16 spriteCount;
    u16 timer;
    u16 spawnTimer;
} SeaMapSparkles;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED SeaMapObject *SeaMapSparkles__Create(CHEVObjectType *objectType, CHEVObject *mapObject);
NOT_DECOMPILED void SeaMapSparkles__Main(void);
NOT_DECOMPILED void SeaMapSparkles__Destructor(Task *task);

#endif // RUSH2_SEAMAPSPARKLES_H