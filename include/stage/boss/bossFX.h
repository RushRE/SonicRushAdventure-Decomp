#ifndef RUSH2_BOSSFX_H
#define RUSH2_BOSSFX_H

#include <stage/stageTask.h>

// --------------------
// TYPES
// --------------------

typedef struct BossFX2D_ BossFX2D;
typedef struct BossFX3D_ BossFX3D;

typedef void (*BossFX2DState)(BossFX2D *work);
typedef void (*BossFX3DState)(BossFX3D *work);

// --------------------
// ENUMS
// --------------------

enum BossFX3DFlags_
{
    BOSSFX3D_FLAG_NONE = 0x00,

    BOSSFX3D_FLAG_SETUP_RESOURCE        = 1 << 0,
    BOSSFX3D_FLAG_INVISIBLE_ON_ENGINE_A = 1 << 1,
    BOSSFX3D_FLAG_INVISIBLE_ON_ENGINE_B = 1 << 2,
};
typedef u32 BossFX3DFlags;

enum BossFX2DFlags_
{
    BOSSFX2D_FLAG_NONE = 0x00,

    BOSSFX2D_FLAG_INVISIBLE_ON_ENGINE_A = 1 << 0,
    BOSSFX2D_FLAG_INVISIBLE_ON_ENGINE_B = 1 << 1,
};
typedef u32 BossFX2DFlags;

// --------------------
// STRUCTS
// --------------------

struct BossFX3D_
{
    StageTask objWork;
    OBS_ACTION3D_NN_WORK aniModel;
    BossFX3DState state;
    BossFX3DFlags flags;
    NNSG3dResFileHeader *resModel;
    void *resPattern;
    u16 *referenceCount;
};

struct BossFX2D_
{
    StageTask objWork;
    OBS_ACTION3D_BAC_WORK aniSprite;
    BossFX2DState state;
    BossFX2DFlags flags;
};

// --------------------
// FUNCTIONS
// --------------------

// Common FX
BossFX3D *BossFX__CreateHitA(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateHitB(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX2D *BossFX__CreateBomb(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX2D *BossFX__CreateBomb2(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z);

// Boss1 FX
BossFX3D *BossFX__CreateRexBite(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateRexHead(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateRexRage(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX2D *BossFX__CreateRexSmoke(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateRexExplode0(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateRexExplode1(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateRexExplode2(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);

// Boss2 FX
BossFX3D *BossFX__CreatePendulumDrop(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreatePendulumFall(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreatePendulumSmoke(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreatePendulumExplode0(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreatePendulumExplode1(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreatePendulumExplode2(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);

// Boss3 FX
BossFX3D *BossFX__CreateKrackenExplode0(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateKrackenExplode1(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateKrackenExplode2(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateKrackenAngry(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);

// Boss4 FX
BossFX3D *BossFX__CreatePirateLand(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreatePirateSwdui(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreatePirateSwdji(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreatePirateKick(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreatePirateShot(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreatePirateExplode0(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreatePirateExplode1(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreatePirateExplode2(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);

// Boss5 FX
BossFX2D *BossFX__CreateWhaleBite(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX2D *BossFX__CreateWhaleIceA(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z, fx32 velX, fx32 velY, fx32 velZ);
BossFX2D *BossFX__CreateWhaleIceB(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z, fx32 velX, fx32 velY, fx32 velZ);
BossFX2D *BossFX__CreateWhaleSpout(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateWhaleTsunami1(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateWhaleTsunami2(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateWhaleSplashB(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z, MtxFx33 *mtx);
BossFX2D *BossFX__CreateWhaleSplashC(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateWhaleExplode0(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateWhaleExplode1(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateWhaleExplode2(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);

// Boss6 FX
BossFX3D *BossFX__CreateCondorTackle(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateCondorImpact(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX2D *BossFX__CreateCondorFire(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateCondorExplode0(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateCondorExplode1(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateCondorExplode2(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);

// Boss7 FX
BossFX3D *BossFX__CreateRivalHipatk(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateRivalShot(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateRivalExplode2(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);

// BossF FX
BossFX2D *BossFX__CreateTitanBomb(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateTitanFlashG(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z, MtxFx33 *mtx);
BossFX3D *BossFX__CreateTitanFlashC(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z, MtxFx33 *mtx);
BossFX3D *BossFX__CreateTitanHover(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX2D *BossFX__CreateTitanLightning(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z);
BossFX3D *BossFX__CreateTitanBreak(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z);

// Boss 3D FX
BossFX3D *BossFX3D__Create(size_t size, BossFX3DState state, const char *path, u32 motionFlags, BossFX3DFlags flags, s32 timer, fx32 x, fx32 y, fx32 z,
                                          u16 *referenceCount);
void BossFX3D__State_Active(BossFX3D *work);
void BossFX3D__Destructor(Task *task);
void BossFX3D__State_Billboard(BossFX3D *work);
void BossFX3D__State_CondorTackle(BossFX3D *work);

// Boss 2D FX
BossFX2D *BossFX2D__Create(size_t size, BossFX2DState state, const char *path, u16 animID, BossFX3DFlags flags, s32 timer, fx32 x, fx32 y, fx32 z);
void BossFX2D__State_Active(BossFX2D *work);
void BossFX2D__Destructor(Task *task);

#endif // RUSH2_BOSSFX_H