#ifndef RUSH_SEAMAPTRAINING_H
#define RUSH_SEAMAPTRAINING_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/input/touchField.h>
#include <game/util/spriteButton.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapTrainingAssets_
{
    void *archive;
    void *sprTrainingText;
    void *bgTraining;
} SeaMapTrainingAssets;

typedef struct SeaMapTraining_
{
    void (*state)(struct SeaMapTraining_ *work);
    BOOL destroyQueued;
    SeaMapTrainingAssets assets;
    BOOL unknownFlag;
    BOOL textVisible;
    TouchField touchField;
    SpriteButtonAnimator trainingTextButton;
    s32 selectedButton;
    s32 unused;
} SeaMapTraining;

// --------------------
// FUNCTIONS
// --------------------

void CreateSeaMapTraining(void);

#endif // RUSH_SEAMAPTRAINING_H