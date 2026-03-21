#include <ex/effects/exBigExplosion.h>
#include <ex/effects/exShockEffect.h>
#include <ex/player/exPlayer.h>
#include <ex/system/exSystem.h>

// Resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// VARIABLES
// --------------------

static s16 sShockEffectInstanceCount;
static s16 sSmallExplosionInstanceCount;
static s16 sBigExplosionInstanceCount;

static Task *sShockEffectTaskSingleton;
static Task *sSmallExplosionTaskSingleton;
static void *sShockEffectSpriteResource;
static Task *sBigExplosionTaskSingleton;
static void *sSmallExplosionSpriteResource;
static void *sBigExplosionSpriteResource;

// force linkage of variables with no apparent references
FORCE_INCLUDE_VARIABLE_BSS(sSmallExplosionInstanceCount)
FORCE_INCLUDE_VARIABLE_BSS(sSmallExplosionTaskSingleton)
FORCE_INCLUDE_VARIABLE_BSS(sSmallExplosionSpriteResource)

// --------------------
// FUNCTION DECLS
// --------------------

// ExExplosion
static void LoadExExplosionSprite(EX_ACTION_BAC3D_WORK *work);
static void ReleaseExExplosionSprite(EX_ACTION_BAC3D_WORK *work);
static void ExExplosion_Main_Init(void);
static void ExExplosion_OnCheckStageFinished(void);
static void ExExplosion_Destructor(void);
static void ExExplosion_Main_Active(void);

// ExShockEffect
static void LoadExShockEffectSprite(EX_ACTION_BAC3D_WORK *work);
static void SetExShockEffectAnimation(EX_ACTION_BAC3D_WORK *work, u16 anim);
static void ReleaseExShockEffectSprite(EX_ACTION_BAC3D_WORK *work);
static void ExShockEffect_Main_Init(void);
static void ExShockEffect_OnCheckStageFinished(void);
static void ExShockEffect_Destructor(void);
static void ExShockEffect_Main_ShockAnimate(void);
static void ExShockEffect_Action_ShockFinish(void);
static void ExShockEffect_Main_ShockFinish(void);

// --------------------
// FUNCTIONS
// --------------------

void LoadExExplosionSprite(EX_ACTION_BAC3D_WORK *work)
{
    InitExDrawRequestSprite3D(work);

    if (sBigExplosionInstanceCount == 0)
    {
        sBigExplosionSpriteResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_ACT_BAC);
    }

    VRAMPixelKey vramPixels    = VRAMSystem__AllocTexture(Sprite__GetTextureSizeFromAnim(sBigExplosionSpriteResource, 1), FALSE);
    VRAMPaletteKey vramPalette = VRAMSystem__AllocPalette(Sprite__GetPaletteSizeFromAnim(sBigExplosionSpriteResource, 1), FALSE);

    AnimatorSprite3D__Init(&work->sprite.animator, ANIMATOR_FLAG_NONE, sBigExplosionSpriteResource, EX_ACTCOM_ANI_EXPLOSION_BIG, ANIMATOR_FLAG_DISABLE_LOOPING, vramPixels,
                           vramPalette);

    work->sprite.animator.polygonAttr.xluDepthUpdate = TRUE;

    work->hitChecker.type                 = EXHITCHECK_TYPE_NOT_SOLID;
    work->hitChecker.input.isSpriteOrModelVFX = TRUE;

    work->sprite.translation.z = FLOAT_TO_FX32(70.0);
    work->sprite.scale.x       = FLOAT_TO_FX32(0.5);
    work->sprite.scale.y       = FLOAT_TO_FX32(0.5);
    work->sprite.scale.z       = FLOAT_TO_FX32(0.5);

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_BOTH;

    work->hitChecker.box.size.x   = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y   = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z   = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position = &work->sprite.translation;

    sBigExplosionInstanceCount++;
}

void ReleaseExExplosionSprite(EX_ACTION_BAC3D_WORK *work)
{
    AnimatorSprite3D__Release(&work->sprite.animator);

    sBigExplosionInstanceCount--;
}

