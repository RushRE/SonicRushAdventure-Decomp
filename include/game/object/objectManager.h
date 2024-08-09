#ifndef RUSH2_OBJECT_MANAGER_H
#define RUSH2_OBJECT_MANAGER_H

#include <game/object/objData.h>
#include <game/graphics/drawReqTask.h>

// --------------------
// ENUMS
// --------------------

enum ObjectManagerFlag_
{
    OBJECTMANAGER_FLAG_NONE = 0,

    OBJECTMANAGER_FLAG_1                    = 1 << 0,
    OBJECTMANAGER_FLAG_2                    = 1 << 1,
    OBJECTMANAGER_FLAG_4                    = 1 << 2,
    OBJECTMANAGER_FLAG_8                    = 1 << 3,
    OBJECTMANAGER_FLAG_USE_BLOCK_COLLISIONS = 1 << 4,
    OBJECTMANAGER_FLAG_20                   = 1 << 5,
    OBJECTMANAGER_FLAG_40                   = 1 << 6,
    OBJECTMANAGER_FLAG_80                   = 1 << 7,
    OBJECTMANAGER_FLAG_100                  = 1 << 8,
    OBJECTMANAGER_FLAG_200                  = 1 << 9,
    OBJECTMANAGER_FLAG_400                  = 1 << 10,
    OBJECTMANAGER_FLAG_800                  = 1 << 11,
    OBJECTMANAGER_FLAG_1000                 = 1 << 12,
    OBJECTMANAGER_FLAG_2000                 = 1 << 13,
    OBJECTMANAGER_FLAG_4000                 = 1 << 14,
    OBJECTMANAGER_FLAG_8000                 = 1 << 15,
    OBJECTMANAGER_FLAG_10000                = 1 << 16,
    OBJECTMANAGER_FLAG_20000                = 1 << 17,
    OBJECTMANAGER_FLAG_40000                = 1 << 18,
    OBJECTMANAGER_FLAG_80000                = 1 << 19,
};
typedef u32 ObjectManagerFlag;

// --------------------
// STRUCTS
// --------------------

struct ObjectManager
{
    VecFx32 scale;
    fx16 offset[2];
    fx32 speed;
    Vec2Fx32 scroll;
    s32 depth;
    fx32 timer;
    fx32 timer_fx;
    ObjectManagerFlag flag;
    Vec2Fx32 camera[2];
    Camera3D *cameraConfig;
    void (*cameraFunc)(fx32 *x, fx32 *y);
    VecFx16 lightDirs[4];
    u16 lightCount;
    u16 spriteMode;
    u8 col_through_dot;
    OBS_DATA_WORK *pData;
    s32 data_max;
};

// --------------------
// VARIABLES
// --------------------

extern struct ObjectManager g_obj;

// --------------------
// FUNCTIONS
// --------------------

void CreateObjectManager(void);

void EnableObjectManagerFlag2(void);
void DisableObjectManagerFlag2(void);
BOOL ObjectPauseCheck(u32 flag);
void AllocObjectFileWork(u32 count);
void *GetObjectFileWork(s32 id);
void ReleaseObjectFileWork(void);
void SetObjOffset(s16 x, s16 y);
void SetObjSpeed(fx32 speed);
fx32 GetObjSpeed(void);
void SetObjCameraPosition(fx32 x1, fx32 y1, fx32 x2, fx32 y2);

#endif // RUSH2_OBJECT_MANAGER_H
