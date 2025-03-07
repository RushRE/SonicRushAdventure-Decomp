#ifndef RUSH_SAILVOYAGEMANAGER_H
#define RUSH_SAILVOYAGEMANAGER_H

#include <game/system/task.h>
#include <seaMap/seaMapManager.h>
#include <seaMap/seaMapUnknown204AB60.h>

// --------------------
// CONSTANTS
// --------------------

#define SAILVOYAGEMANAGER_SEGMENT_LIST_SIZE 0x100

// --------------------
// ENUMS
// --------------------

enum SailVoyageSegmentType_
{
    SAILVOYAGESEGMENT_TYPE_0,
    SAILVOYAGESEGMENT_TYPE_1,
    SAILVOYAGESEGMENT_TYPE_2,
    SAILVOYAGESEGMENT_TYPE_3,
    SAILVOYAGESEGMENT_TYPE_4,
    SAILVOYAGESEGMENT_TYPE_5,
    SAILVOYAGESEGMENT_TYPE_6,
    SAILVOYAGESEGMENT_TYPE_7,
    SAILVOYAGESEGMENT_TYPE_8,
    SAILVOYAGESEGMENT_TYPE_9,
    SAILVOYAGESEGMENT_TYPE_10,
    SAILVOYAGESEGMENT_TYPE_11,
    SAILVOYAGESEGMENT_TYPE_12,
    SAILVOYAGESEGMENT_TYPE_13,
    SAILVOYAGESEGMENT_TYPE_14,
    SAILVOYAGESEGMENT_TYPE_15,
    SAILVOYAGESEGMENT_TYPE_16,
    SAILVOYAGESEGMENT_TYPE_17,
    SAILVOYAGESEGMENT_TYPE_18,
    SAILVOYAGESEGMENT_TYPE_19,
    SAILVOYAGESEGMENT_TYPE_20,
    SAILVOYAGESEGMENT_TYPE_21,
    SAILVOYAGESEGMENT_TYPE_22,
    SAILVOYAGESEGMENT_TYPE_23,
    SAILVOYAGESEGMENT_TYPE_24,
    SAILVOYAGESEGMENT_TYPE_25,
    SAILVOYAGESEGMENT_TYPE_26,
    SAILVOYAGESEGMENT_TYPE_27,

    SAILVOYAGESEGMENT_TYPE_COUNT,
};
typedef u8 SailVoyageSegmentType;

// --------------------
// STRUCTS
// --------------------

typedef struct SailVoyageSegment_
{
    u8 type;
    u8 unknown;
    u16 angle;
    s16 turn;
    u16 blockID;
    u16 header2EntryID;
    s16 targetSeaAngle;
    Vec2Fx32 position;
    Vec2Fx32 startPos;
    Vec2Fx32 endPos;
    u32 field_24;
} SailVoyageSegment;

typedef struct SailVoyageManager_
{
    VecFx32 position;
    VecFx32 prevPosition;
    VecFx32 voyageStartPos;
    u16 curSegment;
    u16 field_26;
    VecFx32 velocity;
    u16 angle;
    u16 prevAngle;
    u16 angleMove;
    u16 angle2;
    s16 targetSeaAngle;
    u16 prevTargetSeaAngle;
    s16 field_40;
    u16 field_42;
    fx32 voyagePos;
    fx32 prevVoyagePos;
    fx32 segmentPos;
    fx32 totalDistance;
    u32 unknownDistance;
    s32 unknownObjectDistance;
    s32 targetUnknownX;
    u32 targetUnknownZ;
    u32 unknownX;
    u32 unknownZ;
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
void SailVoyageManager__SeaMapObjectUnknownType1(SeaMapUnknown204AB60ObjectLink *work, u32 segmentCount);
void SailVoyageManager__SeaMapObjectUnknownType4(SeaMapUnknown204AB60ObjectLink *work, u32 segmentCount);
u8 SailVoyageManager__SeaMapObjectUnknownType2(SeaMapUnknown204AB60ObjectLink *work);
u8 SailVoyageManager__SeaMapObjectUnknownType3(SeaMapUnknown204AB60ObjectLink *work);
void SailVoyageManager__SetupVoyage(void);
s32 SailVoyageManager__GetVoyagePos(void);
VecFx32 *SailVoyageManager__GetVoyageVelocity(void);
s32 SailVoyageManager__GetVoyageAngle(void);
s32 SailVoyageManager__GetSegmentSize(SailVoyageSegment *segment);
void SailVoyageManager__Main(void);
void SailVoyageManager__Func_2157C34(SailVoyageManager *work);
void SailVoyageManager__LoadSegment(SailVoyageManager *work, u8 type);
void SailVoyageManager__Func_2158234(SailVoyageManager *work);
void SailVoyageManager__InitSegmentList(SailVoyageManager *work);
void SailVoyageManager__Func_215868C(Vec2Fx32 *a1, Vec2Fx32 *a2, Vec2Fx32 *a3, Vec2Fx32 *a4, Vec2Fx32 *a5);
u16 SailVoyageManager__GetAngleForSegmentPos(SailVoyageSegment *segment, s32 segmentPos);
void SailVoyageManager__Func_2158888(SailVoyageSegment *segment, s32 a2, fx32 *x, fx32 *z);

#endif // !RUSH_SAILVOYAGEMANAGER_H