#include <stage/boss/bossFX.h>
#include <game/graphics/drawReqTask.h>
#include <game/stage/gameSystem.h>
#include <game/object/obj.h>
#include <game/math/unknown2066510.h>

// --------------------
// VARIABLES
// --------------------

// extern var if non-matching, otherwise it's a static var
// this is because 'WhaleSplashB_ReferenceCount' & 'CondorImpact_ReferenceCount' swapped addresses in Boss1/Boss2 overlay so this fixes that when matching!
#ifdef NON_MATCHING
#define NON_MATCHING_FIX static
#else
#define NON_MATCHING_FIX extern
#endif

NON_MATCHING_FIX u16 RexRage_ReferenceCount;
NON_MATCHING_FIX u16 TitanFlashC_ReferenceCount;
NON_MATCHING_FIX u16 RexHead_ReferenceCount;
NON_MATCHING_FIX u16 RexBite_ReferenceCount;
NON_MATCHING_FIX u16 HitB_ReferenceCount;
NON_MATCHING_FIX u16 WhaleTsunami2_ReferenceCount;
NON_MATCHING_FIX u16 WhaleTsunami1_ReferenceCount;
NON_MATCHING_FIX u16 TitanFlashG_ReferenceCount;
NON_MATCHING_FIX u16 HitA_ReferenceCount;
NON_MATCHING_FIX u16 PirateLand_ReferenceCount;
NON_MATCHING_FIX u16 WhaleSplashB_ReferenceCount;
NON_MATCHING_FIX u16 CondorImpact_ReferenceCount;

// matching shenanigans
#ifndef NON_MATCHING
static const char *_EXT_MAT_ANIM   = ".nsbma";
static const char *_EXT_PAT_ANIM   = ".nsbtp";
static const char *_EXT_VIS_ANIM   = ".nsbva";
static const char *_EXT_JOINT_ANIM = ".nsbca";
static const char *_EXT_TEX_ANIM   = ".nsbta";
#endif

static const char *animationExtList[B3D_ANIM_MAX] = {
    [B3D_ANIM_JOINT_ANIM] = ".nsbca", // joint animations
    [B3D_ANIM_MAT_ANIM]   = ".nsbma", // material animations
    [B3D_ANIM_PAT_ANIM]   = ".nsbtp", // pattern animations
    [B3D_ANIM_TEX_ANIM]   = ".nsbta", // texture animations
    [B3D_ANIM_VIS_ANIM]   = ".nsbva", // visibility animations
};

// --------------------
// FUNCTIONS
// --------------------

// Common FX
BossFX3D *BossFX__CreateHitA(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    return BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef_hit_a", B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, &HitA_ReferenceCount);
}

BossFX3D *BossFX__CreateHitB(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    return BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef_hit_b", B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, &HitB_ReferenceCount);
}

BossFX2D *BossFX__CreateBomb(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX2D *effect = BossFX2D__Create(sizeof(BossFX2D), NULL, "bsef_bomb.bac", 0, flags, 0, x, y, z);

    effect->aniSprite.ani.work.scale.x = FLOAT_TO_FX32(1.0);
    effect->aniSprite.ani.work.scale.y = FLOAT_TO_FX32(1.0);
    effect->aniSprite.ani.work.scale.z = FLOAT_TO_FX32(1.0);

    return effect;
}

BossFX2D *BossFX__CreateBomb2(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX2D *effect = BossFX__CreateBomb(flags, x, y, z);

    effect->objWork.flag |= STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE;

    return effect;
}

// Boss1 FX
BossFX3D *BossFX__CreateRexBite(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    return BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef1_bite", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z,
                            &RexBite_ReferenceCount);
}

BossFX3D *BossFX__CreateRexHead(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    return BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef1_head", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x,
                            y, z, &RexHead_ReferenceCount);
}

BossFX3D *BossFX__CreateRexRage(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    return BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef1_rage", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x,
                            y, z, &RexRage_ReferenceCount);
}

BossFX2D *BossFX__CreateRexSmoke(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX2D *effect = BossFX2D__Create(sizeof(BossFX2D), NULL, "bsef1_smoke.bac", 0, flags, 0, x, y, z);

    effect->aniSprite.ani.work.scale.x = FLOAT_TO_FX32(3.0);
    effect->aniSprite.ani.work.scale.y = FLOAT_TO_FX32(3.0);
    effect->aniSprite.ani.work.scale.z = FLOAT_TO_FX32(3.0);

    effect->aniSprite.ani.polygonAttr.noCullBack = TRUE;
    effect->aniSprite.ani.polygonAttr.noCullFront = TRUE;

    return effect;
}

