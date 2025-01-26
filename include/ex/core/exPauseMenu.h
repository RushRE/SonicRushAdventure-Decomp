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
void exPauseTask__Main(void);
void exPauseTask__Func8(void);
void exPauseTask__Destructor(void);
void exPauseTask__Main_EnterButtons(void);
void exPauseTask__Action_Ready(void);
void exPauseTask__Main_Selecting(void);
void exPauseTask__Action_Select(void);
void exPauseTask__Main_SelectionMade(void);
void exPauseTask__Main_Exit(void);
void exPauseTask__Draw(void);
void exPauseTask__Create(void);
u16 exPauseTask__GetSelectedAction(void);

#endif // RUSH_EXPAUSEMENU_H
