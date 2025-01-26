#ifndef RUSH_EXTUTORIALMESSAGE_H
#define RUSH_EXTUTORIALMESSAGE_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>
#include <ex/player/exPlayer.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exMsgTutorialTask_
{
    u16 timer;
    u16 field_2;
    u16 language;
    EX_ACTION_BAC2D_WORK aniBorder;
    EX_ACTION_BAC2D_WORK aniMessage[2];
    exPlayerAdminTaskWorker *field_1A0;
} exMsgTutorialTask;

// --------------------
// FUNCTIONS
// --------------------

// ExTutorialMessage
NOT_DECOMPILED void exMsgTutorialTask__GetLanguage(void);
NOT_DECOMPILED void exMsgTutorialTask__Main(void);
NOT_DECOMPILED void exMsgTutorialTask__Func8(void);
NOT_DECOMPILED void exMsgTutorialTask__Destructor(void);
NOT_DECOMPILED void exMsgTutorialTask__Main_Active(void);
NOT_DECOMPILED void exMsgTutorialTask__Create(void);
NOT_DECOMPILED void exMsgTutorialTask__Destroy(void);

#endif // RUSH_EXTUTORIALMESSAGE_H