BossFX3D *BossFX__CreateRexExplode0(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), BossFX3D__State_Billboard, "bsef1_f_exp00", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM,
                                        flags, 23, x, y, z, NULL);

    effect->aniModel.ani.speedMultiplier = FLOAT_TO_FX32(1.5);
    effect->objWork.flag |= STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE;

    effect->aniModel.ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_43;
    effect->aniModel.ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;

    effect->objWork.scale.x = FLOAT_TO_FX32(0.1);
    effect->objWork.scale.y = FLOAT_TO_FX32(0.1);
    effect->objWork.scale.z = FLOAT_TO_FX32(0.1);

    effect->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_POSITION;

    return effect;
}

BossFX3D *BossFX__CreateRexExplode1(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef1_f_exp01",
                                        B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);

    effect->objWork.flag |= DISPLAY_FLAG_NO_DRAW;

    return effect;
}

BossFX3D *BossFX__CreateRexExplode2(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), BossFX3D__State_Billboard, "bsef1_f_exp02", B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);
    effect->objWork.flag |= STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE;

    effect->aniModel.ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_43;
    effect->aniModel.ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;

    effect->objWork.scale.x = FLOAT_TO_FX32(0.5);
    effect->objWork.scale.y = FLOAT_TO_FX32(0.5);
    effect->objWork.scale.z = FLOAT_TO_FX32(0.5);

    effect->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_POSITION;

    return effect;
}

// Boss2 FX
BossFX3D *BossFX__CreatePendulumDrop(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    return BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef2_drop", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x,
                            y, z, NULL);
}

BossFX3D *BossFX__CreatePendulumFall(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    return BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef2_fall", B3D_ANIM_FLAG_JOINT_ANIM, flags, 216000, x, y, z, NULL);
}

BossFX3D *BossFX__CreatePendulumSmoke(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    return BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef2_smoke", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);
}

BossFX3D *BossFX__CreatePendulumExplode0(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), BossFX3D__State_Billboard, "bsef2_f_exp00", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM,
                                        flags, 23, x, y, z, NULL);

    effect->aniModel.ani.speedMultiplier = FLOAT_TO_FX32(1.5);
    effect->objWork.flag |= STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE;

    effect->aniModel.ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_43;
    effect->aniModel.ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;

    effect->objWork.scale.x = FLOAT_TO_FX32(0.1);
    effect->objWork.scale.y = FLOAT_TO_FX32(0.1);
    effect->objWork.scale.z = FLOAT_TO_FX32(0.1);

    effect->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_POSITION;

    return effect;
}

BossFX3D *BossFX__CreatePendulumExplode1(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef2_f_exp01",
                                        B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);

    effect->objWork.flag |= DISPLAY_FLAG_NO_DRAW;

    return effect;
}

BossFX3D *BossFX__CreatePendulumExplode2(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), BossFX3D__State_Billboard, "bsef2_f_exp02", B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);
    effect->objWork.flag |= STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE;

    effect->aniModel.ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_43;
    effect->aniModel.ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;

    effect->objWork.scale.x = FLOAT_TO_FX32(0.5);
    effect->objWork.scale.y = FLOAT_TO_FX32(0.5);
    effect->objWork.scale.z = FLOAT_TO_FX32(0.5);

    effect->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_POSITION;

    return effect;
}

// Boss3 FX
BossFX3D *BossFX__CreateKrackenExplode0(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), BossFX3D__State_Billboard, "bsef3_f_exp00", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM,
                                        flags, 23, x, y, z, NULL);

    effect->aniModel.ani.speedMultiplier = FLOAT_TO_FX32(1.5);
    effect->objWork.flag |= STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE;

    effect->aniModel.ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_43;
    effect->aniModel.ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;

    effect->objWork.scale.x = FLOAT_TO_FX32(0.1);
    effect->objWork.scale.y = FLOAT_TO_FX32(0.1);
    effect->objWork.scale.z = FLOAT_TO_FX32(0.1);

    effect->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_POSITION;

    return effect;
}

BossFX3D *BossFX__CreateKrackenExplode1(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef3_f_exp01",
                                        B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);

    effect->objWork.flag |= DISPLAY_FLAG_NO_DRAW;

    effect->objWork.scale.x = FLOAT_TO_FX32(1.5);
    effect->objWork.scale.y = FLOAT_TO_FX32(1.5);
    effect->objWork.scale.z = FLOAT_TO_FX32(0.5);

    return effect;
}

