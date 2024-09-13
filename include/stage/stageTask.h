#ifndef RUSH2_STAGE_TASK_H
#define RUSH2_STAGE_TASK_H

#include <global.h>
#include <game/system/task.h>
#include <game/math/mtMath.h>
#include <game/object/objAction.h>
#include <game/object/objRect.h>
#include <game/object/objData.h>
#include <game/object/objDraw.h>
#include <game/object/objBlock.h>
#include <game/object/objCollision.h>
#include <game/stage/mapSys.h>

// --------------------
// TYPES
// --------------------

typedef void (*StageTaskState)(StageTask *work);
typedef void (*StageTaskInFunc)(void);
typedef void (*StageTaskOutFunc)(void);
typedef void (*StageTaskMoveFunc)(StageTask *work);
typedef void (*StageTaskCollideFunc)(void);
typedef void (*StageTaskLastFunc)(void);
typedef BOOL (*StageTaskViewCheckFunc)(StageTask *work);

typedef struct GameObjectTask_ GameObjectTask;

// --------------------
// CONSTANTS
// --------------------

#define STAGETASK_COLLIDER_COUNT 6

// --------------------
// MACROS
// --------------------

#define SetTaskState(work, func)          (work)->state = (StageTaskState)(func)
#define SetTaskInFunc(work, func)         (work)->ppIn = (func)
#define SetTaskOutFunc(work, func)        (work)->ppOut = (func)
#define SetTaskMoveFunc(work, func)       (work)->ppMove = (StageTaskMoveFunc)(func)
#define SetTaskSpriteCallback(work, func) (work)->ppSpriteCallback = (SpriteFrameCallback)(func)
#define SetTaskCollideFunc(work, func)    (work)->ppCollide = (func)
#define SetTaskLastFunc(work, func)       (work)->ppLast = (func)
#define SetTaskViewCheckFunc(work, func)  (work)->ppViewCheck = (func)

#define DestroyStageTask(work)     (work)->flag |= STAGE_TASK_FLAG_DESTROYED
#define IsStageTaskDestroyed(work) ((work)->flag & STAGE_TASK_FLAG_DESTROYED) != 0

#define StageTaskStateMatches(work, func) ((work)->state == (StageTaskState)(func))

#define GetStageTaskWorker(work, type) ((type *)(work)->taskWorker)

// --------------------
// ENUMS
// --------------------

enum StageTaskFlags_
{
    STAGE_TASK_FLAG_NONE = 0x00,

    STAGE_TASK_FLAG_ON_PLANE_B               = 0x1, // use alternate collision plane (for loops and etc)
    STAGE_TASK_FLAG_NO_OBJ_COLLISION         = 0x2,
    STAGE_TASK_FLAG_DESTROYED                = 0x4,
    STAGE_TASK_FLAG_DESTROY_NEXT_FRAME       = 0x8,
    STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT  = 0x10,
    STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE      = 0x20,
    STAGE_TASK_FLAG_ALWAYS_RUN_PPIN          = 0x40,
    STAGE_TASK_FLAG_DISABLE_STATE            = 0x80,
    STAGE_TASK_FLAG_DISABLE_OBJ_2D_RELEASE   = 0x100,
    STAGE_TASK_FLAG_NO_DESTROY_WITH_PARENT                      = 0x200,
    STAGE_TASK_FLAG_IS_CHILD_OBJ                      = 0x400,
    STAGE_TASK_FLAG_USE_PARENT_SPRITES                      = 0x800,
    STAGE_TASK_FLAG_ALLOCATED_SCREEN_UNKNOWN = 0x1000,
    STAGE_TASK_FLAG_DISABLE_HITSTOP          = 0x2000,
    STAGE_TASK_FLAG_DISABLE_SHAKE            = 0x4000,
    STAGE_TASK_FLAG_ALLOCATED_SPRITE_PALETTE = 0x8000,
    STAGE_TASK_FLAG_10000                    = 0x10000,
    STAGE_TASK_FLAG_20000                    = 0x20000,
    STAGE_TASK_FLAG_40000                    = 0x40000,
    STAGE_TASK_FLAG_80000                    = 0x80000,
    STAGE_TASK_FLAG_100000                   = 0x100000,
    STAGE_TASK_FLAG_200000                   = 0x200000,
    STAGE_TASK_FLAG_400000                   = 0x400000,
    STAGE_TASK_FLAG_800000                   = 0x800000,
    STAGE_TASK_FLAG_ALLOCATED_EX_WORK        = 0x1000000,
    STAGE_TASK_FLAG_ALLOCATED_TASK_WORKER    = 0x2000000,
    STAGE_TASK_FLAG_ALLOCATED_COLLISION_OBJ  = 0x4000000,
    STAGE_TASK_FLAG_ALLOCATED_COLLIDERS      = 0x8000000,
    STAGE_TASK_FLAG_ALLOCATED_OBJ_2D         = 0x10000000,
    STAGE_TASK_FLAG_ALLOCATED_OBJ_3D         = 0x20000000,
    STAGE_TASK_FLAG_ALLOCATED_OBJ_3DES       = 0x40000000,
    STAGE_TASK_FLAG_ALLOCATED_OBJ_2DIN3D     = 0x80000000,
};
typedef u32 StageTaskFlags;

