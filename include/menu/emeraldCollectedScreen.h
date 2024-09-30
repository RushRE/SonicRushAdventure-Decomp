#ifndef RUSH2_EMERALDCOLLECTEDSCREEN_H
#define RUSH2_EMERALDCOLLECTEDSCREEN_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EmeraldCollectedScreenAssets_
{
    void *archiveEndMission;
    void *sprGoalJewelEffect;
} EmeraldCollectedScreenAssets;

typedef struct EmeraldCollectedScreenSparkle_
{
    Vec2Fx32 pos;
    Vec2Fx32 velocity;
    fx32 scale;
    u8 type;
    u8 lifeTime;
    u8 delay;
    s32 field_18;
} EmeraldCollectedScreenSparkle;

typedef struct EmeraldCollectedScreenSparkles_
{
    AnimatorSprite animators[10];
    EmeraldCollectedScreenSparkle particleList[50];
    BOOL enabled;
    s32 field_964;
    s32 field_968;
    Vec2Fx32 acceleration;
    VecFx32 scale;
} EmeraldCollectedScreenSparkles;

typedef struct EmeraldCollectedScreenWorker_
{
    BOOL isChaosEmeralds;
    u16 emeraldFlags;
    s16 currentEmerald;
    AnimatorSprite animators1[7];
    AnimatorSprite animators2[9];
    AnimatorMDL aniMDL;
    NNSG3dResFileHeader *mdlEmerald;
    VecFx32 field_790;
    VecFx32 field_79C;
    EmeraldCollectedScreenSparkles sparkleManager;
} EmeraldCollectedScreenWorker;

typedef struct EmeraldCollectedScreen_
{
    Task *taskUpdateManager;
    Task *taskDrawManager;
    void (*state)(struct EmeraldCollectedScreen_ *work);
    s32 timer;
    s32 flags;
    EmeraldCollectedScreenAssets assets;
    EmeraldCollectedScreenWorker process;
    NNSSndSeqPlayer *seqPlayer;
} EmeraldCollectedScreen;

// --------------------
// FUNCTIONS
// --------------------

void EmeraldCollectedScreen__Create(void);
void EmeraldCollectedScreen__Destructor(Task *task);
void EmeraldCollectedScreen__SetState(EmeraldCollectedScreen *work, void *state);
void EmeraldCollectedScreen__SetupDisplay(void);
void EmeraldCollectedScreen__Init(EmeraldCollectedScreen *work);
void EmeraldCollectedScreen__Release(EmeraldCollectedScreen *work);
void EmeraldCollectedScreen__LoadArchives(EmeraldCollectedScreenAssets *work);
void EmeraldCollectedScreen__ReleaseAssets(EmeraldCollectedScreenAssets *work);
void EmeraldCollectedScreen__InitGraphics(EmeraldCollectedScreenWorker *work, EmeraldCollectedScreenAssets *archives);
void EmeraldCollectedScreen__ReleaseGraphics(EmeraldCollectedScreenWorker *work);
void EmeraldCollectedScreen__HandleUpdating(EmeraldCollectedScreen *work);
void EmeraldCollectedScreen__HandleDrawing(EmeraldCollectedScreen *work);
void EmeraldCollectedScreen__State_21556EC(EmeraldCollectedScreen *work);
void EmeraldCollectedScreen__State_2155730(EmeraldCollectedScreen *work);
void EmeraldCollectedScreen__State_2155770(EmeraldCollectedScreen *work);
void EmeraldCollectedScreen__State_21557C0(EmeraldCollectedScreen *work);
void EmeraldCollectedScreen__State_215581C(EmeraldCollectedScreen *work);
void EmeraldCollectedScreen__State_2155858(EmeraldCollectedScreen *work);
void EmeraldCollectedScreen__State_21558E4(EmeraldCollectedScreen *work);
void EmeraldCollectedScreen__State_2155974(EmeraldCollectedScreen *work);
void EmeraldCollectedScreen__State_2155A08(EmeraldCollectedScreen *work);
void EmeraldCollectedScreen__State_2155A24(EmeraldCollectedScreen *work);
void EmeraldCollectedScreen__State_2155A80(EmeraldCollectedScreen *work);
void EmeraldCollectedScreen__State_2155B38(EmeraldCollectedScreen *work);
void EmeraldCollectedScreen__State_2155B70(EmeraldCollectedScreen *work);
void EmeraldCollectedScreen__State_2155B90(EmeraldCollectedScreen *work);
void EmeraldCollectedScreen__State_ChangeEvent(EmeraldCollectedScreen *work);
s32 EmeraldCollectedScreen__GetEmeraldUnknown(u32 id);
BOOL EmeraldCollectedScreen__IsChaosEmeralds(void);
void EmeraldCollectedScreen__InitEmeraldConfig(EmeraldCollectedScreenWorker *work);
void EmeraldCollectedScreen__RenderCallback(NNSG3dRS *rs);
void EmeraldCollectedScreen__InitSparkles(EmeraldCollectedScreenSparkles *work, void *spriteFile);
void EmeraldCollectedScreen__ReleaseSparkles(EmeraldCollectedScreenSparkles *work);
void EmeraldCollectedScreen__EnableSparkles(EmeraldCollectedScreenSparkles *work);
void EmeraldCollectedScreen__DisableSparkles(EmeraldCollectedScreenSparkles *work);
void EmeraldCollectedScreen__ProcessSparkles(EmeraldCollectedScreenSparkles *work);
void EmeraldCollectedScreen__DrawSparkles(EmeraldCollectedScreenSparkles *work);
void EmeraldCollectedScreen__Main_Core(void);
void EmeraldCollectedScreen__Main_UpdateManager(void);
void EmeraldCollectedScreen__Main_DrawManager(void);

#endif // RUSH2_EMERALDCOLLECTEDSCREEN_H