BossFX3D *BossFX__CreateKrackenExplode2(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), BossFX3D__State_Billboard, "bsef3_f_exp02", B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);
    effect->objWork.flag |= STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE;

    effect->aniModel.ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_43;
    effect->aniModel.ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;

    effect->objWork.scale.x = FLOAT_TO_FX32(0.5);
    effect->objWork.scale.y = FLOAT_TO_FX32(0.5);
    effect->objWork.scale.z = FLOAT_TO_FX32(0.5);

    effect->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_POSITION;

    return effect;
}

BossFX3D *BossFX__CreateKrackenAngry(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef3_angry", B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);

    effect->objWork.scale.x = FLOAT_TO_FX32(1.0);
    effect->objWork.scale.y = FLOAT_TO_FX32(1.0);
    effect->objWork.scale.z = FLOAT_TO_FX32(1.0);

    return effect;
}

// Boss4 FX
BossFX3D *BossFX__CreatePirateLand(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef4_land", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM,
                                        flags, 0, x, y, z, &PirateLand_ReferenceCount);

    effect->objWork.scale.x = FLOAT_TO_FX32(0.5);
    effect->objWork.scale.y = FLOAT_TO_FX32(0.5);
    effect->objWork.scale.z = FLOAT_TO_FX32(0.5);

    return effect;
}

BossFX3D *BossFX__CreatePirateSwdui(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    return BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef4_swdui", B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);
}

BossFX3D *BossFX__CreatePirateSwdji(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    return BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef4_swdji", B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);
}

BossFX3D *BossFX__CreatePirateKick(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    return BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef4_kick", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);
}

BossFX3D *BossFX__CreatePirateShot(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    return BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef4_shot", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);
}

BossFX3D *BossFX__CreatePirateExplode0(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), BossFX3D__State_Billboard, "bsef4_f_exp00", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM,
                                        flags, 23, x, y, z, NULL);

    effect->aniModel.ani.speedMultiplier = FLOAT_TO_FX32(1.5);
    effect->objWork.flag |= STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE;

    effect->aniModel.ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_43;
    effect->aniModel.ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;

    effect->objWork.scale.x = FLOAT_TO_FX32(0.1);
    effect->objWork.scale.y = FLOAT_TO_FX32(0.1);
    effect->objWork.scale.z = FLOAT_TO_FX32(0.1);

    effect->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_POSITION;

    return effect;
}

BossFX3D *BossFX__CreatePirateExplode1(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef4_f_exp01",
                                        B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);
    effect->objWork.flag |= DISPLAY_FLAG_NO_DRAW;
    return effect;
}

BossFX3D *BossFX__CreatePirateExplode2(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), BossFX3D__State_Billboard, "bsef4_f_exp02", B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);
    effect->objWork.flag |= STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE;

    effect->aniModel.ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_43;
    effect->aniModel.ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;

    effect->objWork.scale.x = FLOAT_TO_FX32(0.5);
    effect->objWork.scale.y = FLOAT_TO_FX32(0.5);
    effect->objWork.scale.z = FLOAT_TO_FX32(0.5);

    effect->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_POSITION;

    return effect;
}

// Boss5 FX
BossFX2D *BossFX__CreateWhaleBite(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX2D *effect = BossFX2D__Create(sizeof(BossFX2D), NULL, "bsef5_bite.bac", 0, flags, 0, x, y, z);

    effect->aniSprite.ani.work.scale.x = -FLOAT_TO_FX32(4.0);
    effect->aniSprite.ani.work.scale.y = FLOAT_TO_FX32(4.0);
    effect->aniSprite.ani.work.scale.z = FLOAT_TO_FX32(4.0);

    return effect;
}

BossFX2D *BossFX__CreateWhaleIceA(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z, fx32 velX, fx32 velY, fx32 velZ)
{
    BossFX2D *effect = BossFX2D__Create(sizeof(BossFX2D), NULL, "bsef5_ice_a.bac", 0, flags, 120, x, y, z);

    effect->aniSprite.ani.work.scale.x = FLOAT_TO_FX32(2.0);
    effect->aniSprite.ani.work.scale.y = FLOAT_TO_FX32(2.0);
    effect->aniSprite.ani.work.scale.z = FLOAT_TO_FX32(2.0);

    effect->objWork.velocity.x = velX;
    effect->objWork.velocity.y = -velY;
    effect->objWork.velocity.z = velZ;

    effect->aniSprite.ani.work.matrixOpIDs[0] = MATRIX_OP_FLUSH_P;
    effect->aniSprite.ani.work.matrixOpIDs[1] = MATRIX_OP_NONE;

    effect->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

    return effect;
}

