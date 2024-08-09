#ifndef RUSH2_OBJ_COLLISION_H
#define RUSH2_OBJ_COLLISION_H

#include <global.h>
#include <game/object/objData.h>
#include <game/math/mtMath.h>

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

    OBJ_COL_FLAG_USE_PLANE_B  = 1 << 0,
    OBJ_COL_FLAG_2  = 1 << 1,
    OBJ_COL_FLAG_4  = 1 << 2,
    OBJ_COL_FLAG_8  = 1 << 3,
    OBJ_COL_FLAG_10 = 1 << 4,
    OBJ_COL_FLAG_20 = 1 << 5,
    OBJ_COL_FLAG_40 = 1 << 6,
    OBJ_COL_FLAG_80 = 1 << 7,
};
typedef u16 ObjCollisionFlags;

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
    u32 flag;
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

#endif // RUSH2_OBJ_COLLISION_H
