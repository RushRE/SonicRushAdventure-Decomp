#include <ex/player/exPlayer.h>
#include <ex/player/exPlayerHelpers.h>
#include <ex/effects/exSonicDashEffect.h>
#include <ex/effects/exBlazeDashEffect.h>
#include <ex/effects/exSonicBarrier.h>
#include <ex/effects/exBlazeFireball.h>
#include <ex/effects/exShockEffect.h>
#include <ex/system/exSystem.h>
#include <ex/system/exStage.h>
#include <ex/system/exSave.h>
#include <ex/system/exMath.h>
#include <ex/system/exGameSystem.h>
#include <ex/system/exTimeGameplay.h>
#include <ex/system/exDrawFade.h>
#include <ex/core/exTitleCard.h>
#include <ex/boss/exBossHelpers.h>
#include <game/audio/audioSystem.h>
#include <game/input/padInput.h>

// --------------------
// VARIABLES
// --------------------

static void *exPlayerTaskSingleton;
static void *exPlayerScreenMoverTaskSingleton;
static VecFx32 *exPlayerScreenMoverTargetPos;

static exPlayerAdminTaskWorker exPlayerWorker;

static struct exPlayerGraphics3D exPlayerAniSonic;
static struct exPlayerGraphics3D exPlayerAniBlaze;

static s16 exPlayerUnknown2 = 2;
static u32 exPlayerUnknown1 = 1;

// --------------------
// FUNCTION DECLS
// --------------------

// ExPlayerScreenMover
static void SetExPlayerScreenMoverTargetPos(VecFx32 *followPos);
static void ExPlayerScreenMover_Main_Init(void);
static void ExPlayerScreenMover_TaskUnknown(void);
static void ExPlayerScreenMover_Destructor(void);
static void ExPlayerScreenMover_Main_Active(void);
static void CreateExPlayerScreenMover(void);

// ExPlayer
static void ExPlayer_Main_Init(void);
static void ExPlayer_TaskUnknown(void);
static void ExPlayer_Destructor(void);
static void ExPlayer_Main_ControlLocked(void);
static void ExPlayer_Main_EnterPlayers(void);
static void ExPlayer_Action_ShowTitleCard(void);
static void ExPlayer_Main_WaitForTitleCard(void);
static void ExPlayer_Main_InitForBossChase(void);
static void ExPlayer_Main_PrepareForBossChase(void);
static void ExPlayer_Action_BossChaseDelay(void);
static void ExPlayer_Main_BossChaseDelay(void);
static void ExPlayer_Action_StartBossChase(void);
static void ExPlayer_Main_StartBossChase(void);
static void ExPlayer_Action_ReadyBossPhaseChange(void);
static void ExPlayer_Main_StartBossPhase2(void);
static void ExPlayer_Main_StartBossPhase3(void);
static void ExPlayer_DrawForBossChase(void);
static void ExPlayer_Action_ShockStun(void);
static void ExPlayer_Main_InitShockStun(void);
static void ExPlayer_Main_ShockStun(void);
static void ExPlayer_Action_Die(void);
static void ExPlayer_Main_StartDeath(void);
static void ExPlayer_Action_HandleDeath(void);
static void ExPlayer_Main_HandleDealth(void);
static void ExPlayer_Action_FinishDeath(void);
static void ExPlayer_Main_Died(void);
static void ExPlayer_Action_Hurt(void);
static void ExPlayer_Main_Hurt(void);
static void ExPlayer_Action_FinishedHurt(void);
static void ExPlayer_Main_FinishedHurt(void);
static void ExPlayer_ForceInvincibility(void);

static void ExPlayer_Action_StartSonicBarrier(void);
static void ExPlayer_Main_StartSonicBarrier(void);
static void ExPlayer_Action_SonicBarrierEnd(void);
static void ExPlayer_Main_SonicBarrierEnd(void);
static void ExPlayer_Action_SonicBarrierFinish(void);
static void ExPlayer_Main_SonicBarrierFinish(void);
static void ExPlayer_EndSonicBarrierAnim(void);

static void ExPlayer_Action_StartBlazeFireball(void);
static void ExPlayer_Main_StartBlazeFireball(void);
static void ExPlayer_Main_ChargeBlazeFireball(void);
static void ExPlayer_Action_EndBlazeFireball(void);
static void ExPlayer_Main_ShootBlazeFireball(void);
static void ExPlayer_Main_EndBlazeFireball(void);
static void ExPlayer_Action_FinishBlazeFireball(void);
static void ExPlayer_Main_FinishBlazeFireball(void);
static void ExPlayer_EndBlazeFireballAnim(void);

static BOOL HandleExPlayerHitResponse(void);
static BOOL ExPlayer_HandleUserControl(void);
static BOOL ExPlayer_TryUseAbility(void);
static void ExPlayer_SwapPlayerGraphics(void);
static void ExPlayer_HandleMovement(void);
static void ExPlayer_HandlePlayerSwap(void);
static void ExPlayer_HandleDash(void);
static void ExPlayer_Draw(void);
static void ExPlayer_DelayCallback(void);
static void ProcessExPlayerAnimations(void);

#ifdef NON_MATCHING
extern BOOL SetExDrawRequestGlobalModelConfigTimer(u8 duration);
#else
// We explicitly use "void" return value, as that allows 'exPlayerAdminTask__Action_Die' to match
extern void SetExDrawRequestGlobalModelConfigTimer(u8 duration);
#endif

// --------------------
// FUNCTIONS
// --------------------

// ExPlayer helpers
exPlayerAdminTaskWorker *GetExPlayerWorker(void)
{
    return &exPlayerWorker;
}

// ExPlayerScreenMover
void SetExPlayerScreenMoverTargetPos(VecFx32 *followPos)
{
    exPlayerScreenMoverTargetPos = followPos;
}

void ExPlayerScreenMover_Main_Init(void)
{
    exPlayerScreenMoveTask *work = ExTaskGetWorkCurrent(exPlayerScreenMoveTask);

    exPlayerScreenMoverTaskSingleton = GetCurrentTask();

    work->cameraConfig[GRAPHICS_ENGINE_A] = GetExDrawCameraConfigA();
    work->cameraConfig[GRAPHICS_ENGINE_B] = GetExDrawCameraConfigB();

    SetCurrentExTaskMainEvent(ExPlayerScreenMover_Main_Active);
}

void ExPlayerScreenMover_TaskUnknown(void)
{
    exPlayerScreenMoveTask *work = ExTaskGetWorkCurrent(exPlayerScreenMoveTask);
    UNUSED(work);
}

void ExPlayerScreenMover_Destructor(void)
{
    exPlayerScreenMoveTask *work = ExTaskGetWorkCurrent(exPlayerScreenMoveTask);
    UNUSED(work);

    exPlayerScreenMoverTargetPos = NULL;
}

void ExPlayerScreenMover_Main_Active(void)
{
    exPlayerScreenMoveTask *work = ExTaskGetWorkCurrent(exPlayerScreenMoveTask);

    s32 targetPos = 50 * (exPlayerScreenMoverTargetPos->x / 100);

    if (work->cameraConfig[GRAPHICS_ENGINE_A]->type == EXDRAW_CAMERACONFIG_1 && exPlayerScreenMoverTargetPos != NULL)
    {
        work->cameraConfig[GRAPHICS_ENGINE_A]->nextCamera.lookAtTo.x   = targetPos;
        work->cameraConfig[GRAPHICS_ENGINE_A]->nextCamera.lookAtFrom.x = targetPos;
    }

    if (work->cameraConfig[GRAPHICS_ENGINE_B]->type == EXDRAW_CAMERACONFIG_1 && exPlayerScreenMoverTargetPos != NULL)
    {
        work->cameraConfig[GRAPHICS_ENGINE_B]->nextCamera.lookAtTo.x   = targetPos;
        work->cameraConfig[GRAPHICS_ENGINE_B]->nextCamera.lookAtFrom.x = targetPos;
    }

    RunCurrentExTaskUnknownEvent();
}

void CreateExPlayerScreenMover(void)
{
    Task *task = ExTaskCreate(ExPlayerScreenMover_Main_Init, ExPlayerScreenMover_Destructor, TASK_PRIORITY_UPDATE_LIST_END - 2, TASK_GROUP(3), 0, EXTASK_TYPE_REGULAR,
                              exPlayerScreenMoveTask);

    exPlayerScreenMoveTask *work = ExTaskGetWork(task, exPlayerScreenMoveTask);
    UNUSED(work);

    SetExTaskUnknownEvent(task, ExPlayerScreenMover_TaskUnknown);
}

