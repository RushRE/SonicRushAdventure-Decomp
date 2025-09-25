#include <ex/boss/exBoss.h>
#include <ex/boss/exBossHelpers.h>
#include <ex/player/exPlayer.h>
#include <ex/player/exPlayerHelpers.h>
#include <ex/system/exSystem.h>
#include <game/audio/audioSystem.h>

// Attacks
#include <ex/boss/exBossFireDragonAttack.h>
#include <ex/boss/exBossFireAttack.h>
#include <ex/boss/exBossMeteorAttack.h>
#include <ex/boss/exBossHomingLaserAttack.h>
#include <ex/boss/exBossMagmaWaveAttack.h>
#include <ex/boss/exBossLineMissileAttack.h>

// Attack tasks
#include <ex/boss/exBossFireDragon.h>
#include <ex/boss/exBossHomingLaser.h>

// Attack tasks
#include <ex/effects/exBossHitEffect.h>

// --------------------
// MACROS
// --------------------

// basically a re-implementation of 'SetExTaskMainEvent' since the compiler doesn't want an inline function.
#define EXBOSS_SET_EXTASK_MAIN_EVENT(eventFunc) (GetExTask(exBossTaskSingleton)->main = (eventFunc))

// --------------------
// ENUMS
// --------------------

enum ExBossAttackFunc
{
    EXBOSS_ATTACK_IDLE_DRAGON_ONLY,
    EXBOSS_ATTACK_IDLE_METEOR_FIREBALL,
    EXBOSS_ATTACK_IDLE_WAIT_DRAGON_ONLY,
    EXBOSS_ATTACK_IDLE_HOMINGLASER_DRAGON,
    EXBOSS_ATTACK_IDLE_METOR_FIREBALL_MAGMAWAVE,
    EXBOSS_ATTACK_IDLE_WAIT_HOMINGLASER_DRAGON,
    EXBOSS_ATTACK_IDLE_HOMINGLASER_DRAGON_PHASE3,
    EXBOSS_ATTACK_IDLE_METOR_FIREBALL_MAGMAWAVE_LINEMISSILE,
    EXBOSS_ATTACK_IDLE_WAIT_HOMINGLASER_DRAGON_PHASE3,
    EXBOSS_ATTACK_METEOR,
    EXBOSS_ATTACK_FIREBALL,
    EXBOSS_ATTACK_HOMING_LASER,
    EXBOSS_ATTACK_DRAGON,
    EXBOSS_ATTACK_MAGMA_WAVE,
    EXBOSS_ATTACK_LINE_MISSILE,
    EXBOSS_ATTACK_HURT,
    EXBOSS_ATTACK_BEAT_PHASE1,
    EXBOSS_ATTACK_BEAT_PHASE2,
    EXBOSS_ATTACK_DEFEATED,

    EXBOSS_ATTACK_COUNT,
};

// --------------------
// FUNCTION DECLS
// --------------------

// ExBoss
static void ExBoss_Main_Init(void);
static void ExBoss_TaskUnknown(void);
static void ExBoss_Destructor(void);
static void ExBoss_Main_WaitForTitleCard(void);
static void ExBoss_Action_InitialFlee(void);
static void ExBoss_Main_InitialFlee(void);
static void ExBoss_Action_WaitForFlag(void);
static void ExBoss_Main_WaitForFlag(void);
static void ExBoss_Action_RegenerateHealth(void);
static void ExBoss_Main_RegenerateHealth(void);
static void ExBoss_Action_Idle_DragonOnly(void);
static void ExBoss_Main_Idle_DragonOnly(void);
static void ExBoss_Action_Idle_MeteorFireball(void);
static void ExBoss_Main_Idle_MeteorFireball(void);
static void ExBoss_Action_Idle_Wait_DragonOnly(void);
static void ExBoss_Main_Idle_Wait_DragonOnly(void);
static void ExBoss_Action_Idle_HomingLaserDragon(void);
static void ExBoss_Main_Idle_HomingLaserDragon(void);
static void ExBoss_Action_Idle_MeteorFireballMagmaWave(void);
static void ExBoss_Main_Idle_MeteorFireballMagmaWave(void);
static void ExBoss_Action_Idle_Wait_HomingLaserDragon(void);
static void ExBoss_Main_Idle_Wait_HomingLaserDragon(void);
static void ExBoss_Action_Idle_HomingLaserDragon_Phase3(void);
static void ExBoss_Main_Idle_HomingLaserDragon_Phase3(void);
static void ExBoss_Action_Idle_MeteorFireballMagmaWaveLineMissile(void);
static void ExBoss_Main_Idle_MeteorFireballMagmaWaveLineMissile(void);
static void ExBoss_Action_Idle_Wait_HomingLaserDragon_Phase3(void);
static void ExBoss_Main_Idle_Wait_HomingLaserDragon_Phase3(void);
static void GetExBossIdleDuration(void);
static void ExBoss_Main_Blank(void);

// ExBossEarlyManager
static void ExBossEarlyManager_Main_Init(void);
static void ExBossEarlyManager_TaskUnknown(void);
static void ExBossEarlyManager_Destructor(void);
static void ExBossEarlyManager_Main_PickNextAttack(void);
static void ExBossEarlyManager_Main_WaitForAttack(void);
static BOOL CreateExBossEarlyManager(void);

// ExBoss Helpers
static void HandleExBossMovementX(void);
static void HandleExBossMovementY(void);

// --------------------
// VARIABLES
// --------------------

static s16 exBossRegenerateTimer;
static void *exBossUnused;
static void *exBossWorkSingleton;
static void *exBossBeforeTaskSingleton;
static void *exBossTaskSingleton;
static BOOL exBossFightStarted;

// force linkage of variables with no apparent references
FORCE_INCLUDE_VARIABLE_BSS(exBossUnused)

