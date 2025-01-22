#ifndef RUSH_CAMERA_BOUNDS_TRIGGER_H
#define RUSH_CAMERA_BOUNDS_TRIGGER_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

struct CameraBoundsTrigger_;

typedef struct CameraBoundsTriggerCamera_
{
    u32 flags;
    s32 boundsL;
    s32 boundsT;
    s32 boundsR;
    s32 boundsB;
    void (*state)(struct CameraBoundsTrigger_ *work, s32 id);
    s8 targetPlayer;
} CameraBoundsTriggerCamera;

typedef struct CameraBoundsTrigger_
{
    GameObjectTask gameWork;
    CameraBoundsTriggerCamera camera[2];
} CameraBoundsTrigger;

// --------------------
// FUNCTIONS
// --------------------

CameraBoundsTrigger *CameraBoundsTrigger__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

void CameraBoundsTrigger__State_Active(CameraBoundsTrigger *work);
void CameraBoundsTrigger__CameraState_ApplyBounds(CameraBoundsTrigger *work, s32 id);
void CameraBoundsTrigger__CameraState_Idle(CameraBoundsTrigger *work, s32 id);
void CameraBoundsTrigger__Func_2168974(CameraBoundsTrigger *work, s32 id);
void CameraBoundsTrigger__UnknownState_2168B98(CameraBoundsTrigger *work, s32 id);
void CameraBoundsTrigger__Func_2168BC0(CameraBoundsTrigger *work, s32 id);

#endif // RUSH_CAMERA_BOUNDS_TRIGGER_H
