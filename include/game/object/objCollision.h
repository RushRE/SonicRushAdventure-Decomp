#ifndef RUSH_OBJ_COLLISION_H
#define RUSH_OBJ_COLLISION_H

#include <global.h>
#include <game/object/objData.h>
#include <game/math/mtMath.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define OBJ_COLLISION_REGISTRATION_MAX (0x20)

// --------------------
// ENUMS
// --------------------

enum ObjCollisionVec_
{
    // Flags
    OBJ_COL_VEC_HORIZONTAL = 0,
    OBJ_COL_VEC_FLIP       = 1 << 0,
    OBJ_COL_VEC_VERTICAL   = 1 << 1,

    // Directions
    OBJ_COL_VEC_LEFT  = OBJ_COL_VEC_HORIZONTAL,
    OBJ_COL_VEC_RIGHT = OBJ_COL_VEC_HORIZONTAL | OBJ_COL_VEC_FLIP,
    OBJ_COL_VEC_UP    = OBJ_COL_VEC_VERTICAL,
    OBJ_COL_VEC_DOWN  = OBJ_COL_VEC_VERTICAL | OBJ_COL_VEC_FLIP,
};
typedef u16 ObjCollisionVec;

enum ObjCollisionFlags_
{
    OBJ_COL_FLAG_NONE = 0,

    OBJ_COL_FLAG_USE_PLANE_B = 1 << 0,
    OBJ_COL_FLAG_2           = 1 << 1,
    OBJ_COL_FLAG_4           = 1 << 2,
    OBJ_COL_FLAG_8           = 1 << 3,
    OBJ_COL_FLAG_10          = 1 << 4,
    OBJ_COL_FLAG_20          = 1 << 5,
    OBJ_COL_FLAG_40          = 1 << 6,
    OBJ_COL_FLAG_80          = 1 << 7,
};
typedef u16 ObjCollisionFlags;

enum StageTaskCollisionObjFlag_
{
    STAGE_TASK_OBJCOLLISION_FLAG_NONE = 0x00,

    STAGE_TASK_OBJCOLLISION_FLAG_1        = 1 << 0,
    STAGE_TASK_OBJCOLLISION_FLAG_2        = 1 << 1,
    STAGE_TASK_OBJCOLLISION_FLAG_4        = 1 << 2,
    STAGE_TASK_OBJCOLLISION_FLAG_8        = 1 << 3,
    STAGE_TASK_OBJCOLLISION_FLAG_10       = 1 << 4,
    STAGE_TASK_OBJCOLLISION_FLAG_20       = 1 << 5,
    STAGE_TASK_OBJCOLLISION_FLAG_40       = 1 << 6,
    STAGE_TASK_OBJCOLLISION_FLAG_80       = 1 << 7,
    STAGE_TASK_OBJCOLLISION_FLAG_100      = 1 << 8,
    STAGE_TASK_OBJCOLLISION_FLAG_200      = 1 << 9,
    STAGE_TASK_OBJCOLLISION_FLAG_400      = 1 << 10,
    STAGE_TASK_OBJCOLLISION_FLAG_800      = 1 << 11,
    STAGE_TASK_OBJCOLLISION_FLAG_1000     = 1 << 12,
    STAGE_TASK_OBJCOLLISION_FLAG_2000     = 1 << 13,
    STAGE_TASK_OBJCOLLISION_FLAG_4000     = 1 << 14,
    STAGE_TASK_OBJCOLLISION_FLAG_8000     = 1 << 15,
    STAGE_TASK_OBJCOLLISION_FLAG_10000    = 1 << 16,
    STAGE_TASK_OBJCOLLISION_FLAG_20000    = 1 << 17,
    STAGE_TASK_OBJCOLLISION_FLAG_40000    = 1 << 18,
    STAGE_TASK_OBJCOLLISION_FLAG_80000    = 1 << 19,
    STAGE_TASK_OBJCOLLISION_FLAG_100000   = 1 << 20,
    STAGE_TASK_OBJCOLLISION_FLAG_200000   = 1 << 21,
    STAGE_TASK_OBJCOLLISION_FLAG_400000   = 1 << 22,
    STAGE_TASK_OBJCOLLISION_FLAG_800000   = 1 << 23,
    STAGE_TASK_OBJCOLLISION_FLAG_1000000  = 1 << 24,
    STAGE_TASK_OBJCOLLISION_FLAG_2000000  = 1 << 25,
    STAGE_TASK_OBJCOLLISION_FLAG_4000000  = 1 << 26,
    STAGE_TASK_OBJCOLLISION_FLAG_8000000  = 1 << 27,
    STAGE_TASK_OBJCOLLISION_FLAG_10000000 = 1 << 28,
    STAGE_TASK_OBJCOLLISION_FLAG_20000000 = 1 << 29,
    STAGE_TASK_OBJCOLLISION_FLAG_40000000 = 1 << 30,
    STAGE_TASK_OBJCOLLISION_FLAG_80000000 = 1 << 31,
};
typedef u32 StageTaskCollisionObjFlag;

// --------------------
// STRUCTS
// --------------------

struct StageTask_;