void ExExplosion_Main_Init(void)
{
    exEffectBigBombTask *work = ExTaskGetWorkCurrent(exEffectBigBombTask);

    sBigExplosionTaskSingleton = GetCurrentTask();

    LoadExExplosionSprite(&work->aniExplosion);
    SetExDrawRequestPriority(&work->aniExplosion.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniExplosion.config);

    work->aniExplosion.sprite.translation.x = work->targetPos.x;
    work->aniExplosion.sprite.translation.y = work->targetPos.y;
    work->aniExplosion.sprite.translation.z = work->targetPos.z;

    SetCurrentExTaskMainEvent(ExExplosion_Main_Active);
    ExExplosion_Main_Active();
}

void ExExplosion_OnCheckStageFinished(void)
{
    exEffectBigBombTask *work = ExTaskGetWorkCurrent(exEffectBigBombTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExExplosion_Destructor(void)
{
    exEffectBigBombTask *work = ExTaskGetWorkCurrent(exEffectBigBombTask);

    ReleaseExExplosionSprite(&work->aniExplosion);

    sBigExplosionTaskSingleton = NULL;
}

void ExExplosion_Main_Active(void)
{
    exEffectBigBombTask *work = ExTaskGetWorkCurrent(exEffectBigBombTask);

    AnimateExDrawRequestSprite3D(&work->aniExplosion);

    if (IsExDrawRequestSprite3DAnimFinished(&work->aniExplosion))
    {
        DestroyCurrentExTask();
    }
    else
    {
        AddExDrawRequest(&work->aniExplosion, &work->aniExplosion.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

BOOL CreateExExplosion(VecFx32 *targetPos)
{
    Task *task = ExTaskCreate(ExExplosion_Main_Init, ExExplosion_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(3), 0, EXTASK_TYPE_REGULAR, exEffectBigBombTask);

    exEffectBigBombTask *work = ExTaskGetWork(task, exEffectBigBombTask);
    TaskInitWork8(work);

    work->targetPos.x = targetPos->x;
    work->targetPos.y = targetPos->y;
    work->targetPos.z = targetPos->z;

    SetExTaskOnCheckStageFinishedEvent(task, ExExplosion_OnCheckStageFinished);

    return TRUE;
}

void LoadExShockEffectSprite(EX_ACTION_BAC3D_WORK *work)
{
    InitExDrawRequestSprite3D(work);

    if (sShockEffectInstanceCount == 0)
        sShockEffectSpriteResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_ACT_BAC);

    VRAMPixelKey vramPixels    = VRAMSystem__AllocTexture(Sprite__GetTextureSizeFromAnim(sShockEffectSpriteResource, 1), FALSE);
    VRAMPaletteKey vramPalette = VRAMSystem__AllocPalette(Sprite__GetPaletteSizeFromAnim(sShockEffectSpriteResource, 1), FALSE);

    AnimatorSprite3D__Init(&work->sprite.animator, ANIMATOR_FLAG_NONE, sShockEffectSpriteResource, EX_ACTCOM_ANI_SHOCK_EFFECT, ANIMATOR_FLAG_DISABLE_LOOPING, vramPixels,
                           vramPalette);
    work->sprite.animator.polygonAttr.xluDepthUpdate = TRUE;

    work->hitChecker.type                 = EXHITCHECK_TYPE_NOT_SOLID;
    work->hitChecker.input.isSpriteOrModelVFX = TRUE;
    work->sprite.translation.z            = FLOAT_TO_FX32(70.0);
    work->sprite.scale.x                  = FLOAT_TO_FX32(0.30005);
    work->sprite.scale.y                  = FLOAT_TO_FX32(0.30005);
    work->sprite.scale.z                  = FLOAT_TO_FX32(0.30005);
    work->config.control.activeScreens    = EXDRAWREQTASKCONFIG_SCREEN_BOTH;
    work->hitChecker.box.size.x           = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y           = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z           = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position         = &work->sprite.translation;

    sShockEffectInstanceCount++;
}

void SetExShockEffectAnimation(EX_ACTION_BAC3D_WORK *work, u16 anim)
{
    work->sprite.anim = anim;
    AnimatorSprite__SetAnimation(&work->sprite.animator.animatorSprite, anim);
}

void ReleaseExShockEffectSprite(EX_ACTION_BAC3D_WORK *work)
{
    AnimatorSprite3D__Release(&work->sprite.animator);

    sShockEffectInstanceCount--;
}

void ExShockEffect_Main_Init(void)
{
    exEffectBiriBiriTask *work = ExTaskGetWorkCurrent(exEffectBiriBiriTask);

    sShockEffectTaskSingleton = GetCurrentTask();

    LoadExShockEffectSprite(&work->aniShockEffect);
    SetExDrawRequestPriority(&work->aniShockEffect.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimAsOneShot(&work->aniShockEffect.config);

    work->aniShockEffect.sprite.translation.x = work->targetPos.x;
    work->aniShockEffect.sprite.translation.y = work->targetPos.y;
    work->aniShockEffect.sprite.translation.z = work->targetPos.z - FLOAT_TO_FX32(5.0);

    SetCurrentExTaskMainEvent(ExShockEffect_Main_ShockAnimate);
    ExShockEffect_Main_ShockAnimate();
}

void ExShockEffect_OnCheckStageFinished(void)
{
    exEffectBiriBiriTask *work = ExTaskGetWorkCurrent(exEffectBiriBiriTask);
    UNUSED(work);

    if (CheckExStageFinished())
        DestroyCurrentExTask();
}

void ExShockEffect_Destructor(void)
{
    exEffectBiriBiriTask *work = ExTaskGetWorkCurrent(exEffectBiriBiriTask);

    ReleaseExShockEffectSprite(&work->aniShockEffect);

    sShockEffectTaskSingleton = NULL;
}

void ExShockEffect_Main_ShockAnimate(void)
{
    exEffectBiriBiriTask *work = ExTaskGetWorkCurrent(exEffectBiriBiriTask);

    AnimateExDrawRequestSprite3D(&work->aniShockEffect);

    if (GetExPlayerWorker()->shockStunDuration <= 0)
    {
        ExShockEffect_Action_ShockFinish();
    }
    else
    {
        AddExDrawRequest(&work->aniShockEffect, &work->aniShockEffect.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

void ExShockEffect_Action_ShockFinish(void)
{
    exEffectBiriBiriTask *work = ExTaskGetWorkCurrent(exEffectBiriBiriTask);

    SetExShockEffectAnimation(&work->aniShockEffect, EX_ACTCOM_ANI_SHOCK_EFFECT_FINISH);
    SetExDrawRequestAnimStopOnFinish(&work->aniShockEffect.config);

    SetCurrentExTaskMainEvent(ExShockEffect_Main_ShockFinish);
    ExShockEffect_Main_ShockFinish();
}

void ExShockEffect_Main_ShockFinish(void)
{
    exEffectBiriBiriTask *work = ExTaskGetWorkCurrent(exEffectBiriBiriTask);

    AnimateExDrawRequestSprite3D(&work->aniShockEffect);

    if (IsExDrawRequestSprite3DAnimFinished(&work->aniShockEffect))
    {
        DestroyCurrentExTask();
    }
    else
    {
        AddExDrawRequest(&work->aniShockEffect, &work->aniShockEffect.config);

        RunCurrentExTaskOnCheckStageFinishedEvent();
    }
}

BOOL CreateExShockEffect(VecFx32 *targetPos)
{
    if (sShockEffectTaskSingleton != NULL)
        return FALSE;

    Task *task =
        ExTaskCreate(ExShockEffect_Main_Init, ExShockEffect_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(3), 0, EXTASK_TYPE_REGULAR, exEffectBiriBiriTask);

    exEffectBiriBiriTask *work = ExTaskGetWork(task, exEffectBiriBiriTask);
    TaskInitWork8(work);

    work->targetPos.x = targetPos->x;
    work->targetPos.y = targetPos->y;
    work->targetPos.z = targetPos->z;

    SetExTaskOnCheckStageFinishedEvent(task, ExShockEffect_OnCheckStageFinished);

    return TRUE;
}