static ExTaskMain exBossAttackFuncTable[EXBOSS_ATTACK_COUNT] = {
    [EXBOSS_ATTACK_IDLE_DRAGON_ONLY]                          = ExBoss_Action_Idle_DragonOnly,
    [EXBOSS_ATTACK_IDLE_METEOR_FIREBALL]                      = ExBoss_Action_Idle_MeteorFireball,
    [EXBOSS_ATTACK_IDLE_WAIT_DRAGON_ONLY]                     = ExBoss_Action_Idle_Wait_DragonOnly,
    [EXBOSS_ATTACK_IDLE_HOMINGLASER_DRAGON]                   = ExBoss_Action_Idle_HomingLaserDragon,
    [EXBOSS_ATTACK_IDLE_METOR_FIREBALL_MAGMAWAVE]             = ExBoss_Action_Idle_MeteorFireballMagmaWave,
    [EXBOSS_ATTACK_IDLE_WAIT_HOMINGLASER_DRAGON]              = ExBoss_Action_Idle_Wait_HomingLaserDragon,
    [EXBOSS_ATTACK_IDLE_HOMINGLASER_DRAGON_PHASE3]            = ExBoss_Action_Idle_HomingLaserDragon_Phase3,
    [EXBOSS_ATTACK_IDLE_METOR_FIREBALL_MAGMAWAVE_LINEMISSILE] = ExBoss_Action_Idle_MeteorFireballMagmaWaveLineMissile,
    [EXBOSS_ATTACK_IDLE_WAIT_HOMINGLASER_DRAGON_PHASE3]       = ExBoss_Action_Idle_Wait_HomingLaserDragon_Phase3,
    [EXBOSS_ATTACK_METEOR]                                    = exBossSysAdminTask__Action_StartMete0,
    [EXBOSS_ATTACK_FIREBALL]                                  = exBossSysAdminTask__Action_StartFire0,
    [EXBOSS_ATTACK_HOMING_LASER]                              = exBossSysAdminTask__Action_StartHomi0,
    [EXBOSS_ATTACK_DRAGON]                                    = exBossSysAdminTask__Action_StartDora0,
    [EXBOSS_ATTACK_MAGMA_WAVE]                                = exBossSysAdminTask__Action_StartMagmaEruption0,
    [EXBOSS_ATTACK_LINE_MISSILE]                              = exBossSysAdminTask__Action_StartLine0,
    [EXBOSS_ATTACK_HURT]                                      = exBossSysAdminTask__Action_StartDmg0,
    [EXBOSS_ATTACK_BEAT_PHASE1]                               = exBossSysAdminTask__Action_StartBDmg0,
    [EXBOSS_ATTACK_BEAT_PHASE2]                               = exBossSysAdminTask__Action_StartBDmg1_Last,
    [EXBOSS_ATTACK_DEFEATED]                                  = exBossSysAdminTask__Action_StartBDmg1_First,
};

// --------------------
// FUNCTIONS
// --------------------

exBossSysAdminTask *GetExBossWork(void)
{
    return exBossWorkSingleton;
}

BOOL GetExBossFightStarted(void)
{
    return exBossFightStarted;
}

void SetExBossFightStarted(BOOL value)
{
    exBossFightStarted = value;
}

void ExBoss_Main_Init(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    exBossTaskSingleton = GetCurrentTask();
    exBossWorkSingleton = work;

    work->maxHealth = EXBOSS_HEALTH_NONE;

    SetExBossFightStarted(TRUE);
    CreateExBossEarlyManager();

    work->stateAttack     = exBossAttackFuncTable[EXBOSS_ATTACK_IDLE_DRAGON_ONLY];
    work->nextAttackState = exBossAttackFuncTable[EXBOSS_ATTACK_IDLE_DRAGON_ONLY];

    exBossHelpers__LoadAssets(&work->aniBoss);
    SetExDrawRequestPriority(&work->aniBoss.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimAsOneShot(&work->aniBoss.config);

    for (s16 i = 0; i < (s16)ARRAY_COUNT(work->aniBoss.model.paletteAnimator); i++)
    {
        SetPaletteAnimation(&work->aniBoss.model.paletteAnimator[i], 0);

        // why this is inside the loop?
        work->hitEffectCooldown = 0;
    }

    work->attackFlags.value_1         = FALSE;
    work->aniBoss.model.translation.y = FLOAT_TO_FX32(100.0);
    work->fleeVelocity.y              = FLOAT_TO_FX32(0.5);
    work->flags.isAttackReady         = TRUE;
    work->moveDuration                = 0;
    work->targetPos.x                 = FLOAT_TO_FX32(0.0);
    work->targetPos.y                 = FLOAT_TO_FX32(0.0);
    work->targetPos.z                 = FLOAT_TO_FX32(0.0);
    work->hitVoiceClipCooldown        = 0;
    work->nextHurtVoiceClip           = 1;

    SetCurrentExTaskMainEvent(ExBoss_Main_WaitForTitleCard);
}

void ExBoss_TaskUnknown(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);
    UNUSED(work);

    if (CheckExStageFinished())
    {
        SetCurrentExTaskMainEvent(ExBoss_Main_Blank);
        ExBoss_Main_Blank();
    }
}

void ExBoss_Destructor(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);
    UNUSED(work);

    exBossHelpers__Func_2154390(&work->aniBoss);

    exBossTaskSingleton = NULL;
}

