#ifndef RUSH_SAILCOMMONOBJECTS_H
#define RUSH_SAILCOMMONOBJECTS_H

#include <stage/stageTask.h>
#include <game/object/objDraw.h>
#include <sail/sailManager.h>
#include <sail/sailEventManager.h>
#include <sail/sailVoyageManager.h>

// --------------------
// ENUMS
// --------------------

enum SailStageObjTypes_
{
    SAILSTAGE_OBJ_TYPE_PLAYER,
    SAILSTAGE_OBJ_TYPE_OBJECT,
    SAILSTAGE_OBJ_TYPE_EFFECT,
};
typedef u16 SailStageObjTypes;

enum SailObjectFlags_
{
    SAILOBJECT_FLAG_NONE = 0x00,

    SAILOBJECT_FLAG_1        = 1 << 0,
    SAILOBJECT_FLAG_2        = 1 << 1,
    SAILOBJECT_FLAG_4        = 1 << 2,
    SAILOBJECT_FLAG_8        = 1 << 3,
    SAILOBJECT_FLAG_10       = 1 << 4,
    SAILOBJECT_FLAG_20       = 1 << 5,
    SAILOBJECT_FLAG_40       = 1 << 6,
    SAILOBJECT_FLAG_80       = 1 << 7,
    SAILOBJECT_FLAG_100      = 1 << 8,
    SAILOBJECT_FLAG_200      = 1 << 9,
    SAILOBJECT_FLAG_400      = 1 << 10,
    SAILOBJECT_FLAG_800      = 1 << 11,
    SAILOBJECT_FLAG_1000     = 1 << 12,
    SAILOBJECT_FLAG_2000     = 1 << 13,
    SAILOBJECT_FLAG_4000     = 1 << 14,
    SAILOBJECT_FLAG_8000     = 1 << 15,
    SAILOBJECT_FLAG_10000    = 1 << 16,
    SAILOBJECT_FLAG_20000    = 1 << 17,
    SAILOBJECT_FLAG_40000    = 1 << 18,
    SAILOBJECT_FLAG_80000    = 1 << 19,
    SAILOBJECT_FLAG_100000   = 1 << 20,
    SAILOBJECT_FLAG_200000   = 1 << 21,
    SAILOBJECT_FLAG_400000   = 1 << 22,
    SAILOBJECT_FLAG_800000   = 1 << 23,
    SAILOBJECT_FLAG_1000000  = 1 << 24,
    SAILOBJECT_FLAG_2000000  = 1 << 25,
    SAILOBJECT_FLAG_4000000  = 1 << 26,
    SAILOBJECT_FLAG_8000000  = 1 << 27,
    SAILOBJECT_FLAG_10000000 = 1 << 28,
    SAILOBJECT_FLAG_20000000 = 1 << 29,
    SAILOBJECT_FLAG_40000000 = 1 << 30,
    SAILOBJECT_FLAG_80000000 = 1 << 31,
};
typedef u32 SailObjectFlags;

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
    s32 health;
    s32 field_120;
    s32 field_124;
    s32 field_128;
    s16 field_12C;
    u16 blinkTimer;
    u16 field_130;
    u16 field_132;
    s32 field_134;
    VecFx32 field_138;
    VecFx32 field_144;
    s32 field_150;
    s32 field_154;
    StageTask *collidedObj;
    StageTask *player;
    StageTask *targetHUD;
    SailEventManagerObject *objectRef;
    void *healthBar;
    u16 objectID;
    u16 objectAngle;
    VecFx32 objectRadius;
    VecFx32 field_17C;
    Vec2Fx16 lockOnPos;
    PaletteTexture paletteTex;
    u16 lightColor[3];
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
void SailObject__DefaultIn(void);
void SailObject__Func_2164F10(void);
GXRgb SailObject__ApplyFogBrightness(GXRgb color);
void SailObject__Func_21650B4(StageTask *work, s32 a2);
void SailObject__DefaultLast(void);
void SailObject__Func_216524C(StageTask *work, void *unknown);
BOOL SailObject__DefaultOnCheck(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
BOOL SailObject__CheckCollisions(SailColliderWorkHitCheck *collider1, SailColliderWorkHitCheck *collider2, fx32 a3);
BOOL SailObject__Func_2165624(SailColliderWorkHitCheck *collider1, SailColliderWorkHitCheck *collider2, fx32 a3);
void SailObject__SetupHitbox(StageTask *work, SailColliderWork *sailCollider, s32 id);
void SailObject__Func_21658A4(StageTask *work, s32 id);
void SailObject__Func_21658D0(StageTask *work, s32 id, s32 a3, VecFx32 *a4);
void SailObject__Func_2165960(StageTask *work, s32 id, s32 a3, VecFx32 *a4, VecFx32 *a5, VecFx32 *a6);
void SailObject__ShakeScreen(StageTask *work, s32 timer);
void SailObject__Func_2165A9C(StageTask *work, VecFx32 *position);
void SailObject__Func_2165AF4(StageTask *work, VecFx32 *position);

StageTask *SailLanding__Create(SailEventManagerObject *mapObject);

StageTask *SailJetMine__Create(SailEventManagerObject *mapObject);

StageTask *SailJetBomber__Create(SailEventManagerObject *mapObject);

void SailJetBoatCloud__CreateUnknown(void);
StageTask *SailJetBoatCloud__Create(SailEventManagerObject *mapObject);

StageTask *SailCloud__Create(s32 type);

void SailObject__Func_2166728(StageTask *work);
void SailObject__Func_21667BC(StageTask *work);
void SailObject__Func_2166834(StageTask *work);
void SailObject__Func_216688C(StageTask *work, VecFx32 *a2, VecFx32 *a3);
void SailObject__Func_216690C(StageTask *work);
void SailObject__Func_2166A2C(StageTask *work);
void SailObject__Func_2166C04(StageTask *work);
void SailObject__Func_2166D18(StageTask *work);
void SailObject__Func_2166D50(StageTask *work);
void SailObject__Func_2166D88(void);

StageTask *SailBuoy__Create(StageTask *work);
StageTask *SailBuoy__CreateFromSegment(SailVoyageSegment *voyageSegment);
StageTask *SailBuoy__CreateFromSegment2(SailVoyageSegment *voyageSegment);

StageTask *SailSeagull__Create(SailEventManagerObject *mapObject);
StageTask *SailSeagull2__Create(SailEventManagerObject *mapObject);
StageTask *SailSeagull3__Create(StageTask *parent);
StageTask *SailSeagull__CreateFromSegment(SailVoyageSegment *voyageSegment);
StageTask *SailSeagull__CreateUnknown2(StageTask *work);

StageTask *SailStone__Create(SailEventManagerObject *mapObject);
StageTask *SailStone__CreateFromSegment(SailVoyageSegment *voyageSegment, s32 a2);

StageTask *SailIce__Create(SailEventManagerObject *mapObject);
StageTask *SailIce__CreateFromSegment(SailVoyageSegment *voyageSegment, s32 a2);

StageTask *SailSubFish__Create(SailEventManagerObject *mapObject);
StageTask *SailSubFish2__Create(StageTask *work);
void SailSubFish__CreateUnknown1(SailVoyageSegment *voyageSegment);
void SailSubFish__CreateUnknown2(StageTask *parent);

StageTask *SailChaosEmerald__Create(fx32 z);
StageTask *SailGoal__Create(fx32 radius);
StageTask *SailGoalText__Create(u32 a1);

StageTask *SailJetItem__Create(SailEventManagerObject *mapObject);
StageTask *SailItem3__Create(StageTask *parent);
StageTask *SailItemBonus__Create(StageTask *parent, u32 type);

void SailObject__Destructor(Task *task);
BOOL SailObject__ViewCheck(StageTask *work);
void SailObject__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void SailObject__GivePlayerScore(StageTask *work);
void SailObject__OnPlayerCollide(StageTask *work);

void SailLanding__State_216A46C(StageTask *work);
void SailLanding__Draw_216A4E8(void);
void SailLanding__Draw_216A6A4(void);

void SailMine__State_216A4E8(StageTask *work);

void SailJetBomber__Action_Init(StageTask *work);
void SailJetBomber__State_216AA38(StageTask *work);

void SailJetBoatCloud__State_216AA38(StageTask *work);
void SailCloud__State_216AF60(StageTask *work);

void SailObject__Action_Destroy(StageTask *work);
void SailObject__Action_ExplodeSimple(StageTask *work);
void SailObject__State_ExplodeSimple(StageTask *work);
void SailObject__Action_Explode(StageTask *work);
void SailObject__CreateRingsForExplode1(StageTask *work);
void SailObject__CreateRingsForExplode2(StageTask *work);
void SailObject__State_Explode(StageTask *work);

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

void SailItemBonus__GiveItem(StageTask *work, StageTask *object);
void SailItemBonus__State_216CBF8(StageTask *work);

#endif // !RUSH_SAILCOMMONOBJECTS_H