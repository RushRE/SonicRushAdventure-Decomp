#include <ex/boss/exBossFireDragon.h>
#include <ex/boss/exBoss.h>
#include <ex/effects/exBossFireEffect.h>
#include <ex/effects/exBossShotEffect.h>
#include <ex/system/exDrawReq.h>
#include <ex/system/exSystem.h>
#include <ex/system/exStage.h>
#include <ex/system/exUtils.h>
#include <ex/system/exMath.h>
#include <game/file/binaryBundle.h>
#include <game/audio/audioSystem.h>

// Resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// CONSTANTS
// --------------------

#define EXBOSSFIREDRAGON_HEALTH_EASY   12
#define EXBOSSFIREDRAGON_HEALTH_NORMAL 9

// --------------------
// VARIABLES
// --------------------

static s16 exBossFireDragonInstanceCount;
static s16 exBossFireDragonExplosionInstanceCount;

static u32 exBossFireDragonTextureFileSize;
static void *exBossFireDragonExplosionSpriteResource;
static u32 exBossFireDragonUnused;
static EX_ACTION_NN_WORK *exBossFireDragonLastSpawnedWorker;
static void *exBossFireDragonModelResource;
static Task *exBossFireDragonTaskSingleton;
static u32 exBossFireDragonModelFileSize;

// Interestingly, this array has 4 entries... So maybe at one point the boss was supposed to spawn 4 dragons instead of 3?
static u16 dragonStartAngles[EXBOSS_FIRE_DRAGON_COUNT + 1] = { FLOAT_DEG_TO_IDX(135.0), FLOAT_DEG_TO_IDX(178.9948), FLOAT_DEG_TO_IDX(1.0), FLOAT_DEG_TO_IDX(45.0) };

// force linkage of variables with no apparent references
FORCE_INCLUDE_VARIABLE_BSS(exBossFireDragonUnused)

// --------------------
// FUNCTION DECLS
// --------------------

// Fire Dragon Explosion
static void LoadExBossFireDragonExplosionAssets(EX_ACTION_BAC3D_WORK *work);
static void SetExBossFireDragonExplosionAnim(EX_ACTION_BAC3D_WORK *work, u16 id);
static void ReleaseExBossFireDragonExplosionAssets(EX_ACTION_BAC3D_WORK *work);

// Fire Dragon
static BOOL LoadExBossFireDragonAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExBossFireDragonAssets(EX_ACTION_NN_WORK *work);
static void ExBossFireDragon_Main_Init(void);
static void ExBossFireDragon_TaskUnknown(void);
static void ExBossFireDragon_Destructor(void);
static void ExBossFireDragon_Main_Move(void);
static void ExBossFireDragon_Action_Repelled(void);
static void ExBossFireDragon_Main_Repelled(void);
static void ExBossFireDragon_Action_Explode(void);
static void ExBossFireDragon_Main_Explode(void);
static void ExBossFireDragon_Action_FadeOut(void);
static void ExBossFireDragon_Main_FadeOut(void);

// ExBoss
static void ExBoss_Main_Dora0(void);
static void ExBoss_Action_StartDora1(void);
static void ExBoss_Main_Dora1(void);
static void ExBoss_Main_FinishDora1(void);
static void ExBoss_Action_StartDora2(void);
static void ExBoss_Main_Dora2(void);
static void ExBoss_Action_FinishDragonAttack(void);

// --------------------
// FUNCTIONS
// --------------------