// ExPlayer
void ExPlayer_Main_Init(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    exPlayerTaskSingleton = GetCurrentTask();

    CreateExPlayerScreenMover();
    LoadExSuperSonicModel(&work->aniSonic->manager);
    SetExDrawRequestPriority(&work->aniSonic->manager.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    work->aniSonic->manager.model.translation.y = -FLOAT_TO_FX32(90.0);
    work->aniSonic->nextAnim                    = ex_son_fw;

    LoadExSuperSonicSprite(&work->spriteSonic);
    SetExDrawRequestPriority(&work->spriteSonic.config, EXDRAWREQTASK_PRIORITY_DEFAULT);

    LoadExBurningBlazeModel(&work->aniBlaze->manager);
    SetExDrawRequestPriority(&work->aniBlaze->manager.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    work->aniBlaze->manager.model.translation.y = -FLOAT_TO_FX32(90.0);
    work->aniBlaze->nextAnim                    = ex_blz_fw;

    LoadExBurningBlazeSprite(&work->spriteBlaze);
    SetExDrawRequestPriority(&work->spriteBlaze.config, EXDRAWREQTASK_PRIORITY_DEFAULT);

    work->worker->playerFlags.characterID = EXPLAYER_CHARACTER_SONIC;
    ExPlayer_SwapPlayerGraphics();
    InitExDrawRequestTrail(&work->trailMain, &work->activeModelMain->model.translation, EXDRAWREQTASK_TRAIL_PLAYER);
    SetExDrawRequestPriority(&work->trailMain.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    work->worker->swapCooldown = 0;

    SetCurrentExTaskMainEvent(ExPlayer_Main_EnterPlayers);
}

void ExPlayer_TaskUnknown(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);
    UNUSED(work);
}

void ExPlayer_Destructor(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    ReleaseExSuperSonicModel(&work->aniSonic->manager);
    ReleaseExRegularSonicModel(&work->aniSonic->manager);
    ReleaseExBurningBlazeModel(&work->aniBlaze->manager);
    ReleaseExRegularBlazeModel(&work->aniBlaze->manager);
    ReleaseExSuperSonicSprite(&work->spriteSonic);
    ReleaseExBurningBlazeSprite(&work->spriteBlaze);

    DestroyExTask(exPlayerScreenMoverTaskSingleton);

    exPlayerTaskSingleton = NULL;
}

void ExPlayer_Main_ControlLocked(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);
    UNUSED(work);

    ProcessExPlayerAnimations();

    if (!HandleExPlayerHitResponse() && !ExPlayer_HandleUserControl())
    {
        ExPlayer_Draw();

        RunCurrentExTaskUnknownEvent();
    }
}

void ExPlayer_Main_EnterPlayers(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);
    UNUSED(work);

    ProcessExPlayerAnimations();

    if (work->activeModelMain->model.translation.y >= -FLOAT_TO_FX32(20.0))
    {
        ExPlayer_Action_ShowTitleCard();
    }
    else
    {
        work->activeModelMain->model.translation.y += FLOAT_TO_FX32(1.0);
        ExPlayer_Draw();

        RunCurrentExTaskUnknownEvent();
    }
}

void ExPlayer_Action_ShowTitleCard(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);
    UNUSED(work);

    CreateExTitleCard();

    SetCurrentExTaskMainEvent(ExPlayer_Main_WaitForTitleCard);
    ExPlayer_Main_WaitForTitleCard();
}

void ExPlayer_Main_WaitForTitleCard(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);
    UNUSED(work);

    ProcessExPlayerAnimations();

    if (GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_ACTIVE)
        SetCurrentExTaskMainEvent(ExPlayer_Main_ControlLocked);

    ExPlayer_Draw();

    RunCurrentExTaskUnknownEvent();
}

void ExPlayer_Main_InitForBossChase(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    work->worker->shockStunDuration = 0;
    SetExDrawRequestGlobalModelConfigTimer(0);
    work->worker->moveFlags.disableDash = FALSE;
    SetExDrawLightType(&work->aniSonic->manager.config, EXDRAWREQ_LIGHT_DEFAULT);
    SetExDrawLightType(&work->aniBlaze->manager.config, EXDRAWREQ_LIGHT_DEFAULT);
    work->worker->barrierChargeTimer                       = 0;
    work->aniSonic->manager.model.animator.speedMultiplier = FLOAT_TO_FX32(1.0);
    work->worker->fireballChargeTimer                      = 0;
    work->worker->dashTimer                                = 0;
    work->worker->bossChaseTargetPos.x                     = FLOAT_TO_FX32(0.0);
    work->worker->bossChaseTargetPos.y                     = FLOAT_TO_FX32(0.0);

    SetExSuperSonicAnimation(&work->aniSonic->manager, work->aniSonic->nextAnim);
    SetExDrawRequestAnimAsOneShot(&work->aniSonic->manager.config);

    SetExBurningBlazeAnimation(&work->aniBlaze->manager, work->aniBlaze->nextAnim);
    SetExDrawRequestAnimAsOneShot(&work->aniBlaze->manager.config);

    InitExDrawRequestTrail(&work->trailSub, &work->activeModelSub->model.translation, EXDRAWREQTASK_TRAIL_PLAYER);
    SetExDrawRequestPriority(&work->trailSub.config, EXDRAWREQTASK_PRIORITY_DEFAULT);

    SetCurrentExTaskMainEvent(ExPlayer_Main_PrepareForBossChase);
    ExPlayer_Main_PrepareForBossChase();
}

void ExPlayer_Main_PrepareForBossChase(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    ProcessExPlayerAnimations();

    ovl09_2152EA8(work->activeModelMain->model.translation.y - work->worker->bossChaseTargetPos.y, work->activeModelMain->model.translation.x - work->worker->bossChaseTargetPos.x,
                  &work->worker->bossChaseRotation, &work->worker->bossChaseRotationUnknown, FLOAT_DEG_TO_IDX(179.96));

    work->worker->bossChaseMove.x = MultiplyFX(CosFX(work->worker->bossChaseRotation.y), work->worker->velocity.x);
    work->worker->bossChaseMove.y = MultiplyFX(SinFX(work->worker->bossChaseRotation.y), work->worker->velocity.y);

    work->activeModelMain->model.translation.x -= work->worker->bossChaseMove.x;
    work->activeModelMain->model.translation.y -= work->worker->bossChaseMove.y;

    exPlayerAdminTaskWorker *worker = work->worker;

    if (work->activeModelMain->model.translation.x < worker->bossChaseTargetPos.x + FLOAT_TO_FX32(2.0)
        && work->activeModelMain->model.translation.x > worker->bossChaseTargetPos.x - FLOAT_TO_FX32(2.0))
    {
        if (work->activeModelMain->model.translation.y < worker->bossChaseTargetPos.y + FLOAT_TO_FX32(2.0)
            && work->activeModelMain->model.translation.y > worker->bossChaseTargetPos.y - FLOAT_TO_FX32(2.0))
        {
            ExPlayer_Action_BossChaseDelay();
            return;
        }
    }

    ProcessExDrawRequestPlayerTrail(&work->trailMain, &work->activeModelMain->model.translation, 0, worker->playerFlags.characterID);
    ExPlayer_DrawForBossChase();

    RunCurrentExTaskUnknownEvent();
}

void ExPlayer_Action_BossChaseDelay(void)
{
    exPlayerAdminTask *work      = ExTaskGetWorkCurrent(exPlayerAdminTask);
    work->worker->bossChaseTimer = SECONDS_TO_FRAMES(2.0);

    if (GetExSystemStatus()->state == EXSYSTASK_STATE_STAGE_FINISHED)
        exBossHelpers__Func_2154C38(0);

    SetCurrentExTaskMainEvent(ExPlayer_Main_BossChaseDelay);
    ExPlayer_Main_BossChaseDelay();
}

void ExPlayer_Main_BossChaseDelay(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    ProcessExPlayerAnimations();

    if (GetExSystemStatus()->state != EXSYSTASK_STATE_STAGE_FINISHED && work->worker->bossChaseTimer-- <= 0)
    {
        ExPlayer_Action_StartBossChase();
    }
    else
    {
        ProcessExDrawRequestPlayerTrail(&work->trailMain, &work->activeModelMain->model.translation, 0, work->worker->playerFlags.characterID);
        ExPlayer_DrawForBossChase();

        RunCurrentExTaskUnknownEvent();
    }
}

void ExPlayer_Action_StartBossChase(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    work->activeModelMain->model.translation.x = FLOAT_TO_FX32(0.0);
    work->activeModelMain->model.translation.y = FLOAT_TO_FX32(5.0);

    GetExStageSingleton()->velocity.y += FLOAT_TO_FX32(1.0);

    if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_SONIC)
    {
        CreateExSonicDashEffect(&work->aniSonic->manager);
        CreateExBlazeDashEffect(&work->aniBlaze->manager);
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_DASH);
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_BURNING);
    }
    else if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_BLAZE)
    {
        CreateExSonicDashEffect(&work->aniSonic->manager);
        CreateExBlazeDashEffect(&work->aniBlaze->manager);
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_DASH);
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_BURNING);
    }

    if (GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_HEAL_PHASE2_STARTED)
    {
        work->worker->bossChaseTimer = SECONDS_TO_FRAMES(5.0);
    }
    else if (GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_HEAL_PHASE3_STARTED)
    {
        work->worker->bossChaseTimer = SECONDS_TO_FRAMES(5.0);
    }

    CreateExDrawFadeTask(RENDERCORE_BRIGHTNESS_WHITE, RENDERCORE_BRIGHTNESS_DEFAULT, 16, 0, EXDRAWFADETASK_FLAG_ON_ENGINE_A);
    CreateExDrawFadeTask(RENDERCORE_BRIGHTNESS_WHITE, RENDERCORE_BRIGHTNESS_DEFAULT, 16, 0, EXDRAWFADETASK_FLAG_ON_ENGINE_B);

    SetCurrentExTaskMainEvent(ExPlayer_Main_StartBossChase);
    ExPlayer_Main_StartBossChase();
}