BossFX2D *BossFX__CreateWhaleIceB(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z, fx32 velX, fx32 velY, fx32 velZ)
{
    BossFX2D *effect = BossFX2D__Create(sizeof(BossFX2D), NULL, "bsef5_ice_b.bac", 0, flags, 120, x, y, z);

    effect->aniSprite.ani.work.scale.x = FLOAT_TO_FX32(2.0);
    effect->aniSprite.ani.work.scale.y = FLOAT_TO_FX32(2.0);
    effect->aniSprite.ani.work.scale.z = FLOAT_TO_FX32(2.0);

    effect->objWork.velocity.x = velX;
    effect->objWork.velocity.y = -velY;
    effect->objWork.velocity.z = velZ;

    effect->aniSprite.ani.work.matrixOpIDs[0] = MATRIX_OP_FLUSH_P;
    effect->aniSprite.ani.work.matrixOpIDs[1] = MATRIX_OP_NONE;

    effect->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

    return effect;
}

BossFX2D *BossFX__CreateWhaleSpout(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX2D *effect = BossFX2D__Create(sizeof(BossFX2D), NULL, "bsef5_spout.bac", 0, flags, 0, x, y, z);

    effect->aniSprite.ani.work.scale.x = FLOAT_TO_FX32(6.0);
    effect->aniSprite.ani.work.scale.y = FLOAT_TO_FX32(6.0);
    effect->aniSprite.ani.work.scale.z = FLOAT_TO_FX32(6.0);

    return effect;
}

BossFX3D *BossFX__CreateWhaleTsunami1(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef5_tunami1", B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, -1, x, y, z,
                                        &WhaleTsunami1_ReferenceCount);

    effect->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    effect->objWork.scale.x = FLOAT_TO_FX32(0.66);
    effect->objWork.scale.y = FLOAT_TO_FX32(0.66);
    effect->objWork.scale.z = FLOAT_TO_FX32(1.0);

    return effect;
}

BossFX3D *BossFX__CreateWhaleTsunami2(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect =
        BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef5_tunami2", B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, -1, x, y, z, &WhaleTsunami2_ReferenceCount);

    effect->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    effect->objWork.scale.x = FLOAT_TO_FX32(0.66);
    effect->objWork.scale.y = FLOAT_TO_FX32(0.66);
    effect->objWork.scale.z = FLOAT_TO_FX32(1.0);

    return effect;
}

BossFX3D *BossFX__CreateWhaleSplashB(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z, MtxFx33 *mtx)
{

    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef5_splash_b", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z,
                                        &WhaleSplashB_ReferenceCount);

    effect->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;

    effect->objWork.scale.x = FLOAT_TO_FX32(1.0);
    effect->objWork.scale.y = FLOAT_TO_FX32(1.0);
    effect->objWork.scale.z = FLOAT_TO_FX32(1.0);

    effect->aniModel.ani.work.rotation = *mtx;

    return effect;
}

BossFX2D *BossFX__CreateWhaleSplashC(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX2D *effect = BossFX2D__Create(sizeof(BossFX2D), NULL, "bsef5_splash_c.bac", 0, flags, 0, x, y, z);

    effect->aniSprite.ani.work.scale.x = FLOAT_TO_FX32(2.0);
    effect->aniSprite.ani.work.scale.y = FLOAT_TO_FX32(2.0);
    effect->aniSprite.ani.work.scale.z = FLOAT_TO_FX32(2.0);
    effect->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

    return effect;
}

BossFX3D *BossFX__CreateWhaleExplode0(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), BossFX3D__State_Billboard, "bsef5_f_exp00", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM,
                                        flags, 23, x, y, z, NULL);

    effect->aniModel.ani.speedMultiplier = FLOAT_TO_FX32(1.5);
    effect->objWork.flag |= STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE;

    effect->aniModel.ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_43;
    effect->aniModel.ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;

    effect->objWork.scale.x = FLOAT_TO_FX32(0.1);
    effect->objWork.scale.y = FLOAT_TO_FX32(0.1);
    effect->objWork.scale.z = FLOAT_TO_FX32(0.1);

    effect->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_POSITION;

    return effect;
}

BossFX3D *BossFX__CreateWhaleExplode1(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef5_f_exp01",
                                        B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);
    effect->objWork.flag |= DISPLAY_FLAG_NO_DRAW;
    return effect;
}

BossFX3D *BossFX__CreateWhaleExplode2(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), BossFX3D__State_Billboard, "bsef5_f_exp02", B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);
    effect->objWork.flag |= STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE;

    effect->aniModel.ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_43;
    effect->aniModel.ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;

    effect->objWork.scale.x = FLOAT_TO_FX32(0.5);
    effect->objWork.scale.y = FLOAT_TO_FX32(0.5);
    effect->objWork.scale.z = FLOAT_TO_FX32(0.5);

    effect->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_POSITION;

    return effect;
}

