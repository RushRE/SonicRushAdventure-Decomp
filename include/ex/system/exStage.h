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
NOT_DECOMPILED void exStageTask__LoadAssets(void);
NOT_DECOMPILED void exStageTask__ReleaseAssets(void);
NOT_DECOMPILED void exStageTask__Main(void);
NOT_DECOMPILED void exStageTask__Func8(void);
NOT_DECOMPILED void exStageTask__Destructor(void);
NOT_DECOMPILED void exStageTask__Main_Scrolling(void);
NOT_DECOMPILED void exStageTask__CreateEx(void);
NOT_DECOMPILED void exStageTask__Destroy(void);

#endif // RUSH_EXSTAGE_H
