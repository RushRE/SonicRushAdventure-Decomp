#ifndef RUSH_EXSONICDASHEFFECT_H
#define RUSH_EXSONICDASHEFFECT_H

#include <ex/player/exPlayer.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exSonDushEffectTask_
{
    s32 unused;
    EX_ACTION_NN_WORK aniDash;
    EX_ACTION_NN_WORK *parent;
} exSonDushEffectTask;

// --------------------
// FUNCTIONS
// --------------------

// ExSonic
void LoadExSuperSonicModel(EX_ACTION_NN_WORK *work);
void SetExSuperSonicAnimation(EX_ACTION_NN_WORK *work, u16 anim);
void ReleaseExSuperSonicModel(EX_ACTION_NN_WORK *work);
EX_ACTION_NN_WORK *GetExSuperSonicWorker(void);
void LoadExRegularSonicModel(EX_ACTION_NN_WORK *work);
void SetExRegularSonicAnimation(EX_ACTION_NN_WORK *work, u16 anim);
void ReleaseExRegularSonicModel(EX_ACTION_NN_WORK *work);

// ExSonicDashEffect
BOOL CreateExSonicDashEffect(EX_ACTION_NN_WORK *parent);
void DestroyExSonicDashEffect(void);

// ExSonicSprite
void LoadExSuperSonicSprite(EX_ACTION_BAC3D_WORK *work);
void ReleaseExSuperSonicSprite(EX_ACTION_BAC3D_WORK *work);

#endif // RUSH_EXSONICDASHEFFECT_H