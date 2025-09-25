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

static s16 exShockEffectInstanceCount;
static s16 exSmallExplosionInstanceCount;
static s16 exBigExplosionInstanceCount;

static Task *exShockEffectTaskSingleton;
static Task *exSmallExplosionTaskSingleton;
static void *exShockEffectSpriteResource;
static Task *exBigExplosionTaskSingleton;
static void *exSmallExplosionSpriteResource;
static void *exBigExplosionSpriteResource;

// force linkage of variables with no apparent references
FORCE_INCLUDE_VARIABLE_BSS(exSmallExplosionInstanceCount)
FORCE_INCLUDE_VARIABLE_BSS(exSmallExplosionTaskSingleton)
FORCE_INCLUDE_VARIABLE_BSS(exSmallExplosionSpriteResource)

// --------------------
// FUNCTION DECLS
// --------------------

// ExExplosion
static void LoadExExplosionSprite(EX_ACTION_BAC3D_WORK *work);
static void ReleaseExExplosionSprite(EX_ACTION_BAC3D_WORK *work);
static void ExExplosion_Main_Init(void);
static void ExExplosion_TaskUnknown(void);
static void ExExplosion_Destructor(void);
static void ExExplosion_Main_Active(void);

// ExShockEffect
static void LoadExShockEffectSprite(EX_ACTION_BAC3D_WORK *work);
static void SetExShockEffectAnimation(EX_ACTION_BAC3D_WORK *work, u16 anim);
static void ReleaseExShockEffectSprite(EX_ACTION_BAC3D_WORK *work);
static void ExShockEffect_Main_Init(void);
static void ExShockEffect_TaskUnknown(void);
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

    if (exBigExplosionInstanceCount == 0)
    {
        exBigExplosionSpriteResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_ACT_BAC);
    }

    VRAMPixelKey vramPixels    = VRAMSystem__AllocTexture(Sprite__GetTextureSizeFromAnim(exBigExplosionSpriteResource, 1), FALSE);
    VRAMPaletteKey vramPalette = VRAMSystem__AllocPalette(Sprite__GetPaletteSizeFromAnim(exBigExplosionSpriteResource, 1), FALSE);

    AnimatorSprite3D__Init(&work->sprite.animator, ANIMATOR_FLAG_NONE, exBigExplosionSpriteResource, EX_ACTCOM_ANI_EXPLOSION_BIG, ANIMATOR_FLAG_DISABLE_LOOPING, vramPixels,
                           vramPalette);

    work->sprite.animator.polygonAttr.xluDepthUpdate = TRUE;

    work->hitChecker.type            = EXHITCHECK_TYPE_NOT_SOLID;
    work->hitChecker.input.value_5_1 = TRUE;

    work->sprite.translation.z = FLOAT_TO_FX32(70.0);
    work->sprite.scale.x       = FLOAT_TO_FX32(0.5);
    work->sprite.scale.y       = FLOAT_TO_FX32(0.5);
    work->sprite.scale.z       = FLOAT_TO_FX32(0.5);

    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_BOTH;

    work->hitChecker.box.size.x   = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y   = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z   = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position = &work->sprite.translation;

    exBigExplosionInstanceCount++;
}

void ReleaseExExplosionSprite(EX_ACTION_BAC3D_WORK *work)
{
    AnimatorSprite3D__Release(&work->sprite.animator);

    exBigExplosionInstanceCount--;
}

void ExExplosion_Main_Init(void)
{
    exEffectBigBombTask *work = ExTaskGetWorkCurrent(exEffectBigBombTask);

    exBigExplosionTaskSingleton = GetCurrentTask();

    LoadExExplosionSprite(&work->aniExplosion);
    SetExDrawRequestPriority(&work->aniExplosion.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimStopOnFinish(&work->aniExplosion.config);

    work->aniExplosion.sprite.translation.x = work->targetPos.x;
    work->aniExplosion.sprite.translation.y = work->targetPos.y;
    work->aniExplosion.sprite.translation.z = work->targetPos.z;

    SetCurrentExTaskMainEvent(ExExplosion_Main_Active);
    ExExplosion_Main_Active();
}

void ExExplosion_TaskUnknown(void)
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

    exBigExplosionTaskSingleton = NULL;
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

        RunCurrentExTaskUnknownEvent();
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

    SetExTaskUnknownEvent(task, ExExplosion_TaskUnknown);

    return TRUE;
}