void ExBoss_Main_WaitForTitleCard(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    if (GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_ACTIVE)
    {
        ExBoss_Action_InitialFlee();
    }
    else
    {
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExBoss_Action_InitialFlee(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);
    UNUSED(work);

    SetCurrentExTaskMainEvent(ExBoss_Main_InitialFlee);
    ExBoss_Main_InitialFlee();
}

void ExBoss_Main_InitialFlee(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    work->aniBoss.model.translation.y += work->fleeVelocity.y;

    if (work->aniBoss.model.translation.x >= FLOAT_TO_FX32(90.0) || work->aniBoss.model.translation.x <= -FLOAT_TO_FX32(90.0)
        || work->aniBoss.model.translation.y >= FLOAT_TO_FX32(200.0))
    {
        ExBoss_Action_WaitForFlag();
    }
    else
    {
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExBoss_Action_WaitForFlag(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);
    UNUSED(work);

    SetExBossFightStarted(FALSE);

    SetCurrentExTaskMainEvent(ExBoss_Main_WaitForFlag);
    ExBoss_Main_WaitForFlag();
}

void ExBoss_Main_WaitForFlag(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);
    UNUSED(work);

    if (GetExBossFightStarted())
    {
        ExBoss_Action_RegenerateHealth();
    }
    else
    {
        RunCurrentExTaskUnknownEvent();
    }
}

void ExBoss_Action_RegenerateHealth(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);
    UNUSED(work);

    GetExSystemStatus()->state = EXSYSTASK_STATE_BOSS_FLEE_STARTED;
    GetExBossWork()->health    = EXBOSS_HEALTH_NONE;

    SetCurrentExTaskMainEvent(ExBoss_Main_RegenerateHealth);
    ExBoss_Main_RegenerateHealth();
}

void ExBoss_Main_RegenerateHealth(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);
    HandleExBossMovement();

    if (exBossRegenerateTimer < (EXBOSS_HEALTH_MAX - 1))
    {
        exBossRegenerateTimer++;
        GetExBossWork()->health = exBossRegenerateTimer;
    }
    else
    {
        GetExBossWork()->health = EXBOSS_HEALTH_MAX;

        if (work->aniBoss.model.translation.y <= FLOAT_TO_FX32(110.0))
        {
            exBossRegenerateTimer      = EXBOSS_HEALTH_NONE;
            GetExSystemStatus()->state = EXSYSTASK_STATE_BOSS_FLEE_DONE;
            GetExBossIdleDuration();

            SetCurrentExTaskMainEvent(ExBoss_Main_Idle_DragonOnly);
            ExBoss_Main_Idle_DragonOnly();
            return;
        }
    }

    AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);

    RunCurrentExTaskUnknownEvent();
}

void ExBoss_Action_Idle_DragonOnly(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    exBossHelpers__SetAnimation(&work->aniBoss, bse_body_fw0);
    SetExDrawRequestAnimAsOneShot(&work->aniBoss.config);

    GetExBossIdleDuration();

    SetCurrentExTaskMainEvent(ExBoss_Main_Idle_DragonOnly);
    ExBoss_Main_Idle_DragonOnly();
}

void ExBoss_Main_Idle_DragonOnly(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    work->flags.isAttackReady = TRUE;
    HandleExBossMovement();

    if (work->idleDuration <= 0)
    {
        if (!exBossFireDoraTask__AnyActive())
        {
            s32 attackPercent = mtMathRand() % 100;

            work->nextAttackState = exBossAttackFuncTable[EXBOSS_ATTACK_IDLE_METEOR_FIREBALL];

            switch (GetExPlayerWorker()->playerFlags.characterID)
            {
                case EXPLAYER_CHARACTER_SONIC:
                    if (attackPercent >= 50)
                    {
                        work->attackFlags.doDragon = TRUE;
                    }
                    else
                    {
                        SetCurrentExTaskMainEvent(ExBoss_Main_Idle_MeteorFireball);
                        ExBoss_Main_Idle_MeteorFireball();
                        return;
                    }
                    break;

                // case EXPLAYER_CHARACTER_BLAZE:
                default:
                    if (attackPercent >= 50)
                    {
                        work->attackFlags.doDragon = TRUE;
                    }
                    else
                    {
                        SetCurrentExTaskMainEvent(ExBoss_Main_Idle_MeteorFireball);
                        ExBoss_Main_Idle_MeteorFireball();
                        return;
                    }
                    break;
            }
        }
        else
        {
            SetCurrentExTaskMainEvent(ExBoss_Main_Idle_MeteorFireball);
            ExBoss_Main_Idle_MeteorFireball();
            return;
        }
    }
    else
    {
        work->idleDuration--;
    }

    AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
    exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);

    RunCurrentExTaskUnknownEvent();
}

void ExBoss_Action_Idle_MeteorFireball(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    exBossHelpers__SetAnimation(&work->aniBoss, bse_body_fw0);
    SetExDrawRequestAnimAsOneShot(&work->aniBoss.config);

    SetCurrentExTaskMainEvent(ExBoss_Main_Idle_MeteorFireball);
    ExBoss_Main_Idle_MeteorFireball();
}

void ExBoss_Main_Idle_MeteorFireball(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    work->flags.isAttackReady = TRUE;
    HandleExBossMovement();

    if (work->idleDuration <= 0)
    {
        s32 attackPercent = mtMathRand() % 100;

        work->nextAttackState = exBossAttackFuncTable[EXBOSS_ATTACK_IDLE_DRAGON_ONLY];

        switch (GetExPlayerWorker()->playerFlags.characterID)
        {
            case EXPLAYER_CHARACTER_SONIC:
                if (attackPercent >= 70)
                {
                    work->attackFlags.doMeteor = TRUE;
                }
                else if (attackPercent < 70)
                {
                    work->attackFlags.doFireball = TRUE;
                }
                break;

            // case EXPLAYER_CHARACTER_BLAZE:
            default:
                if (attackPercent >= 70)
                {
                    work->attackFlags.doMeteor = TRUE;
                }
                else if (attackPercent < 70)
                {
                    work->attackFlags.doFireball = TRUE;
                }
                break;
        }
    }
    else
    {
        work->idleDuration--;
    }

    AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
    exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);

    RunCurrentExTaskUnknownEvent();
}

