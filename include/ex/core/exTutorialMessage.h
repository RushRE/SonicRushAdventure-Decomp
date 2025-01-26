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
    s16 scrollPos;
    u16 unused;
    u16 language;
    EX_ACTION_BAC2D_WORK aniBorder;
    EX_ACTION_BAC2D_WORK aniMessage[EXPLAYER_CHARACTER_COUNT];
    exPlayerAdminTaskWorker *playerWorker;
} exMsgTutorialTask;

// --------------------
// FUNCTIONS
// --------------------

// ExTutorialMessage
BOOL CreateExTutorialMessage(void);
void DestroyExTutorialMessage(void);

#endif // RUSH_EXTUTORIALMESSAGE_H
