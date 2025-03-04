#ifndef RUSH_SAILVOYAGEMANAGER_H
#define RUSH_SAILVOYAGEMANAGER_H

#include <game/system/task.h>
#include <seaMap/seaMapManager.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SailVoyageSegment_
{
    u8 field_0;
    u8 field_1;
    u16 angle;
    s16 field_4;
    u16 blockID;
    u16 header2EntryID;
    s16 field_A;
    Vec2Fx32 field_C;
    Vec2Fx32 field_14;
    Vec2Fx32 field_1C;
    u32 field_24;
} SailVoyageSegment;

typedef struct SailVoyageManager_
{
    VecFx32 field_0;
    VecFx32 field_C;
    s32 field_18;
    s32 field_1C;
    s32 field_20;
    u16 field_24;
    u16 field_26;
    VecFx32 field_28;
    u16 angle;
    u16 field_36;
    u16 field_38;
    u16 field_3A;
    u16 word3C;
    u16 field_3E;
    u16 field_40;
    u16 field_42;
    s32 voyagePos;
    s32 field_48;
    s32 field_4C;
    s32 totalDistance;
    u32 dword54;
    s32 field_58;
    s32 int5C;
    u32 dword60;
    u32 dword64;
    u32 dword68;
    u16 field_6C;
    u16 field_6E;
    s32 field_70;
    s32 field_74;
    s32 field_78;
    s32 field_7C;
    s32 field_80;
    s32 field_84;
    s32 field_88;
    s32 field_8C;
    s32 field_90;
    s32 field_94;
    s32 field_98;
    s32 field_9C;
    s32 field_A0;
    s32 field_A4;
    s32 field_A8;
    s32 field_AC;
    s32 field_B0;
    s32 field_B4;
    u16 segmentCount;
    u16 field_BA;
    s32 field_BC;
    SailVoyageSegment *segmentList;
    s32 field_C4;
    s32 field_C8;
    SeaMapEventManagerUnknown2046B14 field_CC[5];
    u16 field_F4[5];
    u16 field_FE;
} SailVoyageManager;

// --------------------
// FUNCTIONS
// --------------------

SailVoyageManager *SailVoyageManager__Create(void);
void SailVoyageManager__Destructor(Task *task);
void SailVoyageManager__Func_21574B4(SailVoyageManager *work);
void SailVoyageManager__Func_2157628(void);
void SailVoyageManager__Func_215776C(void *a1, u32 segmentCount);
void SailVoyageManager__Func_2157894(void *a1, u32 segmentCount);
s32 SailVoyageManager__Func_215794C(SailVoyageManager *work);
u8 SailVoyageManager__Func_215799C(SailVoyageManager *work);
void SailVoyageManager__SetupVoyage(void);
s32 SailVoyageManager__GetVoyagePos(void);
VecFx32 *SailVoyageManager__GetVoyageUnknownPos(void);
s32 SailVoyageManager__GetVoyageAngle(void);
s32 SailVoyageManager__GetVoyageUnknownValue(SailVoyageSegment *segment);
void SailVoyageManager__Main(void);
void SailVoyageManager__Func_2157C34(SailVoyageManager *work);
void SailVoyageManager__Func_2158028(SailVoyageManager *work, s32 a2);
void SailVoyageManager__Func_2158234(SailVoyageManager *work);
void SailVoyageManager__LinkSegments(SailVoyageManager *work);
void SailVoyageManager__Func_215868C(Vec2Fx32 *a1, Vec2Fx32 *a2, Vec2Fx32 *a3, Vec2Fx32 *a4, Vec2Fx32 *a5);
u16 SailVoyageManager__Func_2158854(SailVoyageSegment *segment, s32 a2);
void SailVoyageManager__Func_2158888(SailVoyageSegment *segment, s32 a2, fx32 *x, fx32 *z);

#endif // !RUSH_SAILVOYAGEMANAGER_H