void ExBoss_Action_Idle_Wait_DragonOnly(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    exBossHelpers__SetAnimation(&work->aniBoss, bse_body_fw0);
    SetExDrawRequestAnimAsOneShot(&work->aniBoss.config);

    SetCurrentExTaskMainEvent(ExBoss_Main_Idle_Wait_DragonOnly);
    ExBoss_Main_Idle_Wait_DragonOnly();
}

void ExBoss_Main_Idle_Wait_DragonOnly(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    work->flags.isAttackReady = TRUE;
    HandleExBossMovement();

    if (work->idleDuration <= 0)
    {
        s32 attackPercent = mtMathRand() % 100;
        UNUSED(attackPercent);

        work->nextAttackState = exBossAttackFuncTable[EXBOSS_ATTACK_IDLE_DRAGON_ONLY];

        switch (GetExPlayerWorker()->playerFlags.characterID)
        {
            case EXPLAYER_CHARACTER_SONIC:
                SetCurrentExTaskMainEvent(ExBoss_Main_Idle_DragonOnly);
                ExBoss_Main_Idle_DragonOnly();
                break;

            // case EXPLAYER_CHARACTER_BLAZE:
            default:
                SetCurrentExTaskMainEvent(ExBoss_Main_Idle_DragonOnly);
                ExBoss_Main_Idle_DragonOnly();
                break;
        }
    }
    else
    {
        work->idleDuration--;
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExBoss_Action_Idle_HomingLaserDragon(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    exBossHelpers__SetAnimation(&work->aniBoss, bse_body_fw0);
    SetExDrawRequestAnimAsOneShot(&work->aniBoss.config);

    GetExBossIdleDuration();

    SetCurrentExTaskMainEvent(ExBoss_Main_Idle_HomingLaserDragon);
    ExBoss_Main_Idle_HomingLaserDragon();
}

void ExBoss_Main_Idle_HomingLaserDragon(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    work->flags.isAttackReady = TRUE;
    HandleExBossMovement();

    if (work->idleDuration <= 0)
    {
        if (!exBossFireDoraTask__AnyActive() && !exBossHomingLaserTask__AnyActive())
        {
            s32 attackPercent = mtMathRand() % 100;

            work->nextAttackState = exBossAttackFuncTable[EXBOSS_ATTACK_IDLE_METOR_FIREBALL_MAGMAWAVE];

            switch (GetExPlayerWorker()->playerFlags.characterID)
            {
                case EXPLAYER_CHARACTER_SONIC:
                    if (attackPercent >= 30)
                    {
                        work->attackFlags.doDragon = TRUE;
                    }
                    else
                    {
                        work->attackFlags.doHomingLaser = TRUE;
                    }
                    break;

                // case EXPLAYER_CHARACTER_BLAZE:
                default:
                    if (attackPercent >= 30)
                    {
                        work->attackFlags.doDragon = TRUE;
                    }
                    else
                    {
                        work->attackFlags.doHomingLaser = TRUE;
                    }
                    break;
            }
        }
        else
        {
            SetCurrentExTaskMainEvent(ExBoss_Main_Idle_MeteorFireballMagmaWave);
            ExBoss_Main_Idle_MeteorFireballMagmaWave();
            return;
        }
    }
    else
    {
        work->idleDuration--;
    }

    AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
    exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);

    RunCurrentExTaskUnknownEvent();
}

void ExBoss_Action_Idle_MeteorFireballMagmaWave(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    exBossHelpers__SetAnimation(&work->aniBoss, bse_body_fw0);
    SetExDrawRequestAnimAsOneShot(&work->aniBoss.config);

    SetCurrentExTaskMainEvent(ExBoss_Main_Idle_MeteorFireballMagmaWave);
    ExBoss_Main_Idle_MeteorFireballMagmaWave();
}

void ExBoss_Main_Idle_MeteorFireballMagmaWave(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    work->flags.isAttackReady = TRUE;
    HandleExBossMovement();

    if (work->idleDuration <= 0)
    {
        s32 attackPercent = mtMathRand() % 100;

        work->nextAttackState = exBossAttackFuncTable[EXBOSS_ATTACK_IDLE_WAIT_HOMINGLASER_DRAGON];

        switch (GetExPlayerWorker()->playerFlags.characterID)
        {
            case EXPLAYER_CHARACTER_SONIC:
                if (attackPercent < 30)
                {
                    work->attackFlags.doMeteor = TRUE;
                }
                else if (attackPercent >= 30 && attackPercent < 70)
                {
                    work->attackFlags.doFireball = TRUE;
                }
                else if (attackPercent >= 70)
                {
                    work->attackFlags.doMagmaWave = TRUE;
                }
                break;

            // case EXPLAYER_CHARACTER_BLAZE:
            default:
                if (attackPercent < 30)
                {
                    work->attackFlags.doMeteor = TRUE;
                }
                else if (attackPercent >= 30 && attackPercent < 70)
                {
                    work->attackFlags.doFireball = TRUE;
                }
                else if (attackPercent >= 70)
                {
                    work->attackFlags.doMagmaWave = TRUE;
                }
                break;
        }
    }
    else
    {
        work->idleDuration--;
    }

    AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
    exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);

    RunCurrentExTaskUnknownEvent();
}

void ExBoss_Action_Idle_Wait_HomingLaserDragon(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    exBossHelpers__SetAnimation(&work->aniBoss, bse_body_fw0);
    SetExDrawRequestAnimAsOneShot(&work->aniBoss.config);

    SetCurrentExTaskMainEvent(ExBoss_Main_Idle_Wait_HomingLaserDragon);
    ExBoss_Main_Idle_Wait_HomingLaserDragon();
}

