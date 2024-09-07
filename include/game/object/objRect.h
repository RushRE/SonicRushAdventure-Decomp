#ifndef RUSH2_OBJ_RECT_H
#define RUSH2_OBJ_RECT_H

#include <global.h>

// --------------------
// FORWARD DECLS
// --------------------

typedef struct StageTask_ StageTask;
typedef struct OBS_RECT_ OBS_RECT;
typedef struct OBS_RECT_WORK_ OBS_RECT_WORK;

typedef void (*OBS_RECT_ON_HIT)(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
typedef void (*OBS_RECT_ON_DEF)(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
typedef BOOL (*OBS_RECT_ON_CHECK)(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// CONSTANTS
// --------------------

#define OBS_RECT_GROUP_COUNT  8
#define OBS_RECT_REGISTER_MAX 0x50

// --------------------
// MACROS
// --------------------

#define ObjRect__SetOnAttack(work, func)    (work)->onAttack = (func)
#define ObjRect__SetOnDefend(work, func)    (work)->onDefend = (func)
#define ObjRect__SetCheckActive(work, func) (work)->checkActive = (func)

#define ObjRect__SetGroupFlags(work, groupNum, targetGflag) (work)->groupFlags = ((groupNum)&0xFF) | ((targetGflag) << 8)

// --------------------
// ENUMS
// --------------------

enum OBS_RECT_WORKFlags_
{
    OBS_RECT_WORK_FLAG_FLIP_X    = 0x1,
    OBS_RECT_WORK_FLAG_FLIP_Y    = 0x2,
    OBS_RECT_WORK_FLAG_IS_ACTIVE = 0x4,
    OBS_RECT_WORK_FLAG_8         = 0x8,
    OBS_RECT_WORK_FLAG_10        = 0x10,
    OBS_RECT_WORK_FLAG_20        = 0x20,
    OBS_RECT_WORK_FLAG_40        = 0x40,
    OBS_RECT_WORK_FLAG_80        = 0x80,
    OBS_RECT_WORK_FLAG_100       = 0x100,
    OBS_RECT_WORK_FLAG_200       = 0x200,
    OBS_RECT_WORK_FLAG_400       = 0x400,
    OBS_RECT_WORK_FLAG_800       = 0x800,
    OBS_RECT_WORK_FLAG_NO_PARENT_OFFSET      = 0x1000,
    OBS_RECT_WORK_FLAG_2000      = 0x2000,
    OBS_RECT_WORK_FLAG_4000      = 0x4000,
    OBS_RECT_WORK_FLAG_8000      = 0x8000,
    OBS_RECT_WORK_FLAG_10000     = 0x10000,
    OBS_RECT_WORK_FLAG_20000     = 0x20000,
    OBS_RECT_WORK_FLAG_40000     = 0x40000,
    OBS_RECT_WORK_FLAG_80000     = 0x80000,
};
typedef u32 OBS_RECT_WORKFlags;

// --------------------
// STRUCTS
// --------------------

struct OBS_RECT_
{
    s16 left;
    s16 top;
    s16 back;
    s16 right;
    s16 bottom;
    s16 front;
    VecFx32 pos;
};

struct OBS_RECT_WORK_
{
    OBS_RECT rect;
    OBS_RECT_WORKFlags flag;
    StageTask *parent;
    OBS_RECT_ON_HIT onAttack;
    OBS_RECT_ON_DEF onDefend;
    OBS_RECT_ON_CHECK checkActive;
    s16 hitPower;
    s16 defPower;
    u16 hitFlag;
    u16 defFlag;
    u16 groupFlags;
    s32 attrData;
    void *userData;
};

// --------------------
// FUNCTIONS
// --------------------

void ObjRect__SetBox2D(OBS_RECT *rect, s16 left, s16 top, s16 right, s16 bottom);
void ObjRect__SetBox3D(OBS_RECT *rect, s16 left, s16 top, s16 back, s16 right, s16 bottom, s16 front);
void ObjRect__SetBox(OBS_RECT_WORK *work, s16 left, s16 top, s16 right, s16 bottom);
void ObjRect__SetAttackStat(OBS_RECT_WORK *work, u16 atkFlag, u16 atkPower);
void ObjRect__SetDefenceStat(OBS_RECT_WORK *work, u16 defFlag, u16 defPower);
void ObjRect__HitAgain(OBS_RECT_WORK *work);
void ObjRect__CheckInit(void);
void ObjRect__CheckOut(void);
void ObjRect__Register(OBS_RECT_WORK *work);
void ObjRect__CheckAllGroup(void);
OBS_RECT_WORK *ObjRect__RegistGet(u8 group, s16 groupIdx);
OBS_RECT_WORK *ObjRect__RegistGetNext(u8 group, s16 groupIdx);
void ObjRect__CheckGroup(OBS_RECT_WORK **atkGroup, OBS_RECT_WORK **defGroup, s32 groupNumAtk, s32 groupNumDef, u8 index);
void ObjRect__LTBSet(OBS_RECT_WORK *work, fx32 *left, fx32 *top, fx32 *back);
void ObjRect__WHDSet(OBS_RECT_WORK *work, u16 *width, u16 *height, u16 *depth);
BOOL ObjRect__FlagCheck(u16 ulAtkFlag, u16 usDefFlag, s16 lAtkPower, s16 lDefPower);
u16 ObjRect__CheckFuncCall(OBS_RECT_WORK *attacker, OBS_RECT_WORK *defender);
void ObjRect__FuncNoHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
BOOL ObjRect__RectCheck(OBS_RECT *rect1, OBS_RECT *rect2);
BOOL ObjRect__PointCheck(OBS_RECT_WORK *work, s32 x, s32 y, s32 z);
BOOL ObjRect__RectPointCheck(OBS_RECT_WORK *work, s32 x, s32 y, s32 z);
s32 ObjRect__CenterX(OBS_RECT_WORK *work);
s32 ObjRect__CenterY(OBS_RECT_WORK *work);
fx32 ObjRect__HitCenterX(OBS_RECT_WORK *work, OBS_RECT_WORK *attacker);
fx32 ObjRect__HitCenterY(OBS_RECT_WORK *work, OBS_RECT_WORK *attacker);

#endif // RUSH2_OBJ_RECT_H