void LoadExBossFireDragonExplosionAssets(EX_ACTION_BAC3D_WORK *work)
{
    InitExDrawRequestSprite3D(work);

    if (exBossFireDragonExplosionInstanceCount == 0)
        exBossFireDragonExplosionSpriteResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_ACT_BAC);

    VRAMPixelKey vramPixels    = VRAMSystem__AllocTexture(Sprite__GetTextureSizeFromAnim(exBossFireDragonExplosionSpriteResource, 1), FALSE);
    VRAMPaletteKey vramPalette = VRAMSystem__AllocPalette(Sprite__GetPaletteSizeFromAnim(exBossFireDragonExplosionSpriteResource, 1), FALSE);

    AnimatorSprite3D__Init(&work->sprite.animator, ANIMATOR_FLAG_NONE, exBossFireDragonExplosionSpriteResource, EX_ACTCOM_ANI_5, ANIMATOR_FLAG_DISABLE_LOOPING, vramPixels,
                           vramPalette);
    work->sprite.animator.polygonAttr.xluDepthUpdate = TRUE;

    work->hitChecker.type                        = EXHITCHECK_TYPE_NOT_SOLID;
    work->hitChecker.input.isBossDragonExplosion = TRUE;

    work->sprite.translation.z = FLOAT_TO_FX32(70.0);
    work->sprite.scale.x       = FLOAT_TO_FX32(0.5);
    work->sprite.scale.y       = FLOAT_TO_FX32(0.5);
    work->sprite.scale.z       = FLOAT_TO_FX32(0.5);

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_BOTH;

    work->hitChecker.box.size.x   = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y   = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z   = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position = &work->sprite.translation;

    exBossFireDragonExplosionInstanceCount++;
}

void SetExBossFireDragonExplosionAnim(EX_ACTION_BAC3D_WORK *work, u16 id)
{
    work->sprite.anim = id;
    AnimatorSprite__SetAnimation(&work->sprite.animator.animatorSprite, id);
}

void ReleaseExBossFireDragonExplosionAssets(EX_ACTION_BAC3D_WORK *work)
{
    AnimatorSprite3D__Release(&work->sprite.animator);

    exBossFireDragonExplosionInstanceCount--;
}

BOOL GetActiveExBossFireDragonCount(void)
{
    return exBossFireDragonInstanceCount;
}