void ExPlayer_Main_StartBossChase(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    ProcessExPlayerAnimations();

    if (work->worker->bossChaseTimer-- <= 0)
    {
        ExPlayer_Action_ReadyBossPhaseChange();
    }
    else
    {
        if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_SONIC)
        {
            ProcessExDrawRequestPlayerTrail(&work->trailMain, &work->activeModelMain->model.translation, 2, EXPLAYER_CHARACTER_SONIC);
            ProcessExDrawRequestPlayerTrail(&work->trailSub, &work->activeModelSub->model.translation, 2, EXPLAYER_CHARACTER_BLAZE);

            AddExDrawRequest(&work->trailSub, &work->trailSub.config);
        }
        else
        {
            ProcessExDrawRequestPlayerTrail(&work->trailMain, &work->activeModelMain->model.translation, 2, EXPLAYER_CHARACTER_BLAZE);
            ProcessExDrawRequestPlayerTrail(&work->trailSub, &work->activeModelSub->model.translation, 2, EXPLAYER_CHARACTER_SONIC);

            AddExDrawRequest(&work->trailSub, &work->trailSub.config);
        }

        ExPlayer_DrawForBossChase();

        RunCurrentExTaskUnknownEvent();
    }
}

void ExPlayer_Action_ReadyBossPhaseChange(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);
    UNUSED(work);

    exBossHelpers__Func_2154C38(FALSE);

    if (GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_HEAL_PHASE2_STARTED)
    {
        SetCurrentExTaskMainEvent(ExPlayer_Main_StartBossPhase2);
        ExPlayer_Main_StartBossPhase2();
    }
    else if (GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_HEAL_PHASE3_STARTED)
    {
        SetCurrentExTaskMainEvent(ExPlayer_Main_StartBossPhase3);
        ExPlayer_Main_StartBossPhase3();
    }
}

void ExPlayer_Main_StartBossPhase2(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    ProcessExPlayerAnimations();

    if (GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_HEAL_PHASE2_DONE)
    {
        SetCurrentExTaskMainEvent(ExPlayer_Main_ControlLocked);
        ExPlayer_DrawForBossChase();
    }
    else
    {
        if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_SONIC)
        {
            ProcessExDrawRequestPlayerTrail(&work->trailMain, &work->activeModelMain->model.translation, 2, EXPLAYER_CHARACTER_SONIC);
            ProcessExDrawRequestPlayerTrail(&work->trailSub, &work->activeModelSub->model.translation, 2, EXPLAYER_CHARACTER_BLAZE);

            AddExDrawRequest(&work->trailSub, &work->trailSub.config);
        }
        else
        {
            ProcessExDrawRequestPlayerTrail(&work->trailMain, &work->activeModelMain->model.translation, 2, EXPLAYER_CHARACTER_BLAZE);
            ProcessExDrawRequestPlayerTrail(&work->trailSub, &work->activeModelSub->model.translation, 2, EXPLAYER_CHARACTER_SONIC);

            AddExDrawRequest(&work->trailSub, &work->trailSub.config);
        }

        ExPlayer_DrawForBossChase();

        RunCurrentExTaskUnknownEvent();
    }
}

void ExPlayer_Main_StartBossPhase3(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    ProcessExPlayerAnimations();

    if (GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_HEAL_PHASE3_DONE)
    {
        SetCurrentExTaskMainEvent(ExPlayer_Main_ControlLocked);

        ExPlayer_DrawForBossChase();
    }
    else
    {
        if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_SONIC)
        {
            ProcessExDrawRequestPlayerTrail(&work->trailMain, &work->activeModelMain->model.translation, 2, EXPLAYER_CHARACTER_SONIC);
            ProcessExDrawRequestPlayerTrail(&work->trailSub, &work->activeModelSub->model.translation, 2, EXPLAYER_CHARACTER_BLAZE);

            AddExDrawRequest(&work->trailSub, &work->trailSub.config);
        }
        else
        {
            ProcessExDrawRequestPlayerTrail(&work->trailMain, &work->activeModelMain->model.translation, 2, EXPLAYER_CHARACTER_BLAZE);
            ProcessExDrawRequestPlayerTrail(&work->trailSub, &work->activeModelSub->model.translation, 2, EXPLAYER_CHARACTER_SONIC);

            AddExDrawRequest(&work->trailSub, &work->trailSub.config);
        }

        ExPlayer_DrawForBossChase();

        RunCurrentExTaskUnknownEvent();
    }
}

void ExPlayer_DrawForBossChase(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    if (work->activeModelMain->model.angle.z < FLOAT_DEG_TO_IDX(179.0))
    {
        work->activeModelMain->model.angle.z += FLOAT_DEG_TO_IDX(4.0);
    }
    else
    {
        if (work->activeModelMain->model.angle.z > FLOAT_DEG_TO_IDX(181.0))
            work->activeModelMain->model.angle.z -= FLOAT_DEG_TO_IDX(4.0);
        else
            work->activeModelMain->model.angle.z = FLOAT_DEG_TO_IDX(180.0);
    }

    AddExDrawRequest(work->activeModelMain, &work->activeModelMain->config);

    work->worker->position = &work->activeModelMain->model.translation;

    if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_SONIC)
    {
        work->activeModelSub->model.translation.x +=
            MultiplyFX(work->activeModelMain->model.translation.x + FLOAT_TO_FX32(5.0) - work->activeModelSub->model.translation.x, FLOAT_TO_FX32(0.125));
        work->activeModelSub->model.translation.y +=
            MultiplyFX(work->activeModelMain->model.translation.y - FLOAT_TO_FX32(5.0) - work->activeModelSub->model.translation.y, FLOAT_TO_FX32(0.125));
    }
    else if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_BLAZE)
    {
        work->activeModelSub->model.translation.x +=
            MultiplyFX(work->activeModelMain->model.translation.x - FLOAT_TO_FX32(5.0) - work->activeModelSub->model.translation.x, FLOAT_TO_FX32(0.125));
        work->activeModelSub->model.translation.y +=
            MultiplyFX(work->activeModelMain->model.translation.y - FLOAT_TO_FX32(5.0) - work->activeModelSub->model.translation.y, FLOAT_TO_FX32(0.125));
    }

    AddExDrawRequest(work->activeModelSub, &work->activeModelSub->config);
    AddExDrawRequest(&work->trailMain, &work->trailMain.config);

    SetExPlayerScreenMoverTargetPos(&work->activeModelMain->model.translation);
}

void ExPlayer_Action_ShockStun(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    ProcessExPlayerAnimations();

    work->worker->moveFlags.disableDash = FALSE;
    SetExDrawLightType(&work->aniSonic->manager.config, EXDRAWREQ_LIGHT_DEFAULT);
    SetExDrawLightType(&work->aniBlaze->manager.config, EXDRAWREQ_LIGHT_DEFAULT);

    work->worker->barrierChargeTimer                       = 0;
    work->aniSonic->manager.model.animator.speedMultiplier = FLOAT_TO_FX32(1.0);
    work->worker->fireballChargeTimer                      = 0;
    work->worker->dashTimer                                = 0;

    SetExSuperSonicAnimation(&work->aniSonic->manager, ex_son_biri);
    SetExDrawRequestAnimStopOnFinish(&work->aniSonic->manager.config);
    SetExBurningBlazeAnimation(&work->aniBlaze->manager, ex_blz_biri);
    SetExDrawRequestAnimStopOnFinish(&work->aniBlaze->manager.config);

    work->worker->shockStunDuration = SECONDS_TO_FRAMES(2.0);
    CreateExShockEffect(&work->activeModelMain->model.translation);

    SetCurrentExTaskMainEvent(ExPlayer_Main_InitShockStun);
    ExPlayer_Main_InitShockStun();
}

void ExPlayer_Main_InitShockStun(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    work->activeModelMain->hitChecker.hitFlags.isStunned = FALSE;

    SetCurrentExTaskMainEvent(ExPlayer_Main_ShockStun);
    ExPlayer_Main_ShockStun();
}

