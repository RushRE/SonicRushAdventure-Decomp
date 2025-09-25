#include <ex/system/exStage.h>
#include <ex/system/exSystem.h>
#include <game/file/binaryBundle.h>

// resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// VARIABLES
// --------------------

void *exStageModel;
void *exStageTaskSingleton;
void *exStageSingleton;
void *exStageModelAnimations[3];

// --------------------
// FUNCTION DECLS
// --------------------

// ExStage
static void LoadExStageAssets(EX_ACTION_NN_WORK *work);
static void ReleaseExStageAssets(EX_ACTION_NN_WORK *work);
static void ExStage_Main_Init(void);
static void ExStage_TaskUnknown(void);
static void ExStage_Destructor(void);
static void ExStage_Main_Scrolling(void);

// --------------------
// FUNCTIONS
// --------------------

// ExStage
void LoadExStageAssets(EX_ACTION_NN_WORK *work)
{
    InitExDrawRequestModel(work);

    GetCompressedFileFromBundle("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_STAGE_00_NSBMD, &exStageModel, FALSE, FALSE);

    exStageModelAnimations[0] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_STAGE_NSBCA);
    exStageModelAnimations[1] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_STAGE_NSBTA);
    exStageModelAnimations[2] = LoadExSystemFile(ARCHIVE_EX_COM_FILE_EX_STAGE_NSBMA);
    NNS_G3dResDefaultSetup(exStageModel);

    void *oldMemory = exStageModel;
    exStageModel    = HeapAllocHead(HEAP_USER, Asset3DSetup__GetTexSize(oldMemory));
    Asset3DSetup__GetTexture(oldMemory, exStageModel);
    HeapFree(HEAP_USER, oldMemory);

    AnimatorMDL__Init(&work->model.animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(&work->model.animator, exStageModel, 0, TRUE, TRUE);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_JOINT_ANIM, exStageModelAnimations[0], 0, NULL);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_TEX_ANIM, exStageModelAnimations[1], 0, NULL);
    AnimatorMDL__SetAnimation(&work->model.animator, B3D_ANIM_MAT_ANIM, exStageModelAnimations[2], 0, NULL);

    work->model.primaryAnimType     = B3D_ANIM_JOINT_ANIM;
    work->model.primaryAnimResource = work->model.animator.currentAnimObj[B3D_ANIM_JOINT_ANIM];

    for (u32 r = 0; r < B3D_ANIM_MAX; r++)
    {
        if (((1 << r) & (B3D_ANIM_FLAG_TEX_ANIM | B3D_ANIM_FLAG_MAT_ANIM | B3D_ANIM_FLAG_JOINT_ANIM)) != 0)
            work->model.animator.animFlags[r] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->hitChecker.type                    = EXHITCHECK_TYPE_NOT_SOLID;
    work->hitChecker.field_4.isStageGeometry = TRUE;

    work->model.scale.x           = FLOAT_TO_FX32(1.0);
    work->model.scale.y           = FLOAT_TO_FX32(1.0);
    work->model.scale.z           = FLOAT_TO_FX32(1.0);
    work->hitChecker.box.position = &work->model.translation;
    work->model.angle.x           = FLOAT_DEG_TO_IDX(89.98);
}

void ReleaseExStageAssets(EX_ACTION_NN_WORK *work)
{
    if (exStageModel != NULL)
        NNS_G3dResDefaultRelease(exStageModel);

    if (exStageModelAnimations[0] != NULL)
        NNS_G3dResDefaultRelease(exStageModelAnimations[0]);

    if (exStageModelAnimations[1] != NULL)
        NNS_G3dResDefaultRelease(exStageModelAnimations[1]);

    if (exStageModelAnimations[2] != NULL)
        NNS_G3dResDefaultRelease(exStageModelAnimations[2]);

    if (exStageModel != NULL)
        HeapFree(HEAP_USER, exStageModel);
    else
        exStageModel = NULL;

    AnimatorMDL__Release(&work->model.animator);
}

void ExStage_Main_Init(void)
{
    exStageTask *work = ExTaskGetWorkCurrent(exStageTask);

    exStageTaskSingleton = GetCurrentTask();

    LoadExStageAssets(&work->aniStage);
    SetExDrawRequestPriority(&work->aniStage.config, EXDRAWREQTASK_PRIORITY_DEFAULT - 0x800);
    SetExDrawRequestAnimAsOneShot(&work->aniStage.config);

    work->aniStage.model.translation.y = -FLOAT_TO_FX32(40.0);

    work->velocity.x = FLOAT_TO_FX32(0.0);
    work->velocity.y = FLOAT_TO_FX32(1.0);
    work->velocity.z = FLOAT_TO_FX32(0.0);

    exStageSingleton = work;

    SetCurrentExTaskMainEvent(ExStage_Main_Scrolling);
}

void ExStage_TaskUnknown(void)
{
    exStageTask *work = ExTaskGetWorkCurrent(exStageTask);
    UNUSED(work);
}

void ExStage_Destructor(void)
{
    exStageTask *work = ExTaskGetWorkCurrent(exStageTask);

    ReleaseExStageAssets(&work->aniStage);

    exStageTaskSingleton = NULL;
}

void ExStage_Main_Scrolling(void)
{
    exStageTask *work = ExTaskGetWorkCurrent(exStageTask);

    work->aniStage.model.translation.y -= work->velocity.y;
    if (work->aniStage.model.translation.y <= -FLOAT_TO_FX32(540.0))
        work->aniStage.model.translation.y = -FLOAT_TO_FX32(40.0);

    AnimateExDrawRequestModel(&work->aniStage);
    AddExDrawRequest(&work->aniStage, &work->aniStage.config);

    Camera3D__UseEngineA();

    work->aniStage.model.translation.y += FLOAT_TO_FX32(499.5);
    AddExDrawRequest(&work->aniStage, &work->aniStage.config);
    work->aniStage.model.translation.y -= FLOAT_TO_FX32(499.5);

    RunCurrentExTaskUnknownEvent();
}

void CreateExStage(void)
{
    Task *task = ExTaskCreate(ExStage_Main_Init, ExStage_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(1), 0, EXTASK_TYPE_REGULAR, exStageTask);

    exStageTask *work = ExTaskGetWork(task, exStageTask);

    SetExTaskUnknownEvent(task, ExStage_TaskUnknown);
}

void DestroyExStage(void)
{
    if (exStageTaskSingleton != NULL)
        DestroyExTask(exStageTaskSingleton);
}

exStageTask *GetExStageSingleton(void)
{
    return exStageSingleton;
}