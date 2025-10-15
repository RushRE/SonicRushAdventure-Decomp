#ifndef RUSH_OBJTBLWORK_H
#define RUSH_OBJTBLWORK_H

#include <global.h>
#include <game/math/mtMath.h>
#include <game/object/objData.h>

// --------------------
// ENUMS
// --------------------

enum OBD_TBL_WORK_TYPE_
{
    OBD_TBLWORK_TYPE_SPRITE2D,
    OBD_TBLWORK_TYPE_MOVE,
    OBD_TBLWORK_TYPE_SCALE,
    OBD_TBLWORK_TYPE_ANGLE,

    OBD_TBLWORK_TYPE_COUNT,
};

enum OBD_TBL_WORK_FLAG_
{
    OBD_TBLWORK_FLAG_NONE = 0x00,

    OBD_TBLWORK_FLAG_SPRITE2D_IS_FINISHED = 1 << 0,
    OBD_TBLWORK_FLAG_MOVE_IS_FINISHED     = 1 << 1,
    OBD_TBLWORK_FLAG_SCALE_IS_FINISHED    = 1 << 2,
    OBD_TBLWORK_FLAG_ANGLE_IS_FINISHED    = 1 << 3,
    OBD_TBLWORK_FLAG_MOVE_FLIP_Y          = 1 << 4,
    OBD_TBLWORK_FLAG_MOVE_FLIP_X          = 1 << 5,
    OBD_TBLWORK_FLAG_CAN_LOOP             = 1 << 6,
    OBD_TBLWORK_FLAG_MOVE_PARENT          = 1 << 9,
    OBD_TBLWORK_FLAG_USE_PARENT_FLIP      = 1 << 10,
    OBD_TBLWORK_FLAG_NO_SPRITE2D          = 1 << 24,
    OBD_TBLWORK_FLAG_NO_MOVE              = 1 << 25,
    OBD_TBLWORK_FLAG_NO_SCALE             = 1 << 26,
    OBD_TBLWORK_FLAG_NO_DIR               = 1 << 27,
};
typedef u32 OBD_TBL_WORK_FLAG;

enum OBS_ACT_TBL_FLAG_
{
    OBS_ACT_TBL_FLAG_NONE = 0x00,

    OBS_ACT_TBL_FLAG_IS_LOOP_POINT   = 1 << 0,
    OBS_ACT_TBL_FLAG_DISABLE_LOOPING = 1 << 1,
};
typedef u8 OBS_ACT_TBL_FLAG;

enum OBS_MOVE_TBL_FLAG_
{
    OBS_MOVE_TBL_FLAG_NONE = 0x00,

    OBS_MOVE_TBL_FLAG_IS_LOOP_POINT = 1 << 0,
};
typedef u8 OBS_MOVE_TBL_FLAG;

enum OBS_SCALE_TBL_FLAG_
{
    OBS_SCALE_TBL_FLAG_NONE = 0x00,

    OBS_SCALE_TBL_FLAG_IS_LOOP_POINT = 1 << 0,
};
typedef u8 OBS_SCALE_TBL_FLAG;

enum OBS_ANGLE_TBL_FLAG_
{
    OBS_ANGLE_TBL_FLAG_NONE = 0x00,

    OBS_ANGLE_TBL_FLAG_IS_LOOP_POINT = 1 << 0,
};
typedef u8 OBS_ANGLE_TBL_FLAG;

// --------------------
// STRUCTS
// --------------------

struct StageTask_;

typedef struct OBS_ACT_TBL_
{
    u16 animID;
    u8 timer;
    OBS_ACT_TBL_FLAG flag;
} OBS_ACT_TBL;

typedef struct OBS_MOVE_TBL_
{
    VecFx32 velocity;
    VecFx32 acceleration;
    u8 timer;
    OBS_MOVE_TBL_FLAG flag;
} OBS_MOVE_TBL;

typedef struct OBS_SCALE_TBL_
{
    VecFx32 scale;
    u8 timer;
    OBS_SCALE_TBL_FLAG flag;
} OBS_SCALE_TBL;

typedef struct OBS_DIR_TBL_
{
    VecU16 dir;
    u8 timer;
    OBS_ANGLE_TBL_FLAG flag;
} OBS_DIR_TBL;

typedef struct OBS_TBL_WORK_
{
    s16 frameID[OBD_TBLWORK_TYPE_COUNT];
    s16 frameTimer[OBD_TBLWORK_TYPE_COUNT];
    OBD_TBL_WORK_FLAG flags;
    VecFx32 velocity;
    VecFx32 scale;
    VecU16 angle;
    OBS_ACT_TBL *sprite2DTbl;
    OBS_MOVE_TBL *moveTbl;
    OBS_SCALE_TBL *scaleTbl;
    OBS_DIR_TBL *angleTbl;
    OBS_DATA_WORK *dataWork[OBD_TBLWORK_TYPE_COUNT];
    s16 loopPoint[OBD_TBLWORK_TYPE_COUNT];
} OBS_TBL_WORK;

// --------------------
// FUNCTIONS
// --------------------

void ObjObjectTblWork(struct StageTask_ *work);
void ObjTblWork(struct StageTask_ *work, OBS_TBL_WORK *tblWork);
void InitObjTblWork(OBS_TBL_WORK *work);
void ObjTblWorkReset(OBS_TBL_WORK *work);
void ObjTblWorkMoveSet(OBS_TBL_WORK *work, OBS_MOVE_TBL *moveTbl);

#endif // RUSH_OBJTBLWORK_H