void ExBoss_Main_Idle_Wait_HomingLaserDragon(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    work->flags.isAttackReady = TRUE;
    HandleExBossMovement();

    if (work->idleDuration <= 0)
    {
        s32 attackPercent = mtMathRand() % 100;
        UNUSED(attackPercent);

        work->nextAttackState = exBossAttackFuncTable[EXBOSS_ATTACK_IDLE_HOMINGLASER_DRAGON];

        switch (GetExPlayerWorker()->playerFlags.characterID)
        {
            case EXPLAYER_CHARACTER_SONIC:
                SetCurrentExTaskMainEvent(ExBoss_Main_Idle_HomingLaserDragon);
                ExBoss_Main_Idle_HomingLaserDragon();
                break;

            // case EXPLAYER_CHARACTER_BLAZE:
            default:
                SetCurrentExTaskMainEvent(ExBoss_Main_Idle_HomingLaserDragon);
                ExBoss_Main_Idle_HomingLaserDragon();
                break;
        }
    }
    else
    {
        work->idleDuration--;
        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExBoss_Action_Idle_HomingLaserDragon_Phase3(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    exBossHelpers__SetAnimation(&work->aniBoss, bse_body_fw0);
    SetExDrawRequestAnimAsOneShot(&work->aniBoss.config);

    GetExBossIdleDuration();

    SetCurrentExTaskMainEvent(ExBoss_Main_Idle_HomingLaserDragon_Phase3);
    ExBoss_Main_Idle_HomingLaserDragon_Phase3();
}

void ExBoss_Main_Idle_HomingLaserDragon_Phase3(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    work->flags.isAttackReady = TRUE;
    HandleExBossMovement();

    if (work->idleDuration <= 0)
    {
        if (!exBossFireDoraTask__AnyActive() && !exBossHomingLaserTask__AnyActive())
        {
            s32 attackPercent = mtMathRand() % 100;

            work->nextAttackState = exBossAttackFuncTable[EXBOSS_ATTACK_IDLE_METOR_FIREBALL_MAGMAWAVE_LINEMISSILE];

            switch (GetExPlayerWorker()->playerFlags.characterID)
            {
                case EXPLAYER_CHARACTER_SONIC:
                    if (attackPercent >= 50)
                    {
                        work->attackFlags.doDragon = TRUE;
                    }
                    else
                    {
                        work->attackFlags.doHomingLaser = TRUE;
                    }
                    break;

                // case EXPLAYER_CHARACTER_BLAZE:
                default:
                    if (attackPercent >= 50)
                    {
                        work->attackFlags.doDragon = TRUE;
                    }
                    else
                    {
                        work->attackFlags.doHomingLaser = TRUE;
                    }
                    break;
            }
        }
        else
        {
            SetCurrentExTaskMainEvent(ExBoss_Main_Idle_MeteorFireballMagmaWaveLineMissile);
            ExBoss_Main_Idle_MeteorFireballMagmaWaveLineMissile();
            return;
        }
    }
    else
    {
        work->idleDuration--;
    }

    AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
    exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);

    RunCurrentExTaskUnknownEvent();
}

void ExBoss_Action_Idle_MeteorFireballMagmaWaveLineMissile(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    exBossHelpers__SetAnimation(&work->aniBoss, bse_body_fw0);
    SetExDrawRequestAnimAsOneShot(&work->aniBoss.config);

    SetCurrentExTaskMainEvent(ExBoss_Main_Idle_MeteorFireballMagmaWaveLineMissile);
    ExBoss_Main_Idle_MeteorFireballMagmaWaveLineMissile();
}

void ExBoss_Main_Idle_MeteorFireballMagmaWaveLineMissile(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    work->flags.isAttackReady = TRUE;
    HandleExBossMovement();

    if (work->idleDuration <= 0)
    {
        s32 attackPercent = mtMathRand() % 100;

        work->nextAttackState = exBossAttackFuncTable[EXBOSS_ATTACK_IDLE_WAIT_HOMINGLASER_DRAGON_PHASE3];

        switch (GetExPlayerWorker()->playerFlags.characterID)
        {
            case EXPLAYER_CHARACTER_SONIC:
                if (attackPercent < 20)
                {
                    work->attackFlags.doMeteor = TRUE;
                }
                else if (attackPercent >= 20 && attackPercent < 50)
                {
                    work->attackFlags.doFireball = TRUE;
                }
                else if (attackPercent >= 50 && attackPercent < 70)
                {
                    work->attackFlags.doMagmaWave = TRUE;
                }
                else if (attackPercent > 70)
                {
                    work->attackFlags.doLineMissile = TRUE;
                }
                break;

            // case EXPLAYER_CHARACTER_BLAZE:
            default:
                if (attackPercent < 20)
                {
                    work->attackFlags.doMeteor = TRUE;
                }
                else if (attackPercent >= 20 && attackPercent < 50)
                {
                    work->attackFlags.doFireball = TRUE;
                }
                else if (attackPercent >= 50 && attackPercent < 70)
                {
                    work->attackFlags.doMagmaWave = TRUE;
                }
                else if (attackPercent > 70)
                {
                    work->attackFlags.doLineMissile = TRUE;
                }
                break;
        }
    }
    else
    {
        work->idleDuration--;
    }

    AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
    exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);

    RunCurrentExTaskUnknownEvent();
}

void ExBoss_Action_Idle_Wait_HomingLaserDragon_Phase3(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    exBossHelpers__SetAnimation(&work->aniBoss, bse_body_fw0);
    SetExDrawRequestAnimAsOneShot(&work->aniBoss.config);

    SetCurrentExTaskMainEvent(ExBoss_Main_Idle_Wait_HomingLaserDragon_Phase3);
    ExBoss_Main_Idle_Wait_HomingLaserDragon_Phase3();
}