BOOL LoadExBossFireDragonAssets(EX_ACTION_NN_WORK *work)
{
    exBossFireDragonLastSpawnedWorker = work;

    if (exBossFireDragonModelFileSize != 0 && exBossFireDragonTextureFileSize != 0)
    {
        if (GetHeapTotalSize(HEAP_USER) < exBossFireDragonModelFileSize)
            return FALSE;

        if (VRAMSystem__GetTextureUnknown() < exBossFireDragonTextureFileSize)
            return FALSE;

        if (GetHeapUnallocatedSize(HEAP_SYSTEM) < exBossFireDragonModelFileSize)
            return FALSE;
    }

    InitExDrawRequestModel(work);

    if (exBossFireDragonInstanceCount == 0)
    {
        GetCompressedFileFromBundleEx("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_EFFE_SALA_NSBMD, &exBossFireDragonModelResource, &exBossFireDragonModelFileSize, TRUE,
                                      FALSE);

        Asset3DSetup__Create(exBossFireDragonModelResource);
    }

    AnimatorMDL *animator = &work->model.animator;
    AnimatorMDL__Init(animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(animator, exBossFireDragonModelResource, 0, FALSE, FALSE);

    work->model.translation.z = FLOAT_TO_FX32(0.0);

    work->model.scale.x = FLOAT_TO_FX32(1.0);
    work->model.scale.y = FLOAT_TO_FX32(1.0);
    work->model.scale.z = FLOAT_TO_FX32(1.0);

    work->model.angle.x = FLOAT_DEG_TO_IDX(89.98);

    work->hitChecker.type               = EXHITCHECK_TYPE_HAZARD;
    work->hitChecker.input.isBossDragon = TRUE;
    work->hitChecker.box.size.x         = FLOAT_TO_FX32(5.0);
    work->hitChecker.box.size.y         = FLOAT_TO_FX32(5.0);
    work->hitChecker.box.size.z         = FLOAT_TO_FX32(5.0);
    work->hitChecker.box.position       = &work->model.translation;

    exBossFireDragonInstanceCount++;

    return TRUE;
}

void ReleaseExBossFireDragonAssets(EX_ACTION_NN_WORK *work)
{
    if (exBossFireDragonInstanceCount <= 1)
    {
        if (exBossFireDragonModelResource)
            NNS_G3dResDefaultRelease(exBossFireDragonModelResource);

        if (exBossFireDragonModelResource)
            HeapFree(HEAP_USER, exBossFireDragonModelResource);
        exBossFireDragonModelResource = 0;
    }

    AnimatorMDL__Release(&work->model.animator);

    exBossFireDragonInstanceCount--;
}

void ExBossFireDragon_Main_Init(void)
{
    exBossFireDoraTask *work = ExTaskGetWorkCurrent(exBossFireDoraTask);

    VecFx32 *playerPos = GetExPlayerPosition();
    UNUSED(playerPos);

    exBossFireDragonTaskSingleton = GetCurrentTask();

    LoadExBossFireDragonAssets(&work->aniDragonModel);
    SetExDrawRequestPriority(&work->aniDragonModel.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniDragonModel.config);

    LoadExBossFireDragonExplosionAssets(&work->aniExplosion);
    SetExDrawRequestPriority(&work->aniExplosion.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniExplosion.config);

    work->aniDragonModel.model.translation.x = work->parent->aniBoss.model.bossStaffPos.x;
    work->aniDragonModel.model.translation.y = work->parent->aniBoss.model.bossStaffPos.y;
    work->aniDragonModel.model.translation.z = FLOAT_TO_FX32(60.0);

    work->aniDragonModel.model.angle.y = dragonStartAngles[work->id];
    work->angleUnknown                 = (work->aniDragonModel.model.angle.y / 182);
    work->angle.y                      = work->aniDragonModel.model.angle.y;
    work->trailUpdateTimer             = 4;
    InitExDrawRequestTrail(&work->aniTrail, &work->aniDragonModel.model.translation, EXDRAWREQTASK_TRAIL_BOSS_FIRE_DRAGON);
    SetExDrawRequestPriority(&work->aniTrail.config, EXDRAWREQTASK_PRIORITY_DEFAULT - 1);

    work->moveSpeed = 1.0f + (((mtMathRand() % 50) + 1) / 100);

    if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
    {
        work->aniDragonModel.hitChecker.health = EXBOSSFIREDRAGON_HEALTH_NORMAL;
    }
    else if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_EASY)
    {
        work->aniDragonModel.hitChecker.health = EXBOSSFIREDRAGON_HEALTH_EASY;
    }

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DORAGON_FIRE);

    SetCurrentExTaskMainEvent(ExBossFireDragon_Main_Move);
}