enum StageTaskMoveFlags_
{
    STAGE_TASK_MOVE_FLAG_NONE = 0x00,

    STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR                  = 0x1, // object is colliding with the floor
    STAGE_TASK_MOVE_FLAG_TOUCHING_CEILING                = 0x2, // object is colliding with the ceiling
    STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL                  = 0x4, // object is colliding with the wall to its left
    STAGE_TASK_MOVE_FLAG_TOUCHING_RWALL                  = 0x8, // object is colliding with the wall to its right
    STAGE_TASK_MOVE_FLAG_IN_AIR                          = 0x10,
    STAGE_TASK_MOVE_FLAG_20                              = 0x20,
    STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES                = 0x40,
    STAGE_TASK_MOVE_FLAG_HAS_GRAVITY                     = 0x80,
    STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT           = 0x100,
    STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS          = 0x200,
    STAGE_TASK_MOVE_FLAG_DISABLE_X_COLLISION_CHECK       = 0x400,
    STAGE_TASK_MOVE_FLAG_DISABLE_Y_COLLISION_CHECK       = 0x800,
    STAGE_TASK_MOVE_FLAG_DISABLE_MAP_COLLISIONS          = 0x1000,
    STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT              = 0x2000,
    STAGE_TASK_MOVE_FLAG_4000                            = 0x4000,
    STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES            = 0x8000,
    STAGE_TASK_MOVE_FLAG_10000                           = 0x10000,
    STAGE_TASK_MOVE_FLAG_USE_SLOPE_ACCELERATION          = 0x20000,
    STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_IDLE_ACCELERATION = 0x40000,
    STAGE_TASK_MOVE_FLAG_80000                           = 0x80000,
    STAGE_TASK_MOVE_FLAG_100000                          = 0x100000,
    STAGE_TASK_MOVE_FLAG_200000                          = 0x200000,
    STAGE_TASK_MOVE_FLAG_400000                          = 0x400000,
    STAGE_TASK_MOVE_FLAG_800000                          = 0x800000,
    STAGE_TASK_MOVE_FLAG_1000000                         = 0x1000000,
    STAGE_TASK_MOVE_FLAG_2000000                         = 0x2000000,
    STAGE_TASK_MOVE_FLAG_4000000                         = 0x4000000,
    STAGE_TASK_MOVE_FLAG_DISABLE_OBJECT_SCROLL           = 0x8000000,
    STAGE_TASK_MOVE_FLAG_RESET_FLOW                      = 0x10000000,
    STAGE_TASK_MOVE_FLAG_20000000                        = 0x20000000,
    STAGE_TASK_MOVE_FLAG_40000000                        = 0x40000000,
    STAGE_TASK_MOVE_FLAG_80000000                        = 0x80000000,