void ExBoss_Main_Idle_Wait_HomingLaserDragon_Phase3(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    AnimateExDrawRequestModel(&work->aniBoss);

    work->flags.isAttackReady = TRUE;
    HandleExBossMovement();

    if (work->idleDuration <= 0)
    {
        s32 attackPercent = mtMathRand() % 100;
        UNUSED(attackPercent);

        work->nextAttackState = exBossAttackFuncTable[EXBOSS_ATTACK_IDLE_HOMINGLASER_DRAGON_PHASE3];

        switch (GetExPlayerWorker()->playerFlags.characterID)
        {
            case EXPLAYER_CHARACTER_SONIC:
                SetCurrentExTaskMainEvent(ExBoss_Main_Idle_HomingLaserDragon_Phase3);
                ExBoss_Main_Idle_HomingLaserDragon_Phase3();
                break;

            // case EXPLAYER_CHARACTER_BLAZE:
            default:
                SetCurrentExTaskMainEvent(ExBoss_Main_Idle_HomingLaserDragon_Phase3);
                ExBoss_Main_Idle_HomingLaserDragon_Phase3();
                break;
        }
    }
    else
    {
        work->idleDuration--;

        AddExDrawRequest(&work->aniBoss, &work->aniBoss.config);
        exHitCheckTask_AddHitCheck(&work->aniBoss.hitChecker);

        RunCurrentExTaskUnknownEvent();
    }
}

void GetExBossIdleDuration(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);

    s32 idlePercent = mtMathRand() % 100;

    if (idlePercent < 50)
    {
        work->idleDuration = SECONDS_TO_FRAMES(0.033334);
    }
    else if (idlePercent < 70)
    {
        work->idleDuration = SECONDS_TO_FRAMES(1.0);
    }
    else if (idlePercent < 90)
    {
        work->idleDuration = SECONDS_TO_FRAMES(0.33334);
    }
    else if (idlePercent < 100)
    {
        work->idleDuration = SECONDS_TO_FRAMES(4.0);
    }
}

void ExBoss_Main_Blank(void)
{
    // Do nothing.
}

BOOL CreateExBoss(void)
{
    Task *task = ExTaskCreate(ExBoss_Main_Init, ExBoss_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x3800, TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR, exBossSysAdminTask);

    exBossSysAdminTask *work = ExTaskGetWork(task, exBossSysAdminTask);
    TaskInitWork8(work);

    SetExTaskUnknownEvent(task, ExBoss_TaskUnknown);

    return TRUE;
}

Task *GetExBossTask(void)
{
    return exBossTaskSingleton;
}

void DestroyExBoss(void)
{
    if (exBossTaskSingleton != NULL)
        DestroyExTask(exBossTaskSingleton);
}

void ExBossEarlyManager_Main_Init(void)
{
    exBossSysAdminTask *work = ExTaskGetWork(exBossTaskSingleton, exBossSysAdminTask);

    exBossBeforeTaskSingleton = GetCurrentTask();

    SetCurrentExTaskMainEvent(ExBossEarlyManager_Main_PickNextAttack);
    ExBossEarlyManager_Main_PickNextAttack();
}