BossFX3D *BossFX__CreateCondorTackle(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    return BossFX3D__Create(sizeof(BossFX3D), BossFX3D__State_CondorTackle, "bsef6_tackle", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, -1,
                            0, 0, 0, NULL);
}

BossFX3D *BossFX__CreateCondorImpact(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef6_impact", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z,
                                        &CondorImpact_ReferenceCount);

    effect->objWork.scale.x = FLOAT_TO_FX32(2.0);
    effect->objWork.scale.y = FLOAT_TO_FX32(2.0);
    effect->objWork.scale.z = FLOAT_TO_FX32(2.0);

    return effect;
}

BossFX2D *BossFX__CreateCondorFire(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX2D *effect = BossFX2D__Create(sizeof(BossFX2D), NULL, "bsef6_fire.bac", 0, flags, 0, x, y, z);

    effect->aniSprite.ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_43;

    effect->aniSprite.ani.work.scale.x = FLOAT_TO_FX32(2.0);
    effect->aniSprite.ani.work.scale.y = FLOAT_TO_FX32(2.0);
    effect->aniSprite.ani.work.scale.z = FLOAT_TO_FX32(2.0);

    return effect;
}

BossFX3D *BossFX__CreateCondorExplode0(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), BossFX3D__State_Billboard, "bsef6_f_exp00", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM,
                                        flags, 23, x, y, z, NULL);

    effect->aniModel.ani.speedMultiplier = FLOAT_TO_FX32(1.5);
    effect->objWork.flag |= STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE;

    effect->aniModel.ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_43;
    effect->aniModel.ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;

    effect->objWork.scale.x = FLOAT_TO_FX32(0.1);
    effect->objWork.scale.y = FLOAT_TO_FX32(0.1);
    effect->objWork.scale.z = FLOAT_TO_FX32(0.1);

    effect->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_POSITION;

    return effect;
}

BossFX3D *BossFX__CreateCondorExplode1(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef6_f_exp01",
                                        B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);
    effect->objWork.flag |= DISPLAY_FLAG_NO_DRAW;
    MTX_RotX33(&effect->aniModel.ani.work.rotation, SinFX(FLOAT_DEG_TO_IDX(29.970703125)), CosFX(FLOAT_DEG_TO_IDX(29.970703125)));

    return effect;
}

BossFX3D *BossFX__CreateCondorExplode2(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), BossFX3D__State_Billboard, "bsef6_f_exp02", B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);
    effect->objWork.flag |= STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE;

    effect->aniModel.ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_43;
    effect->aniModel.ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;

    effect->objWork.scale.x = FLOAT_TO_FX32(0.4);
    effect->objWork.scale.y = FLOAT_TO_FX32(0.4);
    effect->objWork.scale.z = FLOAT_TO_FX32(0.4);

    effect->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_POSITION;

    return effect;
}

BossFX3D *BossFX__CreateRivalHipatk(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    return BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef7_hipatk", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);
}

BossFX3D *BossFX__CreateRivalShot(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    return BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef7_shot", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);
}

BossFX3D *BossFX__CreateRivalExplode2(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), BossFX3D__State_Billboard, "bsef7_f_exp02", B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);
    effect->objWork.flag |= STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE;

    effect->aniModel.ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_43;
    effect->aniModel.ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;

    effect->objWork.scale.x = FLOAT_TO_FX32(0.5);
    effect->objWork.scale.y = FLOAT_TO_FX32(0.5);
    effect->objWork.scale.z = FLOAT_TO_FX32(0.5);

    effect->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_POSITION;

    return effect;
}

BossFX2D *BossFX__CreateTitanBomb(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z)
{
    BossFX2D *effect = BossFX2D__Create(sizeof(BossFX2D), NULL, "bsef8_Bomb.bac", 0, flags, 0, x, y, z);

    effect->aniSprite.ani.work.scale.x = FLOAT_TO_FX32(1.5);
    effect->aniSprite.ani.work.scale.y = FLOAT_TO_FX32(1.5);
    effect->aniSprite.ani.work.scale.z = FLOAT_TO_FX32(1.5);

    effect->aniSprite.ani.animatorSprite.animAdvance = FLOAT_TO_FX32(2.0);

    effect->objWork.velocity.z = -FLOAT_TO_FX32(0.25);

    return effect;
}