typedef struct OBS_COL_CHK_DATA_
{
    s32 x;
    s32 y;
    u16 *dir;
    u32 *attr;
    ObjCollisionFlags flag;
    ObjCollisionVec vec;
} OBS_COL_CHK_DATA;

typedef struct StageTaskCollisionObj_
{
    struct StageTask_ *parent;
    struct StageTask_ *riderObj;
    struct StageTask_ *toucherObj;
    VecFx32 pos;
    s16 ofst_x;
    s16 ofst_y;
    StageTaskCollisionObjFlag flag;
    u16 dir;
    u16 attr;
    u8 *diff_data;
    u8 *dir_data;
    u8 *attr_data;
    u16 width;
    u16 height;
    VecFx32 check_pos;
    Vec2Fx16 check_ofst;
    s32 left;
    s32 top;
    s32 right;
    s32 bottom;
    u16 check_dir;
} StageTaskCollisionObj;

typedef struct StageTaskCollisionWork_
{
    StageTaskCollisionObj work;
    OBS_DATA_WORK *diff_data_work;
    OBS_DATA_WORK *dir_data_work;
    OBS_DATA_WORK *attr_data_work;
} StageTaskCollisionWork;

typedef struct OBS_DIFF_COLLISION_
{
    u8 *diffCollision;
    u8 *dirCollision;
    u16 *mapBlockset;
    u16 *mapLayout[2];
    u8 *attrCollision;
    u16 blockWidth;
    u16 blockHeight;
    s32 left;
    s32 top;
    s32 right;
    s32 bottom;
} OBS_DIFF_COLLISION;

// --------------------
// FUNCTIONS
// --------------------

void ObjObjectCollisionDifSet(struct StageTask_ *work, const char *filePath, OBS_DATA_WORK *diffDataWork, NNSiFndArchiveHeader *archive);
void ObjObjectCollisionDirSet(struct StageTask_ *work, const char *filePath, OBS_DATA_WORK *dirDataWork, NNSiFndArchiveHeader *archive);
void ObjObjectCollisionAttrSet(struct StageTask_ *work, const char *filePath, OBS_DATA_WORK *attrDataWork, NNSiFndArchiveHeader *archive);

void objDiffAttrSet(struct StageTask_ *work, u8 attr);
s32 objCollision(OBS_COL_CHK_DATA *colWork);
s32 objCollisionFast(OBS_COL_CHK_DATA *colWork);
s32 ObjCollisionUnion(struct StageTask_ *work, OBS_COL_CHK_DATA *colWork);
s32 ObjCollisionFastUnion(OBS_COL_CHK_DATA *colWork);
void ObjDiffCollisionEarthCheck(struct StageTask_ *work);
void objDiffCollisionDirCheck(struct StageTask_ *work);
ObjCollisionFlags objDiffSufSet(struct StageTask_ *work);
void objDiffCollisionDirWidthCheck(struct StageTask_ *work, u8 ucWall, s32 sSpd);
BOOL objDiffCollisionSimpleOverCheck(struct StageTask_ *work);
void objDiffCollisionDirHeightCheck(struct StageTask_ *work);
void ObjSetDiffCollision(OBS_DIFF_COLLISION *fCol);
s32 ObjDiffCollisionFast(OBS_COL_CHK_DATA *colWork);
s32 ObjDiffCollision(OBS_COL_CHK_DATA *colWork);
u16 objGetMapBlockData(fx32 pos_x, fx32 pos_y, s32 suf);
s32 objGetMapColDataX(fx32 lPosX, fx32 lPosY, ObjCollisionFlags flags, u16 *pDir, u32 *pAttr);
s32 objGetMapColDataY(fx32 lPosX, fx32 lPosY, ObjCollisionFlags flags, u16 *pDir, u32 *pAttr);
void ObjCollisionObjectRegist(StageTaskCollisionObj *work);
void ObjCollisionObjectClear(void);
void objCollsionOffsetSet(StageTaskCollisionObj *work, s16 *offsetX, s16 *offsetY);
s32 ObjCollisionObjectFastCheckDet(fx32 x, fx32 y, ObjCollisionFlags flags, ObjCollisionVec vec, u16 *dir, u32 *attr);
s32 ObjCollisionObjectFastCheck(OBS_COL_CHK_DATA *colWork);
s32 ObjCollisionObjectCheck(struct StageTask_ *work, OBS_COL_CHK_DATA *colWork);
s32 objFastCollisionDiffObject(StageTaskCollisionObj *work, OBS_COL_CHK_DATA *colWork);
s32 objCollisionDiffObject(StageTaskCollisionObj *work, OBS_COL_CHK_DATA *colWork);
s32 objGetColDataX(StageTaskCollisionObj *work, fx32 lPosX, fx32 lPosY, ObjCollisionFlags flags, u16 *pDir, u32 *pAttr);
s32 objGetColDataY(StageTaskCollisionObj *work, fx32 lPosX, fx32 lPosY, ObjCollisionFlags flags, u16 *pDir, u32 *pAttr);

#ifdef __cplusplus
}
#endif

#endif // RUSH_OBJ_COLLISION_H
