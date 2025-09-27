#include <ex/boss/exBossHomingLaser.h>
#include <ex/boss/exBoss.h>
#include <ex/effects/exBossHomingEffect.h>
#include <ex/system/exDrawReq.h>
#include <ex/system/exSystem.h>
#include <ex/system/exStage.h>
#include <ex/player/exPlayerHelpers.h>
#include <game/file/binaryBundle.h>
#include <game/audio/audioSystem.h>

// Resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// VARIABLES
// --------------------

static s16 exBossHomingLaserActiveCount;
static s16 exBossHomingLaserInstanceCount;
static Task *exBossHomingLaserTaskSingleton;
static void *exBossHomingLaserSpriteResource;

static u16 laserStartAngles[EXBOSS_HOMING_LASER_COUNT] = { FLOAT_DEG_TO_IDX(210.0), FLOAT_DEG_TO_IDX(180.0), FLOAT_DEG_TO_IDX(150.0),
                                                           FLOAT_DEG_TO_IDX(30.0),  FLOAT_DEG_TO_IDX(1.0),   FLOAT_DEG_TO_IDX(330.0) };

// --------------------
// FUNCTION DECLS
// --------------------

// Homing Laser
static void LoadExBossHomingLaserAssets(EX_ACTION_BAC3D_WORK *work);
static void ReleaseExBossHomingLaserAssets(EX_ACTION_BAC3D_WORK *work);
static void ExBossHomingLaser_Main_Init(void);
static void ExBossHomingLaser_TaskUnknown(void);
static void ExBossHomingLaser_Destructor(void);
static void ExBossHomingLaser_Main_MoveToStartPos(void);
static void ExBossHomingLaser_Action_WaitForAttack(void);
static void ExBossHomingLaser_Main_WaitForAttack(void);
static void ExBossHomingLaser_Action_TargetPlayer(void);
static void ExBossHomingLaser_Main_TargetPlayer(void);

// ExBoss
static void ExBoss_Main_StartHomi0(void);
static void ExBoss_Main_FinishHomi0(void);
static void ExBoss_Action_StartHomi1(void);
static void ExBoss_Main_StartHomi1(void);
static void ExBoss_Main_FinishHomi1(void);
static void ExBoss_Action_StartHomi2(void);
static void ExBoss_Main_StartHomi2(void);
static void ExBoss_Action_FinishHomingAttack(void);

// --------------------
// FUNCTIONS
// --------------------

void LoadExBossHomingLaserAssets(EX_ACTION_BAC3D_WORK *work)
{
    InitExDrawRequestSprite3D(work);

    if (exBossHomingLaserInstanceCount == 0)
        exBossHomingLaserSpriteResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_ACT_BAC);

    VRAMPixelKey vramPixels    = VRAMSystem__AllocTexture(Sprite__GetTextureSizeFromAnim(exBossHomingLaserSpriteResource, 1), FALSE);
    VRAMPaletteKey vramPalette = VRAMSystem__AllocPalette(Sprite__GetPaletteSizeFromAnim(exBossHomingLaserSpriteResource, 1), FALSE);

    AnimatorSprite3D__Init(&work->sprite.animator, ANIMATOR_FLAG_NONE, exBossHomingLaserSpriteResource, EX_ACTCOM_ANI_HOMING_LASER, ANIMATOR_FLAG_DISABLE_LOOPING, vramPixels,
                           vramPalette);
    work->sprite.animator.polygonAttr.xluDepthUpdate = TRUE;

    work->hitChecker.type                      = EXHITCHECK_TYPE_NOT_SOLID;
    work->hitChecker.input.isHomingLaserSprite = TRUE;

    work->sprite.translation.z = FLOAT_TO_FX32(70.0);
    work->sprite.scale.x       = FLOAT_TO_FX32(0.25);
    work->sprite.scale.y       = FLOAT_TO_FX32(0.25);
    work->sprite.scale.z       = FLOAT_TO_FX32(0.25);

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;

    work->hitChecker.box.size.x   = FLOAT_TO_FX32(2.0);
    work->hitChecker.box.size.y   = FLOAT_TO_FX32(2.0);
    work->hitChecker.box.size.z   = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position = &work->sprite.translation;

    exBossHomingLaserInstanceCount++;
}

void ReleaseExBossHomingLaserAssets(EX_ACTION_BAC3D_WORK *work)
{
    AnimatorSprite3D__Release(&work->sprite.animator);

    exBossHomingLaserInstanceCount--;
}

