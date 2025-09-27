#ifndef RUSH_EXSTAGE_H
#define RUSH_EXSTAGE_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>

// --------------------
// MACROS
// --------------------

#define EX_STAGE_BOUNDARY_L -FLOAT_TO_FX32(90.0)
#define EX_STAGE_BOUNDARY_R FLOAT_TO_FX32(90.0)
#define EX_STAGE_BOUNDARY_T -FLOAT_TO_FX32(60.0)
#define EX_STAGE_BOUNDARY_B FLOAT_TO_FX32(200.0)

// --------------------
// STRUCTS
// --------------------

typedef struct exStageTask_
{
    VecFx32 velocity;
    EX_ACTION_NN_WORK aniStage;
} exStageTask;

// --------------------
// FUNCTIONS
// --------------------

// ExStage
void CreateExStage(void);
void DestroyExStage(void);
exStageTask *GetExStageSingleton(void);

#endif // RUSH_EXSTAGE_H
