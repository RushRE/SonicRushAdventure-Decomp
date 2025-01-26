#ifndef RUSH_EXSTAGE_H
#define RUSH_EXSTAGE_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>

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
