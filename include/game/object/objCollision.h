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

#define TILE_CHAR_NO_MASK 0x03FF
#define TILE_FLIP_X_MASK  0x0400
#define TILE_FLIP_Y_MASK  0x0800

#define TILE_SIZE_X             8
#define TILE_SIZE_Y             8
#define TILE_BLOCK_TILE_COUNT_X 8
#define TILE_BLOCK_TILE_COUNT_Y 8

// --------------------
// ENUMS
// --------------------

enum ObjCollisionVec_
{
    // Flags
    OBD_COL_X = 0,
    OBD_COL_Y = 1 << 1,

    OBD_COL_PLUS  = 0 << 0,
    OBD_COL_MINUS = 1 << 0,

    // Directions
    OBD_COL_RIGHT = OBD_COL_X | OBD_COL_PLUS,
    OBD_COL_LEFT  = OBD_COL_X | OBD_COL_MINUS,
    OBD_COL_DOWN  = OBD_COL_Y | OBD_COL_PLUS,
    OBD_COL_UP    = OBD_COL_Y | OBD_COL_MINUS,
};
typedef u16 ObjCollisionVec;

enum ObjCollisionFlags_
{
    OBJ_COL_FLAG_NONE = 0x00,

    OBJ_COL_FLAG_USE_PLANE_B       = 1 << 0,
    OBJ_COL_FLAG_USE_SIMPLE_CHECKS = 1 << 5,
    OBJ_COL_FLAG_LIMIT_MAP_BOUNDS  = 1 << 6,
    OBJ_COL_FLAG_ALLOW_TOP_SOLID   = 1 << 7,
};
typedef u16 ObjCollisionFlags;

enum ObjCollisionAttr_
{
    OBJ_COL_ATTR_NONE = 0x00,

    OBJ_COL_ATTR_TOP_SOLID  = 1 << 0,
    OBJ_COL_ATTR_CLIFF_EDGE = 1 << 1,
    OBJ_COL_ATTR_GRIND_RAIL = 1 << 2,
};
typedef u16 ObjCollisionAttr;

enum StageTaskCollisionObjFlag_
{
    STAGE_TASK_OBJCOLLISION_FLAG_NONE = 0x00,

    STAGE_TASK_OBJCOLLISION_FLAG_FLIP_X                  = 1 << 0, // User-defined flip flag
    STAGE_TASK_OBJCOLLISION_FLAG_FLIP_Y                  = 1 << 1, // User-defined flip flag
    STAGE_TASK_OBJCOLLISION_FLAG_ROTATE_USING_TILE_ANGLE = 1 << 2,
    STAGE_TASK_OBJCOLLISION_FLAG_FLIP_TILE_ANGLE         = 1 << 3,
    STAGE_TASK_OBJCOLLISION_FLAG_IGNORE_PARENT_POS       = 1 << 4,
    STAGE_TASK_OBJCOLLISION_FLAG_IGNORE_PARENT_ANGLE     = 1 << 5,
    STAGE_TASK_OBJCOLLISION_FLAG_DISABLE_ANGLES          = 1 << 6,
    STAGE_TASK_OBJCOLLISION_FLAG_DISABLE_ATTRIBUTES      = 1 << 7,
    STAGE_TASK_OBJCOLLISION_FLAG_DISABLED                = 1 << 8,

    STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_X = 1 << 30, // System-toggled flip flag (can be enabled via parent display flip or user-defined flip)
    STAGE_TASK_OBJCOLLISION_FLAG_SYS_FLIP_Y = 1 << 31, // System-toggled flip flag (can be enabled via parent display flip or user-defined flip)
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
    ObjCollisionAttr attr;
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

s32 ObjCollisionFastUnion(OBS_COL_CHK_DATA *colWork);
void ObjDiffCollisionEarthCheck(struct StageTask_ *work);
void ObjSetDiffCollision(OBS_DIFF_COLLISION *collisionData);
s32 ObjDiffCollisionFast(OBS_COL_CHK_DATA *colWork);
s32 ObjDiffCollision(OBS_COL_CHK_DATA *colWork);
void ObjCollisionObjectRegist(StageTaskCollisionObj *work);
void ObjCollisionObjectClear(void);
s32 ObjCollisionObjectFastCheckDet(fx32 x, fx32 y, ObjCollisionFlags flags, ObjCollisionVec vec, u16 *dir, u32 *attr);

#ifdef __cplusplus
}
#endif

#endif // RUSH_OBJ_COLLISION_H