    // Helpers
    STAGE_TASK_MOVE_FLAG_TOUCHING_V   = STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR | STAGE_TASK_MOVE_FLAG_TOUCHING_CEILING, // object is colliding with a surface vertically
    STAGE_TASK_MOVE_FLAG_TOUCHING_H   = STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL | STAGE_TASK_MOVE_FLAG_TOUCHING_RWALL,   // object is colliding with a surface horizontally
    STAGE_TASK_MOVE_FLAG_TOUCHING_ANY = STAGE_TASK_MOVE_FLAG_TOUCHING_V | STAGE_TASK_MOVE_FLAG_TOUCHING_H,           // object is colliding with any surface
};
typedef u32 StageTaskMoveFlags;

enum StageCollisionFlags_
{
    STAGE_TASK_COLLISION_FLAG_NONE = 0x00,

    STAGE_TASK_COLLISION_FLAG_1          = 1 << 0,
    STAGE_TASK_COLLISION_FLAG_2          = 1 << 1,
    STAGE_TASK_COLLISION_FLAG_GRIND_RAIL = 1 << 2,
};
typedef u32 StageCollisionFlags;

enum StageDisplayFlags_
{
    DISPLAY_FLAG_NONE = 0x00,

    DISPLAY_FLAG_FLIP_X                    = 1 << 0,
    DISPLAY_FLAG_FLIP_Y                    = 1 << 1,
    DISPLAY_FLAG_DISABLE_LOOPING           = 1 << 2,
    DISPLAY_FLAG_DID_FINISH                = 1 << 3,
    DISPLAY_FLAG_PAUSED                    = 1 << 4,
    DISPLAY_FLAG_NO_DRAW                   = 1 << 5,
    DISPLAY_FLAG_NO_DRAW_EVENT             = 1 << 6,
    DISPLAY_FLAG_SCREEN_RELATIVE           = 1 << 7,
    DISPLAY_FLAG_DISABLE_ROTATION          = 1 << 8,
    DISPLAY_FLAG_APPLY_CAMERA_CONFIG       = 1 << 9,
    DISPLAY_FLAG_400                       = 1 << 10,
    DISPLAY_FLAG_800                       = 1 << 11,
    DISPLAY_FLAG_NO_ANIMATE_CB             = 1 << 12,
    DISPLAY_FLAG_DISABLE_POSITION          = 1 << 13,
    DISPLAY_FLAG_DISABLE_POSITION_OFFSETS  = 1 << 14,
    DISPLAY_FLAG_DISABLE_FINISH_EVENT      = 1 << 15,
    DISPLAY_FLAG_DISABLE_SCALE             = 1 << 16,
    DISPLAY_FLAG_USE_DEFAULT_CAMERA_CONFIG = 1 << 17,
};
typedef u32 StageDisplayFlags;

enum StageObjTypes_
{
    STAGE_OBJ_TYPE_INVALID,
    STAGE_OBJ_TYPE_PLAYER,
    STAGE_OBJ_TYPE_ENEMY,
    STAGE_OBJ_TYPE_OBJECT,
    STAGE_OBJ_TYPE_DECORATION,
    STAGE_OBJ_TYPE_EFFECT,
};
typedef u16 StageObjTypes;

enum StageObjColliderFlags_
{
    STAGE_TASK_COLLIDER_FLAGS_NONE = 0,

    STAGE_TASK_COLLIDER_FLAGS_DYNAMIC_HITBOX = 1 << 0,
};
typedef u16 StageObjColliderFlags;

// --------------------
// STRUCTS
// --------------------

typedef struct ObjExWorkUnknown1_
{
    u16 field_0;
    u16 field_2;
    u16 field_4;
    u16 field_6;
} ObjExWorkUnknown1;

