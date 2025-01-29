#ifndef RUSH_EXBLAZEDASHEFFECT_H
#define RUSH_EXBLAZEDASHEFFECT_H

#include <ex/player/exPlayer.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exBlzDushEffectTask_
{
    s32 unused;
    EX_ACTION_NN_WORK aniDash;
    exPlayerAdminTask *parent;
} exBlzDushEffectTask;

// --------------------
// FUNCTIONS
// --------------------

// ExBlaze
void LoadExBurningBlazeModel(EX_ACTION_NN_WORK *work);
void SetExBurningBlazeAnimation(EX_ACTION_NN_WORK *work, u16 anim);
void ReleaseExBurningBlazeModel(EX_ACTION_NN_WORK *work);
EX_ACTION_NN_WORK *GetExBurningBlazeWorker(void);
void LoadExRegularBlazeModel(EX_ACTION_NN_WORK *work);
void SetExRegularBlazeAnimation(EX_ACTION_NN_WORK *work, u16 anim);
void ReleaseExRegularBlazeModel(EX_ACTION_NN_WORK *work);

// ExBlazeDashEffect
BOOL CreateExBlazeDashEffect(exPlayerAdminTask *parent);
void DestroyExBlazeDashEffect(void);

// ExBlazeSprite
void LoadExBurningBlazeSprite(EX_ACTION_BAC3D_WORK *work);
void ReleaseExBurningBlazeSprite(EX_ACTION_BAC3D_WORK *work);

#endif // RUSH_EXBLAZEDASHEFFECT_H