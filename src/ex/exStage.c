#include <ex/system/exStage.h>
#include <ex/system/exSystem.h>
#include <game/file/binaryBundle.h>

// resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// VARIABLES
// --------------------

static void *sExStageModel;
static Task *sExStageTaskSingleton;
static exStageTask *sExStageSingleton;
static void *sExStageModelAnimations[3];

// --------------------
// FUNCTION DECLS
// --------------------

// ExStage
static void LoadExStageAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExStageAssets(EX_ACTION_NN_WORK *work);
static void ExStage_Main_Init(void);
static void ExStage_OnCheckStageFinished(void);
static void ExStage_Destructor(void);
static void ExStage_Main_Scrolling(void);

// --------------------
// FUNCTIONS
// --------------------

// ExStage
void LoadExStageAssets(EX_ACTION_NN_WORK *work)
{
    InitExDrawRequestModel(work);

    GetCompressedFileFromBundle("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_STAGE_00_NSBMD, &sExStageModel, FALSE, FALSE);

    sExStageModelAnimations[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_STAGE_NSBCA);
    sExStageModelAnimations[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_STAGE_NSBTA);
    sExStageModelAnimations[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_STAGE_NSBMA);
    NNS_G3dResDefaultSetup(sExStageModel);

    void *oldMemory = sExStageModel;
    sExStageModel    = HeapAllocHead(HEAP_USER, Asset3DSetup_GetResourceSize(oldMemory));
    Asset3DSetup_CopyResourceData(oldMemory, sExStageModel);
    HeapFree(HEAP_USER, oldMemory);

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, sExStageModel, 0, TRUE, TRUE);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_JOINT_ANIM, sExStageModelAnimations[0], 0, NULL);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_TEX_ANIM, sExStageModelAnimations[1], 0, NULL);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_MAT_ANIM, sExStageModelAnimations[2], 0, NULL);

    work->model.primaryAnimType     = B3D_ANIM_JOINT_ANIM;
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[B3D_ANIM_JOINT_ANIM];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->hitChecker.type                    = EXHITCHECK_TYPE_NOT_SOLID;
    work->hitChecker.input.isStageGeometry = TRUE;

    work->model.scale.x           = FLOAT_TO_FX32(1.0);
    work->model.scale.y           = FLOAT_TO_FX32(1.0);
    work->model.scale.z           = FLOAT_TO_FX32(1.0);
    work->hitChecker.box.position = &work->model.translation;
    work->model.angle.x           = FLOAT_DEG_TO_IDX(89.98);
}

void ReleaseExStageAssets(EX_ACTION_NN_WORK *work)
{
    if (sExStageModel != NULL)
        NNS_G3dResDefaultRelease(sExStageModel);

    if (sExStageModelAnimations[0] != NULL)
        NNS_G3dResDefaultRelease(sExStageModelAnimations[0]);

    if (sExStageModelAnimations[1] != NULL)
        NNS_G3dResDefaultRelease(sExStageModelAnimations[1]);

    if (sExStageModelAnimations[2] != NULL)
        NNS_G3dResDefaultRelease(sExStageModelAnimations[2]);

    if (sExStageModel != NULL)
        HeapFree(HEAP_USER, sExStageModel);
    else
        sExStageModel = NULL;

    AnimatorMDL__Release(&work->model.animator);
}

void ExStage_Main_Init(void)
{
    exStageTask *work = ExTaskGetWorkCurrent(exStageTask);

    sExStageTaskSingleton = GetCurrentTask();

    LoadExStageAssets(&work->aniStage);
    SetExDrawRequestPriority(&work->aniStage.config, EXDRAWREQTASK_PRIORITY_DEFAULT - 0x800);
    SetExDrawRequestAnimAsOneShot(&work->aniStage.config);

    work->aniStage.model.translation.y = -FLOAT_TO_FX32(40.0);

    work->velocity.x = FLOAT_TO_FX32(0.0);
    work->velocity.y = FLOAT_TO_FX32(1.0);
    work->velocity.z = FLOAT_TO_FX32(0.0);

    sExStageSingleton = work;

    SetCurrentExTaskMainEvent(ExStage_Main_Scrolling);
}

void ExStage_OnCheckStageFinished(void)
{
    exStageTask *work = ExTaskGetWorkCurrent(exStageTask);
    UNUSED(work);
}

void ExStage_Destructor(void)
{
    exStageTask *work = ExTaskGetWorkCurrent(exStageTask);

    ReleaseExStageAssets(&work->aniStage);

    sExStageTaskSingleton = NULL;
}

void ExStage_Main_Scrolling(void)
{
    exStageTask *work = ExTaskGetWorkCurrent(exStageTask);

    work->aniStage.model.translation.y -= work->velocity.y;
    if (work->aniStage.model.translation.y <= -FLOAT_TO_FX32(540.0))
        work->aniStage.model.translation.y = -FLOAT_TO_FX32(40.0);

    AnimateExDrawRequestModel(&work->aniStage);
    AddExDrawRequest(&work->aniStage, &work->aniStage.config);

    UNUSED(SwapBuffer3D_GetPrimaryScreen());

    work->aniStage.model.translation.y += FLOAT_TO_FX32(499.5);
    AddExDrawRequest(&work->aniStage, &work->aniStage.config);
    work->aniStage.model.translation.y -= FLOAT_TO_FX32(499.5);

    RunCurrentExTaskOnCheckStageFinishedEvent();
}

void CreateExStage(void)
{
    Task *task = ExTaskCreate(ExStage_Main_Init, ExStage_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(1), 0, EXTASK_TYPE_REGULAR, exStageTask);

    exStageTask *work = ExTaskGetWork(task, exStageTask);

    SetExTaskOnCheckStageFinishedEvent(task, ExStage_OnCheckStageFinished);
}

void DestroyExStage(void)
{
    if (sExStageTaskSingleton != NULL)
        DestroyExTask(sExStageTaskSingleton);
}

exStageTask *GetExStageSingleton(void)
{
    return sExStageSingleton;
}