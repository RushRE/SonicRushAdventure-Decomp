#ifndef RUSH_DECORATIONSYS_H
#define RUSH_DECORATIONSYS_H

#include <game/system/task.h>
#include <game/stage/mapSys.h>
#include <stage/player/player.h>

// --------------------
// CONSTANTS
// --------------------

#define STAGEDECOR_TEMPLIST_SIZE 32

// --------------------
// TYPES
// --------------------

typedef struct StageDecoration_ StageDecoration;

typedef void (*StageDecorState)(StageDecoration *work);
typedef void (*StageDecorOutFunc)(StageDecoration *work);
typedef void (*StageDecorMoveFunc)(StageDecoration *work);
typedef void (*StageDecorCollideFunc)(StageDecoration *work);

// --------------------
// MACROS
// --------------------

#define SetDecorOutFunc(work, func)     (work)->ppOut = (StageTaskOutFunc)(func)
#define SetDecorMoveFunc(work, func)    (work)->ppMove = (StageTaskMoveFunc)(func)
#define SetDecorCollideFunc(work, func) (work)->ppCollide = (StageTaskCollideFunc)(func)

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

struct StageDecoration_
{
    StageTask objWork;

    OBS_RECT_WORK rect[2];
    s32 field_1E8;
    s32 field_1EC;
    s32 field_1F0;
    s32 field_1F4;
    s32 field_1F8;
    s32 field_1FC;
    s32 field_200;
    s32 field_204;
    s32 field_208;
    MapDecor *mapDecor;
    Vec2Fx32 originPos;
    u32 flags;
    s32 field_21C;
    void (*destructor)(StageDecoration *work);
    StageDecoration *prev;
    StageDecoration *next;
};

typedef struct DecorationCommon2D_
{
    StageDecoration decorWork;

    OBS_ACTION2D_BAC_WORK animator;
} DecorationCommon2D;

typedef struct DecorationCommon3D_
{
    StageDecoration decorWork;
    OBS_ACTION2D_BAC_WORK animator2D;
    OBS_ACTION3D_BAC_WORK animator3D;
} DecorationCommon3D;

typedef struct EffectGrind3Leaf_
{
    StageTask objWork;

    OBS_ACTION2D_BAC_WORK ani;
} EffectGrind3Leaf;

typedef struct DecorationSys_
{
    StageDecoration *listStart;
    StageDecoration *listEnd;
} DecorationSys;

// --------------------
// FUNCTIONS
// --------------------

void DecorationSys__Create(void);
StageDecoration *DecorationSys__Construct(size_t structSize, MapDecor *mapDecor, fx32 x, fx32 y, BOOL prepend);
void DecorationSys__DestroyDecor(StageDecoration *work);
void DecorationSys__Release(void);
StageDecoration *DecorationSys__CreateTempDecoration(s32 type, fx32 x, fx32 y);
StageDecoration *DecorationSys__CreateCommonDecor2D(MapDecor *mapDecor, fx32 x, fx32 y, s32 type);
StageDecoration *DecorationSys__CreateCommonDecor3D(MapDecor *mapDecor, fx32 x, fx32 y, s32 type);
StageDecoration *DecorationSys__CreateUnknown2153118(MapDecor *mapDecor, fx32 x, fx32 y, s32 type);
void DecorationSys__Destructor(Task *task);
void DecorationSys__Main(void);
void DecorationSys__Decor_Main(StageDecoration *work);
void DecorationSys__Draw(StageDecoration *work);
void DecorationSys__ReleaseDecor(StageDecoration *work);
void DecorationSys__InitMapDecor(StageDecoration *work, MapDecor *mapDecor, fx32 x, fx32 y);
void DecorationSys__Destructor_21535B8(StageDecoration *work);
void DecorationSys__AddEntry_Tail(StageDecoration *work);
void DecorationSys__AddEntry_Head(StageDecoration *work);
void DecorationSys__RemoveEntry(StageDecoration *work);
void DecorationSys__SpriteCallback_Default(BACFrameGroupBlock_Hitbox *block, AnimatorSprite *animator, StageDecoration *work);
void DecorationSys__Collide_Default(StageDecoration *work);
s16 DecorationSys__GetNextTempSlot(void);
void DecorationSys__ReleaseTempDecor(MapDecor *mapDecor);
void DecorationSys__CreateWaterBubble(StageDecoration *work);
void DecorationSys__InitCmn_Breakable(StageDecoration *work);
void DecorationSys__OnDefend_Breakable(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void DecorationSys__InitCmn_WhalePointCloud(StageDecoration *work);
void DecorationSys__State_WhalePointCloud(StageDecoration *work);
void DecorationSys__InitCmn_GhostTreeFace(StageDecoration *work);
void DecorationSys__InitCmn_GhostTreeEye(StageDecoration *work);
void DecorationSys__State_GhostTreeEye(StageDecoration *work);
void DecorationSys__InitCmn_SkyBabylonFarCloud(StageDecoration *work);
void DecorationSys__Draw_SkyBabylonFarCloud(StageDecoration *work);
void DecorationSys__InitCmn_SkyBabylonNearCloud(StageDecoration *work);
void DecorationSys__State_SkyBabylonNearCloud(StageDecoration *work);
void DecorationSys__InitCmn_Icicle(StageDecoration *work);
void DecorationSys__OnDefend_Icicle(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void DecorationSys__InitCmn_IceTree(StageDecoration *work);
void DecorationSys__State_IceTree(StageDecoration *work);
void DecorationSys__CreateTripleGrindRailLeaf(fx32 x, fx32 y, fx32 velX, fx32 velY, u32 anim);
void DecorationSys__State_215475C(StageDecoration *work);
void DecorationSys__CreateUnknown21547D4(MapDecor *mapDecor, fx32 x, fx32 y, s32 type);
void DecorationSys__State_21548A8(StageDecoration *work);
void DecorationSys__OnDefend_21548D4(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
s32 DecorationSys__CreateEmitterChild(s32 id);
void DecorationSys__DestroyEmitterChild(s32 id);
void DecorationSys__InitCmn_Animated(StageDecoration *work);
void DecorationSys__Destructor_Animated(StageDecoration *work);
void DecorationSys__Draw_Animated(StageDecoration *work);
void DecorationSys__InitCmn_Emitter(StageDecoration *work);
void DecorationSys__Destructor_EmitterChild(StageDecoration *work);
void DecorationSys__SetAnimation(StageDecoration *work, u16 anim);

#endif // RUSH_DECORATIONSYS_H