typedef struct ObjExWorkUnknown2_
{
    s32 field_0;
    s32 field_4;
    s32 field_8;
    s32 field_C;
    s32 field_10;
    s32 field_14;
    s32 field_18;
    s32 field_1C;
    s32 field_20;
    s32 field_24;
} ObjExWorkUnknown2;

typedef struct ObjExWork_
{
    s16 field_0[4];
    ObjExWorkUnknown1 field_8;
    u32 flags;
    VecFx32 velocity;
    s16 field_20;
    s16 field_22;
    u32 field_24;
    u32 field_28;
    VecFx16 angle;
    s16 field_32;
    u32 *field_34;
    ObjExWorkUnknown2 *field_38;
    u32 *field_3C;
    u32 *field_40;
    OBS_DATA_WORK *field_44[4];
    s16 field_54;
    s16 field_56;
    s16 field_58;
    s16 field_5A;
} ObjExWork;

struct StageTask_
{
    StageObjTypes objType;
    fx32 shakeTimer;
    fx32 hitstopTimer;
    s16 viewOutOffset;
    s16 viewOutOffsetBoundsLeft;
    s16 viewOutOffsetBoundsTop;
    s16 viewOutOffsetBoundsRight;
    s16 viewOutOffsetBoundsBottom;
    StageTaskFlags flag;
    StageTaskMoveFlags moveFlag;
    StageDisplayFlags displayFlag;
    u32 userFlag;
    u32 userWork;
    s32 userTimer;
    VecU16 dir;
    VecFx32 scale;
    VecFx32 position;
    VecFx32 offset;
    VecFx32 prevOffset;
    VecFx32 parentOffset;
    VecFx32 lockOffset;
    VecFx32 prevTempOffset;
    VecFx32 prevPosition; // previous frame's position
    VecFx32 velocity;     // how much to move the object's position
    VecFx32 acceleration; // how much to change the object's velocity
    VecFx32 flow;         // how much to move the object at the end of the frame
    VecFx32 move;         // how much the object moved in the previous frame
    fx32 groundVel;
    u16 slopeDirection;
    u16 fallDir;
    fx32 slopeAcceleration;
    fx32 maxSlopeSpeed;
    fx32 gravityStrength;
    fx32 terminalVelocity;
    fx32 pushCap;
    StageCollisionFlags collisionFlag;
    u32 prevCollisionFlag;
    HitboxRect hitboxRect;
    StageTaskState state;
    StageTaskInFunc ppIn;
    StageTaskOutFunc ppOut;
    StageTaskMoveFunc ppMove;
    SpriteFrameCallback ppSpriteCallback;
    StageTaskCollideFunc ppCollide;
    StageTaskLastFunc ppLast;
    StageTaskViewCheckFunc ppViewCheck;
    StageTask *rideObj;
    StageTask *touchObj;
    StageTask *parentObj;
    Task *taskRef;
    void *taskWorker;
    OBS_ACTION2D_BAC_WORK *obj_2d;
    OBS_ACTION3D_NN_WORK *obj_3d;
    OBS_ACTION3D_ES_WORK *obj_3des;
    OBS_ACTION3D_BAC_WORK *obj_2dIn3d;
    void *sequencePlayerPtr;
    StageTaskCollisionWork *collisionObj;
    ObjExWork *ex_work;
    OBS_RECT_WORK *colliderList[STAGETASK_COLLIDER_COUNT];
    StageObjColliderFlags colliderFlags[STAGETASK_COLLIDER_COUNT];
};

// --------------------
// FUNCTIONS
// --------------------

StageTask *CreateStageTask_(void);
StageTask *CreateStageTaskEx_(u32 priority, TaskScope scope);
void StageTask__SetType(StageTask *work, u16 type);
void StageTask__SetParent(StageTask *work, StageTask *parent, u16 ulFlag);
void StageTask__Draw(StageTask *work);
void StageTask_Main(void);
void StageTask_Destructor(Task *task);
BOOL StageTask__ObjectParent(StageTask *work);
void StageTask__ObjectCollision(StageTask *work);
void StageTask__Draw2D(StageTask *work, AnimatorSpriteDS *animator);
void StageTask__Draw2DEx(AnimatorSpriteDS *animator, VecFx32 *position, VecU16 *direction, VecFx32 *scale, StageDisplayFlags *displayFlagPtr, SpriteFrameCallback callback,
                         void *userData);
