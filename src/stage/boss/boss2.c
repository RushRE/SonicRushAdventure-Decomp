#include <stage/boss/boss2.h>
#include <stage/boss/bossPlayerHelpers.h>
#include <stage/core/hud.h>
#include <stage/core/titleCard.h>
#include <stage/core/bgmManager.h>
#include <stage/core/ringManager.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/stage/bossArena.h>
#include <game/audio/spatialAudio.h>
#include <game/stage/mapFarSys.h>
#include <game/graphics/screenShake.h>
#include <game/graphics/drawFadeTask.h>
#include <game/graphics/background.h>
#include <game/object/objectManager.h>
#include <game/math/unknown2066510.h>

// resources
#include <resources/narc/z2boss_act_lz7.h>

// --------------------
// CONSTANTS
// --------------------

#define MTXSTACK_BOSS2_BODY_TOP    NNS_G3D_MTXSTACK_SYS
#define MTXSTACK_BOSS2_BODY_MID    NNS_G3D_MTXSTACK_USER
#define MTXSTACK_BOSS2_BODY_BOTTOM (NNS_G3D_MTXSTACK_USER - 1)
#define MTXSTACK_BOSS2_WEAK        (NNS_G3D_MTXSTACK_USER - 2)

#define MTXSTACK_BOSS2BALL_BALL_HIT NNS_G3D_MTXSTACK_SYS

#define MTXSTACK_BOSS2ARM_ARM_BALL NNS_G3D_MTXSTACK_SYS

// --------------------
// ENUMS
// --------------------

enum Boss2JointAniID
{
    bs2_body_fw0,
    bs2_arm_fw0,
    bs2_drop_fw0,
    bs2_balla_fw0,
    bs2_ballb_fw0,
    bs2_ballc_fw0,
    bs2_body_gura0,
    bs2_drop_gura0,
    bs2_body_gura1,
    bs2_drop_gura1,
    bs2_body_gura2,
    bs2_drop_gura2,
    bs2_body_gura3,
    bs2_drop_gura3,
    bs2_body_gura4,
    bs2_drop_gura4,
    bs2_body_gura5,
    bs2_drop_gura5,
    bs2_body_zako0,
    bs2_drop_zako0,
    bs2_body_zako1,
    bs2_drop_zako1,
    bs2_body_zako2,
    bs2_drop_zako2,
    bs2_body_dmg0,
    bs2_body_dmg1,
    bs2_body_down0,
    bs2_body_down1,
    bs2_body_down2,
    bs2_body_down3,
    bs2_body_down4,
    bs2_body_down5,
    bs2_body_down6,
    bs2_body_exp0,
    bs2_balla_ratk0,
    bs2_ballb_ratk0,
    bs2_ballc_ratk0,
    bs2_balla_ratk1,
    bs2_ballb_ratk1,
    bs2_ballc_ratk1,
    bs2_balla_pendf0,
    bs2_ballb_pendf0,
    bs2_ballc_pendf0,
    bs2_balla_pendf1,
    bs2_ballb_pendf1,
    bs2_ballc_pendf1,
    bs2_balla_pendb0,
    bs2_ballb_pendb0,
    bs2_ballc_pendb0,
    bs2_balla_pendb1,
    bs2_ballb_pendb1,
    bs2_ballc_pendb1,
    bs2_spka_0,
    bs2_spkb_0,
    bs2_spkc_0,
    bs2_spka_1,
    bs2_spkb_1,
    bs2_spkc_1,
    bs2_spka_2,
    bs2_spkb_2,
    bs2_spkc_2,
    bs2_spka_3,
    bs2_spkb_3,
    bs2_spkc_3,
};

// --------------------
// STRUCTS
// --------------------

struct Boss2BallConfig
{
    u16 spikeDuration;
    u16 vulnerableDuration;
};

struct Boss2UnknownConfig
{
    u16 value;
    u16 range;
};

// --------------------
// VARIABLES
// --------------------

static void (*Boss2__PlayerDrawFunc)(void);
static Task *Boss2Stage__Singleton;

static const fx16 Boss2__ballWeightTable_Normal[BOSS2_BALL_COUNT] = { 0x4000, 0x2999, 0x2000 };
static const s16 Boss2__healthPhaseTable[BOSS2_PHASE_COUNT - 1]   = { 0x3A0, 0x280, 0x140 };
static const fx16 Boss2__ballWeightTable_Heavy[BOSS2_BALL_COUNT]  = { 0x3000, 0x2000, 0x1800 };

static const fx32 Boss2__baseDamageTable[DIFFICULTY_COUNT] = { 0x1000, 0x1000 };

NOT_DECOMPILED const void *Boss2__ballNames;
NOT_DECOMPILED const void *Boss2__ballScales;
NOT_DECOMPILED const void *Boss2Stage__State2_215C938_camUp;
NOT_DECOMPILED const fx32 Boss2__hitFXScaleTable[BOSS2_BALL_COUNT];
NOT_DECOMPILED const void *Boss2Stage__State2_215CD08_camUp;
NOT_DECOMPILED const void *Boss2Ball__Func_215F490_offset;
NOT_DECOMPILED const void *Boss2__activeArmCountTable;
NOT_DECOMPILED const void *Boss2__ballHitboxes;
NOT_DECOMPILED const u16 Boss2__damageModifierTable[BOSS2_PHASE_COUNT][BOSS2_BALL_COUNT];
NOT_DECOMPILED const s16 Boss2__spinSpeeds[BOSS2_PHASE_COUNT][BOSS2_BALL_COUNT];
NOT_DECOMPILED const void *_02179D2C;
NOT_DECOMPILED const struct Boss2UnknownConfig Boss2__UnknownConfig1[DIFFICULTY_COUNT][BOSS2_PHASE_COUNT];
NOT_DECOMPILED const struct Boss2UnknownConfig Boss2__UnknownConfig2[DIFFICULTY_COUNT][BOSS2_PHASE_COUNT];
NOT_DECOMPILED const struct Boss2BallConfig Boss2__ballConfigTable[BOSS2_PHASE_COUNT][BOSS2_BALL_COUNT];

NOT_DECOMPILED const char *Boss2Ball__paletteNames[BOSS2_BALL_COUNT];
NOT_DECOMPILED const char *Boss2__paletteNames[8];

// --------------------
// FUNCTION DECLS
// --------------------

// --------------------
// INLINE FUNCTIONS
// --------------------

// --------------------
// FUNCTIONS
// --------------------

Boss2Stage *Boss2Stage__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
    NNSFndArchive arc;

    Boss2Stage__Singleton = CreateStageTask(Boss2Stage__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), Boss2Stage);

    Boss2Stage *work = TaskGetWork(Boss2Stage__Singleton, Boss2Stage);
    TaskInitWork16(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    SetTaskState(&work->gameWork.objWork, Boss2Stage__State_Active);
    SetTaskOutFunc(&work->gameWork.objWork, Boss2Stage__Draw);
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS
                                       | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    work->health   = 0x400;
    work->dword39C = -y;
    work->state2   = Boss2Stage__State2_215C938;

    Boss2__LoadAssets(&work->assets);

    BossHelpers__InitLights(&work->lightConfig);
    BossHelpers__Model__InitSystem();

    AnimatorMDL *aniStage00 = &work->aniStage[0];
    AnimatorMDL__Init(aniStage00, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniStage00, bossAssetFiles[6].fileData, 0, FALSE, FALSE);
    aniStage00->work.translation.x = FLOAT_TO_FX32(0.0);
    aniStage00->work.translation.y = -y;
    aniStage00->work.translation.z = FLOAT_TO_FX32(0.0);
    aniStage00->work.scale.x       = FLOAT_TO_FX32(3.3);
    aniStage00->work.scale.y       = FLOAT_TO_FX32(3.3);
    aniStage00->work.scale.z       = FLOAT_TO_FX32(3.3);

    AnimatorMDL *aniStage01 = &work->aniStage[1];
    AnimatorMDL__Init(aniStage01, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniStage01, bossAssetFiles[7].fileData, 0, FALSE, FALSE);
    aniStage01->work.translation = aniStage00->work.translation;
    aniStage01->work.scale       = aniStage00->work.scale;

    work->boss        = SpawnStageObject(MAPOBJECT_278, x, y, Boss2);
    work->boss->stage = work;

    work->drop        = SpawnStageObject(MAPOBJECT_280, x, y, Boss2Drop);
    work->drop->stage = work;

    for (s32 i = 0; i < BOSS2_BALL_COUNT; i++)
    {
        work->arms[i]        = SpawnStageObjectParam(MAPOBJECT_279, x, y, Boss2Arm, i);
        work->arms[i]->stage = work;

        work->balls[i]        = SpawnStageObjectParam(MAPOBJECT_281, x, y, Boss2Ball, i);
        work->balls[i]->stage = work;
    }

    s16 angleDir;
    if (mtMathRandRepeat(2) != 0)
        angleDir = -1;
    else
        angleDir = 1;
    Boss2Arm__Func_215EBF0(work->arms[0], 0, angleDir);
    Boss2Ball__Func_215F944(work->balls[0]);
    Boss2Ball__Func_216009C(&work->balls[0]->spikeWorker);

    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);
    NNS_G3dResDefaultSetup(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z2BOSS_ACT_LZ7_FILE_BSEF2_WAVE_NSBMD));
    NNS_FndUnmountArchive(&arc);

    InitSpatialAudioConfig();

    renderCoreSwapBuffer.sortMode = GX_SORTMODE_MANUAL;

    return work;
}

Boss2 *Boss2__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
    NNSFndArchive arc;

    Task *task = CreateStageTask(Boss2__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), Boss2);

    Boss2 *work = TaskGetWork(task, Boss2);
    TaskInitWork16(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, FLOAT_TO_FX32(0.0), y - FLOAT_TO_FX32(585.0));

    SetTaskState(&work->gameWork.objWork, Boss2__State_Active);
    SetTaskOutFunc(&work->gameWork.objWork, Boss2__Draw);
    SetTaskCollideFunc(&work->gameWork.objWork, Boss2__Collide);
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    work->activeArmCount = 0;
    work->bodyHeightA    = FLOAT_TO_FX32(11.75);
    work->bodyHeightB    = FLOAT_TO_FX32(11.75);
    work->angle          = FLOAT_DEG_TO_IDX(69.08203125);

    Boss2__LoadAssets(&work->assets);

    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NORMAL, OBS_RECT_DEFPOWER_DEFAULT);
    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, -8, -8, 8, 8);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], Boss2__OnDefend);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;

    AnimatorMDL *aniBody = &work->aniBody;
    AnimatorMDL__Init(aniBody, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniBody, bossAssetFiles[0].fileData, 0, FALSE, FALSE);
    aniBody->work.scale.x        = FLOAT_TO_FX32(3.3);
    aniBody->work.scale.y        = FLOAT_TO_FX32(3.3);
    aniBody->work.scale.z        = FLOAT_TO_FX32(3.3);
    aniBody->work.matrixOpIDs[0] = MATRIX_OP_FLUSH_VP;

    NNS_G3dRenderObjSetCallBack(&aniBody->renderObj, BossHelpers__Model__RenderCallback, NULL, NNS_G3D_SBC_NODEDESC, NNS_G3D_SBC_CALLBACK_TIMING_C);
    BossHelpers__Model__Init(aniBody->renderObj.resMdl, "body", MTXSTACK_BOSS2_BODY_TOP, NULL, NULL);
    BossHelpers__Model__Init(aniBody->renderObj.resMdl, "body_a", MTXSTACK_BOSS2_BODY_MID, Boss2__BodyACallback, work);
    BossHelpers__Model__Init(aniBody->renderObj.resMdl, "body_b", MTXSTACK_BOSS2_BODY_BOTTOM, Boss2__BodyBCallback, work);
    BossHelpers__Model__Init(aniBody->renderObj.resMdl, "weak", MTXSTACK_BOSS2_WEAK, NULL, NULL);

    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);
    for (s32 i = 0; i < (s32)ARRAY_COUNT(work->aniPalette); i++)
    {
        InitPaletteAnimator(&work->aniPalette[i], NNS_FndGetArchiveFileByIndex(&arc, i + ARCHIVE_Z2BOSS_ACT_LZ7_FILE_BOSS2_EYE_BPA), 0, ANIMATORBPA_FLAG_NONE, 5,
                            VRAMKEY_TO_ADDR(Asset3DSetup__PaletteFromName(NNS_G3dGetTex(bossAssetFiles[0].fileData), Boss2__paletteNames[i])));
    }
    BossHelpers__SetPaletteAnimations(work->aniPalette, (s32)ARRAY_COUNT(work->aniPalette), 0, FALSE);
    NNS_FndUnmountArchive(&arc);

    Boss2__SetupObject(work);

    return work;
}

Boss2Arm *Boss2Arm__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
    Task *task = CreateStageTask(Boss2Arm__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), Boss2Arm);

    Boss2Arm *work = TaskGetWork(task, Boss2Arm);
    TaskInitWork16(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    SetTaskState(&work->gameWork.objWork, Boss2Arm__State_Active);
    SetTaskOutFunc(&work->gameWork.objWork, Boss2Arm__Draw);

    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    work->type             = type;
    work->word3C6          = 1024;
    work->targetAngleSpeed = Boss2__spinSpeeds[BOSS2_PHASE_1][type];

    Boss2__LoadAssets(&work->assets);

    AnimatorMDL *aniArm = &work->animator;
    AnimatorMDL__Init(aniArm, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniArm, bossAssetFiles[1].fileData, 0, FALSE, FALSE);
    aniArm->work.translation.x  = FLOAT_TO_FX32(0.0);
    aniArm->work.translation.y  = FLOAT_TO_FX32(0.0);
    aniArm->work.translation.z  = FLOAT_TO_FX32(0.0);
    aniArm->work.scale.x        = FLOAT_TO_FX32(3.3);
    aniArm->work.scale.y        = FLOAT_TO_FX32(3.3);
    aniArm->work.scale.z        = FLOAT_TO_FX32(3.3);
    aniArm->work.matrixOpIDs[0] = MATRIX_OP_FLUSH_VP;
    NNS_G3dRenderObjSetCallBack(&aniArm->renderObj, BossHelpers__Model__RenderCallback, NULL, NNS_G3D_SBC_NODEDESC, NNS_G3D_SBC_CALLBACK_TIMING_C);
    BossHelpers__Model__Init(aniArm->renderObj.resMdl, "arm_ball", MTXSTACK_BOSS2ARM_ARM_BALL, NULL, NULL);

    Boss2Arm__SetupObject(work);

    return work;
}

Boss2Drop *Boss2Drop__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
    Task *task = CreateStageTask(Boss2Drop__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), Boss2Drop);

    Boss2Drop *work = TaskGetWork(task, Boss2Drop);
    TaskInitWork16(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.terminalVelocity = FLOAT_TO_FX32(64.0);

    SetTaskState(&work->gameWork.objWork, Boss2Drop__State_Active);
    SetTaskOutFunc(&work->gameWork.objWork, Boss2Drop__Draw);
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    Boss2__LoadAssets(&work->assets);

    AnimatorMDL *aniDrop = &work->aniDrop;
    AnimatorMDL__Init(aniDrop, ANIMATORMDL_FLAG_NONE);
    AnimatorMDL__SetResource(&work->aniDrop, bossAssetFiles[2].fileData, 0, FALSE, FALSE);
    aniDrop->work.translation.x = FLOAT_TO_FX32(0.0);
    aniDrop->work.translation.y = FLOAT_TO_FX32(0.0);
    aniDrop->work.translation.z = FLOAT_TO_FX32(0.0);
    aniDrop->work.scale.x       = FLOAT_TO_FX32(3.3);
    aniDrop->work.scale.y       = FLOAT_TO_FX32(3.3);
    aniDrop->work.scale.z       = FLOAT_TO_FX32(3.3);

    Boss2Drop__SetupObject(work);

    return work;
}