void ExBossFireDragon_TaskUnknown(void)
{
    exBossFireDoraTask *work = ExTaskGetWorkCurrent(exBossFireDoraTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExBossFireDragon_Destructor(void)
{
    exBossFireDoraTask *work = ExTaskGetWorkCurrent(exBossFireDoraTask);

    ReleaseExBossFireDragonAssets(&work->aniDragonModel);
    ReleaseExBossFireDragonExplosionAssets(&work->aniExplosion);

    exBossFireDragonTaskSingleton = NULL;
}

void ExBossFireDragon_Main_Move(void)
{
    exBossFireDoraTask *work = ExTaskGetWorkCurrent(exBossFireDoraTask);

    VecFx32 *playerPos = GetExPlayerPosition();

    AnimateExDrawRequestModel(&work->aniDragonModel);
    if (work->aniDragonModel.hitChecker.output.hasCollision)
    {
        work->aniDragonModel.hitChecker.output.hasCollision = FALSE;
        if (work->aniDragonModel.hitChecker.type == EXHITCHECK_TYPE_ACTIVE_PLAYER)
        {
            ExBossFireDragon_Action_Repelled();
            return;
        }

        work->aniDragonModel.hitChecker.health -= work->aniDragonModel.hitChecker.power;
        if (work->aniDragonModel.hitChecker.health <= 0)
        {
            ExBossFireDragon_Action_Explode();
            return;
        }
        work->aniDragonModel.hitChecker.power = 0;
    }
    else if (work->aniDragonModel.hitChecker.output.willExplodeOnContact)
    {
        ExBossFireDragon_Action_Explode();
        return;
    }

    if (ExBoss_IsBossFleeing() == TRUE)
    {
        ExBossFireDragon_Action_Explode();
        return;
    }

    if (work->explodeTimer-- <= 0)
    {
        ExBossFireDragon_Action_Explode();
        return;
    }

    float x;
    MULTIPLY_FLOAT_FX(x, work->moveSpeed);
    work->velocity.x = x;

    float y;
    MULTIPLY_FLOAT_FX(y, work->moveSpeed);
    work->velocity.y = y;

    float z;
    MULTIPLY_FLOAT_FX(z, work->moveSpeed);
    work->velocity.z = z;

    work->trailUpdateTimer--;
    if (work->trailUpdateTimer < 0)
    {
        work->trailUpdateTimer = 4;
        ExUtils_RotateTowards(work->aniDragonModel.model.translation.y - playerPos->y, work->aniDragonModel.model.translation.x - playerPos->x, &work->angle, &work->angleUnknown,
                      FLOAT_DEG_TO_IDX(8.0));

        work->aniTrail.trail.angle = work->angle.y;
        ProcessExDrawRequestBossFireDragonTrail(&work->aniTrail, &work->aniDragonModel.model.translation);
    }

    work->aniDragonModel.model.angle.y = FLOAT_DEG_TO_IDX(269.9341);
    work->aniDragonModel.model.angle.y += work->angle.y;
    work->velocity.x = MultiplyFX(CosFX(work->angle.y), work->velocity.x);
    work->velocity.y = MultiplyFX(SinFX(work->angle.y), work->velocity.y);
    work->aniDragonModel.model.translation.x -= work->velocity.x;
    work->aniDragonModel.model.translation.y -= work->velocity.y;
    AddExDrawRequest(&work->aniTrail, &work->aniTrail.config);
    AddExDrawRequest(&work->aniDragonModel, &work->aniDragonModel.config);
    exHitCheckTask_AddHitCheck(&work->aniDragonModel.hitChecker);

    RunCurrentExTaskUnknownEvent();
}

void ExBossFireDragon_Action_Repelled(void)
{
    exBossFireDoraTask *work = ExTaskGetWorkCurrent(exBossFireDoraTask);

    work->aniDragonModel.hitChecker.output.hasCollision        = FALSE;
    work->aniDragonModel.hitChecker.input.isRepelledProjectile = TRUE;

    work->velocity.x = FLOAT_TO_FX32(0.0);
    work->velocity.y = FLOAT_TO_FX32(1.0);
    if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
    {
        if (work->aniDragonModel.hitChecker.power == EXPLAYER_BARRIER_REGULAR_POWER_NORMAL)
        {
            work->velocity.y = MultiplyFX(work->velocity.y, FLOAT_TO_FX32(4.0));
        }
        else
        {
            work->velocity.y = MultiplyFX(work->velocity.y, FLOAT_TO_FX32(6.0));
        }
    }
    else if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_EASY)
    {
        if (work->aniDragonModel.hitChecker.power == EXPLAYER_BARRIER_REGULAR_POWER_EASY)
        {
            work->velocity.y = MultiplyFX(work->velocity.y, FLOAT_TO_FX32(4.0));
        }
        else
        {
            work->velocity.y = MultiplyFX(work->velocity.y, FLOAT_TO_FX32(6.0));
        }
    }

    BOOL spinClockwise                 = FALSE;
    work->velocity.z                   = FLOAT_TO_FX32(0.0);
    work->aniDragonModel.model.angle.x = FLOAT_DEG_TO_IDX(89.98);
    work->aniDragonModel.model.angle.y = FLOAT_DEG_TO_IDX(179.96);
    work->aniDragonModel.model.angle.z = FLOAT_DEG_TO_IDX(0.0);
    work->spinSpeed                    = FLOAT_DEG_TO_IDX(29.993);

    if ((mtMathRand() % 2) != 0)
        spinClockwise = TRUE;
    work->spinClockwise = spinClockwise;

    SetCurrentExTaskMainEvent(ExBossFireDragon_Main_Repelled);
    ExBossFireDragon_Main_Repelled();
}

void ExBossFireDragon_Main_Repelled(void)
{
    exBossFireDoraTask *work = ExTaskGetWorkCurrent(exBossFireDoraTask);

    if (work->aniDragonModel.hitChecker.output.hasCollision)
    {
        DestroyCurrentExTask();
        return;
    }

    if (work->aniDragonModel.hitChecker.output.willExplodeOnContact)
    {
        DestroyCurrentExTask();
        return;
    }

    if (work->spinClockwise)
    {
        work->aniDragonModel.model.angle.y += work->spinSpeed;
    }
    else
    {
        work->aniDragonModel.model.angle.y -= work->spinSpeed;
    }

    work->aniDragonModel.model.translation.y += work->velocity.y;

    if ((work->aniDragonModel.model.translation.x >= EX_STAGE_BOUNDARY_R || work->aniDragonModel.model.translation.x <= EX_STAGE_BOUNDARY_L)
        || (work->aniDragonModel.model.translation.y >= EX_STAGE_BOUNDARY_B || work->aniDragonModel.model.translation.y <= EX_STAGE_BOUNDARY_T))
    {
        DestroyCurrentExTask();
        return;
    }

    AddExDrawRequest(&work->aniDragonModel, &work->aniDragonModel.config);
    exHitCheckTask_AddHitCheck(&work->aniDragonModel.hitChecker);

    RunCurrentExTaskUnknownEvent();
}

void ExBossFireDragon_Action_Explode(void)
{
    exBossFireDoraTask *work = ExTaskGetWorkCurrent(exBossFireDoraTask);

    work->aniExplosion.sprite.translation.x = work->aniDragonModel.model.translation.x;
    work->aniExplosion.sprite.translation.y = work->aniDragonModel.model.translation.y;
    work->aniExplosion.sprite.translation.z = work->aniDragonModel.model.translation.z;

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DORAGON_EXP);

    SetCurrentExTaskMainEvent(ExBossFireDragon_Main_Explode);
    ExBossFireDragon_Main_Explode();
}

