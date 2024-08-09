#ifndef RUSH2_EFFECT_PLAYERTRAIL_H
#define RUSH2_EFFECT_PLAYERTRAIL_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct TrailEffect_
{
    VecFx32 end;
    VecFx32 start;
    struct TrailEffect_ *next;
    struct TrailEffect_ *prev;
} TrailEffect;

typedef struct EffectPlayerTrail_
{
    EffectTask objWork;

    s32 id;
    s32 height;
    TrailEffect trailBuffer[11];
    TrailEffect *trailListStart;
    s32 nodeCount;
    s32 minNodeCount;
    GXRgb trailStartColor;
    GXRgb trailEndColor;
    s32 unknownAlpha;
    s32 startAlpha;
    s32 endAlpha;
    s32 vanish_time;
    s32 field_2F0;
} EffectPlayerTrail;

// --------------------
// FUNCTIONS
// --------------------

s32 CreateEffectPlayerTrail(Player *parent, fx32 height, u32 nodeCount, GXRgb startColor, GXRgb endColor);
void EffectPlayerTrail_Destructor(Task *task);
void SetPlayerTrailOffset(s32 offset);
void EffectPlayerTrail_State_Init(EffectPlayerTrail *work);
void EffectPlayerTrail_State_Active(EffectPlayerTrail *work);
void EffectPlayerTrail_State_Finish(EffectPlayerTrail *work);
void RecordPlayerTrailBuffer(TrailEffect *trail, Player *player, fx32 height);
void HandlePlayerTrailOffset(EffectPlayerTrail *work);
void EffectPlayerTrail_Draw(void);

#endif // RUSH2_EFFECT_PLAYERTRAIL_H