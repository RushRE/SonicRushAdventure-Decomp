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
    exPlayerAdminTask *parent;
} exSonDushEffectTask;

// --------------------
// FUNCTIONS
// --------------------

// ExSonic
NOT_DECOMPILED void exPlayerAdminTask__LoadSuperSonicAssets(EX_ACTION_NN_WORK *work);
NOT_DECOMPILED void exPlayerAdminTask__SetSuperSonicAnimation(EX_ACTION_NN_WORK *work, u16 anim);
NOT_DECOMPILED void exPlayerAdminTask__Func_2171954(EX_ACTION_NN_WORK *work);
NOT_DECOMPILED EX_ACTION_NN_WORK *exPlayerAdminTask__GetSonicAssets(void);
NOT_DECOMPILED void exPlayerAdminTask__LoadSonicAssets(EX_ACTION_NN_WORK *work);
NOT_DECOMPILED void exPlayerAdminTask__SetSonicAnimation(EX_ACTION_NN_WORK *work, u16 anim);
NOT_DECOMPILED void exPlayerAdminTask__Func_2171B80(EX_ACTION_NN_WORK *work);

// ExSonicDashEffect
NOT_DECOMPILED void exSonDushEffectTask__LoadAssets(EX_ACTION_NN_WORK *work);
NOT_DECOMPILED void exSonDushEffectTask__Destroy_2172270(EX_ACTION_NN_WORK *work);
NOT_DECOMPILED void exSonDushEffectTask__Main(void);
NOT_DECOMPILED void exSonDushEffectTask__Func8(void);
NOT_DECOMPILED void exSonDushEffectTask__Destructor(void);
NOT_DECOMPILED void exSonDushEffectTask__Main_Active(void);
NOT_DECOMPILED void exSonDushEffectTask__Create(exPlayerAdminTask *parent);
NOT_DECOMPILED void exSonDushEffectTask__Destroy(void);

// ExSonicSprite
NOT_DECOMPILED void exSonDushEffectTask__LoadSonicSprite(EX_ACTION_BAC3D_WORK *work);
NOT_DECOMPILED void exSonDushEffectTask__Func_21725F8(EX_ACTION_BAC3D_WORK *work);

#endif // RUSH_EXSONICDASHEFFECT_H