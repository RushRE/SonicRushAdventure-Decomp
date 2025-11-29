#ifndef RUSH_CAMERA_LOCK_ZONE_H
#define RUSH_CAMERA_LOCK_ZONE_H

#include <stage/gameObject.h>

// --------------------
// STRUCTS
// --------------------

struct CameraLockZone_;

typedef struct CameraLockZoneCamera_
{
    u32 flags;
    s32 boundsL;
    s32 boundsT;
    s32 boundsR;
    s32 boundsB;
    void (*state)(struct CameraLockZone_ *work, s32 id);
    s8 targetPlayer;
} CameraLockZoneCamera;

typedef struct CameraLockZone_
{
    GameObjectTask gameWork;
    CameraLockZoneCamera camera[2];
} CameraLockZone;

// --------------------
// FUNCTIONS
// --------------------

CameraLockZone *CreateCameraLockZone(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_CAMERA_LOCK_ZONE_H