void ExPlayer_Main_ShockStun(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    ProcessExPlayerAnimations();

    ProcessExDrawTimer(&work->aniSonic->manager.config);
    ProcessExDrawTimer(&work->aniBlaze->manager.config);

    work->aniSonic->manager.config.control.timer = 5;
    work->aniBlaze->manager.config.control.timer = 5;

    if (HandleExPlayerHitResponse())
    {
        work->aniSonic->manager.config.control.timer = 0;
        work->aniBlaze->manager.config.control.timer = 0;
    }
    else
    {
        if (work->worker->shockStunDuration-- <= 0)
        {
            work->worker->shockStunDuration = 0;

            work->aniSonic->manager.config.control.timer = 0;
            work->aniBlaze->manager.config.control.timer = 0;

            SetExSuperSonicAnimation(&work->aniSonic->manager, work->aniSonic->nextAnim);
            SetExDrawRequestAnimAsOneShot(&work->aniSonic->manager.config);
            SetExBurningBlazeAnimation(&work->aniBlaze->manager, work->aniBlaze->nextAnim);
            SetExDrawRequestAnimAsOneShot(&work->aniBlaze->manager.config);

            SetCurrentExTaskMainEvent(ExPlayer_Main_ControlLocked);
        }

        ExPlayer_Draw();

        RunCurrentExTaskUnknownEvent();
    }
}

void ExPlayer_Action_Die(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    GetExStageSingleton()->velocity.y = FLOAT_TO_FX32(0.0);

    SetExDrawRequestGlobalModelConfigTimer(0);

    work->activeModelMain->config.control.isInvisible = FALSE;
    work->activeModelSub->config.control.isInvisible  = FALSE;
    work->worker->hurtInvulnDuration                  = 0;
    work->worker->shockStunDuration                   = 0;

    work->aniSonic->manager.config.control.timer = 0;
    work->aniBlaze->manager.config.control.timer = 0;

    fx32 x1 = work->activeModelMain->model.translation.x;
    fx32 y1 = work->activeModelMain->model.translation.y;
    fx32 z1 = work->activeModelMain->model.translation.z;
    fx32 x2 = work->activeModelSub->model.translation.x;
    fx32 y2 = work->activeModelSub->model.translation.y;
    fx32 z2 = work->activeModelSub->model.translation.z;

    ReleaseExSuperSonicModel(&work->aniSonic->manager);
    LoadExRegularSonicModel(&work->aniSonic->manager);
    SetExDrawRequestPriority(&work->aniSonic->manager.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    work->aniSonic->nextAnim = ex_nson_die_01;

    struct exPlayerGraphics3D **aniBlaze = &work->aniBlaze;
    ReleaseExBurningBlazeModel(&(*aniBlaze)->manager);
    LoadExRegularBlazeModel(&(*aniBlaze)->manager);
    SetExDrawRequestPriority(&(*aniBlaze)->manager.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    (*aniBlaze)->nextAnim = ex_nblz_die_01;

    work->activeModelMain->model.translation.x = x1;
    work->activeModelMain->model.translation.y = y1;
    work->activeModelMain->model.translation.z = z1;
    work->activeModelSub->model.translation.x  = x2;
    work->activeModelSub->model.translation.y  = y2;
    work->activeModelSub->model.translation.z  = z2;

    work->worker->acceleration.z = FLOAT_TO_FX32(10.0);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DEATH);

    SetCurrentExTaskMainEvent(ExPlayer_Main_StartDeath);
    ExPlayer_Main_StartDeath();
}

void ExPlayer_Main_StartDeath(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    ProcessExPlayerAnimations();

    work->worker->acceleration.z -= FLOAT_TO_FX32(0.5);
    work->activeModelMain->model.translation.z += work->worker->acceleration.z;
    work->activeModelSub->model.translation.z += work->worker->acceleration.z;

    if (IsExDrawRequestModelAnimFinished(&work->aniSonic->manager))
    {
        ExPlayer_Action_HandleDeath();
    }
    else
    {
        work->worker->moveFlags.hasDied = TRUE;
        ExPlayer_Draw();

        RunCurrentExTaskUnknownEvent();
    }
}

void ExPlayer_Action_HandleDeath(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    SetExRegularSonicAnimation(&work->aniSonic->manager, ex_nson_die_02);
    SetExDrawRequestAnimAsOneShot(&work->aniSonic->manager.config);

    SetExRegularBlazeAnimation(&work->aniBlaze->manager, ex_nblz_die_02);
    SetExDrawRequestAnimAsOneShot(&work->aniBlaze->manager.config);

    work->worker->deathTimer = 90;

    SetCurrentExTaskMainEvent(ExPlayer_Main_HandleDealth);
    ExPlayer_Main_HandleDealth();
}

void ExPlayer_Main_HandleDealth(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    ProcessExPlayerAnimations();

    if (work->activeModelMain->model.translation.z <= FLOAT_TO_FX32(0.0))
    {
        if (work->worker->deathTimer-- <= 0)
        {
            ExPlayer_Action_FinishDeath();
            return;
        }
    }
    else
    {
        work->worker->acceleration.z -= FLOAT_TO_FX32(0.5);
        work->activeModelMain->model.translation.z += work->worker->acceleration.z;
        work->activeModelSub->model.translation.z += work->worker->acceleration.z;
    }

    work->worker->moveFlags.hasDied = TRUE;

    ExPlayer_Draw();

    RunCurrentExTaskUnknownEvent();
}

void ExPlayer_Action_FinishDeath(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    GetExSystemStatus()->finishMode = EXFINISHMODE_PLAYER_DEATH;

    SetCurrentExTaskMainEvent(ExPlayer_Main_Died);
    ExPlayer_Main_Died();
}

void ExPlayer_Main_Died(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    work->worker->moveFlags.hasDied = TRUE;

    RunCurrentExTaskUnknownEvent();
}

void ExPlayer_Action_Hurt(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    ProcessExPlayerAnimations();

    if (GetExSystemStatus()->timeLimitMode == EXSYS_TIMELIMIT_ON && CheckExTimeGameplayIsTimeOver())
    {
        // Time Over!
        ExPlayer_Action_Die();
    }
    else
    {
        work->worker->shockStunDuration                    = 0;
        work->activeModelMain->hitChecker.hitFlags.isStunned = FALSE;
        work->worker->moveFlags.disableDash                = FALSE;
        SetExDrawLightType(&work->aniSonic->manager.config, EXDRAWREQ_LIGHT_DEFAULT);
        SetExDrawLightType(&work->aniBlaze->manager.config, EXDRAWREQ_LIGHT_DEFAULT);
        work->worker->barrierChargeTimer                       = 0;
        work->aniSonic->manager.model.animator.speedMultiplier = FLOAT_TO_FX32(1.0);
        work->worker->fireballChargeTimer                      = 0;
        work->worker->dashTimer                                = 0;

        work->worker->playerFlags.isHurt = TRUE;
        work->worker->hurtFallSpeed      = FLOAT_TO_FX32(2.5);
        work->worker->hurtUnknown        = FLOAT_TO_FX32(60.0);

        SetExSuperSonicAnimation(&work->aniSonic->manager, ex_son_dmg);
        SetExDrawRequestAnimStopOnFinish(&work->aniSonic->manager.config);
        SetExBurningBlazeAnimation(&work->aniBlaze->manager, ex_blz_dmg);
        SetExDrawRequestAnimStopOnFinish(&work->aniBlaze->manager.config);

        SetCurrentExTaskMainEvent(ExPlayer_Main_Hurt);
        ExPlayer_Main_Hurt();
    }
}

void ExPlayer_Main_Hurt(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    u8 animFinishedCount = 0;
    ProcessExPlayerAnimations();

    work->worker->hurtFallSpeed -= FLOAT_TO_FX32(0.0625);
    if (work->worker->hurtFallSpeed <= FLOAT_TO_FX32(0.0625))
        work->worker->hurtFallSpeed = FLOAT_TO_FX32(0.0);

    work->activeModelMain->model.translation.y -= work->worker->hurtFallSpeed;

    if (IsExDrawRequestModelAnimFinished(&work->aniSonic->manager))
        animFinishedCount++;

    if (IsExDrawRequestModelAnimFinished(&work->aniBlaze->manager))
        animFinishedCount++;

    if (animFinishedCount == EXPLAYER_CHARACTER_COUNT)
    {
        ExPlayer_Action_FinishedHurt();
    }
    else
    {
        work->worker->hurtInvulnDuration = SECONDS_TO_FRAMES(2.0);
        ExPlayer_Draw();

        RunCurrentExTaskUnknownEvent();
    }
}

void ExPlayer_Action_FinishedHurt(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    ProcessExPlayerAnimations();

    SetExSuperSonicAnimation(&work->aniSonic->manager, work->aniSonic->nextAnim);
    SetExDrawRequestAnimAsOneShot(&work->aniSonic->manager.config);

    SetExBurningBlazeAnimation(&work->aniBlaze->manager, work->aniBlaze->nextAnim);
    SetExDrawRequestAnimAsOneShot(&work->aniBlaze->manager.config);

    work->activeModelMain->model.translation.z = FLOAT_TO_FX32(60.0);
    work->activeModelSub->model.translation.z  = FLOAT_TO_FX32(50.0);
    work->worker->playerFlags.isHurt           = FALSE;
    work->worker->hurtInvulnDuration           = SECONDS_TO_FRAMES(2.0);

    InitExDrawRequestTrail(&work->trailMain, &work->activeModelMain->model.translation, EXDRAWREQTASK_TRAIL_PLAYER);
    SetExDrawRequestPriority(&work->trailMain.config, EXDRAWREQTASK_PRIORITY_DEFAULT);

    SetCurrentExTaskMainEvent(ExPlayer_Main_FinishedHurt);
    ExPlayer_Main_FinishedHurt();
}

void ExPlayer_Main_FinishedHurt(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    ProcessExPlayerAnimations();

    if (work->worker->hurtInvulnDuration <= 0)
    {
        ExPlayer_ForceInvincibility();

        SetCurrentExTaskMainEvent(ExPlayer_Main_ControlLocked);
        ExPlayer_Main_ControlLocked();
    }
    else
    {
        work->activeModelMain->hitChecker.hitFlags.isHurt = FALSE;
        work->activeModelSub->hitChecker.hitFlags.isHurt  = FALSE;

        if (ExPlayer_HandleUserControl())
        {
            ExPlayer_ForceInvincibility();
        }
        else
        {
            ExPlayer_Draw();

            RunCurrentExTaskUnknownEvent();
        }
    }
}

void ExPlayer_ForceInvincibility(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    work->activeModelMain->hitChecker.hitFlags.isHurt = FALSE;
    work->activeModelSub->hitChecker.hitFlags.isHurt  = FALSE;

    work->activeModelMain->config.control.isInvisible = FALSE;
    work->activeModelSub->config.control.isInvisible  = FALSE;
}

void ExPlayer_Action_StartSonicBarrier(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    work->worker->moveFlags.disableDash = TRUE;
    work->worker->barrierChargeTimer    = 1;
    CreateExSonicBarrierChargingEffect(&work->aniSonic->manager);

    SetCurrentExTaskMainEvent(ExPlayer_Main_StartSonicBarrier);
    ExPlayer_Main_StartSonicBarrier();
}

void ExPlayer_Main_StartSonicBarrier(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    ProcessExPlayerAnimations();

    if (!HandleExPlayerHitResponse())
    {
        ExPlayer_HandleMovement();
        ExPlayer_HandleDash();

        if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_SONIC)
        {
            if (((padInput.btnDown & PAD_BUTTON_X) != 0 || (padInput.btnDown & PAD_BUTTON_Y) != 0))
            {
                if (work->worker->barrierChargeTimer++ >= SECONDS_TO_FRAMES(2.0))
                {
                    if (!Camera3D__UseEngineA())
                    {
                        u32 isChargeFlash = work->worker->moveFlags.isChargeFlash;
                        work->worker->moveFlags.isChargeFlash++;

                        if (isChargeFlash)
                            SetExDrawLightType(&work->aniSonic->manager.config, EXDRAWREQ_LIGHT_RED);
                        else
                            SetExDrawLightType(&work->aniSonic->manager.config, EXDRAWREQ_LIGHT_DEFAULT);
                    }

                    work->worker->barrierChargeTimer = SECONDS_TO_FRAMES(2.0);
                }
            }

            if ((padInput.btnDown & PAD_BUTTON_X) == 0 && (padInput.btnDown & PAD_BUTTON_Y) == 0)
            {
                SetExDrawLightType(&work->aniSonic->manager.config, EXDRAWREQ_LIGHT_DEFAULT);

                if (work->worker->barrierChargeTimer == SECONDS_TO_FRAMES(2.0))
                {
                    if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
                    {
                        work->aniSonic->manager.hitChecker.power = EXPLAYER_BARRIER_CHARGED_POWER_NORMAL;
                    }
                    else if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_EASY)
                    {
                        work->aniSonic->manager.hitChecker.power = EXPLAYER_BARRIER_CHARGED_POWER_EASY;
                    }
                }
                else
                {
                    if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
                    {
                        work->aniSonic->manager.hitChecker.power = EXPLAYER_BARRIER_REGULAR_POWER_NORMAL;
                    }
                    else if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_EASY)
                    {
                        work->aniSonic->manager.hitChecker.power = EXPLAYER_BARRIER_REGULAR_POWER_EASY;
                    }
                }

                ExPlayer_Action_SonicBarrierEnd();
                return;
            }
        }

        ExPlayer_Draw();
    }
}