void StageTask__Draw3D(StageTask *work, Animator3D *animator);
void StageTask__Draw3DEx(Animator3D *animator, VecFx32 *position, VecU16 *dir, VecFx32 *scale, StageDisplayFlags *displayFlag, OBS_ACTION3D_ES_WORK *obj3d_es,
                         SpriteFrameCallback callback, void *userData);
void StageTask__SetAnimatorOAMOrder(StageTask *work, u32 order);
void StageTask__SetOAMOrder(AnimatorSprite *animator, u32 order);
void StageTask__SetAnimatorPriority(StageTask *work, SpritePriority priority);
void StageTask__SetOAMPriority(AnimatorSprite *animator, SpritePriority priority);
void StageTask__SetAnimation(StageTask *work, u16 animID);
u16 StageTask__GetAnimID(StageTask *work);
void StageTask__Move(StageTask *work);
void StageTask__ObjectSpdDirFall(fx32 *velX, fx32 *velY, u16 fallDir);
BOOL StageTask__ObjectDirFallReverseCheck(u32 fallDir);
void StageTask__HandleRide(StageTask *work);
void StageTask__HandleCollider(StageTask *work, OBS_RECT_WORK *rect);
BOOL StageTask__ViewCheck_Default(StageTask *work);
BOOL StageTask__ViewOutCheck(fx32 x, fx32 y, s32 offset, s16 sLeft, s16 sTop, s16 sRight, s16 sBottom);
void StageTask__SetHitbox(StageTask *work, s16 left, s16 top, s16 right, s16 bottom);
void StageTask__SetGravity(StageTask *work, s32 gravity, s32 terminalVelocity);
void StageTask__InitCollider(StageTask *work, OBS_RECT_WORK *collider, u32 id, StageObjColliderFlags flags);
OBS_RECT_WORK *StageTask__GetCollider(StageTask *work, u32 id);
void *StageTask__AllocateWorker(StageTask *work, size_t size);
void StageTask__InitSeqPlayer(StageTask *work);
void StageTask__SpriteBlockCallback_Hitbox(BACFrameGroupBlock_Hitbox *block, AnimatorSprite *animator, StageTask *work);
void StageTask__InitExWork(StageTask *work, ObjExWork *exWork);
fx32 StageTask__AdvanceBySpeed(fx32 value);
fx32 StageTask__DecrementBySpeed(fx32 value);

// --------------------
// INLINE FUNCTIONS
// --------------------

#define CreateStageTaskFast(flags, pauseLevel, priority, scope, name)                         TaskCreate(StageTask_Main, StageTask_Destructor, flags, pauseLevel, priority, scope, name)
#define CreateStageTask(taskDestructor, flags, pauseLevel, priority, scope, name)             TaskCreate(StageTask_Main, taskDestructor, flags, pauseLevel, priority, scope, name)
#define CreateStageTaskEx(taskMain, taskDestructor, flags, pauseLevel, priority, scope, name) TaskCreate(taskMain, taskDestructor, flags, pauseLevel, priority, scope, name)

#define CreateStageTaskSimple() CreateStageTask_()

RUSH_INLINE BOOL CheckStageTaskType(StageTask *work, StageObjTypes type)
{
    return work->objType == type;
}

#define CheckStageTaskTouchObj(stageTask, touchWork)   ((stageTask)->touchObj == (touchWork))
#define CheckStageTaskRideObj(stageTask, rideWork)     ((stageTask)->rideObj == (rideWork))
#define CheckStageTaskParentObj(stageTask, parentWork) ((stageTask)->parentObj == (parentWork))

#endif // RUSH2_STAGE_TASK_H