s32 GetActiveExBossHomingLaserCount(void)
{
    return exBossHomingLaserActiveCount;
}

void ExBossHomingLaser_Main_Init(void)
{
    exBossHomingLaserTask *work = ExTaskGetWorkCurrent(exBossHomingLaserTask);

    exBossHomingLaserActiveCount++;

    LoadExBossHomingLaserAssets(&work->aniSprite3D);
    SetExDrawRequestPriority(&work->aniSprite3D.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimAsOneShot(&work->aniSprite3D.config);

    exBossHomingLaserTaskSingleton = GetCurrentTask();

    work->position.x = work->parent->aniBoss.model.bossStaffPos.x;
    work->position.y = work->parent->aniBoss.model.bossStaffPos.y;
    work->position.z = work->parent->aniBoss.model.bossStaffPos.z;

    work->startAngle   = laserStartAngles[work->id];
    work->angleUnknown = (work->startAngle / 182);
    work->angle.y      = work->startAngle;
    InitExDrawRequestTrail(&work->aniTrail, &work->position, EXDRAWREQTASK_TRAIL_BOSS_HOMING_LASER);
    SetExDrawRequestPriority(&work->aniTrail.config, EXDRAWREQTASK_PRIORITY_DEFAULT - 1);

    work->trailUpdateTimer = 1;
    work->moveSpeed        = 1.0f + (((mtMathRand() % 50) + 1) / 100);

    SetCurrentExTaskMainEvent(ExBossHomingLaser_Main_MoveToStartPos);
    ExBossHomingLaser_Main_MoveToStartPos();
}

void ExBossHomingLaser_TaskUnknown(void)
{
    exBossHomingLaserTask *work = ExTaskGetWorkCurrent(exBossHomingLaserTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExBossHomingLaser_Destructor(void)
{
    exBossHomingLaserTask *work = ExTaskGetWorkCurrent(exBossHomingLaserTask);

    if (exBossHomingLaserActiveCount > 1)
        exBossHomingLaserActiveCount--;
    else
        exBossHomingLaserActiveCount = 0;

    ReleaseExBossHomingLaserAssets(&work->aniSprite3D);

    exBossHomingLaserTaskSingleton = NULL;
}

void ExBossHomingLaser_Main_MoveToStartPos(void)
{
    exBossHomingLaserTask *work = ExTaskGetWorkCurrent(exBossHomingLaserTask);

    VecFx32 *playerPos = GetExPlayerPosition();

    AnimateExDrawRequestSprite3D(&work->aniSprite3D);

    float x;
    if (work->moveSpeed > 0.0f)
    {
        x = (FLOAT_TO_FX32(1.0) * work->moveSpeed) + 0.5f;
    }
    else
    {
        x = (FLOAT_TO_FX32(1.0) * work->moveSpeed) - 0.5f;
    }
    work->velocity.x = x;

    float y;
    if (work->moveSpeed > 0.0f)
    {
        y = (FLOAT_TO_FX32(1.0) * work->moveSpeed) + 0.5f;
    }
    else
    {
        y = (FLOAT_TO_FX32(1.0) * work->moveSpeed) - 0.5f;
    }
    work->velocity.y = y;

    float z;
    if (work->moveSpeed > 0.0f)
    {
        z = (FLOAT_TO_FX32(1.0) * work->moveSpeed) + 0.5f;
    }
    else
    {
        z = (FLOAT_TO_FX32(1.0) * work->moveSpeed) - 0.5f;
    }
    work->velocity.z = z;

    work->trailUpdateTimer--;
    if (work->trailUpdateTimer < 0)
    {
        work->trailUpdateTimer = 1;
        ovl09_2152EA8(work->position.y - playerPos->y, work->position.x - playerPos->x, &work->angle, &work->angleUnknown, FLOAT_DEG_TO_IDX(6.0));

        work->aniTrail.trail.angle = work->angle.y;
        ProcessExDrawRequestBossHomingLaserTrail(&work->aniTrail, &work->position, EXDRAWREQTASK_HOMINGLASER_TRAIL_0);
    }

    work->velocity.x = MultiplyFX(CosFX(work->angle.y), work->velocity.x);
    work->velocity.y = MultiplyFX(SinFX(work->angle.y), work->velocity.y);

    work->position.x -= work->velocity.x;
    work->position.y -= work->velocity.y;

    if (ExBoss_IsBossFleeing() == TRUE)
    {
        ExBossHomingLaser_Action_TargetPlayer();
    }
    else if (GetExPlayerPosition()->y >= FLOAT_TO_FX32(15.0) && work->position.y <= GetExPlayerPosition()->y + FLOAT_TO_FX32(1.0))
    {
        ExBossHomingLaser_Action_WaitForAttack();
    }
    else if (work->position.y <= FLOAT_TO_FX32(15.0))
    {
        ExBossHomingLaser_Action_WaitForAttack();
    }
    else
    {
        if (work->position.y > FLOAT_TO_FX32(36.751))
            AddExDrawRequest(&work->aniTrail, &work->aniTrail.config);

        if (work->position.y <= FLOAT_TO_FX32(36.751))
        {
            work->aniSprite3D.sprite.translation.x = work->position.x;
            work->aniSprite3D.sprite.translation.y = work->position.y;
            AddExDrawRequest(&work->aniSprite3D, &work->aniSprite3D.config);
        }

        exHitCheckTask_AddHitCheck(&work->aniTrail.hitChecker);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExBossHomingLaser_Action_WaitForAttack(void)
{
    exBossHomingLaserTask *work = ExTaskGetWorkCurrent(exBossHomingLaserTask);

    work->timer = SECONDS_TO_FRAMES(2.4);

    work->aniTrail.config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_A;

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_LASER_BEAM);

    SetCurrentExTaskMainEvent(ExBossHomingLaser_Main_WaitForAttack);
    ExBossHomingLaser_Main_WaitForAttack();
}

void ExBossHomingLaser_Main_WaitForAttack(void)
{
    exBossHomingLaserTask *work = ExTaskGetWorkCurrent(exBossHomingLaserTask);

    VecFx32 *playerPos = GetExPlayerPosition();

    AnimateExDrawRequestSprite3D(&work->aniSprite3D);

    if (ExBoss_IsBossFleeing() == TRUE)
    {
        ExBossHomingLaser_Action_TargetPlayer();
        return;
    }

    if (work->timer-- < 0)
    {
        ExBossHomingLaser_Action_TargetPlayer();
        return;
    }

    ovl09_2152EA8(work->position.y - playerPos->y, work->position.x - playerPos->x, &work->angle, &work->angleUnknown, FLOAT_DEG_TO_IDX(6.0));

    work->aniTrail.trail.angle = work->angle.y;
    ProcessExDrawRequestBossHomingLaserTrail(&work->aniTrail, &work->position, EXDRAWREQTASK_HOMINGLASER_TRAIL_1);

    AddExDrawRequest(&work->aniSprite3D, &work->aniSprite3D.config);
    exHitCheckTask_AddHitCheck(&work->aniTrail.hitChecker);

    RunCurrentExTaskUnknownEvent();
}

void ExBossHomingLaser_Action_TargetPlayer(void)
{
    exBossHomingLaserTask *work = ExTaskGetWorkCurrent(exBossHomingLaserTask);

    work->trailUpdateTimer = 1;
    work->moveSpeed        = 5.0f + (((mtMathRand() % 50) + 1) / 100);
    work->timer            = 1;

    SetCurrentExTaskMainEvent(ExBossHomingLaser_Main_TargetPlayer);
    ExBossHomingLaser_Main_TargetPlayer();
}

void ExBossHomingLaser_Main_TargetPlayer(void)
{
    exBossHomingLaserTask *work = ExTaskGetWorkCurrent(exBossHomingLaserTask);

    VecFx32 *playerPos = GetExPlayerPosition();

    float x;
    if (work->moveSpeed > 0.0f)
    {
        x = (FLOAT_TO_FX32(1.0) * work->moveSpeed) + 0.5f;
    }
    else
    {
        x = (FLOAT_TO_FX32(1.0) * work->moveSpeed) - 0.5f;
    }
    work->velocity.x = x;

    float y;
    if (work->moveSpeed > 0.0f)
    {
        y = (FLOAT_TO_FX32(1.0) * work->moveSpeed) + 0.5f;
    }
    else
    {
        y = (FLOAT_TO_FX32(1.0) * work->moveSpeed) - 0.5f;
    }
    work->velocity.y = y;

    float z;
    if (work->moveSpeed > 0.0f)
    {
        z = (FLOAT_TO_FX32(1.0) * work->moveSpeed) + 0.5f;
    }
    else
    {
        z = (FLOAT_TO_FX32(1.0) * work->moveSpeed) - 0.5f;
    }
    work->velocity.z = z;

    work->trailUpdateTimer--;
    if (work->trailUpdateTimer < 0)
    {
        work->trailUpdateTimer = 1;
        ovl09_2152EA8(work->position.y - playerPos->y, work->position.x - playerPos->x, &work->angle, &work->angleUnknown, FLOAT_DEG_TO_IDX(2.0));

        work->aniTrail.trail.angle = work->angle.y;
        ProcessExDrawRequestBossHomingLaserTrail(&work->aniTrail, &work->position, EXDRAWREQTASK_HOMINGLASER_TRAIL_2);
    }

    work->velocity.x = MultiplyFX(CosFX(work->angle.y), work->velocity.x);
    work->velocity.y = MultiplyFX(SinFX(work->angle.y), work->velocity.y);

    if (work->position.x >= EX_STAGE_BOUNDARY_R || work->position.x <= EX_STAGE_BOUNDARY_L || work->position.y >= EX_STAGE_BOUNDARY_B || work->position.y <= EX_STAGE_BOUNDARY_T)
    {
        if (work->timer-- <= 0)
        {
            DestroyCurrentExTask();
            return;
        }
    }
    else
    {
        work->position.x -= work->velocity.x;
        work->position.y -= work->velocity.y;
    }

    AddExDrawRequest(&work->aniTrail, &work->aniTrail.config);
    exHitCheckTask_AddHitCheck(&work->aniTrail.hitChecker);

    RunCurrentExTaskUnknownEvent();
}

BOOL CreateExBossHomingLaser(void)
{
    Task *task = ExTaskCreate(ExBossHomingLaser_Main_Init, ExBossHomingLaser_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3100, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR,
                              exBossHomingLaserTask);

    exBossHomingLaserTask *work = ExTaskGetWork(task, exBossHomingLaserTask);
    TaskInitWork8(work);

    work->parent = ExTaskGetWorkCurrent(exBossSysAdminTask);
    work->id     = work->parent->projectileID;

    SetExTaskUnknownEvent(task, ExBossHomingLaser_TaskUnknown);

    return TRUE;
}

// ExBoss
void ExBoss_Action_StartHomingLaserAttack(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExBossAnimation(&work->aniBoss, bse_body_homi0);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);
    CreateExBossEffectHoming();
    PlayStageVoiceClip(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_E_HORE);

    SetCurrentExTaskMainEvent(ExBoss_Main_StartHomi0);
    ExBoss_Main_StartHomi0();
}

void ExBoss_Main_StartHomi0(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (work->aniBoss.model.primaryAnimResource->frame >= FLOAT_TO_FX32(30.0))
    {
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_PREPARE);

        SetCurrentExTaskMainEvent(ExBoss_Main_FinishHomi0);
        ExBoss_Main_FinishHomi0();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExBoss_Main_FinishHomi0(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        ExBoss_Action_StartHomi1();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExBoss_Action_StartHomi1(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    SetExBossAnimation(&work->aniBoss, bse_body_homi1);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);

    SetCurrentExTaskMainEvent(ExBoss_Main_StartHomi1);
    ExBoss_Main_StartHomi1();
}

void ExBoss_Main_StartHomi1(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (work->aniBoss.model.primaryAnimResource->frame >= FLOAT_TO_FX32(10.0))
    {
        for (u16 s = 0; s < EXBOSS_HOMING_LASER_COUNT; s++)
        {
            work->projectileID = s;
            CreateExBossHomingLaser();
        }
        work->projectileID = 0;
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_LASER_DISCHARGE);

        SetCurrentExTaskMainEvent(ExBoss_Main_FinishHomi1);
        ExBoss_Main_FinishHomi1();
    }
    else
    {
        if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
        {
            ExBoss_Action_StartHomi2();
        }
        else
        {
            exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
            AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

            RunCurrentExTaskUnknownEvent();
        }
    }
}

void ExBoss_Main_FinishHomi1(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        ExBoss_Action_StartHomi2();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExBoss_Action_StartHomi2(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    DisableExBossEffectHoming();
    SetExBossAnimation(&work->aniBoss, bse_body_homi2);
    SetExDrawRequestAnimStopOnFinish(&work->aniBoss.config);

    SetCurrentExTaskMainEvent(ExBoss_Main_StartHomi2);
    ExBoss_Main_StartHomi2();
}

void ExBoss_Main_StartHomi2(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    if (IsExDrawRequestModelAnimFinished(&work->aniBoss))
    {
        ExBoss_Action_FinishHomingAttack();
    }
    else
    {
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExBoss_Action_FinishHomingAttack(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    work->nextAttackState();
}