void ExBossEarlyManager_TaskUnknown(void)
{
    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExBossEarlyManager_Destructor(void)
{
    exBossSysAdminTask *work = ExTaskGetWorkCurrent(exBossSysAdminTask);
    UNUSED(work);

    exBossBeforeTaskSingleton = NULL;
}

void ExBossEarlyManager_Main_PickNextAttack(void)
{
    s16 i;

    exBossSysAdminTask *work = ExTaskGetWork(exBossTaskSingleton, exBossSysAdminTask);

    if (work->flags.isAttackReady)
    {
        if (work->attackFlags.value_2)
        {
            work->aniBoss.hitChecker.hitFlags.hasCollision = TRUE;
            work->aniBoss.hitChecker.hitFlags.isHurt       = TRUE;

            work->attackFlags.value_2 = TRUE;
            work->flags.isAttackReady = FALSE;
            return;
        }

        if (work->attackFlags.doMeteor)
        {
            work->attackFlags.doMeteor = FALSE;

            work->stateAttack = exBossAttackFuncTable[EXBOSS_ATTACK_METEOR];
            EXBOSS_SET_EXTASK_MAIN_EVENT(work->stateAttack);

            work->flags.isAttackReady = FALSE;
            return;
        }

        if (work->attackFlags.doFireball)
        {
            work->attackFlags.doFireball = FALSE;

            work->stateAttack = exBossAttackFuncTable[EXBOSS_ATTACK_FIREBALL];
            EXBOSS_SET_EXTASK_MAIN_EVENT(work->stateAttack);

            work->flags.isAttackReady = FALSE;
            return;
        }

        if (work->attackFlags.doHomingLaser)
        {
            work->attackFlags.doHomingLaser = FALSE;

            work->stateAttack = exBossAttackFuncTable[EXBOSS_ATTACK_HOMING_LASER];
            EXBOSS_SET_EXTASK_MAIN_EVENT(work->stateAttack);

            work->flags.isAttackReady = FALSE;
            return;
        }

        if (work->attackFlags.doDragon)
        {
            work->attackFlags.doDragon = FALSE;

            work->stateAttack = exBossAttackFuncTable[EXBOSS_ATTACK_DRAGON];
            EXBOSS_SET_EXTASK_MAIN_EVENT(work->stateAttack);

            work->flags.isAttackReady = FALSE;
            return;
        }

        if (work->attackFlags.doMagmaWave)
        {
            work->attackFlags.doMagmaWave = FALSE;

            work->stateAttack = exBossAttackFuncTable[EXBOSS_ATTACK_MAGMA_WAVE];
            EXBOSS_SET_EXTASK_MAIN_EVENT(work->stateAttack);

            work->flags.isAttackReady = FALSE;
            return;
        }

        if (work->attackFlags.doLineMissile)
        {
            work->attackFlags.doLineMissile = FALSE;

            work->stateAttack = exBossAttackFuncTable[EXBOSS_ATTACK_LINE_MISSILE];
            EXBOSS_SET_EXTASK_MAIN_EVENT(work->stateAttack);

            work->flags.isAttackReady = FALSE;
            return;
        }
    }

    if (work->hurtInvulnDuration <= 0)
    {
        if (work->aniBoss.hitChecker.hitFlags.hasCollision && work->aniBoss.hitChecker.hitFlags.isHurt)
        {
            CreateExBossEffectHit();

            work->health -= work->aniBoss.hitChecker.power;

            if (work->health <= EXBOSS_HEALTH_CRITICAL)
            {
                // health is low! Time to try and regenerate!

                // try and enter phase 2
                if (GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_FLEE_DONE)
                {
                    for (i = 0; i < (s16)ARRAY_COUNT(work->aniBoss.model.paletteAnimator); i++)
                    {
                        SetPaletteAnimation(&work->aniBoss.model.paletteAnimator[i], 0);
                    }

                    if (work->nextHurtVoiceClip != 0)
                        PlayStageVoiceClip(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_E_AITA);
                    else
                        PlayStageVoiceClip(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_E_ONORE);

                    work->nextHurtVoiceClip    = !work->nextHurtVoiceClip;
                    work->health               = EXBOSS_HEALTH_CRITICAL;
                    GetExSystemStatus()->state = EXSYSTASK_STATE_BOSS_HEAL_PHASE2_STARTED;

                    work->nextAttackState = exBossAttackFuncTable[EXBOSS_ATTACK_IDLE_HOMINGLASER_DRAGON];
                    work->stateAttack     = exBossAttackFuncTable[EXBOSS_ATTACK_BEAT_PHASE1];
                    EXBOSS_SET_EXTASK_MAIN_EVENT(work->stateAttack);

                    work->flags.isAttackReady = FALSE;

                    SetCurrentExTaskMainEvent(ExBossEarlyManager_Main_WaitForAttack);
                    return;
                }

                // try and enter phase 3
                if (GetExSystemStatus()->state == EXSYSTASK_STATE_BOSS_HEAL_PHASE2_DONE)
                {
                    for (i = 0; i < (s16)ARRAY_COUNT(work->aniBoss.model.paletteAnimator); i++)
                    {
                        SetPaletteAnimation(&work->aniBoss.model.paletteAnimator[i], 0);
                    }

                    if (work->nextHurtVoiceClip != 0)
                        PlayStageVoiceClip(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_E_AITA);
                    else
                        PlayStageVoiceClip(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_E_ONORE);

                    work->nextHurtVoiceClip    = !work->nextHurtVoiceClip;
                    work->health               = EXBOSS_HEALTH_CRITICAL;
                    GetExSystemStatus()->state = EXSYSTASK_STATE_BOSS_HEAL_PHASE3_STARTED;

                    work->nextAttackState = exBossAttackFuncTable[EXBOSS_ATTACK_IDLE_HOMINGLASER_DRAGON_PHASE3];
                    work->stateAttack     = exBossAttackFuncTable[EXBOSS_ATTACK_BEAT_PHASE2];
                    EXBOSS_SET_EXTASK_MAIN_EVENT(work->stateAttack);

                    work->flags.isAttackReady = FALSE;

                    SetCurrentExTaskMainEvent(ExBossEarlyManager_Main_WaitForAttack);
                    return;
                }

                // if all else fails and we fall below 0 health, that's it for us!
                if (work->health <= EXBOSS_HEALTH_NONE)
                {
                    for (i = 0; i < (s16)ARRAY_COUNT(work->aniBoss.model.paletteAnimator); i++)
                    {
                        SetPaletteAnimation(&work->aniBoss.model.paletteAnimator[i], 1);
                    }

                    work->health               = EXBOSS_HEALTH_NONE;
                    GetExSystemStatus()->state = EXSYSTASK_STATE_STAGE_FINISHED;

                    work->stateAttack = exBossAttackFuncTable[EXBOSS_ATTACK_DEFEATED];
                    EXBOSS_SET_EXTASK_MAIN_EVENT(work->stateAttack);

                    work->flags.isAttackReady = FALSE;

                    SetCurrentExTaskMainEvent(ExBossEarlyManager_Main_WaitForAttack);
                    return;
                }
            }
            else
            {
                // health is in the clear, no need to regenerate!
                u16 value = mtMathRand();
                UNUSED(value);

                if (work->hitVoiceClipCooldown <= 0)
                {
                    work->hitVoiceClipCooldown = SECONDS_TO_FRAMES(1.0);

                    if (work->nextHurtVoiceClip != 0)
                        PlayStageVoiceClip(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_E_AITA);
                    else
                        PlayStageVoiceClip(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_E_ONORE);

                    work->nextHurtVoiceClip = !work->nextHurtVoiceClip;
                }

                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_BIGDAMAGE);
            }

            if (work->attackFlags.value_1)
            {
                PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_EX_BIGDAMAGE);

                work->stateAttack = exBossAttackFuncTable[EXBOSS_ATTACK_HURT];
                EXBOSS_SET_EXTASK_MAIN_EVENT(work->stateAttack);

                work->flags.isAttackReady = FALSE;
                work->attackFlags.value_1 = FALSE;

                SetCurrentExTaskMainEvent(ExBossEarlyManager_Main_WaitForAttack);
            }
            else
            {
                for (i = 0; i < (s16)ARRAY_COUNT(work->aniBoss.model.paletteAnimator); i++)
                {
                    SetPaletteAnimation(&work->aniBoss.model.paletteAnimator[i], 1);
                }

                work->hurtInvulnDuration = SECONDS_TO_FRAMES(0.5);
                work->hitEffectCooldown  = SECONDS_TO_FRAMES(1.0);

                work->aniBoss.hitChecker.hitFlags.isHurt       = FALSE;
                work->aniBoss.hitChecker.hitFlags.hasCollision = FALSE;
            }
        }
    }
    else
    {
        work->aniBoss.hitChecker.hitFlags.isHurt       = FALSE;
        work->aniBoss.hitChecker.hitFlags.hasCollision = FALSE;
    }

    if (work->hitVoiceClipCooldown > 0)
        work->hitVoiceClipCooldown--;

    if (work->hurtInvulnDuration > 0)
        work->hurtInvulnDuration--;

    if (work->hitEffectCooldown == 1)
    {
        for (i = 0; i < (s16)ARRAY_COUNT(work->aniBoss.model.paletteAnimator); i++)
        {
            SetPaletteAnimation(&work->aniBoss.model.paletteAnimator[i], 0);
        }
        work->hitEffectCooldown = 0;
    }
    else
    {
        work->hitEffectCooldown--;
    }

    RunCurrentExTaskUnknownEvent();
}

