#ifndef RUSH_OBJ_RECT_H
#define RUSH_OBJ_RECT_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

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

#define OBS_RECT_DEFPOWER_VULNERABLE (0x00)
#define OBS_RECT_HITPOWER_VULNERABLE (0x00)

#define OBS_RECT_DEFPOWER_DEFAULT (0x3F)
#define OBS_RECT_HITPOWER_DEFAULT (0x40)

#define OBS_RECT_DEFPOWER_INVINCIBLE (0xFF)
#define OBS_RECT_HITPOWER_INVINCIBLE (0xFF)

#define OBS_RECT_ATTR_NO_ATK(attr) (0x0000 ^ (attr))
#define OBS_RECT_ATTR_NO_HIT(attr) (0xFFFF ^ (attr))

// --------------------
// MACROS
// --------------------

#define ObjRect__SetOnAttack(work, func)    (work)->onAttack = (func)
#define ObjRect__SetOnDefend(work, func)    (work)->onDefend = (func)
#define ObjRect__SetCheckActive(work, func) (work)->checkActive = (func)

#define ObjRect__SetGroupFlags(work, groupNum, targetGflag) (work)->groupFlags = ((groupNum) & 0xFF) | ((targetGflag) << 8)

// --------------------
// ENUMS
// --------------------

enum OBS_RECT_WORKFlags_
{
    OBS_RECT_WORK_FLAG_FLIP_X                    = 1 << 0,
    OBS_RECT_WORK_FLAG_FLIP_Y                    = 1 << 1,
    OBS_RECT_WORK_FLAG_ENABLED                   = 1 << 2,
    OBS_RECT_WORK_FLAG_NO_ONATTACK               = 1 << 3,
    OBS_RECT_WORK_FLAG_IGNORE_ATK_DEF_VALUES     = 1 << 4,
    OBS_RECT_WORK_FLAG_ALLOW_MULTI_ATK_PER_FRAME = 1 << 5,
    OBS_RECT_WORK_FLAG_DISABLE_ATK_RESPONSE      = 1 << 6,
    OBS_RECT_WORK_FLAG_DISABLE_DEF_RESPONSE      = 1 << 7,
    OBS_RECT_WORK_FLAG_SYS_WILL_DEF_THIS_FRAME   = 1 << 8,
    OBS_RECT_WORK_FLAG_SYS_HAD_DEF_THIS_FRAME    = 1 << 9,
    OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR      = 1 << 10,
    OBS_RECT_WORK_FLAG_NO_HIT_CHECKS             = 1 << 11,
    OBS_RECT_WORK_FLAG_NO_PARENT_OFFSET          = 1 << 12,
    OBS_RECT_WORK_FLAG_SYS_WILL_ATK_THIS_FRAME   = 1 << 16,
    OBS_RECT_WORK_FLAG_SYS_HAD_ATK_THIS_FRAME    = 1 << 17,
    OBS_RECT_WORK_FLAG_NO_ONATTACK_ONENTER       = 1 << 18,
    OBS_RECT_WORK_FLAG_CHECK_FUNC                = 1 << 19,
};
typedef u32 OBS_RECT_WORKFlags;

enum OBS_RECT_WORKAttribute_
{
    OBS_RECT_WORK_ATTR_NONE = 0x00,

    OBS_RECT_WORK_ATTR_BODY    = 1 << 0,
    OBS_RECT_WORK_ATTR_NORMAL  = 1 << 1,
    OBS_RECT_WORK_ATTR_USER_1  = 1 << 2,
    OBS_RECT_WORK_ATTR_USER_2  = 1 << 3,
    OBS_RECT_WORK_ATTR_USER_3  = 1 << 4,
    OBS_RECT_WORK_ATTR_USER_4  = 1 << 5,
    OBS_RECT_WORK_ATTR_USER_5  = 1 << 6,
    OBS_RECT_WORK_ATTR_USER_6  = 1 << 7,
    OBS_RECT_WORK_ATTR_USER_7  = 1 << 8,
    OBS_RECT_WORK_ATTR_USER_8  = 1 << 9,
    OBS_RECT_WORK_ATTR_USER_9  = 1 << 10,
    OBS_RECT_WORK_ATTR_USER_10 = 1 << 11,
    OBS_RECT_WORK_ATTR_USER_11 = 1 << 12,
    OBS_RECT_WORK_ATTR_USER_12 = 1 << 13,
    OBS_RECT_WORK_ATTR_USER_13 = 1 << 14,
    OBS_RECT_WORK_ATTR_USER_14 = 1 << 15,
};
typedef u16 OBS_RECT_WORKAttribute;

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
    OBS_RECT_WORKAttribute hitFlag;
    OBS_RECT_WORKAttribute defFlag;
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
void ObjRect__SetAttackStat(OBS_RECT_WORK *work, OBS_RECT_WORKAttribute attribute, u16 power);
void ObjRect__SetDefenceStat(OBS_RECT_WORK *work, OBS_RECT_WORKAttribute attribute, u16 power);
void ObjRect__HitAgain(OBS_RECT_WORK *work);
void ObjRect__CheckInit(void);
void ObjRect__CheckOut(void);
void ObjRect__Register(OBS_RECT_WORK *work);
void ObjRect__CheckAllGroup(void);
OBS_RECT_WORK *ObjRect__RegistGet(u8 groupMask, s16 groupIdx);
OBS_RECT_WORK *ObjRect__RegistGetNext(u8 groupMask, s16 groupIdx);
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

#ifdef __cplusplus
}
#endif

#endif // RUSH_OBJ_RECT_H
