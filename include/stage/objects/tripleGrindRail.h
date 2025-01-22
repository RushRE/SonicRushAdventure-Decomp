#ifndef RUSH_TRIPLEGRINDRAIL_H
#define RUSH_TRIPLEGRINDRAIL_H

#include <stage/gameObject.h>

// --------------------
// CONSTANTS
// --------------------

#define TRIPLEGRINDRAILRINGLOSS_MAX_RINGS 64

// --------------------
// STRUCTS
// --------------------

typedef struct TripleGrindRailParticle_
{
    s32 radius;
    u32 y;
    u16 angle;
    u16 id;
} TripleGrindRailParticle;

typedef struct TripleGrindRail_
{
    GameObjectTask gameWork;
    OBS_ACTION3D_NN_WORK aniTripleGrindRail;
    AnimatorSprite3D aniDecorations[7];
    AnimatorSprite3D aniRing;
    AnimatorSprite3D aniRingSparkle;
    u32 flags;
    u32 dwordE08;
    s32 field_E0C;
    s32 field_E10;
    u16 field_E14;
    s16 field_E16;
    TripleGrindRailParticle leafList[64];
    s16 field_1118;
    s16 field_111A;
    TripleGrindRailParticle mushroomList[8];
} TripleGrindRail;

typedef struct TripleGrindRailSpring_
{
    GameObjectTask gameWork;
} TripleGrindRailSpring;

typedef struct TripleGrindRailEntity_
{
    GameObjectTask gameWork;
    OBS_ACTION3D_BAC_WORK aniSprite;
    s32 radius;
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
void TripleGrindRail__State_21640DC(TripleGrindRail *work);
void TripleGrindRail__State_21641E0(TripleGrindRail *work);
void TripleGrindRail__CreateLeafParticle(TripleGrindRailParticle *particle);
void TripleGrindRail__CreateMushroomParticle(TripleGrindRailParticle *particle);
void TripleGrindRail__State_216492C(TripleGrindRail *work);
void TripleGrindRail__State_216497C(TripleGrindRail *work);
void TripleGrindRail__OnDefend_StartTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

void TripleGrindRailEntity__State_Inactive(TripleGrindRailEntity *work);
void TripleGrindRailEntity__State_Active(TripleGrindRailEntity *work);
void TripleGrindRailEntity__Draw(void);
void TripleGrindRailEntity__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

void TripleGrindRailRingLoss__State_Active(TripleGrindRailRingLoss *work);
void TripleGrindRailRingLoss__Draw(void);

#endif // RUSH_TRIPLEGRINDRAIL_H