void ExBossEarlyManager_Main_WaitForAttack(void)
{
    exBossSysAdminTask *work = ExTaskGetWork(exBossTaskSingleton, exBossSysAdminTask);

    if (work->flags.isAttackReady)
        SetCurrentExTaskMainEvent(ExBossEarlyManager_Main_PickNextAttack);

    RunCurrentExTaskUnknownEvent();
}

BOOL CreateExBossEarlyManager(void)
{
    // NOTE: this allocates a task work struct 'exBossSysAdminBiforTask', which is never used!
    // this could likely be optimized to not create any struct, instead of using the 'exBossSysAdminTask' work size
    Task *task = ExTaskCreate(ExBossEarlyManager_Main_Init, ExBossEarlyManager_Destructor, TASK_PRIORITY_UPDATE_LIST_START + (0x3800 - 1), TASK_GROUP(5), 0, EXTASK_TYPE_REGULAR,
                              exBossSysAdminBiforTask);

    exBossSysAdminBiforTask *work = ExTaskGetWork(task, exBossSysAdminBiforTask);
    TaskInitWork8(work);

    SetExTaskUnknownEvent(task, ExBossEarlyManager_TaskUnknown);

    return TRUE;
}

void HandleExBossMovement(void)
{
    exBossSysAdminTask *work = ExTaskGetWork(exBossTaskSingleton, exBossSysAdminTask);

    if (work->moveDuration <= 0)
    {
        work->moveDuration = SECONDS_TO_FRAMES(3.0);

        if ((mtMathRand() % 2) != 0)
        {
            work->moveFlags.left  = FALSE;
            work->moveFlags.right = TRUE;
        }
        else
        {
            work->moveFlags.left  = TRUE;
            work->moveFlags.right = FALSE;
        }

        if ((mtMathRand() % 2) != 0)
        {
            work->moveFlags.up   = FALSE;
            work->moveFlags.down = TRUE;
        }
        else
        {
            work->moveFlags.up   = TRUE;
            work->moveFlags.down = FALSE;
        }
    }
    else
    {
        work->moveDuration--;
    }

    if (work->aniBoss.model.translation.x < -FLOAT_TO_FX32(25.0))
        work->aniBoss.model.translation.x += FLOAT_TO_FX32(0.25);

    if (work->aniBoss.model.translation.x > FLOAT_TO_FX32(25.0))
        work->aniBoss.model.translation.x -= FLOAT_TO_FX32(0.25);

    if (work->aniBoss.model.translation.y > FLOAT_TO_FX32(110.0))
        work->aniBoss.model.translation.y -= FLOAT_TO_FX32(0.25);

    if (work->aniBoss.model.translation.y < FLOAT_TO_FX32(90.0))
        work->aniBoss.model.translation.y += FLOAT_TO_FX32(0.25);

    HandleExBossMovementX();
    HandleExBossMovementY();

    work->targetPos.x = work->aniBoss.model.translation.x;
    work->targetPos.y = work->aniBoss.model.translation.y - FLOAT_TO_FX32(0.1001);

    work->aniBoss.model.angle.y = exPlayerHelpers__Func_2152E28(work->targetPos.x - work->aniBoss.model.translation.x, work->aniBoss.model.translation.y - work->targetPos.y);
}

void HandleExBossMovementX(void)
{
    exBossSysAdminTask *work = ExTaskGetWork(exBossTaskSingleton, exBossSysAdminTask);

    if (work->moveFlags.left)
    {
        if (work->aniBoss.model.translation.x > -FLOAT_TO_FX32(25.0))
        {
            work->aniBoss.model.translation.x -= FLOAT_TO_FX32(0.25);
        }
        else
        {
            work->moveFlags.left  = FALSE;
            work->moveFlags.right = TRUE;
        }
    }
    else if (work->moveFlags.right)
    {
        if (work->aniBoss.model.translation.x < FLOAT_TO_FX32(25.0))
        {
            work->aniBoss.model.translation.x += FLOAT_TO_FX32(0.25);
        }
        else
        {
            work->moveFlags.left  = TRUE;
            work->moveFlags.right = FALSE;
        }
    }
}

void HandleExBossMovementY(void)
{
    exBossSysAdminTask *work = ExTaskGetWork(exBossTaskSingleton, exBossSysAdminTask);

    if (work->moveFlags.up)
    {
        if (work->aniBoss.model.translation.y < FLOAT_TO_FX32(110.0))
        {
            work->aniBoss.model.translation.y += FLOAT_TO_FX32(0.25);
        }
        else
        {
            work->moveFlags.up   = FALSE;
            work->moveFlags.down = TRUE;
        }
    }
    else if (work->moveFlags.down)
    {
        if (work->aniBoss.model.translation.y > FLOAT_TO_FX32(90.0))
        {
            work->aniBoss.model.translation.y -= FLOAT_TO_FX32(0.25);
        }
        else
        {
            work->moveFlags.up   = TRUE;
            work->moveFlags.down = FALSE;
        }
    }
}
