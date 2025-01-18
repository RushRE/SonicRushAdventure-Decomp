#ifndef RUSH_STARTPLATFORM_H
#define RUSH_STARTPLATFORM_H

#include <stage/gameObject.h>

// --------------------
// CONSTANTS
// --------------------

#define STARTPLATFORM_COLLISION_WIDTH  296
#define STARTPLATFORM_COLLISION_HEIGHT 24

// --------------------
// STRUCTS
// --------------------

struct StartPlatformAssets
{
    NNSG3dResFileHeader *mdlStartJump;
    NNSG3dResFileHeader *aniStartJump;
    u8 *startJumpCollision;
};

struct StartPlatformCameraConfig
{
    VecFx32 startPos;
    VecFx32 endPos;
    fx32 amplitudeXZStart;
    fx32 amplitudeXZEnd;
    fx32 amplitudeYStart;
    fx32 amplitudeYEnd;
    u16 angleStart;
    u16 angleEnd;
    s16 lerpPercent;
};

typedef struct StartPlatform_
{
    GameObjectTask gameWork;
    struct StartPlatformAssets assets;
    s32 field_370;
    BOOL usedStartDash;
    u16 advanceDelay;
    u16 advanceTimer;
    BOOL disableStartDash;
    BOOL tryStartDash;
    BOOL isPlayerWalking;
    BOOL skippedTitleCard;
    BOOL playerLeftPlatform;
    void (*stateCamera)(struct StartPlatform_ *work);
    struct StartPlatformCameraConfig cameraConfig;
    s16 playerDistance;
    StageTaskCollisionWork collisionObj[2];
    u8 platformCollision[STARTPLATFORM_COLLISION_WIDTH * STARTPLATFORM_COLLISION_HEIGHT];
    OBS_ACTION3D_NN_WORK aniPlatform;
    u16 startDashTimer;
} StartPlatform;

// --------------------
// FUNCTIONS
// --------------------

StartPlatform *CreateStartPlatform(MapObject *mapObject, fx32 x, fx32 y, fx32 type);

#endif // RUSH_STARTPLATFORM_H
