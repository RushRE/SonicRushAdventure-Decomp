#ifndef RUSH_TRIPLEGRINDRAIL_H
#define RUSH_TRIPLEGRINDRAIL_H

#include <stage/gameObject.h>

// --------------------
// CONSTANTS
// --------------------

#define TRIPLEGRINDRAILRINGLOSS_MAX_RINGS               64
#define TRIPLEGRINDRAIL_ANI_COUNT                       7
#define TRIPLEGRINDRAIL_LEAF_COUNT                      64
#define TRIPLEGRINDRAIL_MUSHROOM_COUNT                  8
#define TRIPLEGRINDRAIL_ANI_COUNT                       7
#define TRIPLEGRINDRAIL_X_OFFSET                        FLOAT_TO_FX32(321.73095703125)
#define TRIPLEGRINDRAIL_EXIT_DISTANCE_TO_LAUNCH         FX32_FROM_WHOLE(300)
#define TRIPLEGRINDRAIL_DISTANCE_BETWEEN_RAILS          FLOAT_TO_FX32(89.0947265625)
#define TRIPLEGRINDRAIL_RADIUS_RAIL_0                   FLOAT_TO_FX32(232.63623046875)    // The rail with ID 0 is the rightmost one on screen.
#define TRIPLEGRINDRAIL_PARTICLE_CUTOFF_ANGLE_UNLOADING FLOAT_DEG_TO_IDX(150.00732421875) // Particles' angles start at around 300 and are decremented until this
#define TRIPLEGRINDRAIL_Y_UNUSED_PARTICLE               FLOAT_TO_FX32(256.0)

// --------------------
// ENUMS
// --------------------

enum TripleGrindRailFlag_
{
    TRIPLEGRINDRAIL_FLAG_EXIT_ABOUT_TO_START = 1 << 0,
    TRIPLEGRINDRAIL_FLAG_EXIT_STARTED        = 1 << 1,
};
typedef u32 TripleGrindRailFlag;

// --------------------
// STRUCTS
// --------------------

typedef struct TripleGrindRailParticle_
{
    fx32 radius;
    fx32 y;
    u16 angle;
    u16 id;
} TripleGrindRailParticle;

typedef struct TripleGrindRail_
{
    GameObjectTask gameWork;
    OBS_ACTION3D_NN_WORK aniTripleGrindRail;
    AnimatorSprite3D aniDecorations[TRIPLEGRINDRAIL_ANI_COUNT];
    AnimatorSprite3D aniRing;
    AnimatorSprite3D aniRingSparkle;
    TripleGrindRailFlag flags;
    s32 railStartExitX;
    fx32 scrollAndAniSpeedMultiplier; // Starts at 0.25, progressively increases to 1.0
    fx32 zOffset;
    u16 sequenceSpeed; // Grows linearly with scrollAndAniSpeedMultiplier
    s16 countFramesToNextLeafParticle;
    TripleGrindRailParticle leafList[TRIPLEGRINDRAIL_LEAF_COUNT];
    s16 countFramesToNextMushroomParticle;
    TripleGrindRailParticle mushroomList[TRIPLEGRINDRAIL_MUSHROOM_COUNT];
} TripleGrindRail;

typedef struct TripleGrindRailSpring_
{
    GameObjectTask gameWork;
} TripleGrindRailSpring;

// An hybrid used for both rings and spiked obstacles
typedef struct TripleGrindRailEntity_
{
    GameObjectTask gameWork;
    OBS_ACTION3D_BAC_WORK aniSprite; // spiked obstacle graphics
    fx32 radius;
    u16 angle;
} TripleGrindRailEntity;

typedef struct TripleGrindRailRingLoss_
{
    StageTask objWork;
    s32 ringCount;
    VecFx32 ringPosition[TRIPLEGRINDRAILRINGLOSS_MAX_RINGS];
    fx32 ringVelocityX[TRIPLEGRINDRAILRINGLOSS_MAX_RINGS];
    fx32 ringVelocityY[TRIPLEGRINDRAILRINGLOSS_MAX_RINGS];
} TripleGrindRailRingLoss;

// --------------------
// FUNCTIONS
// --------------------

TripleGrindRailSpring *TripleGrindRailSpring__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
TripleGrindRail *TripleGrindRail__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
TripleGrindRailEntity *TripleGrindRailEntity__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);
void TripleGrindRailRingLoss__Create(Player *player);

void TripleGrindRailSpring__State_Active(TripleGrindRailSpring *work);
void TripleGrindRailSpring__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

void TripleGrindRail__Destructor(Task *task);
void TripleGrindRail__State_WaitUntilPlayerOnRails(TripleGrindRail *work);
void TripleGrindRail__State_PlayerGrinding(TripleGrindRail *work);
void TripleGrindRail__CreateLeafParticle(TripleGrindRailParticle *particle);
void TripleGrindRail__CreateMushroomParticle(TripleGrindRailParticle *particle);
void TripleGrindRail__State_PlayerExiting(TripleGrindRail *work);
void TripleGrindRail__State_Destroy(TripleGrindRail *work);
void TripleGrindRail__OnDefend_StartTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

void TripleGrindRailEntity__State_Inactive(TripleGrindRailEntity *work);
void TripleGrindRailEntity__State_Active(TripleGrindRailEntity *work);
void TripleGrindRailEntity__Draw(void);
void TripleGrindRailEntity__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

void TripleGrindRailRingLoss__State_Active(TripleGrindRailRingLoss *work);
void TripleGrindRailRingLoss__Draw(void);

#endif // RUSH_TRIPLEGRINDRAIL_H