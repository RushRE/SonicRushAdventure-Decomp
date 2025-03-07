#ifndef RUSH_PAUSEMENU_H
#define RUSH_PAUSEMENU_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>

// --------------------
// CONSTANTS
// --------------------

#define PAUSEMENU_MAX_BUTTON_COUNT 4

// --------------------
// ENUMS
// --------------------

enum PauseMenuAnimatorID_
{
    PAUSEMENU_ANIMATOR_BACKPLATE,
    PAUSEMENU_ANIMATOR_SELECTED_BACKPLATE,
    PAUSEMENU_ANIMATOR_PAUSED,
    PAUSEMENU_ANIMATOR_CONTINUE,
    PAUSEMENU_ANIMATOR_RESTART,
    PAUSEMENU_ANIMATOR_BACK,

    PAUSEMENU_ANIMATOR_COUNT,
};

enum PauseMenuButtonAction_
{
    PAUSEMENU_ACTION_PAUSE    = PAUSEMENU_ANIMATOR_PAUSED,
    PAUSEMENU_ACTION_CONTINUE = PAUSEMENU_ANIMATOR_CONTINUE,
    PAUSEMENU_ACTION_RESTART  = PAUSEMENU_ANIMATOR_RESTART,
    PAUSEMENU_ACTION_BACK     = PAUSEMENU_ANIMATOR_BACK,

    PAUSEMENU_ACTION_COUNT = 4,
};
typedef u8 PauseMenuButtonAction;

// --------------------
// STRUCTS
// --------------------

typedef struct PauseMenu_
{

    // allow each array index to be named
    union
    {
        struct
        {
            AnimatorSpriteDS aniBackplate;
            AnimatorSpriteDS aniSelectedBackplate;
            AnimatorSpriteDS aniPausedText;
            AnimatorSpriteDS aniContinueText;
            AnimatorSpriteDS aniRestartText;
            AnimatorSpriteDS aniBackText;
        };

        AnimatorSpriteDS animators[PAUSEMENU_ANIMATOR_COUNT];
    };

    PauseMenuButtonAction buttonAction[PAUSEMENU_MAX_BUTTON_COUNT];
    u16 buttonCount;
    Vec2Fx32 buttonPosition[PAUSEMENU_MAX_BUTTON_COUNT];
    s16 buttonLerpPercent[PAUSEMENU_MAX_BUTTON_COUNT];
    s16 selectedButton;
    s16 timer;
} PauseMenu;

// --------------------
// FUNCTIONS
// --------------------

void TryOpenPauseMenu(void);

#endif // RUSH_PAUSEMENU_H
