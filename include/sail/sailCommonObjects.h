#ifndef RUSH_SAILCOMMONOBJECTS_H
#define RUSH_SAILCOMMONOBJECTS_H

#include <stage/stageTask.h>
#include <sail/sailManager.h>
#include <sail/sailEventManager.h>
#include <sail/sailVoyageManager.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SailObject_
{
    u16 field_0;
    s16 field_2;
    VecFx32 field_4;
    VecFx32 field_10;
    VecFx32 field_1C;
    SailColliderWork collider[2];
    u32 dword118;
    s32 field_11C;
    s32 field_120;
    s32 field_124;
    s32 field_128;
    s16 field_12C;
    s16 field_12E;
    s32 field_130;
    s32 field_134;
    s32 field_138;
    s32 field_13C;
    s32 field_140;
    s32 field_144;
    s32 field_148;
    s32 field_14C;
    s32 field_150;
    s32 field_154;
    s32 field_158;
    StageTask *player;
    StageTask *targetHUD;
    SailEventManagerObject *objectRef;
    s32 field_168;
    u16 objectID;
    s16 objectAngle;
    VecFx32 objectRadius;
    VecFx32 field_17C;
    Vec2Fx16 lockOnPos;
    s32 field_18C;
    s32 field_190;
    s32 field_194;
    s32 field_198;
    s32 field_19C;
} SailObject;

// --------------------
// FUNCTIONS
// --------------------

void SailObject__Func_21646DC(StageTask *work);
void SailObject__InitFromMapObject(StageTask *work, SailEventManagerObject *mapObject);
void SailObject__SetAnimSpeed(StageTask *work, fx32 speed);
void SailObject__Func_2164B38(StageTask *work);
void SailObject__SetupAnimator3D(StageTask *work);
void SailObject__Func_2164D10(StageTask *work, GXRgb color);
void SailObject__DefaultIn(StageTask *work);
void SailObject__Func_2164F10(StageTask *work);
void SailObject__Func_2165038(StageTask *work);
void SailObject__Func_21650B4(StageTask *work);
void SailObject__DefaultLast(StageTask *work);
void SailObject__Func_216524C(StageTask *work, void *unknown);
void SailObject__DefaultOnCheck(StageTask *work);
void SailObject__CheckCollisions(StageTask *work);
void SailObject__Func_2165624(StageTask *work);
void SailObject__SetupHitbox(StageTask *work, SailColliderWork *userData, s32 id);
void SailObject__Func_21658A4(StageTask *work);
void SailObject__Func_21658D0(StageTask *work, s32 id, s32 a3, VecFx32 *a4);
void SailObject__Func_2165960(StageTask *work);
void SailObject__ShakeScreen(StageTask *work, s32 timer);
void SailObject__Func_2165A9C(StageTask *work, VecFx32 *positon);
void SailObject__Func_2165AF4(StageTask *work);

StageTask *SailLanding__Create(SailEventManagerObject *mapObject);

StageTask *SailJetMine__Create(StageTask *work);

StageTask *SailJetBomber__Create(StageTask *work);

void SailJetBoatCloud__CreateUnknown(void);
StageTask *SailJetBoatCloud__Create(StageTask *work);

StageTask *SailCloud__Create(s32 type);

void SailObject__Func_2166728(StageTask *work);
void SailObject__Func_21667BC(StageTask *work);
void SailObject__Func_2166834(StageTask *work);
void SailObject__Func_216688C(StageTask *work);
void SailObject__Func_216690C(StageTask *work);
void SailObject__Func_2166A2C(StageTask *work);
void SailObject__Func_2166C04(StageTask *work);
void SailObject__Func_2166D18(StageTask *work);
void SailObject__Func_2166D50(StageTask *work);
void SailObject__Func_2166D88(void);

StageTask *SailBuoy__Create(StageTask *work);
StageTask *SailBuoy__CreateFromSegment(SailVoyageSegment *voyageSegment);
StageTask *SailBuoy__CreateFromSegment2(SailVoyageSegment *voyageSegment);

