#ifndef RUSH_CORRUPTSAVEWARNING_H
#define RUSH_CORRUPTSAVEWARNING_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/text/fontAnimator.h>
#include <game/text/fontWindowAnimator.h>

// --------------------
// STRUCTS
// --------------------

typedef struct CorruptSaveWarning_
{
    void *fontPtr;
    void *archive;
    FontWindow fontWindow;
    FontAnimator fontAnimator;
    FontWindowAnimator fontWindowAnimator;
    AnimatorSprite aniButtonPrompt;
} CorruptSaveWarning;

// --------------------
// FUNCTIONS
// --------------------

void CreateCorruptSaveWarning(void);

#endif // RUSH_CORRUPTSAVEWARNING_H