void ExBossFireDragon_Main_Explode(void)
{
    exBossFireDoraTask *work = ExTaskGetWorkCurrent(exBossFireDoraTask);

    AnimateExDrawRequestSprite3D(&work->aniExplosion);
    if (IsExDrawRequestSprite3DAnimFinished(&work->aniExplosion))
    {
        ExBossFireDragon_Action_FadeOut();
    }
    else
    {
        AddExDrawRequest(&work->aniExplosion, &work->aniExplosion.config);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExBossFireDragon_Action_FadeOut(void)
{
    exBossFireDoraTask *work = ExTaskGetWorkCurrent(exBossFireDoraTask);

    work->aniExplosion.sprite.translation.x = work->aniDragonModel.model.translation.x;
    work->aniExplosion.sprite.translation.y = work->aniDragonModel.model.translation.y;
    work->aniExplosion.sprite.translation.z = work->aniDragonModel.model.translation.z;

    work->explodeTimer = SECONDS_TO_FRAMES(0.5);
    SetExBossFireDragonExplosionAnim(&work->aniExplosion, EX_ACTCOM_ANI_6);
    SetExDrawRequestAnimAsOneShot(&work->aniExplosion.config);

    SetCurrentExTaskMainEvent(ExBossFireDragon_Main_FadeOut);
    ExBossFireDragon_Main_FadeOut();
}

void ExBossFireDragon_Main_FadeOut(void)
{
    exBossFireDoraTask *work = ExTaskGetWorkCurrent(exBossFireDoraTask);

    AnimateExDrawRequestSprite3D(&work->aniExplosion);

    if (work->explodeTimer <= 0)
    {
        if (work->aniExplosion.sprite.animator.polygonAttr.alpha <= 1)
        {
            DestroyCurrentExTask();
            return;
        }
        work->aniExplosion.sprite.animator.polygonAttr.alpha--;
    }
    else
    {
        work->explodeTimer--;
    }
    AddExDrawRequest(&work->aniExplosion, &work->aniExplosion.config);

    RunCurrentExTaskUnknownEvent();
}

BOOL CreateExBossFireDragon(void)
{
    Task *task =
        ExTaskCreate(ExBossFireDragon_Main_Init, ExBossFireDragon_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR, exBossFireDoraTask);

    exBossFireDoraTask *work = ExTaskGetWork(task, exBossFireDoraTask);
    TaskInitWork8(work);

    work->parent       = ExTaskGetWorkCurrent(exBossSysAdminTask);
    work->id           = work->parent->projectileID;
    work->explodeTimer = work->parent->genericCooldown;

    SetExTaskUnknownEvent(task, ExBossFireDragon_TaskUnknown);

    return TRUE;
}

// ExBoss
void ExBoss_Action_StartFireDragonAttack(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    CreateExBossEffectFire();
    SetExBossAnimation(&work->aniBoss, bse_body_dora0);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);

    SetCurrentExTaskMainEvent(ExBoss_Main_Dora0);
    ExBoss_Main_Dora0();
}

void ExBoss_Main_Dora0(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        ExBoss_Action_StartDora1();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExBoss_Action_StartDora1(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExBossAnimation(&work->aniBoss, bse_body_dora1);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_PREPARE);
    DisableExBossEffectFire();

    SetCurrentExTaskMainEvent(ExBoss_Main_Dora1);
    ExBoss_Main_Dora1();
}

void ExBoss_Main_Dora1(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (work->aniBoss.model.primaryAnimResource->frame >= FLOAT_TO_FX32(15.0))
    {
        s32 chance = mtMathRand() % 100;

        if (chance >= 60)
        {
            work->genericCooldown = SECONDS_TO_FRAMES(6);
        }
        else if (chance < 60 && chance >= 40)
        {
            work->genericCooldown = SECONDS_TO_FRAMES(10);
        }
        else if (chance < 40)
        {
            work->genericCooldown = SECONDS_TO_FRAMES(3);
        }

        for (u16 d = 0; d < EXBOSS_FIRE_DRAGON_COUNT; d++)
        {
            work->projectileID = d;
            CreateExBossFireDragon();
        }
        CreateExBossEffectShot();
        work->projectileID = 0;

        SetCurrentExTaskMainEvent(ExBoss_Main_FinishDora1);
        ExBoss_Main_FinishDora1();
    }
    else
    {
        if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
        {
            ExBoss_Action_StartDora2();
        }
        else
        {
            exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
            AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

            RunCurrentExTaskUnknownEvent();
        }
    }
}

void ExBoss_Main_FinishDora1(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        ExBoss_Action_StartDora2();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExBoss_Action_StartDora2(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExBossAnimation(&work->aniBoss, bse_body_dora2);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);

    SetCurrentExTaskMainEvent(ExBoss_Main_Dora2);
    ExBoss_Main_Dora2();
}

void ExBoss_Main_Dora2(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        ExBoss_Action_FinishDragonAttack();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExBoss_Action_FinishDragonAttack(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    work->nextAttackState();
}