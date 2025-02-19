#ifndef RUSH_SEAMAPTRAINING_H
#define RUSH_SEAMAPTRAINING_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/input/touchField.h>
#include <game/util/spriteButton.h>

// --------------------
// STRUCTS
// --------------------

struct SeaMapTrainingAssets
{
    void *archive;
    void *sprTrainingLogo;
    void *bgTraining;
};

typedef struct SeaMapTraining_
{
    void (*state)(struct SeaMapTraining_ *work);
    s32 field_4;
    struct SeaMapTrainingAssets assets;
    s32 field_14;
    s32 field_18;
    TouchField touchField;
    SpriteButtonAnimator spriteButton;
    s32 field_D8;
    s32 field_DC;
} SeaMapTraining;

// --------------------
// VARIABLES
// --------------------

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void SeaMapTraining__Create(void);
NOT_DECOMPILED void SeaMapTraining__Main(void);
NOT_DECOMPILED void SeaMapTraining__Destructor(Task *task);
NOT_DECOMPILED void SeaMapTraining__Destroy(SeaMapTraining *work);
NOT_DECOMPILED void SeaMapTraining__DrawLogo(SeaMapTraining *work);
NOT_DECOMPILED void SeaMapTraining__LoadAssets(SeaMapTraining *work);
NOT_DECOMPILED void SeaMapTraining__ReleaseAssets(SeaMapTraining *work);
NOT_DECOMPILED void SeaMapTraining__SetupDisplay(SeaMapTraining *work);
NOT_DECOMPILED void SeaMapTraining__InitUnknown(SeaMapTraining *work);
NOT_DECOMPILED void SeaMapTraining__Func_2170E74(SeaMapTraining *work);
NOT_DECOMPILED void SeaMapTraining__InitBackground(SeaMapTraining *work);
NOT_DECOMPILED void SeaMapTraining__InitSprites(SeaMapTraining *work);
NOT_DECOMPILED void SeaMapTraining__Func_217101C(SeaMapTraining *work);
NOT_DECOMPILED u32 SeaMapTraining__GetSpriteSize(SeaMapTraining *work);
NOT_DECOMPILED void SeaMapTraining__Func_21710B0(SeaMapTraining *work);
NOT_DECOMPILED void SeaMapTraining__State_InitNavTails(SeaMapTraining *work);
NOT_DECOMPILED void SeaMapTraining__State_2171158(SeaMapTraining *work);
NOT_DECOMPILED void SeaMapTraining__State_21711BC(SeaMapTraining *work);
NOT_DECOMPILED void SeaMapTraining__State_2171214(SeaMapTraining *work);
NOT_DECOMPILED void SeaMapTraining__State_2171244(SeaMapTraining *work);
NOT_DECOMPILED void SeaMapTraining__State_2171268(SeaMapTraining *work);
NOT_DECOMPILED void SeaMapTraining__State_2171290(SeaMapTraining *work);
NOT_DECOMPILED void SeaMapTraining__State_21712BC(SeaMapTraining *work);

#endif // RUSH_SEAMAPTRAINING_H