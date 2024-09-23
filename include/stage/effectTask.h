#ifndef RUSH2_EFFECT_TASK_H
#define RUSH2_EFFECT_TASK_H

#include <stage/stageTask.h>
#include <stage/player/player.h>

// --------------------
// TYPES
// --------------------

typedef struct EffectTask3D_ EffectTask3D;

typedef void (*EffectTask3DState)(EffectTask3D *work);

// --------------------
// MACROS
// --------------------

#define CreateEffect(type, parent) (type *)CreateEffectTask(sizeof(type), (StageTask *)(parent))

// --------------------
// ENUMS
// --------------------

enum EffectTask3DFlags_
{
    EFFECTTASK3D_FLAG_NONE = 0x00,

    EFFECTTASK3D_FLAG_HAS_MODEL      = 1 << 0,
    EFFECTTASK3D_FLAG_HAS_ARCHIVE    = 1 << 1,
    EFFECTTASK3D_FLAG_HAS_ANIM_JOINT = 1 << 2,
    EFFECTTASK3D_FLAG_HAS_ANIM_MAT   = 1 << 3,
    EFFECTTASK3D_FLAG_HAS_ANIM_PAT   = 1 << 4,
    EFFECTTASK3D_FLAG_HAS_ANIM_TEX   = 1 << 5,
    EFFECTTASK3D_FLAG_HAS_ANIM_VIS   = 1 << 6,
};
typedef u16 EffectTask3DFlags;

// --------------------
// STRUCTS
// --------------------

struct EffectTaskStaticVars
{
    Task *lastCreatedTask;
    StageTask *airEffectSingleton;
    OBS_DATA_WORK effectExplosionFile;
    OBS_DATA_WORK effectWaterSplashFile;
    OBS_DATA_WORK effectFoundFile;
    OBS_DATA_WORK effectVitalityFile;
    OBS_DATA_WORK field_28;
    OBS_DATA_WORK effectBattleBurstFile;
    u8 trailIDList[4];
    fx32 trailXOffset;
    Task *trailTaskList[2];
    OBS_DATA_WORK effectBrakeDustFile;
    OBS_DATA_WORK effectSpindashDustFile;
    OBS_DATA_WORK effectBoostFile;
    OBS_DATA_WORK effectFlameJetFile;
    OBS_DATA_WORK effectGrindFile;
    OBS_DATA_WORK effectTrickSparkleFile;
    OBS_DATA_WORK field_78;
    OBS_DATA_WORK field_80;
    OBS_DATA_WORK effectSnowSmokeFile;
    OBS_DATA_WORK effectBattleAttackFile;
    OBS_DATA_WORK effectWaterGrindFile;
    OBS_DATA_WORK effectDrownAlertFile;
    OBS_DATA_WORK effectBrakeDust3DFile;
    OBS_DATA_WORK effectSpindashDust3DFile;
    OBS_DATA_WORK effectFlameJet3DFile;
};

struct EffectTask3D_
{
    StageTask objWork;

    AnimatorMDL animatorMDL;
    OBS_DATA_WORK *filePtr;
    NNSG3dResFileHeader *resource;
    void *files[B3D_ANIM_MAX];
    EffectTask3DState nextState;
    u16 delay;
    EffectTask3DFlags flags;
};

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED struct EffectTaskStaticVars EffectTask__sVars;

// --------------------
// FUNCTIONS
// --------------------

// EffectTask
StageTask *CreateEffectTask(size_t size, StageTask *parent);
StageTask *InitEffectTaskViewCheck(StageTask *work, s16 offset, s16 left, s16 top, s16 right, s16 bottom);

// EffectTask3D
void LoadEffectTask3DAsset(EffectTask3D *work, const char *path, OBS_DATA_WORK *fileWork, NNSiFndArchiveHeader *archive, u32 resourceFlags, StageTaskState nextState,
                           BOOL initResources);
void EffectTask3D_State_Init(EffectTask3D *work);
void EffectTask3D_Draw_3D(void);
void EffectTask3D_Destructor(Task *task);

// EffectTask states
void EffectTask_State_DestroyAfterAnimation(StageTask *work);
void EffectTask_State_DestroyAfterTime(StageTask *work);
void EffectTask_State_MoveTowardsZeroX(StageTask *work);
void EffectTask_State_TrackParent(StageTask *work);

#endif // RUSH2_EFFECT_TASK_H