NONMATCH_FUNC Boss2Ball *Boss2Ball__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
#ifdef NON_MATCHING
    NNSFndArchive arc;

    Task *task = CreateStageTask(Boss2Ball__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), Boss2Ball);

    Boss2Ball *work = TaskGetWork(task, Boss2Ball);
    TaskInitWork16(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    SetTaskState(&work->gameWork.objWork, Boss2Ball__State_Active);
    SetTaskOutFunc(&work->gameWork.objWork, Boss2Ball__Draw);
    SetTaskCollideFunc(&work->gameWork.objWork, Boss2Ball__Collide);
    work->gameWork.objWork.flag |= STAGE_TASK_MOVE_FLAG_IN_AIR;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS
                                       | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    work->sndHandle          = AllocSndHandle();
    work->type               = type;
    work->spikeWorker.type   = 3;
    work->spikeWorker.state3 = Boss2Ball__StateSpikes_2160354;

    Boss2Ball__DisableSpikes(&work->spikeWorker);

    Boss2__LoadAssets(&work->assets);

    const HitboxRect ballHitboxes[BOSS2_BALL_COUNT] = {
        { -16, -16, 16, 16 },
        { -24, -24, 24, 24 },
        { -32, -32, 32, 32 },
    };
    const HitboxRect *curHitbox = &ballHitboxes[type];

    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NORMAL, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, curHitbox->left, curHitbox->top, curHitbox->right, curHitbox->bottom);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], Boss2Ball__OnDefend);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_DISABLE_DEF_RESPONSE;
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;

    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_WORK_ATTR_NORMAL, OBS_RECT_HITPOWER_DEFAULT);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_DEFPOWER_DEFAULT);
    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect, curHitbox->left, curHitbox->top, curHitbox->right, curHitbox->bottom);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = &work->gameWork.objWork;
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;

    AnimatorMDL *aniBall = &work->aniBall;
    AnimatorMDL__Init(aniBall, ANIMATORMDL_FLAG_NONE);
    AnimatorMDL__SetResource(&work->aniBall, bossAssetFiles[3].fileData, type, FALSE, FALSE);
    aniBall->work.translation.x = FLOAT_TO_FX32(0.0);
    aniBall->work.translation.y = FLOAT_TO_FX32(0.0);
    aniBall->work.translation.z = FLOAT_TO_FX32(0.0);
    aniBall->work.scale.x       = FLOAT_TO_FX32(3.3);
    aniBall->work.scale.y       = FLOAT_TO_FX32(3.3);
    aniBall->work.scale.z       = FLOAT_TO_FX32(3.3);

    const char *ballNames[BOSS2_BALL_COUNT] = {
        "ball_a_hit",
        "ball_b_hit",
        "ball_c_hit",
    };
    aniBall->work.matrixOpIDs[0] = MATRIX_OP_FLUSH_VP;
    NNS_G3dRenderObjSetCallBack(&aniBall->renderObj, BossHelpers__Model__RenderCallback, NULL, NNS_G3D_SBC_NODEDESC, NNS_G3D_SBC_CALLBACK_TIMING_C);
    BossHelpers__Model__Init(aniBall->renderObj.resMdl, ballNames[type], MTXSTACK_BOSS2BALL_BALL_HIT, NULL, NULL);

    AnimatorMDL *aniSpike = &work->spikeWorker.aniSpike;
    AnimatorMDL__Init(aniSpike, ANIMATORMDL_FLAG_NONE);
    AnimatorMDL__SetResource(aniSpike, bossAssetFiles[4].fileData, type, FALSE, FALSE);
    aniSpike->work.translation.x = FLOAT_TO_FX32(0.0);
    aniSpike->work.translation.y = FLOAT_TO_FX32(0.0);
    aniSpike->work.translation.z = FLOAT_TO_FX32(0.0);
    aniSpike->work.scale.x       = FLOAT_TO_FX32(1.0);
    aniSpike->work.scale.y       = FLOAT_TO_FX32(1.0);
    aniSpike->work.scale.z       = FLOAT_TO_FX32(1.0);

    const fx32 ballScale[BOSS2_BALL_COUNT] = {
        0x1A660,
        0x2E328,
        0x41FF0,
    };

    AnimatorMDL *aniBallD = &work->aniBallD;
    AnimatorMDL__Init(aniBallD, ANIMATORMDL_FLAG_NONE);
    AnimatorMDL__SetResource(aniBallD, bossAssetFiles[3].fileData, 3, FALSE, FALSE);
    aniBallD->work.translation.x = FLOAT_TO_FX32(0.0);
    aniBallD->work.translation.y = FLOAT_TO_FX32(0.0);
    aniBallD->work.translation.z = FLOAT_TO_FX32(0.0);
    aniBallD->work.scale.x       = ballScale[type];
    aniBallD->work.scale.y       = 0x149FB0;
    aniBallD->work.scale.z       = ballScale[type];

    AnimatorMDL *aniBallM = &work->aniBallM;
    AnimatorMDL__Init(aniBallM, ANIMATORMDL_FLAG_NONE);
    AnimatorMDL__SetResource(aniBallM, bossAssetFiles[3].fileData, 4, FALSE, FALSE);
    work->aniBallM.work.matrixOpIDs[0] = MATRIX_OP_NONE;
    work->aniBallM.work.translation.x  = FLOAT_TO_FX32(0.0);
    work->aniBallM.work.translation.y  = FLOAT_TO_FX32(0.0);
    work->aniBallM.work.translation.z  = FLOAT_TO_FX32(0.0);
    work->aniBallM.work.scale.x        = ballScale[type];
    work->aniBallM.work.scale.y        = 0x149FB0;
    work->aniBallM.work.scale.z        = ballScale[type];

    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);
    InitPaletteAnimator(&work->aniPalette, NNS_FndGetArchiveFileByIndex(&arc, type + ARCHIVE_Z2BOSS_ACT_LZ7_FILE_BOSS2_BALL_A_BPA), 0, ANIMATORBPA_FLAG_CAN_LOOP, 5,
                        VRAMKEY_TO_ADDR(Asset3DSetup__PaletteFromName(NNS_G3dGetTex(bossAssetFiles[3].fileData), Boss2Ball__paletteNames[type])));
    BossHelpers__SetPaletteAnimations(&work->aniPalette, 1, 0, FALSE);
    NNS_FndUnmountArchive(&arc);

    Boss2Ball__SetupObject(work);

    return work;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xa4
	mov r6, #0x1500
	mov r7, r0
	str r6, [sp]
	mov r0, #2
	mov r5, r1
	mov r4, r2
	str r0, [sp, #4]
	ldr r6, =0x00000988
	ldr r0, =StageTask_Main
	ldr r1, =Boss2Ball__Destructor
	mov r2, #0
	mov r8, r3
	mov r3, r2
	str r6, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r6, r0
	ldr r2, =0x00000988
	mov r0, #0
	mov r1, r6
	bl MIi_CpuClear16
	mov r1, r7
	mov r2, r5
	mov r3, r4
	mov r0, r6
	bl GameObject__InitFromObject
	ldr r1, =Boss2Ball__State_Active
	ldr r0, =Boss2Ball__Draw
	str r1, [r6, #0xf4]
	str r0, [r6, #0xfc]
	ldr r0, =Boss2Ball__Collide
	str r0, [r6, #0x108]
	ldr r0, [r6, #0x18]
	orr r0, r0, #0x10
	str r0, [r6, #0x18]
	ldr r0, [r6, #0x1c]
	orr r0, r0, #0xa300
	str r0, [r6, #0x1c]
	bl AllocSndHandle
	str r0, [r6, #0x984]
	str r8, [r6, #0x37c]
	mov r0, #3
	str r0, [r6, #0x384]
	ldr r1, =Boss2Ball__StateSpikes_2160354
	add r0, r6, #0x380
	str r1, [r6, #0x380]
	bl Boss2Ball__DisableSpikes
	add r0, r6, #0x364
	bl Boss2__LoadAssets
	ldr r4, =Boss2__ballHitboxes
	add r3, sp, #0x24
	mov r2, #6
_0215B838:
	ldrh r1, [r4, #0]
	ldrh r0, [r4, #2]
	add r4, r4, #4
	strh r1, [r3]
	strh r0, [r3, #2]
	add r3, r3, #4
	subs r2, r2, #1
	bne _0215B838
	add r5, sp, #0x24
	add r0, r6, #0x218
	mov r1, #2
	mov r2, #0
	mov r4, r8, lsl #3
	add r7, r5, r8, lsl #3
	bl ObjRect__SetAttackStat
	mov r1, #0
	mov r2, r1
	add r0, r6, #0x218
	bl ObjRect__SetDefenceStat
	ldrsh r1, [r7, #6]
	add r0, r6, #0x218
	str r1, [sp]
	ldrsh r1, [r5, r4]
	ldrsh r2, [r7, #2]
	ldrsh r3, [r7, #4]
	bl ObjRect__SetBox2D
	ldr r1, =Boss2Ball__OnDefend
	str r6, [r6, #0x234]
	str r1, [r6, #0x23c]
	ldr r2, [r6, #0x230]
	add r0, r6, #0x258
	orr r2, r2, #0x80
	bic r2, r2, #4
	str r2, [r6, #0x230]
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	add r0, r6, #0x258
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldrsh r1, [r7, #6]
	add r0, r6, #0x258
	str r1, [sp]
	ldrsh r1, [r5, r4]
	ldrsh r2, [r7, #2]
	ldrsh r3, [r7, #4]
	bl ObjRect__SetBox2D
	str r6, [r6, #0x274]
	ldr r0, [r6, #0x270]
	add r4, r6, #0x1b8
	bic r0, r0, #4
	str r0, [r6, #0x270]
	add r0, r4, #0x400
	mov r1, #0
	bl AnimatorMDL__Init
	mov r3, #0
	ldr r1, =bossAssetFiles
	str r3, [sp]
	ldr r1, [r1, #0x18]
	add r0, r4, #0x400
	mov r2, r8
	bl AnimatorMDL__SetResource
	mov r5, #0
	str r5, [r4, #0x448]
	str r5, [r4, #0x44c]
	ldr r0, =0x000034CC
	str r5, [r4, #0x450]
	str r0, [r4, #0x418]
	str r0, [r4, #0x41c]
	str r0, [r4, #0x420]
	ldr r0, =Boss2__ballNames
	add r3, sp, #0x18
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #4
	mov r2, r5
	strb r0, [r4, #0x40a]
	mov r5, #3
	ldr r1, =BossHelpers__Model__RenderCallback
	add r0, r4, #0x490
	mov r3, #6
	str r5, [sp]
	bl NNS_G3dRenderObjSetCallBack
	mov r3, #0
	str r3, [sp]
	add r1, sp, #0x18
	ldr r0, [r4, #0x494]
	ldr r1, [r1, r8, lsl #2]
	mov r2, #0x1e
	bl BossHelpers__Model__Init
	add r0, r6, #0x394
	mov r1, #0
	bl AnimatorMDL__Init
	mov r3, #0
	ldr r1, =bossAssetFiles
	str r3, [sp]
	ldr r1, [r1, #0x20]
	add r0, r6, #0x394
	mov r2, r8
	bl AnimatorMDL__SetResource
	mov r4, #0
	str r4, [r6, #0x3dc]
	str r4, [r6, #0x3e0]
	str r4, [r6, #0x3e4]
	mov r0, #0x1000
	str r0, [r6, #0x3ac]
	str r0, [r6, #0x3b0]
	str r0, [r6, #0x3b4]
	ldr r0, =Boss2__ballScales
	add r3, sp, #0xc
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r5, r6, #0x2fc
	mov r1, r4
	add r0, r5, #0x400
	bl AnimatorMDL__Init
	mov r3, r4
	ldr r1, =bossAssetFiles
	str r3, [sp]
	ldr r1, [r1, #0x18]
	add r0, r5, #0x400
	mov r2, #3
	bl AnimatorMDL__SetResource
	mov r1, r4
	str r1, [r5, #0x448]
	str r1, [r5, #0x44c]
	str r1, [r5, #0x450]
	add r0, sp, #0xc
	ldr r4, [r0, r8, lsl #2]
	ldr r2, =0x00149FB0
	str r4, [r5, #0x418]
	str r2, [r5, #0x41c]
	add r0, r6, #0x840
	str r4, [r5, #0x420]
	bl AnimatorMDL__Init
	mov r3, #0
	ldr r1, =bossAssetFiles
	str r3, [sp]
	ldr r1, [r1, #0x18]
	add r0, r6, #0x840
	mov r2, #4
	bl AnimatorMDL__SetResource
	mov r0, #0
	strb r0, [r6, #0x84a]
	str r0, [r6, #0x888]
	str r0, [r6, #0x88c]
	str r0, [r6, #0x890]
	ldr r0, =0x00149FB0
	str r4, [r6, #0x858]
	str r0, [r6, #0x85c]
	ldr r0, =gameArchiveStage
	str r4, [r6, #0x860]
	ldr r2, [r0, #0]
	ldr r1, =0x0217A7FC // =aExec
	add r0, sp, #0x3c
	bl NNS_FndMountArchive
	add r0, sp, #0x3c
	add r1, r8, #9
	bl NNS_FndGetArchiveFileByIndex
	ldr r1, =bossAssetFiles
	mov r4, r0
	ldr r0, [r1, #0x18]
	bl NNS_G3dGetTex
	ldr r1, =Boss2Ball__paletteNames
	ldr r1, [r1, r8, lsl #2]
	bl Asset3DSetup__PaletteFromName
	mov r2, #5
	str r2, [sp]
	str r0, [sp, #4]
	add r0, r6, #0x198
	mov r1, r4
	add r0, r0, #0x400
	mov r2, #0
	mov r3, #2
	bl InitPaletteAnimator
	add r0, r6, #0x198
	mov r2, #0
	add r0, r0, #0x400
	mov r1, #1
	mov r3, r2
	bl BossHelpers__SetPaletteAnimations
	add r0, sp, #0x3c
	bl NNS_FndUnmountArchive
	mov r0, r6
	bl Boss2Ball__SetupObject
	mov r0, r6
	add sp, sp, #0xa4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

Boss2Bomb *Boss2Bomb__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
    Task *task = CreateStageTask(Boss2Bomb__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), Boss2Bomb);

    Boss2Bomb *work = TaskGetWork(task, Boss2Bomb);
    TaskInitWork16(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.terminalVelocity = FLOAT_TO_FX32(64.0);

    SetTaskState(&work->gameWork.objWork, Boss2Bomb__State_Active);
    SetTaskOutFunc(&work->gameWork.objWork, Boss2Bomb__Draw);
    SetTaskCollideFunc(&work->gameWork.objWork, Boss2Bomb__Collide);
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

    Boss2__LoadAssets(&work->assets);

    StageTask__SetHitbox(&work->gameWork.objWork, -8, -20, 8, 0);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], 2, 64);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], 1, 64);
    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, -15, -24, 15, 0);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], Boss2Bomb__OnDefend_21606DC);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;

    AnimatorMDL *aniBomb = &work->aniBomb;
    AnimatorMDL__Init(aniBomb, ANIMATORMDL_FLAG_NONE);
    AnimatorMDL__SetResource(aniBomb, bossAssetFiles[5].fileData, 0, FALSE, FALSE);
    aniBomb->work.scale.x = FLOAT_TO_FX32(3.3);
    aniBomb->work.scale.y = FLOAT_TO_FX32(3.3);
    aniBomb->work.scale.z = FLOAT_TO_FX32(3.3);

    Boss2Bomb__SetupObject(work);

    return work;
}

Boss2Wave *Boss2Wave__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
    NNSFndArchive arc;

    Task *task = CreateStageTask(Boss2Wave__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), Boss2Wave);

    Boss2Wave *work = TaskGetWork(task, Boss2Wave);
    TaskInitWork16(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.terminalVelocity = FLOAT_TO_FX32(64.0);

    SetTaskState(&work->gameWork.objWork, Boss2Wave__State_Active);
    SetTaskOutFunc(&work->gameWork.objWork, Boss2Wave__Draw);

    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);

    AnimatorMDL *aniWave = &work->aniWave;
    AnimatorMDL__Init(aniWave, ANIMATORMDL_FLAG_NONE);
    AnimatorMDL__SetResource(aniWave, NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z2BOSS_ACT_LZ7_FILE_BSEF2_WAVE_NSBMD), 0, FALSE, FALSE);
    AnimatorMDL__SetAnimation(aniWave, B3D_ANIM_JOINT_ANIM, NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z2BOSS_ACT_LZ7_FILE_BSEF2_WAVE_NSBCA), 0, NULL);
    AnimatorMDL__SetAnimation(aniWave, B3D_ANIM_MAT_ANIM, NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z2BOSS_ACT_LZ7_FILE_BSEF2_WAVE_NSBMA), 0, NULL);
    AnimatorMDL__SetAnimation(aniWave, B3D_ANIM_VIS_ANIM, NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z2BOSS_ACT_LZ7_FILE_BSEF2_WAVE_NSBVA), 0, NULL);
    aniWave->work.translation.y = -y;
    aniWave->work.scale.x       = FLOAT_TO_FX32(3.3);
    aniWave->work.scale.y       = FLOAT_TO_FX32(3.3);
    aniWave->work.scale.z       = FLOAT_TO_FX32(3.3);
    aniWave->speedMultiplier    = FLOAT_TO_FX32(0.4);
    NNS_FndUnmountArchive(&arc);

    return work;
}

void Boss2__DrawPlayer(void)
{
    Player *work = TaskGetWorkCurrent(Player);

    if ((work->objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        BossHelpers__Arena__GetPlayerDrawMtx(work, BOSS2_STAGE_START, BOSS2_STAGE_END, BOSS2_STAGE_RADIUS);
        Boss2__PlayerDrawFunc();
    }
}

void Boss2__LoadAssets(Boss2Assets *assets)
{
    NNSFndArchive arc;

    assets->background = MapFarSys__GetAsset();

    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);
    assets->jointAnims = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z2BOSS_ACT_LZ7_FILE_BOSS2_NSBCA);
    assets->visAnims   = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z2BOSS_ACT_LZ7_FILE_BOSS2_NSBVA);
    NNS_FndUnmountArchive(&arc);
}

Boss2Phase Boss2__GetBossPhase(Boss2Stage *work)
{
    s16 health = work->health;

    Boss2Phase p = BOSS2_PHASE_1;
    for (; p < BOSS2_PHASE_COUNT - 1; p++)
    {
        if (Boss2__healthPhaseTable[p] < health)
            break;
    }

    return p;
}

fx32 Boss2Stage__GetBaseDamageValue(Boss2Stage *work, s32 ballType)
{
    UNUSED(work);
    UNUSED(ballType);

    return Boss2__baseDamageTable[gameState.difficulty];
}

fx32 Boss2Stage__GetDamageModifier(Boss2Stage *work, s32 ballType)
{
    return Boss2__damageModifierTable[Boss2__GetBossPhase(work)][ballType];
}

u16 Boss2Stage__GetImpactDamage(Boss2Stage *work, s32 ballType)
{
    return FX32_TO_WHOLE(Boss2Stage__GetBaseDamageValue(work, ballType) * Boss2Stage__GetDamageModifier(work, ballType));
}

fx32 Boss2__GetHitFXScale(Boss2Stage *work, s32 ballType)
{
    return Boss2__hitFXScaleTable[ballType];
}

s16 Boss2__GetBallSpinSpeed(Boss2Stage *work, s32 ballType)
{
    if (gmCheckMissionType(MISSION_TYPE_BOSS_REMATCH))
    {
        return Boss2__spinSpeeds[BOSS2_PHASE_4][ballType];
    }
    else
    {
        return Boss2__spinSpeeds[Boss2__GetBossPhase(work)][ballType];
    }
}

fx16 Boss2Stage__GetBallWeight(Boss2Stage *work, s32 ballType)
{
    if (gmCheckMissionType(MISSION_TYPE_BOSS_REMATCH))
    {
        return Boss2__ballWeightTable_Heavy[ballType];
    }
    else
    {
        return Boss2__ballWeightTable_Normal[ballType];
    }
}

void Boss2Stage__GetBallConfig(Boss2Stage *work, s32 ballType, u16 *spikeDuration, u16 *vulnerableDuration)
{
    const struct Boss2BallConfig *config;

    if (gmCheckMissionType(MISSION_TYPE_BOSS_REMATCH))
    {
        config = &Boss2__ballConfigTable[BOSS2_PHASE_4][ballType];
    }
    else
    {
        config = &Boss2__ballConfigTable[Boss2__GetBossPhase(work)][ballType];
    }

    *spikeDuration      = config->spikeDuration;
    *vulnerableDuration = config->vulnerableDuration;
}

u16 Boss2__Func_215C104(Boss2Stage *work)
{
    const struct Boss2UnknownConfig *config;

    if (gmCheckMissionType(MISSION_TYPE_BOSS_REMATCH))
    {
        config = &Boss2__UnknownConfig1[gameState.difficulty][BOSS2_PHASE_4];
    }
    else
    {
        config = &Boss2__UnknownConfig1[gameState.difficulty][Boss2__GetBossPhase(work)];
    }

    return config->value + (mtMathRand() & config->range);
}

u16 Boss2__Func_215C19C(Boss2Stage *work)
{
    const struct Boss2UnknownConfig *config;

    Boss2Phase phase = Boss2__GetBossPhase(work);
    UNUSED(phase);

    if (gmCheckMissionType(MISSION_TYPE_BOSS_REMATCH))
    {
        config = &Boss2__UnknownConfig2[gameState.difficulty][BOSS2_PHASE_4];
    }
    else
    {
        config = &Boss2__UnknownConfig2[gameState.difficulty][Boss2__GetBossPhase(work)];
    }

    return config->value + (mtMathRand() & config->range);
}

void Boss2__Func_215C240(Boss2Stage *work)
{
    if (work->boss->field_3C8 == 0)
        work->boss->field_3C8 = Boss2__Func_215C104(work);

    if (work->boss->field_3CA == 0)
        work->boss->field_3CA = Boss2__Func_215C19C(work);

    for (s32 i = 0; i < BOSS2_BALL_COUNT; i++)
    {
        work->arms[i]->targetAngleSpeed = Boss2__GetBallSpinSpeed(work, work->arms[i]->type);
    }
}

void Boss2Stage__Func_215C2CC(Boss2Stage *work)
{
    VecFx32 cam1Target0, cam1Target1, cam1Up;
    VecFx32 cam2Target0, cam2Target1, cam2Up;

    VecFx32 camPos;
    VecFx32 camTarget;

    Boss2Ball *balls[3];

    BossArena__SetAngleTarget(BossArena__GetCamera(0), BossHelpers__Arena__GetAngle(gPlayer->objWork.position.x, BOSS2_STAGE_START, BOSS2_STAGE_END));

    Camera3D *cameraConfig = BossArena__GetCameraConfig2(BossArena__GetCamera(0));
    u16 ballCount          = Boss2Stage__Func_215C6E0(work, balls);

    if (ballCount)
    {
        camTarget.x = FLOAT_TO_FX32(0.0);
        camTarget.y = FLOAT_TO_FX32(0.0);
        camTarget.z = FLOAT_TO_FX32(0.0);

        for (u16 i = 0; i < ballCount; i++)
        {
            Boss2Ball *ball = balls[i];

            camTarget.x += ball->mtxBallCenter.m[3][0];
            camTarget.y += ball->mtxBallCenter.m[3][1];
            camTarget.z += ball->mtxBallCenter.m[3][2];
        }

        camTarget.x = FX_DivS32(camTarget.x, ballCount);
        camTarget.y = FX_DivS32(camTarget.y, ballCount);
        camTarget.z = FX_DivS32(camTarget.z, ballCount);

        camTarget.x = cameraConfig->camTarget.x + MultiplyFX(FLOAT_TO_FX32(0.3), camTarget.x - cameraConfig->camTarget.x);
        camTarget.y = cameraConfig->camTarget.y + MultiplyFX(FLOAT_TO_FX32(0.05), camTarget.y - cameraConfig->camTarget.y);
        camTarget.z = cameraConfig->camTarget.z + MultiplyFX(FLOAT_TO_FX32(0.3), camTarget.z - cameraConfig->camTarget.z);

        VecFx32 camConfigLocalPos;
        VecFx32 camLocalPos;
        VecFx32 camDir;
        VecFx32 distance;
        VEC_Subtract(&cameraConfig->camTarget, &cameraConfig->camPos, &camConfigLocalPos);
        VEC_Subtract(&camTarget, &cameraConfig->camPos, &camLocalPos);
        VEC_Normalize(&camLocalPos, &camDir);
        VEC_Subtract(&camLocalPos, &camConfigLocalPos, &distance);

        fx32 magnitude = MultiplyFX(FLOAT_TO_FX32(0.3), VEC_Mag(&distance));
        camPos.x       = camTarget.x - camLocalPos.x - MultiplyFX(camDir.x, magnitude);
        camPos.y       = camTarget.y;
        camPos.z       = camTarget.z - camLocalPos.z - MultiplyFX(camDir.z, magnitude);
    }
    else
    {
        camPos    = cameraConfig->camPos;
        camTarget = cameraConfig->camTarget;
    }

    BossArena__Func_2039AD4(&camPos, &camTarget, &cameraConfig->camUp, 0x15E000, FLOAT_TO_FX32(1.3333), &cam1Target0, &cam1Target1, &cam1Up, &cam2Target0, &cam2Target1, &cam2Up);
    Boss2Stage__Func_215C5F8(work, &cam1Target0, &cam1Target1, &cam1Up);
    Boss2Stage__Func_215C66C(work, &cam2Target0, &cam2Target1, &cam2Up);
}

void Boss2Stage__Func_215C5F8(Boss2Stage *work, VecFx32 *target0, VecFx32 *target1, VecFx32 *up)
{
    BossArenaCamera *camera = BossArena__GetCamera(1);

    BossArena__SetCameraType(camera, BOSSARENACAMERA_TYPE_0);
    BossArena__SetUpVector(camera, up);
    BossArena__SetTracker1TargetPos(camera, target1->x, target1->y, target1->z);
    BossArena__SetTracker0TargetPos(camera, target0->x, target0->y, target0->z);
    BossArena__SetTracker1Speed(camera, FLOAT_TO_FX32(0.1), FLOAT_TO_FX32(0.3));
    BossArena__SetTracker0Speed(camera, FLOAT_TO_FX32(0.1), FLOAT_TO_FX32(0.3));
}

void Boss2Stage__Func_215C66C(Boss2Stage *work, VecFx32 *target0, VecFx32 *target1, VecFx32 *up)
{
    BossArenaCamera *camera = BossArena__GetCamera(2);

    BossArena__SetCameraType(camera, BOSSARENACAMERA_TYPE_0);
    BossArena__SetUpVector(camera, up);
    BossArena__SetTracker1TargetPos(camera, target1->x, target1->y, target1->z);
    BossArena__SetTracker0TargetPos(camera, target0->x, target0->y, target0->z);
    BossArena__SetTracker1Speed(camera, FLOAT_TO_FX32(0.1), FLOAT_TO_FX32(0.3));
    BossArena__SetTracker0Speed(camera, FLOAT_TO_FX32(0.1), FLOAT_TO_FX32(0.3));
}

u16 Boss2Stage__Func_215C6E0(Boss2Stage *work, Boss2Ball **balls)
{
    s32 i;
    u16 count = 0;

    for (i = 0; i < 3; i++)
    {
        Boss2Ball *ball = work->balls[i];
        if (ball->field_378 == 2 && ball->angleAccel > 0x6000)
        {
            balls[count] = ball;
            count++;
        }
    }

    return count;
}

void Boss2Stage__HandleBossCamera(Boss2Stage *work)
{
    MtxFx43 mtxView;

    Camera3D *config = BossArena__GetCameraConfig2(BossArena__GetCamera(1));

    MTX_LookAt(&config->camPos, &config->camUp, &config->camTarget, &mtxView);
    InitSpatialAudioMatrix((MtxFx33 *)&mtxView);
    SetSpatialAudioOriginPosition(&gPlayer->aniPlayerModel.ani.work.translation);
}

void Boss2Stage__State_Active(Boss2Stage *work)
{
    BossHelpers__ProcessLights(&work->lightConfig);
    Boss2Stage__HandleBossCamera(work);

    work->state2(work);
}

void Boss2Stage__Destructor(Task *task)
{
    NNSFndArchive arc;

    Boss2Stage *work = TaskGetWork(task, Boss2Stage);

    for (s32 i = 0; i < (s32)ARRAY_COUNT(work->aniStage); i++)
    {
        AnimatorMDL__Release(&work->aniStage[i]);
    }

    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);
    NNS_G3dResDefaultRelease(NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z2BOSS_ACT_LZ7_FILE_BSEF2_WAVE_NSBMD));
    NNS_FndUnmountArchive(&arc);

    renderCoreSwapBuffer.sortMode = GX_SORTMODE_AUTO;

    Boss2Stage__Singleton = NULL;

    GameObject__Destructor(task);
}

void Boss2Stage__Draw(void)
{
    Boss2Stage *work = TaskGetWorkCurrent(Boss2Stage);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        BossHelpers__RevertModifiedLights(&work->lightConfig);
        AnimatorMDL__Draw(&work->aniStage[0]);
        AnimatorMDL__Draw(&work->aniStage[1]);
        BossHelpers__ApplyModifiedLights(&work->lightConfig);
    }
}

void Boss2__Collide(void)
{
    Boss2 *work = TaskGetWorkCurrent(Boss2);

    if ((work->gameWork.objWork.flag & (STAGE_TASK_FLAG_DESTROY_NEXT_FRAME | STAGE_TASK_FLAG_DESTROYED)) != 0)
        return;

    if ((work->gameWork.objWork.flag & (STAGE_TASK_FLAG_NO_OBJ_COLLISION)) != 0)
        return;

    if ((work->gameWork.colliders[0].flag & OBS_RECT_WORK_FLAG_ENABLED) == 0)
        return;

    BossHelpers__Collision__HandleArenaCollider(work->gameWork.colliders, &work->field_388, (VecFx32 *)work->mtxWeakPoint.m[3], BOSS2_STAGE_START, BOSS2_STAGE_END,
                                                BOSS2_STAGE_RADIUS);
}

void Boss2__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Boss2 *boss    = (Boss2 *)rect2->parent;
    Player *player = (Player *)rect1->parent;

    if (player->objWork.objType == STAGE_OBJ_TYPE_PLAYER)
    {
        boss->stage->health = 0;
        UpdateBossHealthHUD(boss->stage->health);
        Boss2__Action_Die(boss);
    }
}

NONMATCH_FUNC void Boss2Stage__State2_215C938(Boss2Stage *work)
{
    // https://decomp.me/scratch/y3AaP -> 94.63%
#ifdef NON_MATCHING
    VecFx32 camUp = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0) };

    CameraConfig config;
    MI_CpuClear16(&config, sizeof(config));
    config.projFOV     = FLOAT_DEG_TO_IDX(30.0);
    config.projNear    = FLOAT_TO_FX32(1.0);
    config.projFar     = FLOAT_TO_FX32(2560.0);
    config.aspectRatio = FLOAT_TO_FX32(1.3333);
    config.projScaleW  = FLOAT_TO_FX32(0.8);

    BossArena__SetType(BOSSARENA_TYPE_4);

    BossArenaCamera *camera0 = BossArena__GetCamera(0);
    BossArena__SetCameraType(camera0, BOSSARENACAMERA_TYPE_1);
    BossArena__SetCameraConfig(camera0, &config);
    BossArena__SetTracker1TargetWork(camera0, &gPlayer->objWork, 0, &gPlayer->objWork);
    BossArena__SetTracker1TargetPos(camera0, 0, work->dword39C + 0x118000, 0);
    BossArena__SetTracker1Speed(camera0, 1024, 0);
    BossArena__SetTracker1UseObj3D(camera0, TRUE);
    BossArena__UpdateTracker1TargetPos(camera0);
    BossArena__SetAmplitudeXZTarget(camera0, 1024000);
    BossArena__SetAmplitudeXZSpeed(camera0, 512);
    BossArena__ApplyAmplitudeXZTarget(camera0);
    BossArena__SetAmplitudeYTarget(camera0, -122880);
    BossArena__ApplyAmplitudeYTarget(camera0);
    BossArena__SetAngleTarget(camera0, BossHelpers__Arena__GetAngle(gPlayer->objWork.position.x, BOSS2_STAGE_START, BOSS2_STAGE_END));
    BossArena__ApplyAngleTarget(camera0);
    BossArena__DoProcess();
    BossArena__UpdateTracker1TargetPos(camera0);
    BossArena__UpdateTracker0TargetPos(camera0);
    Boss2Stage__Func_215C2CC(work);
    BossArena__DoProcess();
    Boss2Stage__Func_215C2CC(work);

    BossArenaCamera *camera1 = BossArena__GetCamera(1);
    BossArena__SetCameraConfig(camera1, &config);
    BossArena__SetUpVector(camera1, &camUp);
    BossArena__UpdateTracker1TargetPos(camera1);
    BossArena__UpdateTracker0TargetPos(camera1);

    BossArenaCamera *camera2 = BossArena__GetCamera(2);
    BossArena__SetCameraConfig(camera2, &config);
    BossArena__SetUpVector(camera2, &camUp);
    BossArena__UpdateTracker1TargetPos(camera2);
    BossArena__UpdateTracker0TargetPos(camera2);

    G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_512x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_23);

    BossArena__SetBackgroundType(BOSSARENABACKGROUND_TYPE_3D);

    BossArenaUnknown4A8 *unknown = BossArena__GetField4A8();
    unknown->background          = work->assets.background;
    unknown->backgroundID        = BACKGROUND_1;
    unknown->screenBaseA         = 0;
    unknown->screenBaseBlock     = 0;

    LoadCompressedPixels(GetBackgroundPixels(work->assets.background), PIXEL_MODE_SPRITE, VRAMSystem__VRAM_BG[0] + 0x4000);
    LoadCompressedPalette(GetBackgroundPalette(work->assets.background), PALETTE_MODE_SPRITE, VRAMSystem__VRAM_PALETTE_BG[0]);

    BossArena__SetBoundsX(0, -160);

    GX_SetVisiblePlane(GX_GetVisiblePlane() | GX_PLANEMASK_BG1);

    Camera3D__Create();
    Camera3DTask *camera3D_A = Camera3D__GetWork();
    Camera3DTask *camera3D_B = Camera3D__GetWork();

    camera3D_A->gfxControl[0].blendManager.blendControl.value = camera3D_B->gfxControl[1].blendManager.blendControl.value = 0x00;
    camera3D_A->gfxControl[0].blendManager.blendControl.plane1_BG0 = camera3D_B->gfxControl[1].blendManager.blendControl.plane1_BG0 = TRUE;
    camera3D_A->gfxControl[0].blendManager.blendControl.plane2_BG1 = camera3D_B->gfxControl[1].blendManager.blendControl.plane2_BG1 = TRUE;
    camera3D_A->gfxControl[0].blendManager.blendControl.plane2_BG2 = camera3D_B->gfxControl[1].blendManager.blendControl.plane2_BG2 = TRUE;
    camera3D_A->gfxControl[0].blendManager.blendControl.plane2_BG3 = camera3D_B->gfxControl[1].blendManager.blendControl.plane2_BG3 = TRUE;
    camera3D_A->gfxControl[0].blendManager.blendControl.plane2_OBJ = camera3D_B->gfxControl[1].blendManager.blendControl.plane2_OBJ = TRUE;

    Boss2__PlayerDrawFunc = gPlayer->objWork.ppOut;
    SetTaskOutFunc(&gPlayer->objWork, Boss2__DrawPlayer);
    gPlayer->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_POSITION;

    UpdateBossHealthHUD(work->health);
    SetHUDActiveScreen(1);

    work->state2 = Boss2Stage__State2_215CD08;
#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x2c
	ldr r1, =Boss2Stage__State2_215C938_camUp
	add r3, sp, #0x20
	mov r5, r0
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r1, sp, #0
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClear16
	ldr r4, =0x00001555
	mov r3, #0x1000
	sub r1, r3, #0x334
	mov r2, #0xa00000
	mov r0, #4
	str r3, [sp, #4]
	strh r4, [sp]
	str r2, [sp, #8]
	str r4, [sp, #0xc]
	str r1, [sp, #0x10]
	bl BossArena__SetType
	mov r0, #0
	bl BossArena__GetCamera
	mov r4, r0
	mov r1, #1
	bl BossArena__SetCameraType
	mov r0, r4
	add r1, sp, #0
	bl BossArena__SetCameraConfig
	ldr r1, =gPlayer
	mov r0, r4
	ldr r1, [r1, #0]
	mov r2, #0
	mov r3, r1
	bl BossArena__SetTracker1TargetWork
	ldr r2, [r5, #0x39c]
	mov r1, #0
	mov r0, r4
	mov r3, r1
	add r2, r2, #0x118000
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, r4
	mov r1, #1
	bl BossArena__SetTracker1UseObj3D
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r4
	mov r1, #0xfa000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	bl BossArena__ApplyAmplitudeXZTarget
	mov r1, #0x1e000
	mov r0, r4
	rsb r1, r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	bl BossArena__ApplyAmplitudeYTarget
	ldr r0, =gPlayer
	ldr r2, =BOSS2_STAGE_END
	ldr r0, [r0, #0]
	mov r1, #BOSS2_STAGE_START
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__GetAngle
	mov r1, r0
	mov r0, r4
	bl BossArena__SetAngleTarget
	mov r0, r4
	bl BossArena__ApplyAngleTarget
	bl BossArena__DoProcess
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r4
	bl BossArena__UpdateTracker0TargetPos
	mov r0, r5
	bl Boss2Stage__Func_215C2CC
	bl BossArena__DoProcess
	mov r0, r5
	bl Boss2Stage__Func_215C2CC
	mov r0, #1
	bl BossArena__GetCamera
	mov r4, r0
	add r1, sp, #0
	bl BossArena__SetCameraConfig
	mov r0, r4
	add r1, sp, #0x20
	bl BossArena__SetUpVector
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r4
	bl BossArena__UpdateTracker0TargetPos
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, r0
	add r1, sp, #0
	bl BossArena__SetCameraConfig
	mov r0, r4
	add r1, sp, #0x20
	bl BossArena__SetUpVector
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r4
	bl BossArena__UpdateTracker0TargetPos
	ldr r2, =0x0400000A
	mov r0, #2
	ldrh r1, [r2, #0]
	and r1, r1, #0x43
	orr r1, r1, #4
	orr r1, r1, #0x6000
	strh r1, [r2]
	bl BossArena__SetBackgroundType
	bl BossArena__GetField4A8
	ldr r2, [r5, #0x364]
	mov r1, #1
	str r2, [r0, #4]
	strb r1, [r0, #0x14]
	mov r1, #0
	strh r1, [r0, #0x2c]
	strh r1, [r0, #0x2e]
	ldr r0, [r5, #0x364]
	bl GetBackgroundPixels
	ldr r2, =VRAMSystem__VRAM_BG
	mov r1, #0
	ldr r2, [r2, #0]
	add r2, r2, #0x4000
	bl LoadCompressedPixels
	ldr r0, [r5, #0x364]
	bl GetBackgroundPalette
	ldr r2, =VRAMSystem__VRAM_PALETTE_BG
	mov r1, #0
	ldr r2, [r2, #0]
	bl LoadCompressedPalette
	mov r0, #0
	sub r1, r0, #0xa0
	bl BossArena__SetBoundsX
	mov r2, #0x4000000
	ldr r0, [r2, #0]
	and r0, r0, #0x1f00
	mov r0, r0, lsr #8
	ldr r1, [r2, #0]
	orr r0, r0, #2
	bic r1, r1, #0x1f00
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bl Camera3D__Create
	bl Camera3D__GetWork
	mov r4, r0
	bl Camera3D__GetWork
	mov r1, #0
	strh r1, [r0, #0x7c]
	strh r1, [r4, #0x20]
	ldrh r1, [r0, #0x7c]
	ldr r3, =Boss2__DrawPlayer
	bic r1, r1, #1
	orr r1, r1, #1
	strh r1, [r0, #0x7c]
	ldrh r1, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	mov r1, r1, lsl #0x1f
	mov r1, r1, lsr #0x1f
	bic r2, r2, #1
	and r1, r1, #1
	orr r1, r2, r1
	strh r1, [r4, #0x20]
	ldrh r1, [r0, #0x7c]
	orr r1, r1, #0x200
	strh r1, [r0, #0x7c]
	ldrh r1, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	mov r1, r1, lsl #0x16
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x200
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #22
	strh r1, [r4, #0x20]
	ldrh r1, [r0, #0x7c]
	orr r1, r1, #0x400
	strh r1, [r0, #0x7c]
	ldrh r1, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	mov r1, r1, lsl #0x15
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x400
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #21
	strh r1, [r4, #0x20]
	ldrh r1, [r0, #0x7c]
	orr r1, r1, #0x800
	strh r1, [r0, #0x7c]
	ldrh r1, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	mov r1, r1, lsl #0x14
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x800
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #20
	strh r1, [r4, #0x20]
	ldrh r1, [r0, #0x7c]
	ldr r2, =gPlayer
	orr r1, r1, #0x1000
	strh r1, [r0, #0x7c]
	ldrh r0, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	mov r0, r0, lsl #0x13
	mov r0, r0, lsr #0x1f
	bic r1, r1, #0x1000
	mov r0, r0, lsl #0x1f
	orr r0, r1, r0, lsr #19
	strh r0, [r4, #0x20]
	ldr ip, [r2]
	ldr r1, =Boss2__PlayerDrawFunc
	ldr r4, [ip, #0xfc]
	add r0, r5, #0x300
	str r4, [r1]
	str r3, [ip, #0xfc]
	ldr r2, [r2, #0]
	ldr r1, [r2, #0x20]
	orr r1, r1, #0x2000
	str r1, [r2, #0x20]
	ldrsh r0, [r0, #0x98]
	bl UpdateBossHealthHUD
	mov r0, #1
	bl SetHUDActiveScreen
	ldr r0, =Boss2Stage__State2_215CD08
	str r0, [r5, #0x394]
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss2Stage__State2_215CD08(Boss2Stage *work)
{
    // will match when 'camUp' is decompiled
#ifdef NON_MATCHING
    VecFx32 camUp = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0) };

    BossArena__SetType(BOSSARENA_TYPE_4);

    BossArenaCamera *camera0 = BossArena__GetCamera(0);
    BossArena__SetCameraType(camera0, BOSSARENACAMERA_TYPE_1);
    BossArena__SetTracker1TargetWork(camera0, &gPlayer->objWork, 0, &gPlayer->objWork);
    BossArena__SetTracker1TargetPos(camera0, 0, work->dword39C + 0x118000, 0);
    BossArena__SetTracker1Speed(camera0, 1024, 0);
    BossArena__SetTracker1UseObj3D(camera0, TRUE);
    BossArena__UpdateTracker1TargetPos(camera0);
    BossArena__SetAmplitudeXZTarget(camera0, 1024000);
    BossArena__SetAmplitudeXZSpeed(camera0, 512);
    BossArena__ApplyAmplitudeXZTarget(camera0);
    BossArena__SetAmplitudeYTarget(camera0, -122880);
    BossArena__ApplyAmplitudeYTarget(camera0);
    BossArena__SetAngleTarget(camera0, BossHelpers__Arena__GetAngle(gPlayer->objWork.position.x, BOSS2_STAGE_START, BOSS2_STAGE_END));
    BossArena__ApplyAngleTarget(camera0);
    BossArena__DoProcess();
    BossArena__UpdateTracker1TargetPos(camera0);
    BossArena__UpdateTracker0TargetPos(camera0);
    Boss2Stage__Func_215C2CC(work);
    BossArena__DoProcess();
    Boss2Stage__Func_215C2CC(work);

    BossArenaCamera *camera1 = BossArena__GetCamera(1);
    BossArena__SetUpVector(camera1, &camUp);
    BossArena__UpdateTracker1TargetPos(camera1);
    BossArena__UpdateTracker0TargetPos(camera1);

    BossArenaCamera *camera2 = BossArena__GetCamera(2);
    BossArena__SetUpVector(camera2, &camUp);
    BossArena__UpdateTracker1TargetPos(camera2);
    BossArena__UpdateTracker0TargetPos(camera2);

    work->state2 = Boss2Stage__State2_215CE88;
#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldr r1, =Boss2Stage__State2_215CD08_camUp
	add r3, sp, #0
	mov r4, r0
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #4
	bl BossArena__SetType
	mov r0, #0
	bl BossArena__GetCamera
	mov r1, #1
	mov r5, r0
	bl BossArena__SetCameraType
	ldr r1, =gPlayer
	mov r0, r5
	ldr r1, [r1, #0]
	mov r2, #0
	mov r3, r1
	bl BossArena__SetTracker1TargetWork
	ldr r2, [r4, #0x39c]
	mov r1, #0
	mov r0, r5
	mov r3, r1
	add r2, r2, #0x118000
	bl BossArena__SetTracker1TargetPos
	mov r0, r5
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, r5
	mov r1, #1
	bl BossArena__SetTracker1UseObj3D
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	mov r1, #0xfa000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r5
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r5
	bl BossArena__ApplyAmplitudeXZTarget
	mov r1, #0x1e000
	mov r0, r5
	rsb r1, r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, r5
	bl BossArena__ApplyAmplitudeYTarget
	ldr r0, =gPlayer
	ldr r2, =BOSS2_STAGE_END
	ldr r0, [r0, #0]
	mov r1, #BOSS2_STAGE_START
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__GetAngle
	mov r1, r0
	mov r0, r5
	bl BossArena__SetAngleTarget
	mov r0, r5
	bl BossArena__ApplyAngleTarget
	bl BossArena__DoProcess
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker0TargetPos
	mov r0, r4
	bl Boss2Stage__Func_215C2CC
	bl BossArena__DoProcess
	mov r0, r4
	bl Boss2Stage__Func_215C2CC
	mov r0, #1
	bl BossArena__GetCamera
	mov r5, r0
	add r1, sp, #0
	bl BossArena__SetUpVector
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker0TargetPos
	mov r0, #2
	bl BossArena__GetCamera
	add r1, sp, #0
	mov r5, r0
	bl BossArena__SetUpVector
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker0TargetPos
	ldr r0, =Boss2Stage__State2_215CE88
	str r0, [r4, #0x394]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

void Boss2Stage__State2_215CE88(Boss2Stage *work)
{
    if (!work->field_3D4)
        Boss2Stage__Func_215C2CC(work);

    BossArena__SetNextPos(BossArena__GetCamera(1), MultiplyFX(GetScreenShakeOffsetX(), FLOAT_TO_FX32(1.0)), MultiplyFX(GetScreenShakeOffsetY(), FLOAT_TO_FX32(1.0)),
                          FLOAT_TO_FX32(0.0));
    BossArena__SetNextPos(BossArena__GetCamera(2), MultiplyFX(GetScreenShakeOffsetX(), FLOAT_TO_FX32(1.0)), MultiplyFX(GetScreenShakeOffsetY(), FLOAT_TO_FX32(1.0)),
                          FLOAT_TO_FX32(0.0));
}

void Boss2__State_Active(Boss2 *work)
{
    switch (work->activeArmCount)
    {
        case 0:
            if (work->bodyHeightB < FLOAT_TO_FX32(11.75))
                work->bodyHeightB += FLOAT_TO_FX32(0.3);
            else if (work->bodyHeightA < FLOAT_TO_FX32(11.75))
                work->bodyHeightA += FLOAT_TO_FX32(0.3);
            break;

        case 1:
            if (work->bodyHeightA > FLOAT_TO_FX32(0.0))
                work->bodyHeightA -= FLOAT_TO_FX32(0.3);

            if (work->bodyHeightB < FLOAT_TO_FX32(11.75))
                work->bodyHeightB += FLOAT_TO_FX32(0.3);
            break;

        case 2:
            if (work->bodyHeightA > FLOAT_TO_FX32(0.0))
                work->bodyHeightA -= FLOAT_TO_FX32(0.3);
            else if (work->bodyHeightB > FLOAT_TO_FX32(0.0))
                work->bodyHeightB -= FLOAT_TO_FX32(0.3);
            break;
    }

    work->state2(work);
}

void Boss2__Destructor(Task *task)
{
    Boss2 *work = TaskGetWork(task, Boss2);

    AnimatorMDL__Release(&work->aniBody);

    for (s32 i = 0; i < (s32)ARRAY_COUNT(work->aniPalette); i++)
        ReleasePaletteAnimator(&work->aniPalette[i]);

    GameObject__Destructor(task);
}

void Boss2__Draw(void)
{
    Boss2 *work = TaskGetWorkCurrent(Boss2);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        BOOL canDraw = Boss2__Func_215D168(work);

        AnimatorMDL *aniBody = &work->aniBody;

        VEC_Set(&aniBody->work.translation, work->gameWork.objWork.position.x, -work->gameWork.objWork.position.y, work->gameWork.objWork.position.z);

        MTX_RotY33(&aniBody->work.rotation, SinFX(work->angle), CosFX(work->angle));

        AnimatorMDL__ProcessAnimation(aniBody);

        if (canDraw)
        {
            AnimatorMDL__Draw(aniBody);
            BossHelpers__Model__SetMatrixMode(MTXSTACK_BOSS2_BODY_TOP, &work->mtxBody[0]);
            BossHelpers__Model__SetMatrixMode(MTXSTACK_BOSS2_BODY_MID, &work->mtxBody[1]);
            BossHelpers__Model__SetMatrixMode(MTXSTACK_BOSS2_BODY_BOTTOM, &work->mtxBody[2]);
            BossHelpers__Model__SetMatrixMode(MTXSTACK_BOSS2_WEAK, &work->mtxWeakPoint);
        }

        for (s32 i = 0; i < (s32)ARRAY_COUNT(work->aniPalette); i++)
        {
            AnimatePalette(&work->aniPalette[i]);
            DrawAnimatedPalette(&work->aniPalette[i]);
        }
    }
}

BOOL Boss2__Func_215D168(Boss2 *work)
{
    BOOL canDraw = FALSE;

    if (work->field_4A0)
    {
        switch (work->attackType)
        {
            case 3:
            case 4:
                canDraw = TRUE;
                break;

            default:
                if (Camera3D__UseEngineA())
                    canDraw = TRUE;
                break;
        }
    }
    else
    {
        canDraw         = TRUE;
        work->field_4A0 = canDraw;
    }

    return canDraw;
}

void Boss2__BodyACallback(NNSG3dRS *context, void *userData)
{
    Boss2 *work = (Boss2 *)userData;

    NNS_G3dGeTranslate(FLOAT_TO_FX32(0.0), MTM_MATH_CLIP(work->bodyHeightA, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(11.75)), FLOAT_TO_FX32(0.0));
}

void Boss2__BodyBCallback(NNSG3dRS *context, void *userData)
{
    Boss2 *work = (Boss2 *)userData;

    NNS_G3dGeTranslate(FLOAT_TO_FX32(0.0), MTM_MATH_CLIP(work->bodyHeightB, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(11.75)), FLOAT_TO_FX32(0.0));
}

void Boss2__SetupObject(Boss2 *work)
{
    work->attackType = 0;

    work->state2 = Boss2__State2_215D2E4;
    work->state2(work);
}

void Boss2__Action_Attack1(Boss2 *work)
{
    work->attackType = 1;

    work->state2 = Boss2__State2_215D2F0;
    work->state2(work);
}

void Boss2__Action_Attack2(Boss2 *work)
{
    work->attackType = 2;

    work->state2 = Boss2__State2_215D4DC;
    work->state2(work);
}

void Boss2__Action_Attack3(Boss2 *work)
{
    work->attackType = 3;

    work->state2 = Boss2__State2_215D5DC;
    work->state2(work);
}

void Boss2__Action_Die(Boss2 *work)
{
    work->attackType = 4;

    work->state2 = Boss2__State2_215DAD4;
    work->state2(work);
}

void Boss2__State2_215D2E4(Boss2 *work)
{
    Boss2__Action_Attack1(work);
}

void Boss2__State2_215D2F0(Boss2 *work)
{
    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, bs2_body_fw0, 0, TRUE);

    work->state2 = Boss2__State2_215D334;
}

void Boss2__State2_215D334(Boss2 *work)
{
    u16 angle = BossHelpers__Arena__GetAngle(gPlayer->objWork.position.x, BOSS2_STAGE_START, BOSS2_STAGE_END);

    s16 angleDist = ((s16)work->angle - (s16)angle);
    if (MATH_ABS(angleDist) > FLOAT_DEG_TO_IDX(45.0))
        work->field_3D0 = TRUE;

    if (work->field_3D0)
    {
        work->angle = BossHelpers__Math__Func_2039264(work->angle, angle, 96);

        angleDist = ((s16)work->angle - (s16)angle);
        if (MATH_ABS(angleDist) < FLOAT_DEG_TO_IDX(5.0))
            work->field_3D0 = FALSE;
    }

    if (work->field_3C8)
    {
        if (work->stage->drop->field_378 == 0)
        {
            work->field_3C8--;
            if (work->field_3C8 == 0)
            {
                Boss2Drop__Func_215E208(work->stage->drop);
                work->field_3C8 = Boss2__Func_215C104(work->stage);
            }
        }
    }

    if (work->field_3CA)
    {
        if (work->stage->bomb == NULL && work->stage->drop->field_378 == 0)
        {
            work->field_3CA--;

            if (work->field_3CA == 0)
            {
                BOOL flipped;
                if (mtMathRandRepeat(2) != 0)
                    flipped = TRUE;
                else
                    flipped = FALSE;
                Boss2Bomb__Spawn(work->stage, FLOAT_TO_FX32(1.5), flipped);

                work->field_3CA = Boss2__Func_215C19C(work->stage);

                if (work->field_3C8 != 0)
                {
                    if (work->field_3C8 < 120)
                        work->field_3C8 += 120;
                }
            }
        }
    }
}

void Boss2__State2_215D4DC(Boss2 *work)
{
    work->state2 = Boss2__State2_215D4EC;
}

void Boss2__State2_215D4EC(Boss2 *work)
{
    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, bs2_body_dmg0, 0, FALSE);
    BossHelpers__SetPaletteAnimations(work->aniPalette, ARRAY_COUNT(work->aniPalette), 1, TRUE);

    work->state2 = Boss2__State2_215D544;
}

void Boss2__State2_215D544(Boss2 *work)
{
    if ((work->aniBody.animFlags[0] & ANIMATORMDL_FLAG_FINISHED) != 0)
        work->state2 = Boss2__State2_215D560;
}

void Boss2__State2_215D560(Boss2 *work)
{
    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, bs2_body_dmg1, 0, FALSE);

    work->state2 = Boss2__State2_215D5A0;
}

void Boss2__State2_215D5A0(Boss2 *work)
{
    if ((work->aniBody.animFlags[0] & ANIMATORMDL_FLAG_FINISHED) != 0)
    {
        BossHelpers__SetPaletteAnimations(work->aniPalette, ARRAY_COUNT(work->aniPalette), 0, FALSE);
        Boss2__Action_Attack1(work);
    }
}

void Boss2__State2_215D5DC(Boss2 *work)
{
    struct Boss2ActionAttack3 *action = &work->action.attack3;

    action->value = 0;

    work->state2 = Boss2__State2_215D5F4;
}

void Boss2__State2_215D5F4(Boss2 *work)
{
    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, bs2_body_dmg0, 0, FALSE);
    BossHelpers__SetPaletteAnimations(work->aniPalette, ARRAY_COUNT(work->aniPalette), 1, TRUE);

    work->state2 = Boss2__State2_215D64C;
}

void Boss2__State2_215D64C(Boss2 *work)
{
    if ((work->aniBody.animFlags[0] & ANIMATORMDL_FLAG_FINISHED) != 0)
        work->state2 = Boss2__State2_215D668;
}

void Boss2__State2_215D668(Boss2 *work)
{
    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, bs2_body_down0, 0, FALSE);

    work->state2 = Boss2__State2_215D6A8;
}

void Boss2__State2_215D6A8(Boss2 *work)
{
    work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(4.0);

    if ((work->aniBody.animFlags[0] & ANIMATORMDL_FLAG_FINISHED) != 0)
        work->state2 = Boss2__State2_215D6CC;
}

void Boss2__State2_215D6CC(Boss2 *work)
{
    work->gameWork.objWork.userWork = work->activeArmCount;
    work->activeArmCount            = 0;

    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, bs2_body_down1, 0, TRUE);

    work->state2 = Boss2__State2_215D71C;
}

void Boss2__State2_215D71C(Boss2 *work)
{
    struct Boss2ActionAttack3 *action = &work->action.attack3;

    fx32 targetY = -FLOAT_TO_FX32(70.0) - work->stage->dword39C;

    action->value += FLOAT_TO_FX32(2.5);
    if (action->value > FLOAT_TO_FX32(120.0))
        action->value = FLOAT_TO_FX32(120.0);

    BossHelpers__Arena__GetXZPos(work->angle, action->value, &work->gameWork.objWork.position.x, &work->gameWork.objWork.position.z);

    if (work->gameWork.objWork.position.y >= targetY)
    {
        work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
        work->gameWork.objWork.position.y = targetY;

        work->state2 = Boss2__State2_215D790;
    }
}

void Boss2__State2_215D790(Boss2 *work)
{
    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, bs2_body_down2, 0, FALSE);
    BossHelpers__SetPaletteAnimations(work->aniPalette, ARRAY_COUNT(work->aniPalette), 0, FALSE);

    ShakeScreenEx(0xA000, 0x3000, 227);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ZAKO_LAND);

    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_ENABLED;

    work->state2 = Boss2__State2_215D824;
}

void Boss2__State2_215D824(Boss2 *work)
{
    if ((work->aniBody.animFlags[0] & ANIMATORMDL_FLAG_FINISHED) != 0)
        work->state2 = Boss2__State2_215D840;
}

void Boss2__State2_215D840(Boss2 *work)
{
    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, bs2_body_down3, 0, TRUE);

    work->gameWork.objWork.userTimer = 600;

    work->state2 = Boss2__State2_215D88C;
}

void Boss2__State2_215D88C(Boss2 *work)
{
    work->gameWork.objWork.userTimer--;
    if (work->gameWork.objWork.userTimer == 0)
        work->state2 = Boss2__State2_215D8A8;
}

void Boss2__State2_215D8A8(Boss2 *work)
{
    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, bs2_body_down4, 0, FALSE);

    work->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;
    work->stage->health = 320;

    UpdateBossHealthHUD(work->stage->health);

    work->state2 = Boss2__State2_215D914;
}

void Boss2__State2_215D914(Boss2 *work)
{
    struct Boss2ActionAttack3 *action = &work->action.attack3;

    action->value -= FLOAT_TO_FX32(2.5);
    if (action->value < FLOAT_TO_FX32(0.0))
        action->value = FLOAT_TO_FX32(0.0);

    BossHelpers__Arena__GetXZPos(work->angle, action->value, &work->gameWork.objWork.position.x, &work->gameWork.objWork.position.z);

    work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(8.0);

    if ((work->aniBody.animFlags[0] & ANIMATORMDL_FLAG_FINISHED) != 0)
        work->state2 = Boss2__State2_215D970;
}

void Boss2__State2_215D970(Boss2 *work)
{
    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, bs2_body_down5, 0, TRUE);

    work->state2 = Boss2__State2_215D9BC;
    work->state2(work);
}

void Boss2__State2_215D9BC(Boss2 *work)
{
    struct Boss2ActionAttack3 *action = &work->action.attack3;

    fx32 targetY = work->stage->gameWork.objWork.position.y - FLOAT_TO_FX32(585.0);

    action->value -= FLOAT_TO_FX32(2.5);
    if (action->value < FLOAT_TO_FX32(0.0))
        action->value = FLOAT_TO_FX32(0.0);

    BossHelpers__Arena__GetXZPos(work->angle, action->value, &work->gameWork.objWork.position.x, &work->gameWork.objWork.position.z);

    work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(8.0);

    if (work->gameWork.objWork.position.y <= targetY && !action->value)
    {
        work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
        work->gameWork.objWork.position.y = targetY;

        work->state2 = Boss2__State2_215DA44;
    }
}

void Boss2__State2_215DA44(Boss2 *work)
{
    work->activeArmCount = work->gameWork.objWork.userWork;

    for (s32 i = 0; i <= work->activeArmCount; i++)
        Boss2Arm__Func_215EBD8(work->stage->arms[i]);

    BossHelpers__SetAnimation(&work->aniBody, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, bs2_body_down6, 0, FALSE);
    work->state2 = Boss2__State2_215DAB8;
}

void Boss2__State2_215DAB8(Boss2 *work)
{
    if ((work->aniBody.animFlags[B3D_ANIM_JOINT_ANIM] & ANIMATORMDL_FLAG_FINISHED) != 0)
        Boss2__Action_Attack1(work);
}

void Boss2__State2_215DAD4(Boss2 *work)
{
    struct Boss2ActionDestroyed *action = &work->action.destroyed;

    MI_CpuClear16(action, sizeof(*action));

    work->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;

    playerGameStatus.flags &= ~PLAYERGAMESTATUS_FLAG_FREEZE_TIME;
    StopStageBGM();

    Player__Action_Blank(gPlayer);
    gPlayer->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_IN_AIR;
    Player__ChangeAction(gPlayer, PLAYER_ACTION_HOMING_ATTACK);
    gPlayer->blinkTimer = 0;
    BossHelpers__Player__LockControl(gPlayer);

    work->aniBody.speedMultiplier = FLOAT_TO_FX32(0.0);

    EnableObjectManagerFlag2();
    work->gameWork.objWork.flag |= 0x20;
    work->stage->gameWork.objWork.flag |= STAGE_TASK_FLAG_ACTIVE_DURING_PAUSE;

    for (s32 i = 0; i < 3; i++)
        Boss2Arm__SetupObject(work->stage->arms[i]);

    ShakeScreenEx(0x5000, 0x3000, 0x2AA);
    gPlayer->objWork.shakeTimer = FLOAT_TO_FX32(16.0);

    // Create explode impact fx
    BossFX__CreatePendulumExplode2(BOSSFX3D_FLAG_NONE, gPlayer->aniPlayerModel.ani.work.translation.x, gPlayer->aniPlayerModel.ani.work.translation.y,
                                   gPlayer->aniPlayerModel.ani.work.translation.z);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SHOCK_L);

    action->timer = 0;
    work->state2  = Boss2__State2_215DC20;
}

void Boss2__State2_215DC20(Boss2 *work)
{
    struct Boss2ActionDestroyed *action = &work->action.destroyed;

    UNUSED(Camera3D__GetWork());

    action->timer++;
    if (action->timer == SECONDS_TO_FRAMES(1.5))
    {
        BossArenaCamera *camera = BossArena__GetCamera(2);
        work->stage->field_3D4  = 1;

        VecFx32 translation = gPlayer->aniPlayerModel.ani.work.translation;

        translation.x >>= 1;
        translation.z >>= 1;
        BossArena__SetTracker1TargetWork(camera, NULL, NULL, NULL);
        BossArena__SetTracker1TargetPos(camera, translation.x, translation.y, translation.z);

        translation = gPlayer->aniPlayerModel.ani.work.translation;
        u16 angle   = BossHelpers__Arena__GetAngle(gPlayer->objWork.position.x, BOSS2_STAGE_START, BOSS2_STAGE_END) - FLOAT_DEG_TO_IDX(60.0);

        translation.y += FLOAT_TO_FX32(50.0);
        translation.x += MultiplyFX(FLOAT_TO_FX32(180.0), SinFX((s32)angle));
        translation.z += MultiplyFX(FLOAT_TO_FX32(180.0), CosFX((s32)angle));
        BossArena__SetTracker0TargetPos(camera, translation.x, translation.y, translation.z);

        BossArena__SetTracker1Speed(camera, FLOAT_TO_FX32(0.05), FLOAT_TO_FX32(0.05));
        BossArena__SetTracker0Speed(camera, FLOAT_TO_FX32(0.05), FLOAT_TO_FX32(0.05));

        work->state2 = Boss2__State2_215DDD8;
    }
}

void Boss2__State2_215DDD8(Boss2 *work)
{
    Camera3DTask *camera3D = Camera3D__GetWork();

    MI_CpuClear16(&camera3D->gfxControl[GRAPHICS_ENGINE_A].blendManager, sizeof(camera3D->gfxControl[GRAPHICS_ENGINE_A].blendManager));
    camera3D->gfxControl[GRAPHICS_ENGINE_A].blendManager.blendControl.effect     = BLENDTYPE_FADEOUT;
    camera3D->gfxControl[GRAPHICS_ENGINE_A].blendManager.blendControl.plane1_BG0 = TRUE;
    camera3D->gfxControl[GRAPHICS_ENGINE_A].blendManager.blendControl.value |= GX_PLANEMASK_BG1 | GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3 | GX_PLANEMASK_OBJ;

    work->action.destroyed.timer = 0;
    work->state2                 = Boss2__State2_215DE40;
}

void Boss2__State2_215DE40(Boss2 *work)
{
    Boss2Stage *stage                   = work->stage;
    struct Boss2ActionDestroyed *action = &work->action.destroyed;

    Camera3DTask *camera3D = Camera3D__GetWork();

    // dim the lights
    if (stage->lightConfig.brightness != RENDERCORE_BRIGHTNESS_BLACK && ++action->lightDimTimer > 1)
    {
        action->lightDimTimer = 0;
        stage->lightConfig.brightness--;
    }

    // brighten the blending
    if (camera3D->gfxControl[0].blendManager.coefficient.value < RENDERCORE_BRIGHTNESS_WHITE && ++action->brightnessTimer > 2)
    {
        action->brightnessTimer = 0;
        camera3D->gfxControl[0].blendManager.coefficient.value++;
    }

    // create explosion "shock" fx
    for (s32 i = 0; i < 3; i++)
    {
        if (action->timer == BossArena__explosionFXSpawnTime[i])
        {
            BossFX__CreatePendulumExplode0(BOSSFX3D_FLAG_NONE, work->mtxWeakPoint.m[3][0], work->mtxWeakPoint.m[3][1], work->mtxWeakPoint.m[3][2]);
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TODOME_EFFECT);
            CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_ENGINEB_ONLY | DRAW_FADE_TASK_FLAG_FADE_TO_BLACK | DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS, FLOAT_TO_FX32(2.0));
            ShakeScreenEx(0x3000, 0x3000, 0x600);
        }
    }

    if (action->timer++ > SECONDS_TO_FRAMES(4))
        work->state2 = Boss2__State2_215DF78;
}

void Boss2__State2_215DF78(Boss2 *work)
{
    BossFX3D *effect        = BossFX__CreatePendulumExplode1(BOSSFX3D_FLAG_NONE, MultiplyFX(FLOAT_TO_FX32(0.7), work->mtxWeakPoint.m[3][0]), work->mtxWeakPoint.m[3][1],
                                                             MultiplyFX(FLOAT_TO_FX32(0.7), work->mtxWeakPoint.m[3][2]));
    effect->objWork.scale.x = FLOAT_TO_FX32(3.0);
    effect->objWork.scale.y = FLOAT_TO_FX32(3.0);
    effect->objWork.scale.z = FLOAT_TO_FX32(3.0);
    effect->aniModel.ani.speedMultiplier = FLOAT_TO_FX32(0.333251953125);

    ShakeScreenEx(0xA000, 0x3000, 227);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOSS_EXPLOSION);

    work->action.destroyed.timer = 0;

    work->state2 = Boss2__State2_215E050;
    work->state2(work);
}

void Boss2__State2_215E050(Boss2 *work)
{
    Boss2Stage *stage                   = work->stage;
    struct Boss2ActionDestroyed *action = &work->action.destroyed;

    Camera3DTask *camera3D = Camera3D__GetWork();

    BOOL doneLights = FALSE;
    BOOL doneFading = FALSE;

    if (stage->lightConfig.brightness == RENDERCORE_BRIGHTNESS_DEFAULT)
        doneLights = TRUE;
    else
        stage->lightConfig.brightness++;

    if (camera3D->gfxControl[GRAPHICS_ENGINE_A].brightness < RENDERCORE_BRIGHTNESS_WHITE)
    {
        if (action->timer > SECONDS_TO_FRAMES(3.0) && ++action->fadeOutTimer > 3)
        {
            camera3D->gfxControl[GRAPHICS_ENGINE_A].brightness++;
            camera3D->gfxControl[GRAPHICS_ENGINE_B].brightness++;
            action->fadeOutTimer = 0;
        }
    }
    else
    {
        doneFading = TRUE;
    }

    action->timer++;

    if (doneLights && doneFading)
        work->state2 = Boss2__State2_ShowResultsScreen;
}

void Boss2__State2_ShowResultsScreen(Boss2 *work)
{
    playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_CAN_CHANGE_EVENT;
}

void Boss2Drop__State_Active(Boss2Drop *work)
{
    work->state2(work);
}

void Boss2Drop__Destructor(Task *task)
{
    Boss2Drop *work = TaskGetWork(task, Boss2Drop);

    AnimatorMDL__Release(&work->aniDrop);

    GameObject__Destructor(task);
}

void Boss2Drop__Draw(void)
{
    Boss2Drop *work = TaskGetWorkCurrent(Boss2Drop);

    Boss2 *boss = work->stage->boss;

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        if (work->field_37C)
        {
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

            work->gameWork.objWork.position.x = boss->mtxBody[2].m[3][0];
            work->gameWork.objWork.position.y = -boss->mtxBody[2].m[3][1];
            work->gameWork.objWork.position.z = boss->mtxBody[2].m[3][2];

            work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
            work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
            work->gameWork.objWork.velocity.z = FLOAT_TO_FX32(0.0);
        }
        else
        {
            work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
        }

        AnimatorMDL *aniDrop = &work->aniDrop;
        VEC_Set(&aniDrop->work.translation, work->gameWork.objWork.position.x, -work->gameWork.objWork.position.y, work->gameWork.objWork.position.z);

        AnimatorMDL__ProcessAnimation(aniDrop);
        AnimatorMDL__Draw(aniDrop);
    }
}

void Boss2Drop__SetupObject(Boss2Drop *work)
{
    work->field_378 = 0;

    work->state2 = Boss2Drop__State_Init;
    work->state2(work);
}

void Boss2Drop__Func_215E208(Boss2Drop *work)
{
    work->field_378      = 1;
    work->playedSteamSfx = FALSE;

    work->state2 = Boss2Drop__State2_215E3F4;
    work->state2(work);
}

void Boss2Drop__State_Init(Boss2Drop *work)
{
    work->field_37C = 1;

    work->state2 = Boss2Drop__State_Attached;
}

void Boss2Drop__State_Attached(Boss2Drop *work)
{
    *(MtxFx33 *)&work->aniDrop.work.rotation._00 = *(MtxFx33 *)&work->stage->boss->mtxBody[2];

    work->aniDrop.work.rotation.m[0][0] = MultiplyFX(FLOAT_TO_FX32(0.302978515625), work->aniDrop.work.rotation.m[0][0]);
    work->aniDrop.work.rotation.m[0][1] = MultiplyFX(FLOAT_TO_FX32(0.302978515625), work->aniDrop.work.rotation.m[0][1]);
    work->aniDrop.work.rotation.m[0][2] = MultiplyFX(FLOAT_TO_FX32(0.302978515625), work->aniDrop.work.rotation.m[0][2]);
    work->aniDrop.work.rotation.m[1][0] = MultiplyFX(FLOAT_TO_FX32(0.302978515625), work->aniDrop.work.rotation.m[1][0]);
    work->aniDrop.work.rotation.m[1][1] = MultiplyFX(FLOAT_TO_FX32(0.302978515625), work->aniDrop.work.rotation.m[1][1]);
    work->aniDrop.work.rotation.m[1][2] = MultiplyFX(FLOAT_TO_FX32(0.302978515625), work->aniDrop.work.rotation.m[1][2]);
    work->aniDrop.work.rotation.m[2][0] = MultiplyFX(FLOAT_TO_FX32(0.302978515625), work->aniDrop.work.rotation.m[2][0]);
    work->aniDrop.work.rotation.m[2][1] = MultiplyFX(FLOAT_TO_FX32(0.302978515625), work->aniDrop.work.rotation.m[2][1]);
    work->aniDrop.work.rotation.m[2][2] = MultiplyFX(FLOAT_TO_FX32(0.302978515625), work->aniDrop.work.rotation.m[2][2]);
}

void Boss2Drop__State2_215E3F4(Boss2Drop *work)
{
    work->field_37C = 1;

    work->state2 = Boss2Drop__State2_215E40C;
}

void Boss2Drop__State2_215E40C(Boss2Drop *work)
{
    BossHelpers__SetAnimation(&work->aniDrop, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, bs2_drop_gura0, 0, FALSE);

    work->gameWork.objWork.userTimer = 60;
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOSS_STEAM);

    work->state2 = Boss2Drop__State2_215E46C;
}

void Boss2Drop__State2_215E46C(Boss2Drop *work)
{
    if (work->stage->lightConfig.brightness >= -8 && (work->gameWork.objWork.userTimer & 1) == 0)
        work->stage->lightConfig.brightness--;

    if (work->gameWork.objWork.userTimer != 0)
        work->gameWork.objWork.userTimer--;

    if ((work->aniDrop.animFlags[0] & ANIMATORMDL_FLAG_FINISHED) != 0 && work->gameWork.objWork.userTimer == 0)
        work->state2 = Boss2Drop__State2_215E4CC;
}

void Boss2Drop__State2_215E4CC(Boss2Drop *work)
{
    BossFX__CreatePendulumDrop(BOSSFX3D_FLAG_NONE, work->aniDrop.work.translation.x, work->aniDrop.work.translation.y - FLOAT_TO_FX32(50.0), work->aniDrop.work.translation.z);

    work->pendulumFallFX = BossFX__CreatePendulumFall(BOSSFX3D_FLAG_NONE, work->gameWork.objWork.position.x, -work->gameWork.objWork.position.y, work->gameWork.objWork.position.z);

    BossHelpers__SetAnimation(&work->aniDrop, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, bs2_drop_gura1, 0, TRUE);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(32.0);

    work->field_37C = 0;

    work->state2 = Boss2Drop__State2_215E564;
    work->state2(work);
}

void Boss2Drop__State2_215E564(Boss2Drop *work)
{
    Boss2Stage *stage = TaskGetWork(Boss2Stage__Singleton, Boss2Stage);

    fx32 targetY = -stage->dword39C;
    targetY -= FLOAT_TO_FX32(120.0);

    if (targetY <= work->gameWork.objWork.position.y)
    {
        work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
        work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
        work->gameWork.objWork.position.y = targetY;

        if (work->pendulumFallFX != NULL)
        {
            QueueDestroyStageTask(&work->pendulumFallFX->objWork);
            work->pendulumFallFX = NULL;
        }

        work->state2 = Boss2Drop__State2_215E604;
    }

    if (work->pendulumFallFX != NULL)
    {
        work->pendulumFallFX->objWork.position = work->gameWork.objWork.position;

        work->pendulumFallFX->objWork.position.y -= FLOAT_TO_FX32(50.0);
    }
}

void Boss2Drop__State2_215E604(Boss2Drop *work)
{
    BossHelpers__SetAnimation(&work->aniDrop, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, bs2_drop_gura2, 0, FALSE);
    work->gameWork.objWork.userTimer = 120;

    if (work->playedSteamSfx == FALSE)
    {
        BossFX__CreatePendulumSmoke(BOSSFX3D_FLAG_NONE, work->aniDrop.work.translation.x, work->stage->dword39C, work->aniDrop.work.translation.z);

        Boss2Wave *wave = SpawnStageObject(MAPOBJECT_283, 0, -FLOAT_TO_FX32(5.0) - work->stage->dword39C, Boss2Wave);
        UNUSED(wave);

        ShakeScreenEx(0x5000, 0x3000, 170);
        work->playedSteamSfx = TRUE;
    }

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOSS_STEAM);

    work->state2 = Boss2Drop__State2_215E6D8;
}

void Boss2Drop__State2_215E6D8(Boss2Drop *work)
{
    if (work->stage->lightConfig.brightness != 0 && (work->gameWork.objWork.userTimer & 1) == 0)
        work->stage->lightConfig.brightness++;

    work->gameWork.objWork.userTimer--;
    if (work->gameWork.objWork.userTimer == 0)
        work->state2 = Boss2Drop__State2_215E718;
}

void Boss2Drop__State2_215E718(Boss2Drop *work)
{
    BossHelpers__SetAnimation(&work->aniDrop, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, bs2_drop_gura3, 0, FALSE);

    work->state2 = Boss2Drop__State2_215E754;
}

void Boss2Drop__State2_215E754(Boss2Drop *work)
{
    if ((work->aniDrop.animFlags[0] & ANIMATORMDL_FLAG_FINISHED) != 0)
        work->state2 = Boss2Drop__State2_215E770;
}

void Boss2Drop__State2_215E770(Boss2Drop *work)
{
    switch (work->stage->boss->attackType)
    {
        case 1:
        case 2:
            BossHelpers__SetAnimation(&work->aniDrop, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, bs2_drop_gura4, 0, TRUE);
            work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(10.0);
            work->state2                      = Boss2Drop__State2_215E7D8;
            break;
    }
}

void Boss2Drop__State2_215E7D8(Boss2Drop *work)
{
    Boss2 *boss = work->stage->boss;

    switch (boss->attackType)
    {

        default:
            BossHelpers__SetAnimation(&work->aniDrop, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, bs2_drop_gura1, 0, TRUE);

            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
            work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);

            work->state2 = Boss2Drop__State2_215E564;
            break;

        case 1:
        case 2:
            if (work->gameWork.objWork.position.y <= boss->mtxBody[2].m[3][1])
            {
                work->gameWork.objWork.position.y = boss->gameWork.objWork.position.y;
                work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);

                work->state2 = Boss2Drop__State2_215E87C;
            }
            break;
    }
}

void Boss2Drop__State2_215E87C(Boss2Drop *work)
{
    BossHelpers__SetAnimation(&work->aniDrop, B3D_ANIM_JOINT_ANIM, work->assets.jointAnims, bs2_drop_gura5, 0, FALSE);

    work->field_37C = 1;
    work->state2    = Boss2Drop__State2_215E8C0;
}

void Boss2Drop__State2_215E8C0(Boss2Drop *work)
{
    if ((work->aniDrop.animFlags[0] & ANIMATORMDL_FLAG_FINISHED) != 0)
        Boss2Drop__SetupObject(work);
}

void Boss2Arm__State_Active(Boss2Arm *work)
{
    if (work->field_3B8)
    {
        Boss2 *boss = work->stage->boss;

        if (work->field_3BC)
        {
            work->angleSpeed = MTM_MATH_CLIP_3(work->angleSpeed, -work->word3C6, work->word3C6);

            if (work->angleSpeed > 0)
            {
                if (work->angleSpeed < work->targetAngleSpeed)
                {
                    work->angleSpeed += MultiplyFX(122, (work->targetAngleSpeed - work->angleSpeed));
                }
                else if (work->angleSpeed > work->targetAngleSpeed)
                {
                    work->angleSpeed -= MultiplyFX(122, (work->angleSpeed - work->targetAngleSpeed));
                }
            }
            else if (work->angleSpeed < 0)
            {
                if (work->angleSpeed < -work->targetAngleSpeed)
                {
                    work->angleSpeed += MultiplyFX(122, -(work->targetAngleSpeed + work->angleSpeed));
                }
                else if (work->angleSpeed > -work->targetAngleSpeed)
                {
                    work->angleSpeed -= MultiplyFX(122, (work->angleSpeed + work->targetAngleSpeed));
                }
            }

            work->angle += work->angleSpeed;
        }

        MTX_RotY33(&work->animator.work.rotation, SinFX(work->angle), CosFX(work->angle));

        VEC_SetFromArray(&work->animator.work.translation, boss->mtxBody[work->type].m[3]);
    }
    else
    {
        VEC_Set(&work->animator.work.translation, work->gameWork.objWork.position.x, -work->gameWork.objWork.position.y, work->gameWork.objWork.position.z);
    }

    work->state2(work);
}

void Boss2Arm__Destructor(Task *task)
{
    Boss2Arm *work = TaskGetWork(task, Boss2Arm);

    AnimatorMDL__Release(&work->animator);

    GameObject__Destructor(task);
}

void Boss2Arm__Draw(void)
{
    Boss2Arm *work = TaskGetWorkCurrent(Boss2Arm);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        BOOL canDraw = Boss2Arm__CheckCanDraw(work);

        AnimatorMDL__ProcessAnimation(&work->animator);

        if (canDraw)
        {
            AnimatorMDL__Draw(&work->animator);
            BossHelpers__Model__SetMatrixMode(MTXSTACK_BOSS2ARM_ARM_BALL, &work->mtxArmBall);
        }
    }
}

BOOL Boss2Arm__CheckCanDraw(Boss2Arm *work)
{
    BOOL canDraw = FALSE;

    if (work->field_3C8)
    {
        switch (work->field_380)
        {
            case 0:
                canDraw = FALSE;
                break;

            case 1:
            case 2:
            case 4:
                canDraw = TRUE;
                break;

            default:
                if (Camera3D__UseEngineA())
                    canDraw = TRUE;
                break;
        }
    }
    else
    {
        canDraw         = TRUE;
        work->field_3C8 = canDraw;
    }

    return canDraw;
}

void Boss2Arm__SetupObject(Boss2Arm *work)
{
    work->field_380 = 0;

    work->state2 = Boss2Arm__State2_215EC44;
}

void Boss2Arm__Action_215EBC0(Boss2Arm *work)
{
    work->field_380 = 1;

    work->state2 = Boss2Arm__State2_215EC5C;
}

void Boss2Arm__Func_215EBD8(Boss2Arm *work)
{
    work->field_380 = 2;

    work->state2 = Boss2Arm__State2_215EF50;
}

void Boss2Arm__Func_215EBF0(Boss2Arm *work, u16 angle, s16 angleSpeed)
{
    work->field_380  = 3;
    work->field_3BC  = 1;
    work->angle      = angle;
    work->angleSpeed = angleSpeed;

    work->state2 = Boss2Arm__State2_215F204;
    work->state2(work);
}

void Boss2Arm__Func_215EC24(Boss2Arm *work)
{
    work->field_380 = 4;

    work->state2 = Boss2Arm__State2_215F258;
    work->state2(work);
}

void Boss2Arm__State2_215EC44(Boss2Arm *work)
{
    work->field_3BC = 0;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
}

void Boss2Arm__State2_215EC5C(Boss2Arm *work)
{
    work->field_3B8 = 0;
    work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;

    work->angle      = BossHelpers__Arena__GetAngle(gPlayer->objWork.position.x, BOSS2_STAGE_START, BOSS2_STAGE_END) - FLOAT_DEG_TO_IDX(105.0);
    work->angleSpeed = FLOAT_DEG_TO_IDX(11.25);
    work->field_374  = FLOAT_TO_FX32(500.0);

    work->state2 = Boss2Arm__State2_215ECD8;
}

void Boss2Arm__State2_215ECD8(Boss2Arm *work)
{
    Boss2 *boss = work->stage->boss;

    BOOL done = FALSE;

    work->field_374 -= FLOAT_TO_FX32(2.0);
    if (work->field_374 < FLOAT_TO_FX32(250.0))
    {
        work->field_374 = FLOAT_TO_FX32(250.0);
        done            = TRUE;
    }

    BossHelpers__Arena__GetXZPos(work->angle, work->field_374, &work->gameWork.objWork.position.x, &work->gameWork.objWork.position.z);
    work->gameWork.objWork.position.y = -boss->mtxBody[work->type].m[3][1];

    work->angleSpeed -= FLOAT_DEG_TO_IDX(0.088);
    if (work->angleSpeed < FLOAT_DEG_TO_IDX(4.21875))
        work->angleSpeed = FLOAT_DEG_TO_IDX(4.21875);

    work->angle += work->angleSpeed;

    MtxFx33 mtxRot;
    MTX_RotX33(&work->animator.work.rotation, SinFX(FLOAT_DEG_TO_IDX(319.922)), CosFX(FLOAT_DEG_TO_IDX(319.922)));
    MTX_RotY33(&mtxRot, SinFX(work->angle), CosFX(work->angle));
    MTX_Concat33(&work->animator.work.rotation, &mtxRot, &work->animator.work.rotation);

    if (done)
        work->state2 = Boss2Arm__State2_215EDE4;
}

void Boss2Arm__State2_215EDE4(Boss2Arm *work)
{
    work->field_374 += FLOAT_TO_FX32(2.0);
    if (work->field_374 > FLOAT_TO_FX32(450.0))
        work->field_374 = FLOAT_TO_FX32(450.0);

    BossHelpers__Arena__GetXZPos(work->angle, work->field_374, &work->gameWork.objWork.position.x, &work->gameWork.objWork.position.z);

    work->gameWork.objWork.velocity.y += FLOAT_TO_FX32(0.1);
    if (work->gameWork.objWork.velocity.y > FLOAT_TO_FX32(8.0))
        work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(8.0);

    work->angleSpeed += FLOAT_DEG_TO_IDX(0.044);
    if (work->angleSpeed > FLOAT_DEG_TO_IDX(5.625))
        work->angleSpeed = FLOAT_DEG_TO_IDX(5.625);

    work->angle += work->angleSpeed;

    MtxFx33 mtxRot;
    MTX_RotX33(&work->animator.work.rotation, SinFX(FLOAT_DEG_TO_IDX(319.922)), CosFX(FLOAT_DEG_TO_IDX(319.922)));

    u32 angle = (u32)((FLOAT_DEG_TO_IDX(180.0) * -FX_Div(work->gameWork.objWork.velocity.y, FLOAT_TO_FX32(5.0)))) >> 16;
    MTX_RotZ33(&mtxRot, SinFX(angle), CosFX(angle));
    MTX_Concat33(&work->animator.work.rotation, &mtxRot, &work->animator.work.rotation);

    MTX_RotY33(&mtxRot, SinFX(work->angle), CosFX(work->angle));
    MTX_Concat33(&work->animator.work.rotation, &mtxRot, &work->animator.work.rotation);

    if (work->gameWork.objWork.position.y > FLOAT_TO_FX32(800.0))
    {
        work->gameWork.objWork.position.y = FLOAT_TO_FX32(800.0);
        Boss2Arm__Func_215EBD8(work);
    }
}

void Boss2Arm__State2_215EF50(Boss2Arm *work)
{
    Boss2Ball *ball = work->stage->balls[work->type];

    work->field_3B8 = 0;
    work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;

    work->stage->balls[work->type]->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;
    work->gameWork.objWork.position.y = FLOAT_TO_FX32(1000.0);

    work->angle =
        BossHelpers__Arena__GetAngle(gPlayer->objWork.position.x, BOSS2_STAGE_START, BOSS2_STAGE_END) + FLOAT_DEG_TO_IDX(135.0) + mtMathRandRepeat(FLOAT_DEG_TO_IDX(90.0));
    work->field_374 = FLOAT_TO_FX32(400.0);

    MTX_RotY33(&work->animator.work.rotation, SinFX((s32)(u16)(work->angle - FLOAT_DEG_TO_IDX(90.0))), CosFX((s32)(u16)(work->angle - FLOAT_DEG_TO_IDX(90.0))));

    Boss2Ball__State2_215FB14(ball);
    Boss2Ball__Func_21600AC(&ball->spikeWorker);
    ball->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    work->state2 = Boss2Arm__State2_215F08C;
}

void Boss2Arm__State2_215F08C(Boss2Arm *work)
{
    Boss2 *boss = work->stage->boss;

    BOOL isIdle = FALSE;

    BossHelpers__Arena__GetXZPos(work->angle, work->field_374, &work->gameWork.objWork.position.x, &work->gameWork.objWork.position.z);

    fx32 velocity = MultiplyFX(FLOAT_TO_FX32(0.1), (work->gameWork.objWork.position.y + boss->mtxBody[work->type].m[3][1]));
    if (velocity > FLOAT_TO_FX32(8.0))
        velocity = FLOAT_TO_FX32(8.0);

    if (velocity < FLOAT_TO_FX32(0.009765625))
        isIdle = TRUE;

    work->gameWork.objWork.velocity.y = -velocity;

    if (isIdle)
        work->state2 = Boss2Arm__State2_215F128;
}

void Boss2Arm__State2_215F128(Boss2Arm *work)
{
    BOOL done = FALSE;

    work->field_374 -= FLOAT_TO_FX32(10.0);
    if (work->field_374 < FLOAT_TO_FX32(0.0))
    {
        work->field_374 = FLOAT_TO_FX32(0.0);
        done            = TRUE;
    }

    BossHelpers__Arena__GetXZPos(work->angle, work->field_374, &work->gameWork.objWork.position.x, &work->gameWork.objWork.position.z);

    if (done)
    {
        Boss2Ball__Func_216009C(&work->stage->balls[work->type]->spikeWorker);
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_PENDULUM_HIT);

        s16 nextDir;
        if (mtMathRandRepeat(2) != 0)
            nextDir = 1;
        else
            nextDir = -1;
        Boss2Arm__Func_215EBF0(work, work->angle - FLOAT_DEG_TO_IDX(90.0), nextDir);
    }
}

void Boss2Arm__State2_215F204(Boss2Arm *work)
{
    work->word3C6   = 0x400;
    work->field_3B8 = 1;

    Boss2Ball *ball = work->stage->balls[work->type];
    Boss2Ball__EnableSpikes(&ball->spikeWorker);
    ball->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    work->state2 = Boss2Arm__State2_215F254;
}

void Boss2Arm__State2_215F254(Boss2Arm *work)
{
    // Do nothing
}

void Boss2Arm__State2_215F258(Boss2Arm *work)
{
    work->field_374 = FLOAT_TO_FX32(0.0);
    work->field_3B8 = 0;

    work->gameWork.objWork.position.x = work->animator.work.translation.x;
    work->gameWork.objWork.position.y = -work->animator.work.translation.y;
    work->gameWork.objWork.position.z = work->animator.work.translation.z;

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

    work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(5.0);
    work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
    work->gameWork.objWork.velocity.z = FLOAT_TO_FX32(0.0);

    work->stage->balls[work->type]->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    work->state2 = Boss2Arm__State2_215F2C8;
}

void Boss2Arm__State2_215F2C8(Boss2Arm *work)
{
    work->field_374 += FLOAT_TO_FX32(2.0);

    if (work->field_374 > BOSS2_STAGE_RADIUS || work->gameWork.objWork.position.y > FLOAT_TO_FX32(1500.0))
    {
        work->field_374 = BOSS2_STAGE_RADIUS;

        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
        work->stage->balls[work->type]->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;

        work->gameWork.objWork.position.y = FLOAT_TO_FX32(1500.0);
        work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    }

    BossHelpers__Arena__GetXZPos(work->angle + FLOAT_DEG_TO_IDX(90.0), work->field_374, &work->gameWork.objWork.position.x, &work->gameWork.objWork.position.z);
}

void Boss2Ball__State_Active(Boss2Ball *work)
{
    Boss2Stage__GetBallConfig(work->stage, work->type, &work->spikeWorker.spikeDuration, &work->spikeWorker.vulnerableDuration);

    work->state2(work);
    work->spikeWorker.state3(work, &work->spikeWorker);
}

void Boss2Ball__Destructor(Task *task)
{
    Boss2Ball *work = TaskGetWork(task, Boss2Ball);

    AnimatorMDL__Release(&work->aniBall);
    AnimatorMDL__Release(&work->aniBallD);
    AnimatorMDL__Release(&work->aniBallM);
    AnimatorMDL__Release(&work->spikeWorker.aniSpike);

    ReleasePaletteAnimator(&work->aniPalette);

    FreeSndHandle(work->sndHandle);

    GameObject__Destructor(task);
}

void Boss2Ball__Draw(void)
{
    Boss2Ball *work = TaskGetWorkCurrent(Boss2Ball);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        PaletteAnimator *aniPalette;
        AnimatorMDL *aniSpike;
        AnimatorMDL *aniBall;

        aniBall = &work->aniBall;
        AnimatorMDL__ProcessAnimation(aniBall);
        AnimatorMDL__Draw(aniBall);

        BossHelpers__Model__SetMatrixMode(MTXSTACK_BOSS2BALL_BALL_HIT, &work->mtxBallCenter);

        aniSpike                             = &work->spikeWorker.aniSpike;
        *(MtxFx43 *)&aniSpike->work.rotation = *(MtxFx43 *)&work->mtxBallCenter;

        AnimatorMDL__ProcessAnimation(aniSpike);
        AnimatorMDL__Draw(aniSpike);

        Boss2Ball__Func_215F490(work);

        aniPalette = &work->aniPalette;
        AnimatePalette(aniPalette);
        DrawAnimatedPalette(aniPalette);
    }
}

NONMATCH_FUNC void Boss2Ball__Func_215F490(Boss2Ball *work)
{
	// will match when 'offset' is decompiled
#ifdef NON_MATCHING
    AnimatorMDL *aniBallD = &work->aniBallD;

    const fx32 offset[BOSS2_BALL_COUNT] = { [BOSS2_BALL_M] = 0x1A660, [BOSS2_BALL_S] = 0x2E328, [BOSS2_BALL_L] = 0x41FF0 };

    VEC_SetFromArray(&aniBallD->work.translation, work->mtxBallCenter.m[3]);

    fx32 position;
    BossHelpers__Arena__GetPosition(&position, BOSS2_STAGE_START, BOSS2_STAGE_END, BOSS2_STAGE_RADIUS, aniBallD->work.translation.x, aniBallD->work.translation.z);
    BossHelpers__Arena__Func_2038CDC(position, BOSS2_STAGE_START, BOSS2_STAGE_END, BOSS2_STAGE_RADIUS, &aniBallD->work.translation.x, &aniBallD->work.translation.z);

    aniBallD->work.translation.y -= offset[work->type];

    AnimatorMDL__Draw(aniBallD);
    AnimatorMDL__Draw(&work->aniBallM);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x18
	mov r5, r0
	add r0, r5, #0x2fc
	ldr r1, =Boss2Ball__Func_215F490_offset
	add r4, r0, #0x400
	add ip, sp, #0xc
	ldmia r1, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	add r3, r5, #0xfc
	add r0, r3, #0x400
	add r3, r4, #0x48
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r4, #0x48]
	ldr r2, =BOSS2_STAGE_END
	str r1, [sp]
	ldr ip, [r4, #0x50]
	ldr r3, =BOSS2_STAGE_RADIUS
	add r0, sp, #8
	mov r1, #BOSS2_STAGE_START
	str ip, [sp, #4]
	bl BossHelpers__Arena__GetPosition
	add r0, r4, #0x48
	str r0, [sp]
	add r0, r4, #0x50
	str r0, [sp, #4]
	ldr r0, [sp, #8]
	ldr r2, =BOSS2_STAGE_END
	ldr r3, =BOSS2_STAGE_RADIUS
	mov r1, #BOSS2_STAGE_START
	bl BossStage_GetCirclePos
	ldr r2, [r5, #0x37c]
	add r1, sp, #0xc
	ldr r3, [r4, #0x4c]
	ldr r1, [r1, r2, lsl #2]
	mov r0, r4
	sub r1, r3, r1
	str r1, [r4, #0x4c]
	bl AnimatorMDL__Draw
	add r0, r5, #0x840
	bl AnimatorMDL__Draw
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void Boss2Ball__Collide(void)
{
    Boss2Ball *work = TaskGetWorkCurrent(Boss2Ball);

    if ((work->gameWork.objWork.flag & (STAGE_TASK_FLAG_DESTROY_NEXT_FRAME | STAGE_TASK_FLAG_DESTROYED)) != 0)
        return;

    if ((work->gameWork.objWork.flag & (STAGE_TASK_FLAG_NO_OBJ_COLLISION)) != 0)
        return;

    if (work->field_208 > 0)
    {
        work->field_208--;
    }
    else
    {
        for (s32 i = 0; i < 2; i++)
        {
            OBS_RECT_WORK *colliderSrc = &work->gameWork.colliders[i];
            OBS_RECT_WORK *colliderDst = &work->field_188[i];

            colliderSrc->flag &= ~OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
            colliderDst->flag &= ~OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

            if ((colliderSrc->flag & OBS_RECT_WORK_FLAG_ENABLED) != 0)
            {
                BossHelpers__Collision__HandleArenaCollider(colliderSrc, colliderDst, (VecFx32 *)work->mtxBallCenter.m[3], BOSS2_STAGE_START, BOSS2_STAGE_END, BOSS2_STAGE_RADIUS);
            }
        }
    }
}

NONMATCH_FUNC void Boss2Ball__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    // https://decomp.me/scratch/MDWLZ -> 80.82%
#ifdef NON_MATCHING
    Boss2Ball *ball = (Boss2Ball *)rect2->parent;
    Player *player  = (Player *)rect1->parent;

    if (player->objWork.objType == STAGE_OBJ_TYPE_PLAYER && (player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) == 0)
    {
        fx32 position;
        BossHelpers__Arena__GetPosition(&position, BOSS2_STAGE_START, BOSS2_STAGE_END, BOSS2_STAGE_RADIUS, ball->mtxBallCenter.m[3][0], ball->mtxBallCenter.m[3][2]);

        fx32 y = -ball->mtxBallCenter.m[3][1];

        BOOL flag;
        if (ball->angleAccel > 0x4000)
        {
            flag = ball->field_20C;
        }
        else
        {
            if (MATH_ABS(player->objWork.velocity.x) > 128)
                flag = player->objWork.velocity.x <= 0;
            else
                flag = position < player->objWork.position.x;
        }

        fx32 velX = player->objWork.velocity.x;
        if (flag)
        {
            velX = MATH_MIN(velX, 0);
        }
        else
        {
            velX = MATH_MAX(velX, 0);
        }

        fx32 velY = player->objWork.velocity.y;
        velY      = MATH_MIN(velY, 0);

        velY = MATH_ABS(velY);
        velX = MATH_ABS(velX);

        fx32 playerForce = MultiplyFX(0xB50, velX) + MultiplyFX(0xB50, velY);
        if (playerForce < 0xB33)
            playerForce = 0xB33;

        fx16 weight = Boss2Stage__GetBallWeight(ball->stage, ball->type);
        Boss2Ball__Action_Hit(ball, flag, MultiplyFX(playerForce, weight));

        if (y < player->objWork.position.y)
        {
            player->objWork.flow.y     = y + FX32_FROM_WHOLE(rect2->rect.bottom) - (player->objWork.position.y + FX32_FROM_WHOLE(rect1->rect.top));
            player->objWork.velocity.y = FLOAT_TO_FX32(1.0);
        }
        else
        {
            player->objWork.flow.y     = y + FX32_FROM_WHOLE(rect2->rect.top) - (player->objWork.position.y + FX32_FROM_WHOLE(rect1->rect.bottom));
            player->objWork.velocity.y = -FLOAT_TO_FX32(4.0);
        }

        if (!flag)
            player->objWork.velocity.x = -FLOAT_TO_FX32(8.0);
        else
            player->objWork.velocity.x = FLOAT_TO_FX32(8.0);

        fx32 x, z;
        BossHelpers__Arena__Func_2038CDC(player->objWork.position.x, BOSS2_STAGE_START, BOSS2_STAGE_END, BOSS2_STAGE_RADIUS, &x, &z);

        BossFX__CreateHitB(BOSSFX3D_FLAG_NONE, x, -player->objWork.position.y, z);
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_PENDULUM_HIT);

        ball->field_208 = 4;

        for (s32 i = 0; i < 2; i++)
        {
            ball->gameWork.colliders[i].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
            ball->field_188[i].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
        }
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x1c
	mov r8, r0
	ldr r5, [r8, #0x1c]
	mov r7, r1
	ldrh r0, [r5, #0]
	ldr r4, [r7, #0x1c]
	cmp r0, #1
	addne sp, sp, #0x1c
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r0, [r5, #0x1c]
	tst r0, #1
	addne sp, sp, #0x1c
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r1, [r4, #0x4fc]
	ldr r2, =BOSS2_STAGE_END
	str r1, [sp]
	ldr r1, [r4, #0x504]
	ldr r3, =BOSS2_STAGE_RADIUS
	str r1, [sp, #4]
	add r0, sp, #8
	mov r1, #BOSS2_STAGE_START
	bl BossHelpers__Arena__GetPosition
	ldr r0, [r4, #0x500]
	rsb r0, r0, #0
	str r0, [sp, #0xc]
	ldr r0, [r4, #0x590]
	cmp r0, #0x4000
	ldrgt r6, [r4, #0x58c]
	bgt _0215F6C8
	ldr r0, [r5, #0x98]
	cmp r0, #0
	rsblt r1, r0, #0
	movge r1, r0
	cmp r1, #0x80
	ble _0215F6B4
	cmp r0, #0
	movle r6, #1
	movgt r6, #0
	b _0215F6C8
_0215F6B4:
	ldr r1, [sp, #8]
	ldr r0, [r5, #0x44]
	cmp r1, r0
	movlt r6, #1
	movge r6, #0
_0215F6C8:
	cmp r6, #0
	ldr r10, [r5, #0x98]
	beq _0215F6E0
	cmp r10, #0
	movgt r10, #0
	b _0215F6E8
_0215F6E0:
	cmp r10, #0
	movlt r10, #0
_0215F6E8:
	ldr r0, [r5, #0x9c]
	mov r1, #0xb50
	cmp r0, #0
	movgt r0, #0
	cmp r10, #0
	rsblt r10, r10, #0
	cmp r0, #0
	rsblt r0, r0, #0
	umull r9, lr, r10, r1
	mov r2, #0
	mla lr, r10, r2, lr
	umull ip, r3, r0, r1
	mla r3, r0, r2, r3
	mov r10, r10, asr #0x1f
	mov r0, r0, asr #0x1f
	adds r9, r9, #0x800
	mla lr, r10, r1, lr
	adc r10, lr, #0
	adds r2, ip, #0x800
	mla r3, r0, r1, r3
	mov r9, r9, lsr #0xc
	adc r0, r3, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	orr r9, r9, r10, lsl #20
	sub r0, r1, #0x1d
	add r9, r9, r2
	cmp r9, r0
	movlt r9, r0
	ldr r0, [r4, #0x370]
	ldr r1, [r4, #0x37c]
	bl Boss2Stage__GetBallWeight
	smull r1, r0, r9, r0
	adds r1, r1, #0x800
	adc r3, r0, #0
	mov r2, r1, lsr #0xc
	mov r0, r4
	mov r1, r6
	orr r2, r2, r3, lsl #20
	bl Boss2Ball__Action_Hit
	ldr r0, [r5, #0x48]
	ldr r9, [sp, #0xc]
	cmp r9, r0
	bge _0215F7B8
	ldrsh r3, [r7, #8]
	ldrsh r2, [r8, #2]
	mov r1, #0x1000
	add r3, r9, r3, lsl #12
	add r0, r0, r2, lsl #12
	sub r0, r3, r0
	str r0, [r5, #0xb4]
	b _0215F7D8
_0215F7B8:
	ldrsh r3, [r7, #2]
	ldrsh r2, [r8, #8]
	mov r1, #0x4000
	add r3, r9, r3, lsl #12
	add r0, r0, r2, lsl #12
	sub r0, r3, r0
	str r0, [r5, #0xb4]
	rsb r1, r1, #0
_0215F7D8:
	mov r0, #0x8000
	str r1, [r5, #0x9c]
	cmp r6, #0
	rsbeq r0, r0, #0
	str r0, [r5, #0x98]
	add r1, sp, #0x10
	str r1, [sp]
	add r0, sp, #0x18
	str r0, [sp, #4]
	ldr r0, [r5, #0x44]
	ldr r2, =BOSS2_STAGE_END
	ldr r3, =BOSS2_STAGE_RADIUS
	mov r1, #BOSS2_STAGE_START
	bl BossStage_GetCirclePos
	ldr r0, [r5, #0x48]
	ldr r1, [sp, #0x10]
	rsb r2, r0, #0
	ldr r3, [sp, #0x18]
	mov r0, #0
	str r2, [sp, #0x14]
	bl BossFX__CreateHitB
	mov r5, #0x9c
	sub r1, r5, #0x9d
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r5}
	bl PlaySfxEx
	add r0, r4, #0x500
	mov r1, #4
	strh r1, [r0, #0x88]
	mov r2, #0
_0215F858:
	add r1, r4, r2, lsl #6
	ldr r0, [r1, #0x230]
	add r2, r2, #1
	orr r0, r0, #0x800
	str r0, [r1, #0x230]
	ldr r0, [r1, #0x520]
	cmp r2, #2
	orr r0, r0, #0x800
	str r0, [r1, #0x520]
	blt _0215F858
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

void Boss2Ball__Func_215F890(Boss2Ball *work)
{
    Boss2Arm *arm = work->stage->arms[work->type];

    AnimatorMDL *aniBall = &work->aniBall;
    MtxFx33 *mtxRotation = &work->aniBall.work.rotation;

    aniBall->work.rotation = *(MtxFx33 *)&arm->mtxArmBall;

    VEC_Set((VecFx32 *)mtxRotation->m[1], FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0));
    VEC_CrossProduct((VecFx32 *)mtxRotation->m[0], (VecFx32 *)mtxRotation->m[1], (VecFx32 *)mtxRotation->m[2]);
    VEC_Normalize((VecFx32 *)mtxRotation->m[2], (VecFx32 *)mtxRotation->m[2]);
    VEC_CrossProduct((VecFx32 *)mtxRotation->m[1], (VecFx32 *)mtxRotation->m[2], (VecFx32 *)mtxRotation->m[0]);

    VEC_SetFromArray(&work->aniBall.work.translation, arm->mtxArmBall.m[3]);
}

void Boss2Ball__SetupObject(Boss2Ball *work)
{
    work->field_378 = 0;

    work->state2 = Boss2Ball__State_215FAE0;
    work->state2(work);
}

NONMATCH_FUNC void Boss2Ball__Func_215F944(Boss2Ball *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	mov r2, #1
	ldr r1, =Boss2Ball__State2_215FB14
	str r2, [r0, #0x378]
	str r1, [r0, #0x374]
	blx r1
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss2Ball__Action_Hit(Boss2Ball *work, s32 direction, fx32 force)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr ip, [r0, #0x370]
	ldr r4, [r0, #0x37c]
	mov r3, #2
	add r4, ip, r4, lsl #2
	ldr lr, [r4, #0x374]
	str r3, [r0, #0x378]
	str r1, [r0, #0x58c]
	ldr r3, [lr, #0x3bc]
	cmp r3, #0
	mov r3, #0
	beq _0215FA6C
	cmp r1, #0
	beq _0215F9E4
	add ip, lr, #0x300
	ldrsh r4, [ip, #0xc2]
	cmp r4, #0
	ble _0215F9E4
	ldrsh r1, [ip, #0xc4]
	cmp r4, r1
	ble _0215FA38
	sub r4, r4, r1
	mov r1, #0x64000
	umull lr, ip, r4, r1
	mla ip, r4, r3, ip
	mov r4, r4, asr #0x1f
	mla ip, r4, r1, ip
	adds r4, lr, #0x800
	adc r1, ip, r3
	mov r3, r4, lsr #0xc
	orr r3, r3, r1, lsl #20
	b _0215FA38
_0215F9E4:
	cmp r1, #0
	bne _0215FA38
	add r1, lr, #0x300
	ldrsh ip, [r1, #0xc2]
	cmp ip, #0
	ldrltsh r4, [r1, #0xc4]
	rsblt r1, r4, #0
	cmplt ip, r1
	bge _0215FA38
	add r1, r4, ip
	rsb r4, r1, #0
	mov r1, #0x64000
	umull lr, ip, r4, r1
	mov r3, #0
	mla ip, r4, r3, ip
	mov r3, r4, asr #0x1f
	adds r4, lr, #0x800
	mla ip, r3, r1, ip
	adc r1, ip, #0
	mov r3, r4, lsr #0xc
	orr r3, r3, r1, lsl #20
_0215FA38:
	ldr r1, =0x00000CCC
	mov ip, #0
	umull lr, r4, r3, r1
	mla r4, r3, ip, r4
	mov r3, r3, asr #0x1f
	adds ip, lr, #0x800
	mla r4, r3, r1, r4
	adc r1, r4, #0
	mov r3, ip, lsr #0xc
	orr r3, r3, r1, lsl #20
	add r1, r2, r3
	str r1, [r0, #0x590]
	b _0215FA9C
_0215FA6C:
	ldr ip, [r0, #0x590]
	ldr r1, =0x00000CCC
	umull r4, lr, ip, r1
	mla lr, ip, r3, lr
	mov r3, ip, asr #0x1f
	mla lr, r3, r1, lr
	adds r4, r4, #0x800
	adc r1, lr, #0
	mov r3, r4, lsr #0xc
	orr r3, r3, r1, lsl #20
	add r1, r3, r2
	str r1, [r0, #0x590]
_0215FA9C:
	ldr r1, =Boss2Ball__State2_InitHit
	str r1, [r0, #0x374]
	blx r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss2Ball__Action_HitRecoil(Boss2Ball *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	mov r2, #3
	str r2, [r0, #0x378]
	mov r2, #0
	str r2, [r0, #0x590]
	ldr r1, =Boss2Ball__State2_215FF00
	str r2, [r0, #0x594]
	str r1, [r0, #0x374]
	blx r1
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss2Ball__State_215FAE0(Boss2Ball *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r1, #0x3e8000
	rsb r1, r1, #0
	str r1, [r0, #0x48]
	ldr r1, [r0, #0x20]
	ldr ip, =Boss2Ball__DisableSpikes
	orr r1, r1, #0x20
	str r1, [r0, #0x20]
	ldr r1, [r0, #0x18]
	orr r1, r1, #2
	str r1, [r0, #0x18]
	add r0, r0, #0x380
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void Boss2Ball__State2_215FB14(Boss2Ball *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x20]
	add r0, r4, #0x1b8
	bic r1, r1, #0x20
	str r1, [r4, #0x20]
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	ldr r3, [r4, #0x37c]
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	add r3, r3, #3
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x18]
	add r0, r4, #0x380
	bic r1, r1, #2
	str r1, [r4, #0x18]
	bl Boss2Ball__EnableSpikes
	ldr r0, =Boss2Ball__State2_215FB78
	str r0, [r4, #0x374]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss2Ball__State2_215FB78(Boss2Ball *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =Boss2Ball__Func_215F890
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void Boss2Ball__State2_InitHit(Boss2Ball *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r2, [r4, #0x370]
	ldr r1, [r4, #0x37c]
	ldr r0, [r4, #0x20]
	add r1, r2, r1, lsl #2
	ldr r2, [r1, #0x374]
	bic r0, r0, #0x20
	str r0, [r4, #0x20]
	mov r1, #0
	add r0, r4, #0x380
	str r1, [r2, #0x3bc]
	bl Boss2Ball__Func_216009C
	add r0, r4, #0x380
	bl Boss2Ball__DisableSpikes
	ldr r0, [r4, #0x590]
	mov r1, #0
	str r0, [r4, #0x594]
	ldr r0, [r4, #0x58c]
	cmp r0, #0
	str r1, [sp]
	str r1, [sp, #4]
	movne ip, #0x28
	add r0, r4, #0x1b8
	ldr r3, [r4, #0x37c]
	moveq ip, #0x2e
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	add r3, ip, r3
	bl BossHelpers__SetAnimation
	mov r1, #0
	ldr r0, =Boss2Ball__State2_Hit
	str r1, [r4, #0x6d0]
	str r0, [r4, #0x374]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss2Ball__State2_Hit(Boss2Ball *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r7, r0
	mov r1, #0x6000
	ldr r0, [r7, #0x594]
	rsb r1, r1, #0
	cmp r0, r1
	ldr r0, [r7, #0x69c]
	strlt r1, [r7, #0x594]
	ldr r2, [r0, #0]
	ldr r1, [r7, #0x594]
	add r1, r2, r1
	str r1, [r0]
	ldr r1, [r7, #0x594]
	sub r1, r1, #0x66
	sub r1, r1, #0x200
	str r1, [r7, #0x594]
	ldr r2, [r0, #0]
	cmp r2, #0
	bgt _0215FD24
	ldr r3, [r7, #0x370]
	ldr r1, [r7, #0x37c]
	mov r2, #0
	add r1, r3, r1, lsl #2
	ldr r3, [r1, #0x374]
	mov r1, #1
	str r2, [r0]
	str r1, [r3, #0x3bc]
	add r0, r3, #0x300
	ldrsh r0, [r0, #0xc2]
	add r2, r3, #0x300
	mov r1, #0
	cmp r0, #0
	rsblt r0, r0, #0
	strh r0, [r2, #0xc2]
	ldr r3, [r7, #0x590]
	mov r0, #0x28
	umull r5, r4, r3, r0
	mla r4, r3, r1, r4
	mov r1, r3, asr #0x1f
	mla r4, r1, r0, r4
	adds r3, r5, #0x800
	mov r1, r3, lsr #0xc
	adc r0, r4, #0
	orr r1, r1, r0, lsl #20
	ldrsh r3, [r2, #0xc2]
	mov r0, r1, lsl #0x10
	add r0, r3, r0, asr #16
	strh r0, [r2, #0xc2]
	ldr r0, [r7, #0x58c]
	cmp r0, #0
	ldreqsh r0, [r2, #0xc2]
	rsbeq r0, r0, #0
	streqh r0, [r2, #0xc2]
	mov r0, #0
	str r0, [r7, #0x590]
	mov r0, #0x1000
	str r0, [r7, #0x6d0]
	ldr r1, [r7, #0x594]
	mov r0, r7
	cmp r1, #0
	rsblt r1, r1, #0
	str r1, [r7, #0x590]
	bl Boss2Ball__Func_215F944
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215FD24:
	ldr r1, [r0, #8]
	sub r0, r2, #1
	ldrh r1, [r1, #4]
	cmp r0, r1, lsl #12
	blt _0215FEEC
	ldr r4, [r7, #0x370]
	mov r0, r4
	bl Boss2__GetBossPhase
	mov r5, r0
	ldr r1, [r7, #0x37c]
	mov r0, r4
	bl Boss2Stage__GetImpactDamage
	ldr r1, [r7, #0x370]
	add r1, r1, #0x300
	ldrsh r2, [r1, #0x98]
	sub r2, r2, r0
	mov r0, r4
	strh r2, [r1, #0x98]
	bl Boss2__GetBossPhase
	ldr r2, =Boss2__activeArmCountTable
	mov r6, r0
	ldr r1, [r2, r6, lsl #2]
	ldr r0, [r2, r5, lsl #2]
	cmp r0, r1
	bge _0215FDAC
	ldr r0, [r7, #0x370]
	ldr r0, [r0, #0x370]
	str r1, [r0, #0x494]
	ldr r0, [r7, #0x370]
	add r0, r0, r1, lsl #2
	ldr r0, [r0, #0x374]
	bl Boss2Arm__Action_215EBC0
	mov r0, r4
	bl Boss2__Func_215C240
_0215FDAC:
	cmp r5, r6
	beq _0215FDC4
	cmp r6, #3
	blo _0215FDC4
	mov r0, #1
	bl ChangeBossBGMVariant
_0215FDC4:
	ldr r1, [r7, #0x370]
	add r0, r1, #0x300
	ldrsh r0, [r0, #0x98]
	cmp r0, #0
	ble _0215FE14
	mov r0, #0x1000
	str r0, [r7, #0x6d0]
	ldr r0, [r7, #0x370]
	ldr r0, [r0, #0x370]
	bl Boss2__Action_Attack2
	mov r0, r7
	bl Boss2Ball__Action_HitRecoil
	mov r3, #0x8c
	sub r1, r3, #0x8d
	mov r0, #0
	stmia sp, {r0, r3}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	b _0215FEA8
_0215FE14:
	ldr r0, [r1, #0x370]
	ldr r0, [r0, #0x384]
	cmp r0, #3
	beq _0215FEA0
	mov r0, r4
	bl Boss2__GetBossPhase
	ldr r1, =Boss2__activeArmCountTable
	mov r5, #0
	ldr r0, [r1, r0, lsl #2]
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	movs r6, r0, lsr #0x10
	beq _0215FE6C
_0215FE48:
	ldr r0, [r7, #0x370]
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0x374]
	bl Boss2Arm__Func_215EC24
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	cmp r6, r0, lsr #16
	mov r5, r0, lsr #0x10
	bhi _0215FE48
_0215FE6C:
	ldr r0, [r7, #0x370]
	ldr r0, [r0, #0x370]
	bl Boss2__Action_Attack3
	mov r5, #0xce
	sub r1, r5, #0xcf
	add r0, r4, #0x300
	mov r2, #1
	strh r2, [r0, #0x98]
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r5}
	bl PlaySfxEx
_0215FEA0:
	mov r0, r7
	bl Boss2Ball__Action_HitRecoil
_0215FEA8:
	add r0, r4, #0x300
	ldrsh r0, [r0, #0x98]
	bl UpdateBossHealthHUD
	ldr r1, [r7, #0x4fc]
	ldr r2, [r7, #0x500]
	ldr r3, [r7, #0x504]
	mov r0, #0
	bl BossFX__CreateHitA
	mov r5, r0
	ldr r1, [r7, #0x37c]
	mov r0, r4
	bl Boss2__GetHitFXScale
	str r0, [r5, #0x38]
	str r0, [r5, #0x3c]
	add sp, sp, #8
	str r0, [r5, #0x40]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215FEEC:
	mov r0, r7
	bl Boss2Ball__Func_215F890
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss2Ball__State2_215FF00(Boss2Ball *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r2, [r5, #0x370]
	ldr r1, [r5, #0x37c]
	ldr r0, [r5, #0x18]
	add r1, r2, r1, lsl #2
	ldr r4, [r1, #0x374]
	orr r1, r0, #2
	add r0, r5, #0x380
	str r1, [r5, #0x18]
	bl Boss2Ball__Func_216009C
	add r0, r5, #0x380
	bl Boss2Ball__DisableSpikes
	mov r0, #1
	str r0, [r4, #0x3bc]
	ldr r2, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	str r1, [r2]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #1
	mov r1, #0x800
	rsbeq r1, r1, #0
	add r0, r4, #0x300
	strh r1, [r0, #0xc2]
	ldr r2, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r3, [r2, #0]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0xf
	str r1, [r2]
	add r0, r0, #0x1e
	str r0, [r5, #0x2c]
	ldr r0, [r5, #0x58c]
	mov r1, #0
	cmp r0, #0
	str r1, [sp]
	str r1, [sp, #4]
	movne r4, #0x2b
	add r0, r5, #0x1b8
	ldr r3, [r5, #0x37c]
	moveq r4, #0x31
	ldr r2, [r5, #0x368]
	add r0, r0, #0x400
	add r3, r4, r3
	bl BossHelpers__SetAnimation
	ldr r0, =Boss2Ball__State2_215FFFC
	str r0, [r5, #0x374]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss2Ball__State2_215FFFC(Boss2Ball *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r2, [r4, #0x370]
	ldr r1, [r4, #0x37c]
	add r1, r2, r1, lsl #2
	ldr r5, [r1, #0x374]
	bl Boss2Ball__Func_215F890
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	ble _02160050
	sub r0, r0, #1
	str r0, [r4, #0x2c]
	add r0, r5, #0x300
	mov r1, #0x800
	strh r1, [r0, #0xc6]
	ldrsh r0, [r0, #0xc2]
	cmp r0, #0
	suble r1, r1, #0x1000
	add r0, r5, #0x300
	strh r1, [r0, #0xc2]
	b _0216005C
_02160050:
	add r0, r5, #0x300
	mov r1, #0x400
	strh r1, [r0, #0xc6]
_0216005C:
	add r0, r4, #0x600
	ldrh r0, [r0, #0xc4]
	tst r0, #0x8000
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl Boss2Ball__Func_215F944
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void Boss2Ball__EnableSpikes(Boss2BallSpikeWorker *worker)
{
    worker->disableSpikes = FALSE;
}

void Boss2Ball__DisableSpikes(Boss2BallSpikeWorker *worker)
{
    worker->disableSpikes = TRUE;
}

void Boss2Ball__Func_216009C(Boss2BallSpikeWorker *worker)
{
    worker->state3 = Boss2Ball__StateSpikes_2160354;
}

void Boss2Ball__Func_21600AC(Boss2BallSpikeWorker *worker)
{
    worker->state3 = Boss2Ball__StateSpikes_21600BC;
}

NONMATCH_FUNC void Boss2Ball__StateSpikes_21600BC(Boss2Ball *work, Boss2BallSpikeWorker *worker)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r1
	mov r1, #0
	str r1, [r4, #4]
	mov r5, r0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	ldr r3, [r5, #0x37c]
	ldr r2, [r5, #0x368]
	add r0, r4, #0x14
	add r3, r3, #0x37
	bl BossHelpers__SetAnimation
	mov r0, #0
	str r0, [sp]
	mov r0, #1
	str r0, [sp, #4]
	ldr r1, [r5, #0x37c]
	ldr r2, [r5, #0x36c]
	add r0, r4, #0x14
	add r3, r1, #3
	mov r1, #4
	bl BossHelpers__SetAnimation
	ldr r1, [r5, #0x230]
	add r0, r5, #0x500
	bic r1, r1, #4
	str r1, [r5, #0x230]
	ldr r1, [r5, #0x270]
	bic r1, r1, #4
	str r1, [r5, #0x270]
	ldrh r0, [r0, #0x9c]
	cmp r0, #1
	beq _0216015C
	add r0, r5, #0x198
	mov r2, #0
	mov r3, r2
	add r0, r0, #0x400
	mov r1, #1
	bl BossHelpers__SetPaletteAnimations
_0216015C:
	ldr r0, =Boss2Ball__StateSpikes_Blank
	str r0, [r4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void Boss2Ball__StateSpikes_Blank(Boss2Ball *work, Boss2BallSpikeWorker *worker)
{
    // Do nothing
}

NONMATCH_FUNC void Boss2Ball__StateSpikes_2160174(Boss2Ball *work, Boss2BallSpikeWorker *worker)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r1
	mov r2, #1
	str r2, [r4, #4]
	mov r1, #0
	mov r5, r0
	stmia sp, {r1, r2}
	ldr r3, [r5, #0x37c]
	ldr r2, [r5, #0x368]
	add r0, r4, #0x14
	add r3, r3, #0x34
	bl BossHelpers__SetAnimation
	mov r0, #0
	str r0, [sp]
	mov r0, #1
	str r0, [sp, #4]
	ldr r2, [r5, #0x36c]
	ldr r3, [r5, #0x37c]
	add r0, r4, #0x14
	mov r1, #4
	bl BossHelpers__SetAnimation
	ldr r1, [r5, #0x230]
	add r0, r5, #0x500
	bic r1, r1, #4
	str r1, [r5, #0x230]
	ldr r1, [r5, #0x270]
	orr r1, r1, #4
	str r1, [r5, #0x270]
	ldrh r0, [r0, #0x9c]
	cmp r0, #1
	beq _0216020C
	mov r1, #1
	add r0, r5, #0x198
	mov r2, r1
	mov r3, r1
	add r0, r0, #0x400
	bl BossHelpers__SetPaletteAnimations
_0216020C:
	mov r1, #0
	mov r0, #0x9a
	str r1, [sp]
	sub r1, r0, #0x9b
	str r0, [sp, #4]
	ldr r0, [r5, #0x984]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add r1, r5, #0xfc
	ldr r0, [r5, #0x984]
	add r1, r1, #0x400
	bl ProcessSpatialVoiceClip
	mov r0, #0
	str r0, [r4, #0x10]
	ldr r2, =Boss2Ball__StateSpikes_2160268
	mov r0, r5
	mov r1, r4
	str r2, [r4]
	blx r2
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss2Ball__StateSpikes_2160268(Boss2Ball *work, Boss2BallSpikeWorker *worker){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r0, [r1, #8]
	cmp r0, #0
	bxne lr
	ldrh r0, [r1, #0xc]
	cmp r0, #0
	bxeq lr
	ldr r0, [r1, #0x10]
	add r2, r0, #1
	str r2, [r1, #0x10]
	ldrh r0, [r1, #0xc]
	cmp r2, r0
	ldrhi r0, =Boss2Ball__StateSpikes_21602A4
	strhi r0, [r1]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss2Ball__StateSpikes_21602A4(Boss2Ball *work, Boss2BallSpikeWorker *worker)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r1
	mov r1, #2
	str r1, [r4, #4]
	mov r1, #0
	str r1, [sp]
	mov r5, r0
	str r1, [sp, #4]
	ldr r3, [r5, #0x37c]
	ldr r2, [r5, #0x368]
	add r0, r4, #0x14
	add r3, r3, #0x3d
	bl BossHelpers__SetAnimation
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	ldr r1, [r5, #0x37c]
	ldr r2, [r5, #0x36c]
	add r0, r4, #0x14
	add r3, r1, #9
	mov r1, #4
	bl BossHelpers__SetAnimation
	ldr r1, [r5, #0x230]
	add r0, r5, #0x500
	orr r1, r1, #4
	str r1, [r5, #0x230]
	ldr r1, [r5, #0x270]
	bic r1, r1, #4
	str r1, [r5, #0x270]
	ldrh r0, [r0, #0x9c]
	cmp r0, #2
	beq _02160340
	add r0, r5, #0x198
	mov r1, #1
	mov r3, r1
	add r0, r0, #0x400
	mov r2, #2
	bl BossHelpers__SetPaletteAnimations
_02160340:
	ldr r0, =Boss2Ball__StateSpikes_2160354
	str r0, [r4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss2Ball__StateSpikes_2160354(Boss2Ball *work, Boss2BallSpikeWorker *worker)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r1
	mov r1, #3
	str r1, [r4, #4]
	mov r1, #0
	mov r5, r0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	ldr r3, [r5, #0x37c]
	ldr r2, [r5, #0x368]
	add r0, r4, #0x14
	add r3, r3, #0x37
	bl BossHelpers__SetAnimation
	mov r0, #0
	str r0, [sp]
	mov r0, #1
	str r0, [sp, #4]
	ldr r1, [r5, #0x37c]
	ldr r2, [r5, #0x36c]
	add r0, r4, #0x14
	add r3, r1, #3
	mov r1, #4
	bl BossHelpers__SetAnimation
	ldr r1, [r5, #0x230]
	add r0, r5, #0x500
	orr r1, r1, #4
	str r1, [r5, #0x230]
	ldr r1, [r5, #0x270]
	bic r1, r1, #4
	str r1, [r5, #0x270]
	ldrh r0, [r0, #0x9c]
	cmp r0, #2
	beq _021603F8
	add r0, r5, #0x198
	mov r1, #1
	mov r3, r1
	add r0, r0, #0x400
	mov r2, #2
	bl BossHelpers__SetPaletteAnimations
_021603F8:
	mov r0, #0
	str r0, [r4, #0x10]
	ldr r2, =Boss2Ball__StateSpikes_2160420
	mov r0, r5
	mov r1, r4
	str r2, [r4]
	blx r2
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss2Ball__StateSpikes_2160420(Boss2Ball *work, Boss2BallSpikeWorker *worker){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r0, [r1, #8]
	cmp r0, #0
	bxne lr
	ldrh r0, [r1, #0xe]
	cmp r0, #0
	bxeq lr
	ldr r0, [r1, #0x10]
	add r2, r0, #1
	str r2, [r1, #0x10]
	ldrh r0, [r1, #0xe]
	cmp r2, r0
	ldrhi r0, =Boss2Ball__StateSpikes_216045C
	strhi r0, [r1]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss2Ball__StateSpikes_216045C(Boss2Ball *work, Boss2BallSpikeWorker *worker)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r1
	mov r1, #4
	str r1, [r4, #4]
	mov r1, #0
	str r1, [sp]
	mov r5, r0
	str r1, [sp, #4]
	ldr r3, [r5, #0x37c]
	ldr r2, [r5, #0x368]
	add r0, r4, #0x14
	add r3, r3, #0x3a
	bl BossHelpers__SetAnimation
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	ldr r1, [r5, #0x37c]
	ldr r2, [r5, #0x36c]
	add r0, r4, #0x14
	add r3, r1, #6
	mov r1, #4
	bl BossHelpers__SetAnimation
	ldr r1, [r5, #0x230]
	add r0, r5, #0x500
	orr r1, r1, #4
	str r1, [r5, #0x230]
	ldr r1, [r5, #0x270]
	bic r1, r1, #4
	str r1, [r5, #0x270]
	ldrh r0, [r0, #0x9c]
	cmp r0, #2
	beq _021604F8
	add r0, r5, #0x198
	mov r1, #1
	mov r3, r1
	add r0, r0, #0x400
	mov r2, #2
	bl BossHelpers__SetPaletteAnimations
_021604F8:
	ldr r0, =Boss2Ball__StateSpikes_216050C
	str r0, [r4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss2Ball__StateSpikes_216050C(Boss2Ball *work, Boss2BallSpikeWorker *worker){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r0, r1, #0x100
	ldrh r0, [r0, #0x20]
	tst r0, #0x8000
	ldrne r0, =Boss2Ball__StateSpikes_2160174
	strne r0, [r1]
	bx lr

// clang-format on
#endif
}

Boss2Bomb *Boss2Bomb__Spawn(Boss2Stage *work, fx32 moveSpeed, BOOL flipped)
{
    Boss2Bomb *bomb = SpawnStageObject(MAPOBJECT_282, FLOAT_TO_FX32(0.0), -work->boss->mtxBody[2].m[3][1], Boss2Bomb);

    bomb->gameWork.objWork.parentObj = &work->gameWork.objWork;
    bomb->stage                      = work;
    bomb->moveSpeed                  = MATH_ABS(moveSpeed);

    if (flipped)
    {
        bomb->moveSpeed = -bomb->moveSpeed;
        bomb->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
    }

    work->bomb = bomb;

    return bomb;
}

void Boss2Bomb__State_Active(Boss2Bomb *work)
{
    work->state2(work);
}

void Boss2Bomb__Destructor(Task *task)
{
    Boss2Bomb *work = TaskGetWork(task, Boss2Bomb);

    AnimatorMDL__Release(&work->aniBomb);

    GameObject__Destructor(task);
}

void Boss2Bomb__Draw(void)
{
    Boss2Bomb *work = TaskGetWorkCurrent(Boss2Bomb);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        if (work->field_380 == FALSE)
        {
            BossHelpers__Arena__GetObjectDrawMtx(&work->gameWork.objWork, &work->aniBomb, BOSS2_STAGE_START, BOSS2_STAGE_END, BOSS2_STAGE_RADIUS);
        }
        else
        {
            VEC_Set(&work->aniBomb.work.translation, work->gameWork.objWork.position.x, -work->gameWork.objWork.position.y, work->gameWork.objWork.position.z);
        }

        AnimatorMDL__ProcessAnimation(&work->aniBomb);
        AnimatorMDL__Draw(&work->aniBomb);
    }
}

void Boss2Bomb__Collide(void)
{
    Boss2Bomb *work = TaskGetWorkCurrent(Boss2Bomb);

    if ((work->gameWork.objWork.flag & (STAGE_TASK_FLAG_DESTROY_NEXT_FRAME | STAGE_TASK_FLAG_DESTROYED)) != 0)
        return;

    if ((work->gameWork.objWork.flag & (STAGE_TASK_FLAG_NO_OBJ_COLLISION)) != 0)
        return;

    if ((work->gameWork.colliders[0].flag & OBS_RECT_WORK_FLAG_ENABLED) == 0)
        return;

    BossHelpers__Collision__InitArenaCollider(&work->gameWork.colliders[0], &work->field_390, work->gameWork.objWork.position.x, work->gameWork.objWork.position.y,
                                              BOSS2_STAGE_START, BOSS2_STAGE_END, BOSS2_STAGE_RADIUS);
}

void Boss2Bomb__OnDefend_21606DC(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Boss2Bomb *bomb = (Boss2Bomb *)rect2->parent;
    Player *player  = (Player *)rect1->parent;

    if (player->objWork.objType == STAGE_OBJ_TYPE_PLAYER)
    {
        bomb->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
        bomb->field_390.flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
        Boss2Bomb__Func_216073C(bomb);
        Player__Action_DestroyAttackRecoil(player);
    }
}

void Boss2Bomb__SetupObject(Boss2Bomb *work)
{
    work->field_378 = 0;

    work->state2 = Boss2Bomb__State2_216075C;
    work->state2(work);
}

void Boss2Bomb__Func_216073C(Boss2Bomb *work)
{
    work->field_378 = 2;

    work->state2 = Boss2Bomb__State2_2160938;
    work->state2(work);
}

void Boss2Bomb__State2_216075C(Boss2Bomb *work)
{
    work->field_380 = TRUE;

    work->state2 = Boss2Bomb__State2_2160774;
}

void Boss2Bomb__State2_2160774(Boss2Bomb *work)
{
    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
        work->state2 = Boss2Bomb__State2_216078C;
}

void Boss2Bomb__State2_216078C(Boss2Bomb *work)
{
    work->gameWork.objWork.userTimer = 60;

    work->state2 = Boss2Bomb__State2_21607AC;
    work->state2(work);
}

void Boss2Bomb__State2_21607AC(Boss2Bomb *work)
{
    work->gameWork.objWork.userTimer--;

    if (work->gameWork.objWork.userTimer == 0)
        work->state2 = Boss2Bomb__State2_21607C8;
}

NONMATCH_FUNC void Boss2Bomb__State2_21607C8(Boss2Bomb *work)
{
    // https://decomp.me/scratch/XdCQn -> 50.45%
#ifdef NON_MATCHING
    work->field_38C = 0;

    UNUSED(mtMathRand());

    work->field_388 = 0x4000;
    MTX_RotY33(&work->aniBomb.work.rotation, SinFX(FLOAT_DEG_TO_IDX(45.0)), CosFX(FLOAT_DEG_TO_IDX(45.0)));

    work->state2 = Boss2Bomb__State2_EnterArena;
    work->state2(work);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	mov r1, #0
	mov r3, #0x4000
	mov r0, r3, asr #4
	mov r5, r0, lsl #1
	str r1, [r4, #0x38c]
	ldr ip, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r6, [ip]
	ldr r1, =0x3C6EF35F
	add r2, r5, #1
	mla r7, r6, r0, r1
	str r7, [ip]
	add ip, r4, #0x300
	ldr lr, =FX_SinCosTable_
	mov r1, r5, lsl #1
	mov r0, r2, lsl #1
	ldrsh r2, [lr, r0]
	ldrsh r1, [lr, r1]
	add r0, r4, #0x3f4
	strh r3, [ip, #0x88]
	bl MTX_RotY33_
	ldr r1, =Boss2Bomb__State2_EnterArena
	mov r0, r4
	str r1, [r4, #0x374]
	blx r1
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void Boss2Bomb__State2_EnterArena(Boss2Bomb *work)
{
    work->field_38C += 0x3000;

    BOOL isDone = FALSE;
    if (work->field_38C >= BOSS2_STAGE_RADIUS)
    {
        isDone          = TRUE;
        work->field_38C = BOSS2_STAGE_RADIUS;
    }

    BossHelpers__Arena__GetXZPos(work->field_388, work->field_38C, &work->gameWork.objWork.position.x, &work->gameWork.objWork.position.z);

    if (isDone)
    {
        work->field_380 = FALSE;
        BossHelpers__Arena__GetPosition(&work->gameWork.objWork.position.x, BOSS2_STAGE_START, BOSS2_STAGE_END, BOSS2_STAGE_RADIUS, work->gameWork.objWork.position.x,
                                        work->gameWork.objWork.position.z);

        work->gameWork.objWork.position.z = FLOAT_TO_FX32(0.0);

        work->state2 = Boss2Bomb__State2_StartMoving;
    }
}

void Boss2Bomb__State2_StartMoving(Boss2Bomb *work)
{
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_ENABLED;

    work->timer = 120;

    work->state2 = Boss2Bomb__State2_Moving;
}

void Boss2Bomb__State2_Moving(Boss2Bomb *work)
{
    if (work->timer != 0)
    {
        work->timer--;

        if (work->timer == 0)
            work->gameWork.objWork.velocity.x = work->moveSpeed;
        else
            work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
    }
}

void Boss2Bomb__State2_2160938(Boss2Bomb *work)
{
    Boss2Stage *stage = (Boss2Stage *)work->gameWork.objWork.parentObj;
    if (stage != NULL)
        stage->bomb = NULL;

    QueueDestroyStageTask(&work->gameWork.objWork);

    BossFX__CreateBomb(BOSSFX2D_FLAG_NONE, work->aniBomb.work.translation.x, work->aniBomb.work.translation.y + FLOAT_TO_FX32(32.0), work->aniBomb.work.translation.z);

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_B_BOMB);

    work->state2 = Boss2Bomb__State2_21609A8;
}

void Boss2Bomb__State2_21609A8(Boss2Bomb *work)
{
    // Do nothing
}

void Boss2Wave__State_Active(Boss2Wave *work)
{
    fx32 frame = work->aniWave.currentAnimObj[0]->frame;
    if (frame >= FLOAT_TO_FX32(27.0) && frame < FLOAT_TO_FX32(29.0) && BossHelpers__Player__IsAlive(gPlayer))
    {
        if ((gPlayer->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0 && gPlayer->blinkTimer == 0)
            Player__Hurt(gPlayer);
    }

    if ((work->aniWave.animFlags[0] & ANIMATORMDL_FLAG_FINISHED) != 0)
        work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DESTROY_NEXT_FRAME;
}

void Boss2Wave__Destructor(Task *task)
{
    Boss2Wave *work = TaskGetWork(task, Boss2Wave);

    AnimatorMDL__Release(&work->aniWave);

    GameObject__Destructor(task);
}

void Boss2Wave__Draw(void)
{
    Boss2Wave *work = TaskGetWorkCurrent(Boss2Wave);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        AnimatorMDL__ProcessAnimation(&work->aniWave);
        AnimatorMDL__Draw(&work->aniWave);
    }
}