void ExPlayer_Action_SonicBarrierEnd(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    work->worker->barrierChargeTimer = 0;

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_EFFECT);
    CreateExSonicBarrierEffect(&work->aniSonic->manager);

    SetExSuperSonicAnimation(&work->aniSonic->manager, ex_son_br_03);
    SetExDrawRequestAnimStopOnFinish(&work->aniSonic->manager.config);

    work->aniSonic->manager.model.animator.speedMultiplier = FLOAT_TO_FX32(2.0);

    SetCurrentExTaskMainEvent(ExPlayer_Main_SonicBarrierEnd);
    ExPlayer_Main_SonicBarrierEnd();
}

void ExPlayer_Main_SonicBarrierEnd(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    ProcessExPlayerAnimations();

    if (IsExDrawRequestModelAnimFinished(&work->aniSonic->manager))
    {
        work->aniSonic->manager.model.animator.speedMultiplier = FLOAT_TO_FX32(1.0);
        ExPlayer_Action_SonicBarrierFinish();
    }
    else
    {
        if (!HandleExPlayerHitResponse())
        {
            ExPlayer_HandleMovement();
            ExPlayer_HandleDash();
        }
        ExPlayer_Draw();
    }
}

void ExPlayer_Action_SonicBarrierFinish(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    SetExSuperSonicAnimation(&work->aniSonic->manager, ex_son_br_04);
    SetExDrawRequestAnimStopOnFinish(&work->aniSonic->manager.config);
    work->worker->moveFlags.disableDash = FALSE;

    SetCurrentExTaskMainEvent(ExPlayer_Main_SonicBarrierFinish);
    ExPlayer_Main_SonicBarrierFinish();
}

void ExPlayer_Main_SonicBarrierFinish(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    ProcessExPlayerAnimations();
    ExPlayer_HandlePlayerSwap();

    if (ExPlayer_TryUseAbility())
    {
        ExPlayer_EndSonicBarrierAnim();
    }
    else if (IsExDrawRequestModelAnimFinished(&work->aniSonic->manager))
    {
        ExPlayer_EndSonicBarrierAnim();

        SetCurrentExTaskMainEvent(ExPlayer_Main_ControlLocked);
        ExPlayer_Main_ControlLocked();
    }
    else
    {
        if (!HandleExPlayerHitResponse())
        {
            ExPlayer_HandleMovement();
            ExPlayer_HandleDash();
        }
        ExPlayer_Draw();
    }
}

void ExPlayer_EndSonicBarrierAnim(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    SetExSuperSonicAnimation(&work->aniSonic->manager, work->aniSonic->nextAnim);
    SetExDrawRequestAnimAsOneShot(&work->aniSonic->manager.config);
}

void ExPlayer_Action_StartBlazeFireball(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    work->worker->moveFlags.disableDash = TRUE;
    SetExBurningBlazeAnimation(&work->aniBlaze->manager, ex_blz_fb_01);
    SetExDrawRequestAnimStopOnFinish(&work->aniBlaze->manager.config);
    CreateExBlazeFireballChargingEffect(&work->aniBlaze->manager);
    CreateExBlazeFireballEffect(&work->aniBlaze->manager);

    SetCurrentExTaskMainEvent(ExPlayer_Main_StartBlazeFireball);
    ExPlayer_Main_StartBlazeFireball();
}

void ExPlayer_Main_StartBlazeFireball(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    SetExBurningBlazeAnimation(&work->aniBlaze->manager, ex_blz_fb_02);
    SetExDrawRequestAnimAsOneShot(&work->aniBlaze->manager.config);

    SetCurrentExTaskMainEvent(ExPlayer_Main_ChargeBlazeFireball);
    ExPlayer_Main_ChargeBlazeFireball();
}