BossFX3D *BossFX__CreateTitanFlashG(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z, MtxFx33 *mtx)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef8_g_flash", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z,
                                        &TitanFlashG_ReferenceCount);

    if (mtx != NULL)
        effect->aniModel.ani.work.rotation = *mtx;

    effect->objWork.scale.x = FLOAT_TO_FX32(1.5);
    effect->objWork.scale.y = FLOAT_TO_FX32(1.5);
    effect->objWork.scale.z = FLOAT_TO_FX32(1.5);

    return effect;
}

BossFX3D *BossFX__CreateTitanFlashC(BossFX3DFlags flags, fx32 x, fx32 y, fx32 z, MtxFx33 *mtx)
{
    BossFX3D *effect = BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef8_c_flash", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_PAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z,
                                        &TitanFlashC_ReferenceCount);

    if (mtx != NULL)
        effect->aniModel.ani.work.rotation = *mtx;

    return effect;
}

BossFX3D *BossFX__CreateTitanHover(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z)
{
    return BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef8_float2", B3D_ANIM_FLAG_VIS_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);
}

BossFX2D *BossFX__CreateTitanLightning(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z)
{
    return BossFX2D__Create(sizeof(BossFX2D), NULL, "bsef8_lightning.bac", ObjDispRandRepeat(2), flags, 60, x, y, z);
}

BossFX3D *BossFX__CreateTitanBreak(BossFX2DFlags flags, fx32 x, fx32 y, fx32 z)
{
    return BossFX3D__Create(sizeof(BossFX3D), NULL, "bsef8_b_break", B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM, flags, 0, x, y, z, NULL);
}

// Boss 3D FX
BossFX3D *BossFX3D__Create(size_t size, BossFX3DState state, const char *path, u32 motionFlags, BossFX3DFlags flags, s32 timer, fx32 x, fx32 y, fx32 z, u16 *referenceCount)
{
    NNSFndArchive arc;
    char fullPath[32];

    Task *task;
    BossFX3D *work;

#ifdef RUSH_DEBUG
    task = TaskCreate_(StageTask_Main, BossFX3D__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1A00, TASK_GROUP(4), size, path);
#else
    task = TaskCreate_(StageTask_Main, BossFX3D__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1A00, TASK_GROUP(4), size);
#endif
    if (task == HeapNull)
        return NULL;

    work = TaskGetWork(task, BossFX3D);
    MI_CpuClear16(work, size);

    work->state               = state;
    work->flags               = flags;
    work->objWork.displayFlag = DISPLAY_FLAG_NO_DRAW | DISPLAY_FLAG_PAUSED;
    work->objWork.userTimer   = timer;
    work->objWork.userWork    = 2;
    work->objWork.position.x  = x;
    work->objWork.position.y  = -y;
    work->objWork.position.z  = z;
    work->objWork.scale.x     = FLOAT_TO_FX32(1.0);
    work->objWork.scale.y     = FLOAT_TO_FX32(1.0);
    work->objWork.scale.z     = FLOAT_TO_FX32(1.0);
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    work->objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    SetTaskState(&work->objWork, BossFX3D__State_Active);

    work->referenceCount = referenceCount;
    if (work->referenceCount != NULL)
        (*work->referenceCount)++;

    STD_CopyString(fullPath, path);
    STD_ConcatenateString(fullPath, ".nsbmd");
    ObjAction3dNNModelLoad(&work->objWork, &work->aniModel, fullPath, 0, NULL, gameArchiveStage);
    work->aniModel.ani.work.scale.x = FLOAT_TO_FX32(3.3);
    work->aniModel.ani.work.scale.y = FLOAT_TO_FX32(3.3);
    work->aniModel.ani.work.scale.z = FLOAT_TO_FX32(3.3);

    STD_CopyString(fullPath, "exc:");
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);
    STD_CopyString(&fullPath[4], path);
    STD_ConcatenateString(&fullPath[4], ".nsbmd");
    work->resModel = NNS_FndGetArchiveFileByName(fullPath);

    if ((work->flags & BOSSFX3D_FLAG_SETUP_RESOURCE) == 0)
    {
        if (work->referenceCount != NULL)
        {
            if ((*work->referenceCount) == 1)
                Asset3DSetup__Create(work->resModel);
        }
        else
        {
            Asset3DSetup__Create(work->resModel);
        }
    }

    for (u32 i = 0; i < B3D_ANIM_MAX; i++)
    {
        if ((motionFlags & (1 << i)) != 0)
        {
            STD_CopyString(&fullPath[4], path);
            STD_ConcatenateString(&fullPath[4], animationExtList[i]);

            if (i != B3D_ANIM_PAT_ANIM)
            {
                AnimatorMDL__SetAnimation(&work->aniModel.ani, i, NNS_FndGetArchiveFileByName(fullPath), 0, NULL);
            }
            else
            {
                work->resPattern = NNS_FndGetArchiveFileByName(fullPath);
            }
        }
    }
    NNS_FndUnmountArchive(&arc);

    return work;
}