void LoadExShockEffectSprite(EX_ACTION_BAC3D_WORK *work)
{
    InitExDrawRequestSprite3D(work);

    if (exShockEffectInstanceCount == 0)
        exShockEffectSpriteResource = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_ACT_BAC);

    VRAMPixelKey vramPixels    = VRAMSystem__AllocTexture(Sprite__GetTextureSizeFromAnim(exShockEffectSpriteResource, 1), FALSE);
    VRAMPaletteKey vramPalette = VRAMSystem__AllocPalette(Sprite__GetPaletteSizeFromAnim(exShockEffectSpriteResource, 1), FALSE);

    AnimatorSprite3D__Init(&work->sprite.animator, ANIMATOR_FLAG_NONE, exShockEffectSpriteResource, EX_ACTCOM_ANI_SHOCK_EFFECT, ANIMATOR_FLAG_DISABLE_LOOPING, vramPixels,
                           vramPalette);
    work->sprite.animator.polygonAttr.xluDepthUpdate = TRUE;

    work->hitChecker.type              = EXHITCHECK_TYPE_NOT_SOLID;
    work->hitChecker.input.value_5_1   = TRUE;
    work->sprite.translation.z         = FLOAT_TO_FX32(70.0);
    work->sprite.scale.x               = FLOAT_TO_FX32(0.30005);
    work->sprite.scale.y               = FLOAT_TO_FX32(0.30005);
    work->sprite.scale.z               = FLOAT_TO_FX32(0.30005);
    work->config.control.activeScreens = EXDRAWREQTASKCONFIG_SCREEN_BOTH;
    work->hitChecker.box.size.x        = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.y        = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.size.z        = FLOAT_TO_FX32(0.0);
    work->hitChecker.box.position      = &work->sprite.translation;

    exShockEffectInstanceCount++;
}

void SetExShockEffectAnimation(EX_ACTION_BAC3D_WORK *work, u16 anim)
{
    work->sprite.anim = anim;
    AnimatorSprite__SetAnimation(&work->sprite.animator.animatorSprite, anim);
}

void ReleaseExShockEffectSprite(EX_ACTION_BAC3D_WORK *work)
{
    AnimatorSprite3D__Release(&work->sprite.animator);

    exShockEffectInstanceCount--;
}

void ExShockEffect_Main_Init(void)
{
    exEffectBiriBiriTask *work = ExTaskGetWorkCurrent(exEffectBiriBiriTask);

    exShockEffectTaskSingleton = GetCurrentTask();

    LoadExShockEffectSprite(&work->aniShockEffect);
    SetExDrawRequestPriority(&work->aniShockEffect.config, EXDRAWREQTASK_PRIORITY_DEFAULT);
    SetExDrawRequestAnimAsOneShot(&work->aniShockEffect.config);

    work->aniShockEffect.sprite.translation.x = work->targetPos.x;
    work->aniShockEffect.sprite.translation.y = work->targetPos.y;
    work->aniShockEffect.sprite.translation.z = work->targetPos.z - FLOAT_TO_FX32(5.0);

    SetCurrentExTaskMainEvent(ExShockEffect_Main_ShockAnimate);
    ExShockEffect_Main_ShockAnimate();
}

void ExShockEffect_TaskUnknown(void)
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

    exShockEffectTaskSingleton = NULL;
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

        RunCurrentExTaskUnknownEvent();
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

        RunCurrentExTaskUnknownEvent();
    }
}

BOOL CreateExShockEffect(VecFx32 *targetPos)
{
    if (exShockEffectTaskSingleton != NULL)
        return FALSE;

    Task *task =
        ExTaskCreate(ExShockEffect_Main_Init, ExShockEffect_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(3), 0, EXTASK_TYPE_REGULAR, exEffectBiriBiriTask);

    exEffectBiriBiriTask *work = ExTaskGetWork(task, exEffectBiriBiriTask);
    TaskInitWork8(work);

    work->targetPos.x = targetPos->x;
    work->targetPos.y = targetPos->y;
    work->targetPos.z = targetPos->z;

    SetExTaskUnknownEvent(task, ExShockEffect_TaskUnknown);

    return TRUE;
}