void ExPlayer_Main_ChargeBlazeFireball(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    ProcessExPlayerAnimations();

    if (!HandleExPlayerHitResponse())
    {
        ExPlayer_HandleMovement();
        ExPlayer_HandleDash();

        if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_BLAZE)
        {
            if (((padInput.btnDown & PAD_BUTTON_X) != 0 || (padInput.btnDown & PAD_BUTTON_Y) != 0))
            {
                if (work->worker->fireballChargeTimer++ >= SECONDS_TO_FRAMES(2.0))
                {
                    if (!Camera3D__UseEngineA())
                    {
                        u32 isChargeFlash = work->worker->moveFlags.isChargeFlash;
                        work->worker->moveFlags.isChargeFlash++;

                        if (isChargeFlash)
                            SetExDrawLightType(&work->aniBlaze->manager.config, EXDRAWREQ_LIGHT_RED);
                        else
                            SetExDrawLightType(&work->aniBlaze->manager.config, EXDRAWREQ_LIGHT_DEFAULT);
                    }

                    work->worker->fireballChargeTimer = SECONDS_TO_FRAMES(2.0);
                }
            }

            if ((padInput.btnDown & PAD_BUTTON_X) == 0 && (padInput.btnDown & PAD_BUTTON_Y) == 0)
            {
                SetExDrawLightType(&work->aniBlaze->manager.config, EXDRAWREQ_LIGHT_DEFAULT);

                if (work->worker->fireballChargeTimer > 80)
                {
                    if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
                    {
                        work->aniBlaze->manager.hitChecker.power = EXPLAYER_FIREBALL_CHARGED_POWER_NORMAL;
                    }
                    else if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_EASY)
                    {
                        work->aniBlaze->manager.hitChecker.power = EXPLAYER_FIREBALL_CHARGED_POWER_EASY;
                    }
                }
                else if (work->worker->fireballChargeTimer <= 80)
                {
                    if (work->worker->fireballChargeTimer <= 40)
                    {
                        if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
                        {
                            work->aniBlaze->manager.hitChecker.power = EXPLAYER_FIREBALL_WEAK_POWER_NORMAL;
                        }
                        else if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_EASY)
                        {
                            work->aniBlaze->manager.hitChecker.power = EXPLAYER_FIREBALL_WEAK_POWER_EASY;
                        }
                    }
                    else
                    {
                        if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
                        {
                            work->aniBlaze->manager.hitChecker.power = EXPLAYER_FIREBALL_REGULAR_POWER_NORMAL;
                        }
                        else if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_EASY)
                        {
                            work->aniBlaze->manager.hitChecker.power = EXPLAYER_FIREBALL_REGULAR_POWER_EASY;
                        }
                    }
                }

                ExPlayer_Action_EndBlazeFireball();
                return;
            }
        }

        ExPlayer_Draw();
    }
}

void ExPlayer_Action_EndBlazeFireball(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    work->worker->fireballChargeTimer = 0;
    SetExBurningBlazeAnimation(&work->aniBlaze->manager, ex_blz_fb_03);
    SetExDrawRequestAnimStopOnFinish(&work->aniBlaze->manager.config);

    SetCurrentExTaskMainEvent(ExPlayer_Main_ShootBlazeFireball);
    ExPlayer_Main_ShootBlazeFireball();
}

void ExPlayer_Main_ShootBlazeFireball(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    ProcessExPlayerAnimations();

    if (work->aniBlaze->manager.model.primaryAnimResource->frame >= FLOAT_TO_FX32(5.0))
    {
        if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_NORMAL)
        {
            if (work->aniBlaze->manager.hitChecker.power == EXPLAYER_FIREBALL_CHARGED_POWER_NORMAL)
            {
                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_MAX);
            }
            else if (work->aniBlaze->manager.hitChecker.power == EXPLAYER_FIREBALL_REGULAR_POWER_NORMAL)
            {
                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_SAVED);
            }
            else
            {
                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_NORMAL);
            }
        }
        else if (GetExSystemStatus()->difficulty == EXSYS_DIFFICULTY_EASY)
        {
            if (work->aniBlaze->manager.hitChecker.power == EXPLAYER_FIREBALL_CHARGED_POWER_EASY)
            {
                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_MAX);
            }
            else if (work->aniBlaze->manager.hitChecker.power == EXPLAYER_FIREBALL_REGULAR_POWER_EASY)
            {
                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_SAVED);
            }
            else
            {
                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_NORMAL);
            }
        }

        CreateExBlazeFireballShotEffect(&work->aniBlaze->manager);

        SetCurrentExTaskMainEvent(ExPlayer_Main_EndBlazeFireball);
    }

    if (!HandleExPlayerHitResponse())
    {
        ExPlayer_HandleMovement();
        ExPlayer_HandleDash();
    }

    ExPlayer_Draw();
}

void ExPlayer_Main_EndBlazeFireball(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    ProcessExPlayerAnimations();

    if (IsExDrawRequestModelAnimFinished(&work->aniBlaze->manager))
    {
        ExPlayer_Action_FinishBlazeFireball();
    }
    else
    {
        if (!HandleExPlayerHitResponse())
        {
            ExPlayer_HandleMovement();
            ExPlayer_HandleDash();
        }
        ExPlayer_Draw();
    }
}

void ExPlayer_Action_FinishBlazeFireball(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    SetExBurningBlazeAnimation(&work->aniBlaze->manager, ex_blz_fb_04);
    SetExDrawRequestAnimStopOnFinish(&work->aniBlaze->manager.config);

    SetCurrentExTaskMainEvent(ExPlayer_Main_FinishBlazeFireball);
    ExPlayer_Main_FinishBlazeFireball();
}

void ExPlayer_Main_FinishBlazeFireball(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    ProcessExPlayerAnimations();

    if (IsExDrawRequestModelAnimFinished(&work->aniBlaze->manager))
    {
        ExPlayer_EndBlazeFireballAnim();

        SetCurrentExTaskMainEvent(ExPlayer_Main_ControlLocked);
        ExPlayer_Main_ControlLocked();
    }
    else
    {
        if (!HandleExPlayerHitResponse())
        {
            ExPlayer_HandleMovement();
            ExPlayer_HandleDash();
        }
        ExPlayer_Draw();
    }
}

void ExPlayer_EndBlazeFireballAnim(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    work->worker->moveFlags.disableDash = FALSE;

    SetExBurningBlazeAnimation(&work->aniBlaze->manager, work->aniBlaze->nextAnim);
    SetExDrawRequestAnimAsOneShot(&work->aniBlaze->manager.config);
}

BOOL HandleExPlayerHitResponse(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    exPlayerAdminTaskWorker *worker = work->worker;

    if (worker->dashTimer <= 0)
    {
        if (work->activeModelMain->hitChecker.hitFlags.isHurt)
        {
            if (worker->playerFlags.characterID == EXPLAYER_CHARACTER_SONIC)
                PlayStageVoiceClip(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_OWA);
            else
                PlayStageVoiceClip(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_UPS);

            ExPlayer_Action_Hurt();

            return TRUE;
        }

        if (work->activeModelMain->hitChecker.hitFlags.isStunned)
        {
            if (worker->shockStunDuration <= 0)
            {
                if (worker->playerFlags.characterID == EXPLAYER_CHARACTER_SONIC)
                    PlayStageVoiceClip(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_OWA);
                else
                    PlayStageVoiceClip(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_UPS);
            }

            ExPlayer_Action_ShockStun();

            return TRUE;
        }
    }
    else
    {
        if (worker->playerFlags.characterID == EXPLAYER_CHARACTER_BLAZE)
        {
            if (worker->shockStunDuration <= 0)
            {
                if (work->activeModelMain->hitChecker.hitFlags.isHurt)
                {
                    PlayStageVoiceClip(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_UPS);
                    ExPlayer_Action_Hurt();

                    return TRUE;
                }

                if (work->activeModelMain->hitChecker.hitFlags.isStunned)
                {
                    PlayStageVoiceClip(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_UPS);
                    ExPlayer_Action_ShockStun();

                    return TRUE;
                }
            }
        }
        else
        {
            work->activeModelMain->hitChecker.hitFlags.isHurt = FALSE;
            work->activeModelMain->hitChecker.hitFlags.isInvincible = TRUE;
        }
    }

    return FALSE;
}

BOOL ExPlayer_HandleUserControl(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    if (GetExSystemStatus()->state == EXSYSTASK_STATE_STAGE_FINISHED)
        return FALSE;

    ExPlayer_HandleMovement();
    ExPlayer_HandleDash();
    ExPlayer_HandlePlayerSwap();

    return ExPlayer_TryUseAbility();
}

BOOL ExPlayer_TryUseAbility(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    if (GetExSystemStatus()->state == EXSYSTASK_STATE_STAGE_FINISHED)
        return FALSE;

    if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_SONIC && ((padInput.btnDown & PAD_BUTTON_X) != 0 || (padInput.btnDown & PAD_BUTTON_Y) != 0))
    {
        ExPlayer_Action_StartSonicBarrier();
        return TRUE;
    }
    else if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_BLAZE && ((padInput.btnDown & PAD_BUTTON_X) != 0 || (padInput.btnDown & PAD_BUTTON_Y) != 0))
    {
        ExPlayer_Action_StartBlazeFireball();
        return TRUE;
    }

    return FALSE;
}

void ExPlayer_SwapPlayerGraphics(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_SONIC)
    {
        work->activeModelMain = &work->aniSonic->manager;
        work->activeModelSub  = &work->aniBlaze->manager;
        work->activeSprite    = &work->spriteBlaze;
    }
    else if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_BLAZE)
    {
        work->activeModelMain = &work->aniBlaze->manager;
        work->activeModelSub  = &work->aniSonic->manager;
        work->activeSprite    = &work->spriteSonic;
    }

    work->activeModelMain->hitChecker.type = EXHITCHECK_TYPE_ACTIVE_PLAYER;
    work->activeModelSub->hitChecker.type  = EXHITCHECK_TYPE_INACTIVE_PLAYER;

    AnimateExDrawRequestSprite3D(work->activeSprite);
}

