#ifndef RUSH2_SAILVOYAGEMANAGER_H
#define RUSH2_SAILVOYAGEMANAGER_H

#include <game/system/task.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SailVoyageSegment_
{
    u8 field_0;
    u8 field_1;
    u16 angle;
    u16 field_4;
    u16 blockID;
    u16 header2EntryID;
    u16 field_A;
    s32 field_C;
    s32 field_10;
    s32 field_14;
    s32 field_18;
    s32 field_1C;
    s32 field_20;
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
    void *field_CC[1][2];
    s32 field_D4;
    s32 field_D8;
    s32 field_DC;
    s32 field_E0;
    s32 field_E4;
    s32 field_E8;
    s32 field_EC;
    s32 field_F0;
    u16 field_F4[2];
    s32 field_F8;
    u16 field_FC;
    u16 field_FE;
} SailVoyageManager;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC SailVoyageManager *SailVoyageManager__Create(void);
NONMATCH_FUNC void SailVoyageManager__Destructor(Task *Task);
NONMATCH_FUNC void SailVoyageManager__Func_21574B4(SailVoyageManager *work);
NONMATCH_FUNC void SailVoyageManager__Func_2157628(void);
NONMATCH_FUNC void SailVoyageManager__Func_215776C(void *a1, u32 segmentCount);
NONMATCH_FUNC void SailVoyageManager__Func_2157894(void *a1, u32 segmentCount);
NONMATCH_FUNC void SailVoyageManager__Func_215794C(SailVoyageManager *work);
NONMATCH_FUNC void SailVoyageManager__Func_215799C(SailVoyageManager *work);
NONMATCH_FUNC void SailVoyageManager__SetupVoyage(void);
NONMATCH_FUNC s32 SailVoyageManager__Func_2157AE4(void);
NONMATCH_FUNC VecFx32 *SailVoyageManager__Func_2157AF4(void);
NONMATCH_FUNC s32 SailVoyageManager__Func_2157B04(void);
NONMATCH_FUNC s32 SailVoyageManager__Func_2157B14(void);
NONMATCH_FUNC void SailVoyageManager__Main(void);
NONMATCH_FUNC void SailVoyageManager__Func_2157C34(SailVoyageManager *work);
NONMATCH_FUNC void SailVoyageManager__Func_2158028(SailVoyageManager *work, s32 a2);
NONMATCH_FUNC void SailVoyageManager__Func_2158234(SailVoyageManager *work);
NONMATCH_FUNC void SailVoyageManager__LinkSegments(SailVoyageManager *work);
NONMATCH_FUNC void SailVoyageManager__Func_215868C(s32 *a1, s32 *a2, s32 *a3, s32 *a4, s32 *a5);
NONMATCH_FUNC void SailVoyageManager__Func_2158854(SailVoyageSegment *segment, s32 a2);
NONMATCH_FUNC void SailVoyageManager__Func_2158888(SailVoyageSegment *segment, int a2, fx32 *a3, fx32 *a4);

#endif // !RUSH2_SAILVOYAGEMANAGER_H