void BossFX3D__State_Active(BossFX3D *work)
{
    OBS_ACTION3D_NN_WORK *ani = &work->aniModel;

    if ((work->flags & (BOSSFX3D_FLAG_INVISIBLE_ON_ENGINE_B | BOSSFX3D_FLAG_INVISIBLE_ON_ENGINE_A)) != 0 && Camera3D__GetTask())
    {
        if ((work->flags & BOSSFX3D_FLAG_INVISIBLE_ON_ENGINE_A) != 0 && Camera3D__UseEngineA()
            || (work->flags & BOSSFX3D_FLAG_INVISIBLE_ON_ENGINE_B) != 0 && !Camera3D__UseEngineA())
            work->objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;
        else
            work->objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
    }

    if (work->objWork.userWork == 0)
    {
        if (work->state != NULL)
            work->state(work);

        if (work->objWork.userTimer == 0)
        {
            u32 i;
            for (i = 0; i < B3D_ANIM_MAX; i++)
            {
                if (ani->ani.currentAnimObj[i] != NULL && (ani->ani.animFlags[i] & ANIMATORMDL_FLAG_FINISHED) == 0)
                    break;
            }

            if (i == B3D_ANIM_MAX)
                work->objWork.flag |= STAGE_TASK_FLAG_DESTROYED;
        }
        else
        {
            if (work->objWork.userTimer > 0)
            {
                work->objWork.userTimer--;
                if (work->objWork.userTimer == 0)
                    work->objWork.flag |= STAGE_TASK_FLAG_DESTROYED;
            }
        }
    }
    else
    {
        work->objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW | DISPLAY_FLAG_PAUSED;

        work->objWork.userWork--;
        if (work->objWork.userWork == 0)
        {
            if (work->resPattern != NULL)
                AnimatorMDL__SetAnimation(&work->aniModel.ani, B3D_ANIM_PAT_ANIM, work->resPattern, 0, NNS_G3dGetTex(work->resModel));

            work->objWork.displayFlag &= ~(DISPLAY_FLAG_NO_DRAW | DISPLAY_FLAG_PAUSED);
        }
    }
}

void BossFX3D__Destructor(Task *task)
{
    BossFX3D *work = TaskGetWork(task, BossFX3D);

    if (work->referenceCount != NULL)
        (*work->referenceCount)--;

    if ((work->flags & BOSSFX3D_FLAG_SETUP_RESOURCE) == 0)
    {
        if (work->referenceCount != NULL)
        {
            if ((*work->referenceCount) == 0)
                NNS_G3dResDefaultRelease(work->resModel);
        }
        else
        {
            NNS_G3dResDefaultRelease(work->resModel);
        }
    }

    StageTask_Destructor(task);
}

void BossFX3D__State_Billboard(BossFX3D *work)
{
    VecFx32 position;
    fx32 camUnknown[4];    // unknown struct #1
    fx32 camPosUnknown[6]; // unknown struct #2
    VecFx32 camDir;
    VecFx32 camEnd;

    VEC_Set(&position, work->objWork.position.x, -work->objWork.position.y, work->objWork.position.z);

    VEC_Subtract(NNS_G3dGlbGetCameraTarget(), NNS_G3dGlbGetCameraPos(), &camDir);
    VEC_Normalize(&camDir, &camDir);
    VEC_MultAdd(FLOAT_TO_FX32(11.0), &camDir, (VecFx32 *)NNS_G3dGlbGetCameraPos(), &camEnd);

    Unknown2066510__Func_206703C(camUnknown, &camDir, &camEnd);
    Unknown2066510__Func_2066F88((VecFx32 *)NNS_G3dGlbGetCameraPos(), &position, camPosUnknown);
    Unknown2066510__Func_20670F8(camUnknown, camPosUnknown, &work->aniModel.ani.work.translation);
}

void BossFX3D__State_CondorTackle(BossFX3D *work)
{
    NNSFndArchive arc;

    if ((work->aniModel.ani.animFlags[0] & ANIMATORMDL_FLAG_FINISHED) != 0)
    {
        NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

        AnimatorMDL__SetAnimation(&work->aniModel.ani, 0, NNS_FndGetArchiveFileByName("exc:bsef6_tackle.nsbca"), 1, NULL);
        AnimatorMDL__SetAnimation(&work->aniModel.ani, 1, NNS_FndGetArchiveFileByName("exc:bsef6_tackle.nsbma"), 1, NULL);
        AnimatorMDL__SetAnimation(&work->aniModel.ani, 4, NNS_FndGetArchiveFileByName("exc:bsef6_tackle.nsbva"), 1, NULL);

        NNS_FndUnmountArchive(&arc);
    }
}