void ExPlayer_HandleMovement(void)
{
    EX_ACTION_NN_WORK *activeWorker;

    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    activeWorker = work->activeModelMain;

    if (GetExSystemStatus()->state != EXSYSTASK_STATE_STAGE_FINISHED)
    {
        if (work->worker->dashTimer <= 0)
        {
            work->worker->playerFlags.btnLeft        = FALSE;
            work->worker->playerFlags.btnRight       = FALSE;
            work->worker->playerFlags.btnDown        = FALSE;
            work->worker->playerFlags.btnUp          = FALSE;
            work->worker->playerFlags.movingDiagonal = FALSE;

            work->worker->velocity.x = FLOAT_TO_FX32(1.5);
            work->worker->velocity.y = FLOAT_TO_FX32(1.5);

            if ((padInput.btnDown & PAD_KEY_LEFT) != 0)
            {
                work->worker->playerFlags.btnLeft = TRUE;

                if (work->activeModelMain->model.angle.z > FLOAT_DEG_TO_IDX(135.0))
                    work->activeModelMain->model.angle.z -= FLOAT_DEG_TO_IDX(2.0);
                else
                    work->activeModelMain->model.angle.z = FLOAT_DEG_TO_IDX(135.0);
            }
            else if ((padInput.btnDown & PAD_KEY_RIGHT) != 0)
            {
                work->worker->playerFlags.btnRight = TRUE;

                if (work->activeModelMain->model.angle.z < FLOAT_DEG_TO_IDX(225.0))
                    work->activeModelMain->model.angle.z += FLOAT_DEG_TO_IDX(2.0);
                else
                    work->activeModelMain->model.angle.z = FLOAT_DEG_TO_IDX(225.0);
            }
            else
            {
                if (work->activeModelMain->model.angle.z < FLOAT_DEG_TO_IDX(179.0))
                {
                    work->activeModelMain->model.angle.z += FLOAT_DEG_TO_IDX(4.0);
                }
                else
                {
                    if (work->activeModelMain->model.angle.z > FLOAT_DEG_TO_IDX(181.0))
                        work->activeModelMain->model.angle.z -= FLOAT_DEG_TO_IDX(4.0);
                    else
                        work->activeModelMain->model.angle.z = FLOAT_DEG_TO_IDX(180.0);
                }
            }

            if (work->activeModelSub->model.angle.z < FLOAT_DEG_TO_IDX(179.0))
            {
                work->activeModelSub->model.angle.z += FLOAT_DEG_TO_IDX(4.0);
            }
            else
            {
                if (work->activeModelSub->model.angle.z > FLOAT_DEG_TO_IDX(181.0))
                    work->activeModelSub->model.angle.z -= FLOAT_DEG_TO_IDX(4.0);
                else
                    work->activeModelSub->model.angle.z = FLOAT_DEG_TO_IDX(180.0);
            }

            if ((padInput.btnDown & PAD_KEY_DOWN) != 0)
            {
                work->worker->playerFlags.btnDown = TRUE;

                if (work->worker->playerFlags.btnRight || work->worker->playerFlags.btnLeft)
                    work->worker->playerFlags.movingDiagonal = TRUE;
            }
            else if ((padInput.btnDown & PAD_KEY_UP) != 0)
            {
                work->worker->playerFlags.btnUp = TRUE;

                if (work->worker->playerFlags.btnRight || work->worker->playerFlags.btnLeft)
                    work->worker->playerFlags.movingDiagonal = TRUE;
            }

            if (work->worker->playerFlags.movingDiagonal == TRUE)
            {
                fx32 velX = work->worker->velocity.x;
                float speedX;
                MULTIPLY_FLOAT_FX(speedX, FX32_TO_FLOAT(CosFX(FLOAT_DEG_TO_IDX(45.0))))
                work->worker->velocity.x = MultiplyFX(speedX, velX);

                fx32 velY = work->worker->velocity.y;
                float speedY;
                MULTIPLY_FLOAT_FX(speedY, FX32_TO_FLOAT(SinFX(FLOAT_DEG_TO_IDX(45.0))))
                work->worker->velocity.y = MultiplyFX(speedY, velY);
            }

            if ((padInput.btnPress & PAD_BUTTON_B) != 0 || (padInput.btnPress & PAD_BUTTON_A) != 0)
            {
                if (!work->worker->moveFlags.disableDash)
                {
                    work->worker->dashTimer = 0;

                    if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_SONIC)
                    {
                        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_DASH);
                        work->worker->dashTimer = 8;
                        CreateExSonicDashEffect(&work->aniSonic->manager);
                    }
                    else if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_BLAZE)
                    {
                        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_BURNING);
                        work->worker->dashTimer = 6;
                        CreateExBlazeDashEffect(&work->aniBlaze->manager);
                    }

                    SetExSuperSonicAnimation(&work->aniSonic->manager, ex_son_f);
                    SetExDrawRequestAnimStopOnFinish(&work->aniSonic->manager.config);
                    SetExBurningBlazeAnimation(&work->aniBlaze->manager, ex_blz_f);
                    SetExDrawRequestAnimStopOnFinish(&work->aniBlaze->manager.config);
                }
            }
            else
            {
                if (work->worker->playerFlags.btnLeft == TRUE)
                    activeWorker->model.translation.x -= work->worker->velocity.x;

                if (work->worker->playerFlags.btnRight == TRUE)
                    activeWorker->model.translation.x += work->worker->velocity.x;

                if (work->worker->playerFlags.btnDown == TRUE)
                    activeWorker->model.translation.y -= work->worker->velocity.y;

                if (work->worker->playerFlags.btnUp == TRUE)
                    activeWorker->model.translation.y += work->worker->velocity.y;
            }
        }
    }
}

void ExPlayer_HandlePlayerSwap(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    if (work->worker->dashTimer <= 0 && GetExSystemStatus()->state != EXSYSTASK_STATE_STAGE_FINISHED)
    {
        work->worker->swapCooldown--;

        if (work->worker->swapCooldown <= 0)
        {
            work->worker->swapCooldown = 0;

            if ((padInput.btnPress & PAD_BUTTON_R) != 0)
            {
                work->worker->swapCooldown = 15;
                work->worker->playerFlags.characterID++;

                if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_SONIC)
                {
                    PlayStageVoiceClip(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TRUST_ME);
                    work->aniSonic->manager.model.translation.x = work->aniBlaze->manager.model.translation.x;
                    work->aniSonic->manager.model.translation.y = work->aniBlaze->manager.model.translation.y;
                }
                else if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_BLAZE)
                {
                    PlayStageVoiceClip(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_NUKARI);
                    work->aniBlaze->manager.model.translation.x = work->aniSonic->manager.model.translation.x;
                    work->aniBlaze->manager.model.translation.y = work->aniSonic->manager.model.translation.y;
                }

                ExPlayer_SwapPlayerGraphics();
            }
        }
    }
}

void ExPlayer_HandleDash(void)
{
    EX_ACTION_NN_WORK *activeWorker;

    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    activeWorker = work->activeModelMain;

    if (work->worker->dashTimer-- <= 0)
    {
        exPlayerUnknown2        = 2;
        exPlayerUnknown1        = 1;
        work->worker->dashTimer = 0;
    }
    else
    {
        if (work->worker->dashTimer <= 0 && !work->worker->moveFlags.disableDash)
        {
            SetExSuperSonicAnimation(&work->aniSonic->manager, work->aniSonic->nextAnim);
            SetExDrawRequestAnimAsOneShot(&work->aniSonic->manager.config);
            SetExBurningBlazeAnimation(&work->aniBlaze->manager, work->aniBlaze->nextAnim);
            SetExDrawRequestAnimAsOneShot(&work->aniBlaze->manager.config);
        }

        if (GetExSystemStatus()->state != EXSYSTASK_STATE_STAGE_FINISHED)
        {
            work->worker->velocity.x = FLOAT_TO_FX32(3.75);
            work->worker->velocity.y = FLOAT_TO_FX32(3.75);

            if (work->worker->playerFlags.movingDiagonal == TRUE)
            {
                fx32 velX = work->worker->velocity.x;
                float speedX;
                MULTIPLY_FLOAT_FX(speedX, FX32_TO_FLOAT(CosFX(FLOAT_DEG_TO_IDX(45.0))))
                work->worker->velocity.x = MultiplyFX(speedX, velX);

                fx32 velY = work->worker->velocity.y;
                float speedY;
                MULTIPLY_FLOAT_FX(speedY, FX32_TO_FLOAT(SinFX(FLOAT_DEG_TO_IDX(45.0))))
                work->worker->velocity.y = MultiplyFX(speedY, velY);
            }

            if (!work->worker->playerFlags.btnLeft && !work->worker->playerFlags.btnRight && !work->worker->playerFlags.btnDown && !work->worker->playerFlags.btnUp)
            {
                activeWorker->model.translation.y += work->worker->velocity.y;
            }
            else
            {
                if (work->worker->playerFlags.btnLeft == TRUE)
                    activeWorker->model.translation.x -= work->worker->velocity.x;

                if (work->worker->playerFlags.btnRight == TRUE)
                    activeWorker->model.translation.x += work->worker->velocity.x;

                if (work->worker->playerFlags.btnDown == TRUE)
                    activeWorker->model.translation.y -= work->worker->velocity.y;

                if (work->worker->playerFlags.btnUp == TRUE)
                    activeWorker->model.translation.y += work->worker->velocity.y;
            }

            if (exPlayerUnknown2-- <= 0)
                exPlayerUnknown2 = 2;
        }
    }
}