StageTask *SailSeagull__Create(StageTask *work);
StageTask *SailSeagull2__Create(StageTask *work);
StageTask *SailSeagull3__Create(StageTask *work);
StageTask *SailSeagull__CreateFromSegment(SailVoyageSegment *voyageSegment);
StageTask *SailSeagull__CreateUnknown2(StageTask *work);

StageTask *SailStone__Create(StageTask *work);
StageTask *SailStone__CreateFromSegment(SailVoyageSegment *voyageSegment, s32 a2);

StageTask *SailIce__Create(StageTask *work);
StageTask *SailIce__CreateFromSegment(SailVoyageSegment *voyageSegment, s32 a2);

StageTask *SailSubFish__Create(StageTask *work);
StageTask *SailSubFish2__Create(StageTask *work);
StageTask *SailSubFish__CreateUnknown1(SailVoyageSegment *voyageSegment);
StageTask *SailSubFish__CreateUnknown2(StageTask *work);

StageTask *SailChaosEmerald__Create(fx32 z);
StageTask *SailGoal__Create(fx32 radius);
StageTask *SailGoalText__Create(u32 a1);

StageTask *SailJetItem__Create(SailEventManagerObject *mapObject);
StageTask *SailItem3__Create(StageTask *parent);
StageTask *SailItemBonus__Create(StageTask *parent, u16 type);

void SailObject__Destructor_2169B20(Task *task);
void SailObject__ViewCheck_2169B60(StageTask *work);
void SailObject__OnDefend_2169BAC(StageTask *work);
void SailObject__Func_216A168(StageTask *work);
void SailObject__Func_216A1C4(StageTask *work);
void SailObject__Func_216A46C(StageTask *work);
void SailObject__Func_216A4E8(StageTask *work);
void SailObject__Func_216A6A4(StageTask *work);
void SailObject__Func_216A9A4(StageTask *work);
void SailObject__Func_216A9F0(StageTask *work);
void SailObject__State_216AA38(StageTask *work);
void SailObject__Func_216ABF0(StageTask *work);
void SailObject__State_216AF60(StageTask *work);
void SailObject__Func_216B178(StageTask *work);
void SailObject__Func_216B1A4(StageTask *work);
void SailObject__Func_216B284(StageTask *work);
void SailObject__Func_216B408(StageTask *work);
void SailObject__Func_216B4B8(StageTask *work);
void SailObject__Func_216B644(StageTask *work);
void SailObject__Func_216B7A4(StageTask *work);

void SailBuoy__SetupObject(StageTask *work);
void SailBuoy__State_216BAC0(StageTask *work);

void SailSeagull__SetupObject(StageTask *work);
void SailSeagull__State_216BD1C(StageTask *work);

void SailSeagull2__SetupObject(StageTask *work);
void SailSeagull2__State_216BF04(StageTask *work);

void SailSeagull3__State_216BF2C(StageTask *work);
void SailSeagull3__State_216C03C(StageTask *work);

void SailSubFish__SetupObject(StageTask *work);
void SailSubFish__State_216C1E8(StageTask *work);

void SailSubFish2__SetupObject(StageTask *work);
void SailSubFish2__State_216C458(StageTask *work);

void SailChaosEmerald__SetupObject(StageTask *work);
void SailChaosEmerald__State_216C5B0(StageTask *work);
void SailChaosEmerald__Func_216C650(StageTask *work);
void SailChaosEmerald__State_216C69C(StageTask *work);

void SailGoal__SetupObject(StageTask *work);
void SailGoal__State_216C7E0(StageTask *work);

void SailGoalText__SetupObject(StageTask *work);
void SailGoalText__State_216C8F8(StageTask *work);

void SailItemBonus__GiveItem(StageTask *work);
void SailItemBonus__State_216CBF8(StageTask *work);

#endif // !RUSH_SAILCOMMONOBJECTS_H