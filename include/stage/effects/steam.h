#ifndef RUSH_EFFECT_STEAM_H
#define RUSH_EFFECT_STEAM_H

#include <stage/effectTask.h>

// --------------------
// ENUMS
// --------------------

enum EffectSteamType_
{
    EFFECTSTEAM_TYPE_LARGE,
    EFFECTSTEAM_TYPE_SMALL,

    EFFECTSTEAM_TYPE_COUNT,
};
typedef u8 EffectSteamType;

// --------------------
// STRUCTS
// --------------------

typedef struct EffectSteam_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectSteam;

// --------------------
// FUNCTIONS
// --------------------

EffectSteam *EffectSteamDust__Create(u8 type, fx32 x, fx32 y, fx32 velX, fx32 velY);
EffectSteam *EffectSteamEffect__Create(u8 type, fx32 x, fx32 y, fx32 velX, fx32 velY, s32 timer);

#endif // RUSH_EFFECT_STEAM_H