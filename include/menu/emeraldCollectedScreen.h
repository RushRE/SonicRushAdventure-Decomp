#ifndef RUSH_EMERALDCOLLECTEDSCREEN_H
#define RUSH_EMERALDCOLLECTEDSCREEN_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>

// --------------------
// ENUMS
// --------------------

enum EmeraldCollectedScreenFlags_
{
    EMERALDCOLLECTEDSCREEN_FLAG_NONE = 0x00,

    EMERALDCOLLECTEDSCREEN_FLAG_CAN_UPDATE = 1 << 0,
    EMERALDCOLLECTEDSCREEN_FLAG_CAN_DRAW   = 1 << 1,
};
typedef u32 EmeraldCollectedScreenFlags;

// --------------------
// STRUCTS
// --------------------

typedef struct EmeraldCollectedScreenAssets_
{
    void *archiveEmeraldCollected;
    void *sprGoalJewelEffect;
} EmeraldCollectedScreenAssets;

typedef struct EmeraldCollectedScreenSparkle_
{
    Vec2Fx32 pos;
    Vec2Fx32 velocity;
    fx32 scale;
    u8 type;
    u8 inactiveTime;
    u8 activeTime;
    s32 unknown;
} EmeraldCollectedScreenSparkle;

typedef struct EmeraldCollectedScreenSparkles_
{
    AnimatorSprite animators[10];
    EmeraldCollectedScreenSparkle particleList[50];
    BOOL enabled;
    Vec2Fx32 originPos;
    Vec2Fx32 acceleration;
    fx32 scale;
    fx32 spawnMoveSpeed;
    fx32 spawnRange;
} EmeraldCollectedScreenSparkles;

typedef struct EmeraldCollectedScreenWorker_
{
    BOOL isChaosEmeralds;
    u16 emeraldFlags;
    s16 currentEmerald;
    
    // allow each array index to be named
    union
    {
        struct
        {
            AnimatorSprite aniJewel1;
            AnimatorSprite aniJewel2;
            AnimatorSprite aniJewel3;
            AnimatorSprite aniJewel4;
            AnimatorSprite aniJewel5;
            AnimatorSprite aniJewel6;
            AnimatorSprite aniJewel7;
            
            AnimatorSprite aniEmerald1;
            AnimatorSprite aniEmerald2;
            AnimatorSprite aniEmerald3;
            AnimatorSprite aniEmerald4;
            AnimatorSprite aniEmerald5;
            AnimatorSprite aniEmerald6;
            AnimatorSprite aniEmerald7;

            AnimatorSprite aniCase;
            AnimatorSprite aniActiveCase;
        };

        AnimatorSprite animators[7 + 7 + 2];
    };

    AnimatorMDL aniEmerald3D[1]; // not sure why this is an array... but it is!

    NNSG3dResFileHeader *mdlEmerald;
    VecFx32 emeraldTargetPos;
    VecFx32 emeraldPos;
    EmeraldCollectedScreenSparkles sparkleManager;
} EmeraldCollectedScreenWorker;

typedef struct EmeraldCollectedScreen_
{
    Task *taskUpdateManager;
    Task *taskDrawManager;
    void (*state)(struct EmeraldCollectedScreen_ *work);
    u32 timer;
    EmeraldCollectedScreenFlags flags;
    EmeraldCollectedScreenAssets assets;
    EmeraldCollectedScreenWorker process;
    NNSSndHandle *seqPlayer;
} EmeraldCollectedScreen;

// --------------------
// FUNCTIONS
// --------------------

void CreateEmeraldCollectedScreen(void);

#endif // RUSH_EMERALDCOLLECTEDSCREEN_H