#ifndef RUSH_EXPAUSEMENU_H
#define RUSH_EXPAUSEMENU_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>

// --------------------
// ENUMS
// --------------------

enum ExPauseMenuButton_
{
    EXPAUSEMENU_BUTTON_CONTINUE,
    EXPAUSEMENU_BUTTON_BACK,

    EXPAUSEMENU_BUTTON_COUNT,
};
typedef u16 ExPauseMenuButton;

enum ExPauseMenuAction_
{
    EXPAUSEMENU_ACTION_NONE,
    EXPAUSEMENU_ACTION_CONTINUE,
    EXPAUSEMENU_ACTION_BACK,
};
typedef u16 ExPauseMenuAction;

// --------------------
// STRUCTS
// --------------------

typedef struct exPauseTask_
{
    u16 language;
    u16 buttonSelected[EXPAUSEMENU_BUTTON_COUNT];
    s16 timer;
    s16 pauseTextLerpPercent;
    s16 buttonLerpPercent[EXPAUSEMENU_BUTTON_COUNT];
    s16 pauseTextOvershootPercent;
    s16 buttonOvershootPercent[EXPAUSEMENU_BUTTON_COUNT];
    BOOL madeSelection;
    EX_ACTION_BAC2D_WORK aniPauseText;
    EX_ACTION_BAC2D_WORK aniContinueButton[2];
    EX_ACTION_BAC2D_WORK aniBackButton[2];
} exPauseTask;

// --------------------
// FUNCTIONS
// --------------------

// ExPauseMenu
BOOL CreateExPauseMenu(void);
ExPauseMenuAction GetExPauseMenuSelectedAction(void);

#endif // RUSH_EXPAUSEMENU_H