// Boss 2D FX
BossFX2D *BossFX2D__Create(size_t size, BossFX2DState state, const char *path, u16 animID, BossFX3DFlags flags, s32 timer, fx32 x, fx32 y, fx32 z)
{
#ifdef RUSH_DEBUG
    Task *task = TaskCreate_(StageTask_Main, BossFX2D__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1A00, TASK_GROUP(4), size, path);
#else
    Task *task = TaskCreate_(StageTask_Main, BossFX2D__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1A00, TASK_GROUP(4), size);
#endif
    if (task == HeapNull)
        return NULL;

    BossFX2D *work = TaskGetWork(task, BossFX2D);
    MI_CpuClear16(work, size);

    work->state              = state;
    work->flags              = flags;
    work->objWork.userTimer  = timer;
    work->objWork.position.x = x;
    work->objWork.position.y = -y;
    work->objWork.position.z = z;
    work->objWork.scale.x    = FLOAT_TO_FX32(1.0);
    work->objWork.scale.y    = FLOAT_TO_FX32(1.0);
    work->objWork.scale.z    = FLOAT_TO_FX32(1.0);
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    SetTaskState(&work->objWork, BossFX2D__State_Active);

    if (timer > 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    work->objWork.gravityStrength  = FLOAT_TO_FX32(0.1640625);
    work->objWork.terminalVelocity = FLOAT_TO_FX32(15.0);

    ObjObjectAction3dBACLoad(&work->objWork, &work->aniSprite, path, OBJ_DATA_GFX_AUTO, OBJ_DATA_GFX_AUTO, NULL, gameArchiveStage);
    work->aniSprite.ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_33;
    work->aniSprite.ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P;
    AnimatorSprite__SetAnimation(&work->aniSprite.ani.animatorSprite, animID);

    return work;
}

NONMATCH_FUNC void BossFX2D__State_Active(BossFX2D *work)
{
    // https://decomp.me/scratch/TSCD2 -> 86%
#ifdef NON_MATCHING
    if ((work->flags & (BOSSFX2D_FLAG_INVISIBLE_ON_ENGINE_B | BOSSFX2D_FLAG_INVISIBLE_ON_ENGINE_A)) != 0 && Camera3D__GetTask() != NULL)
    {
        if ((work->flags & BOSSFX2D_FLAG_INVISIBLE_ON_ENGINE_A) != 0 && Camera3D__UseEngineA()
            || (work->flags & BOSSFX2D_FLAG_INVISIBLE_ON_ENGINE_B) != 0 && !Camera3D__UseEngineA())
        {
            work->objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;
        }
        else
        {
            work->objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
        }
    }

    if (work->state != NULL)
        work->state(work);

    if (work->objWork.userTimer == 0)
    {
        if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        {
            work->objWork.flag |= STAGE_TASK_FLAG_DESTROYED;
        }
    }
    else
    {
        if (work->objWork.userTimer > 0)
        {
            work->objWork.userTimer--;
            if (work->objWork.userTimer == 0)
                work->objWork.flag |= STAGE_TASK_FLAG_DESTROYED;
        }
    }
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x280]
	tst r0, #3
	beq _02154450
	bl Camera3D__GetTask
	cmp r0, #0
	beq _02154450
	ldr r0, [r4, #0x280]
	tst r0, #1
	beq _0215441C
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _02154434
_0215441C:
	ldr r0, [r4, #0x280]
	tst r0, #2
	beq _02154444
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _02154444
_02154434:
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x20
	str r0, [r4, #0x20]
	b _02154450
_02154444:
	ldr r0, [r4, #0x20]
	bic r0, r0, #0x20
	str r0, [r4, #0x20]
_02154450:
	ldr r1, [r4, #0x27c]
	cmp r1, #0
	beq _02154464
	mov r0, r4
	blx r1
_02154464:
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	bne _0215448C
	ldr r0, [r4, #0x20]
	tst r0, #8
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
_0215448C:
	ldmleia sp!, {r4, pc}
	subs r0, r0, #1
	str r0, [r4, #0x2c]
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void BossFX2D__Destructor(Task *task)
{
    BossFX2D *work = TaskGetWork(task, BossFX2D);
    StageTask_Destructor(task);
}