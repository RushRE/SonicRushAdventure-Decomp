#ifndef RUSH_EXPAUSEMENU_H
#define RUSH_EXPAUSEMENU_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exPauseTask_
{
  u16 language;
  u16 buttonSelected[2];
  s16 timer;
  s16 percent;
  s16 buttonLerpPercent[2];
  s16 wordE;
  s16 word10;
  s16 word12;
  BOOL madeSelection;
  EX_ACTION_BAC2D_WORK aniPauseText;
  EX_ACTION_BAC2D_WORK aniContinueButton[2];
  EX_ACTION_BAC2D_WORK aniBackButton[2];
} exPauseTask;

// --------------------
// FUNCTIONS
// --------------------

// ExPauseMenu
NOT_DECOMPILED void exPauseTask__Main(void);
NOT_DECOMPILED void exPauseTask__Func8(void);
NOT_DECOMPILED void exPauseTask__Destructor(void);
NOT_DECOMPILED void exPauseTask__Main_EnterButtons(void);
NOT_DECOMPILED void exPauseTask__Action_Ready(void);
NOT_DECOMPILED void exPauseTask__Main_Selecting(void);
NOT_DECOMPILED void exPauseTask__Action_Select(void);
NOT_DECOMPILED void exPauseTask__Main_SelectionMade(void);
NOT_DECOMPILED void exPauseTask__Main_Exit(void);
NOT_DECOMPILED void exPauseTask__Draw(void);
NOT_DECOMPILED void exPauseTask__Create(void);
NOT_DECOMPILED void exPauseTask__GetSelectedAction(void);

#endif // RUSH_EXPAUSEMENU_H