void ExPlayer_Draw(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    if (work->worker->moveFlags.hasDied != TRUE)
    {
        if (GetExSystemStatus()->timeLimitMode == EXSYS_TIMELIMIT_ON && CheckExTimeGameplayIsTimeOver())
        {
            ResetExTimeGameplayTimeOverFlag();
            ExPlayer_Action_Die();
            return;
        }

        if (GetExSystemStatus()->rings == 0)
        {
            ExPlayer_Action_Die();
            return;
        }
    }

    if (work->worker->hurtInvulnDuration-- > 0)
    {
        work->activeModelMain->hitChecker.hitFlags.isInvincible = TRUE;

        if (!Camera3D__UseEngineA())
        {
            BOOL isInvisible = work->worker->playerFlags.isInvisible;

            work->worker->playerFlags.isInvisible++;

            if (isInvisible)
            {
                work->activeModelMain->config.control.isInvisible = TRUE;
                work->activeModelSub->config.control.isInvisible  = TRUE;
            }
            else
            {
                work->activeModelMain->config.control.isInvisible = FALSE;
                work->activeModelSub->config.control.isInvisible  = FALSE;
            }
        }
    }
    else
    {
        work->activeModelMain->config.control.isInvisible = FALSE;
        work->activeModelSub->config.control.isInvisible  = FALSE;
        work->worker->hurtInvulnDuration                  = 0;

        if (exBossHelpers__IsBossFleeing() == 1)
            SetCurrentExTaskMainEvent(ExPlayer_Main_InitForBossChase);
    }

    AddExDrawRequest(work->activeModelMain, &work->activeModelMain->config);

    work->worker->position = &work->activeModelMain->model.translation;

    if (work->worker->playerFlags.btnLeft == TRUE || work->worker->playerFlags.btnRight == TRUE || work->worker->playerFlags.btnDown == TRUE
        || work->worker->playerFlags.btnUp == TRUE)
    {
        if (work->worker->hurtInvulnDuration <= 0)
        {
            work->activeModelSub->model.translation.x += MultiplyFX(work->activeModelMain->model.translation.x - work->activeModelSub->model.translation.x, FLOAT_TO_FX32(0.125));
            work->activeModelSub->model.translation.y +=
                MultiplyFX(work->activeModelMain->model.translation.y - FLOAT_TO_FX32(5.0) - work->activeModelSub->model.translation.y, FLOAT_TO_FX32(0.125));
        }
        else
        {
            if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_SONIC)
            {
                work->activeModelSub->model.translation.x +=
                    MultiplyFX(work->activeModelMain->model.translation.x + FLOAT_TO_FX32(5.0) - work->activeModelSub->model.translation.x, FLOAT_TO_FX32(0.125));
                work->activeModelSub->model.translation.y +=
                    MultiplyFX(work->activeModelMain->model.translation.y - FLOAT_TO_FX32(5.0) - work->activeModelSub->model.translation.y, FLOAT_TO_FX32(0.125));
            }
            else if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_BLAZE)
            {
                work->activeModelSub->model.translation.x +=
                    MultiplyFX(work->activeModelMain->model.translation.x - FLOAT_TO_FX32(5.0) - work->activeModelSub->model.translation.x, FLOAT_TO_FX32(0.125));
                work->activeModelSub->model.translation.y +=
                    MultiplyFX(work->activeModelMain->model.translation.y - FLOAT_TO_FX32(5.0) - work->activeModelSub->model.translation.y, FLOAT_TO_FX32(0.125));
            }
        }
    }
    else
    {
        if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_SONIC)
        {
            work->activeModelSub->model.translation.x +=
                MultiplyFX(work->activeModelMain->model.translation.x + FLOAT_TO_FX32(5.0) - work->activeModelSub->model.translation.x, FLOAT_TO_FX32(0.125));
            work->activeModelSub->model.translation.y +=
                MultiplyFX(work->activeModelMain->model.translation.y - FLOAT_TO_FX32(5.0) - work->activeModelSub->model.translation.y, FLOAT_TO_FX32(0.125));
        }
        else if (work->worker->playerFlags.characterID == EXPLAYER_CHARACTER_BLAZE)
        {
            work->activeModelSub->model.translation.x +=
                MultiplyFX(work->activeModelMain->model.translation.x - FLOAT_TO_FX32(5.0) - work->activeModelSub->model.translation.x, FLOAT_TO_FX32(0.125));
            work->activeModelSub->model.translation.y +=
                MultiplyFX(work->activeModelMain->model.translation.y - FLOAT_TO_FX32(5.0) - work->activeModelSub->model.translation.y, FLOAT_TO_FX32(0.125));
        }
    }

    if (work->worker->hurtInvulnDuration <= 0 && work->worker->moveFlags.hasDied != TRUE)
    {
        work->activeModelMain->model.translation.z = FLOAT_TO_FX32(60.0);
        work->activeModelSub->model.translation.z  = FLOAT_TO_FX32(50.0);
    }

    if (!work->worker->playerFlags.isHurt || work->worker->moveFlags.hasDied != TRUE)
    {
        work->activeSprite->sprite.translation.x = work->activeModelSub->model.translation.x;
        work->activeSprite->sprite.translation.y = work->activeModelSub->model.translation.y;
        work->activeSprite->sprite.translation.z = work->activeModelSub->model.translation.z;

        if (work->worker->moveFlags.hasDied != TRUE)
            AddExDrawRequest(work->activeSprite, &work->activeSprite->config);
        else
            AddExDrawRequest(work->activeModelSub, &work->activeModelSub->config);

        if (work->worker->playerFlags.btnLeft == TRUE || work->worker->playerFlags.btnRight == TRUE)
        {
            if (work->worker->dashTimer <= 0)
                ProcessExDrawRequestPlayerTrail(&work->trailMain, &work->activeModelMain->model.translation, 1, work->worker->playerFlags.characterID);
            else
                ProcessExDrawRequestPlayerTrail(&work->trailMain, &work->activeModelMain->model.translation, 3, work->worker->playerFlags.characterID);

            AddExDrawRequest(&work->trailMain, &work->trailMain.config);
        }
        else
        {
            if (work->worker->dashTimer <= 0)
                ProcessExDrawRequestPlayerTrail(&work->trailMain, &work->activeModelMain->model.translation, 0, work->worker->playerFlags.characterID);
            else
                ProcessExDrawRequestPlayerTrail(&work->trailMain, &work->activeModelMain->model.translation, 2, work->worker->playerFlags.characterID);

            AddExDrawRequest(&work->trailMain, &work->trailMain.config);
        }
    }
    else
    {
        AddExDrawRequest(work->activeModelSub, &work->activeModelSub->config);
    }

    SetExPlayerScreenMoverTargetPos(&work->activeModelMain->model.translation);
}

void ExPlayer_DelayCallback(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    AddExDrawRequest(work->activeModelMain, &work->activeModelMain->config);
    AddExDrawRequest(work->activeSprite, &work->activeSprite->config);

    RunCurrentExTaskUnknownEvent();
}

void ProcessExPlayerAnimations(void)
{
    exPlayerAdminTask *work = ExTaskGetWorkCurrent(exPlayerAdminTask);

    AnimateExDrawRequestModel(work->activeModelMain);
    AnimateExDrawRequestModel(work->activeModelSub);
    AnimateExDrawRequestSprite3D(work->activeSprite);
}

void CreateExPlayer(void)
{
    Task *task = ExTaskCreate(ExPlayer_Main_Init, ExPlayer_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR, exPlayerAdminTask);

    SetExTaskUnknownEvent(task, ExPlayer_TaskUnknown);
    SetExTaskDelayEvent(task, ExPlayer_DelayCallback);

    exPlayerAdminTask *work = ExTaskGetWork(task, exPlayerAdminTask);

    TaskInitWork8(work);

    MI_CpuClear8(&exPlayerAniSonic, sizeof(exPlayerAniSonic));
    MI_CpuClear8(&exPlayerAniBlaze, sizeof(exPlayerAniBlaze));
    MI_CpuClear8(&exPlayerWorker, sizeof(exPlayerWorker));
    work->aniSonic = &exPlayerAniSonic;
    work->aniBlaze = &exPlayerAniBlaze;
    work->worker   = &exPlayerWorker;
}

void DestroyExPlayer(void)
{
    if (exPlayerTaskSingleton != NULL)
        DestroyExTask(exPlayerTaskSingleton);
}

VecFx32 *GetExPlayerPosition(void)
{
    return exPlayerWorker.position;
}