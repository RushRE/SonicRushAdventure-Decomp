#ifndef RUSH_EFFECT_BUTTON_PROMPT_H
#define RUSH_EFFECT_BUTTON_PROMPT_H

#include <stage/effectTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct EffectButtonPrompt_
{
    StageTask objWork;
    
    OBS_ACTION2D_BAC_WORK ani;
} EffectButtonPrompt;

// --------------------
// FUNCTIONS
// --------------------

EffectButtonPrompt *EffectButtonPrompt__Create(StageTask *parent, s32 type);
void EffectButtonPrompt__State_DPadUp(EffectButtonPrompt *work);
void EffectButtonPrompt__State_JumpButton(EffectButtonPrompt *work);

#endif // RUSH_EFFECT_BUTTON_PROMPT_H