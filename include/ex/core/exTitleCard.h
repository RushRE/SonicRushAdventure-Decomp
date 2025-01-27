#ifndef RUSH_EXTITLECARD_H
#define RUSH_EXTITLECARD_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>

// --------------------
// ENUMS
// --------------------

enum ExTitleCardZoneLetterIDs
{
    EXTITLECARD_ZONELETTER_E,
    EXTITLECARD_ZONELETTER_X,
    EXTITLECARD_ZONELETTER_T,
    EXTITLECARD_ZONELETTER_R,
    EXTITLECARD_ZONELETTER_A,

    EXTITLECARD_ZONELETTER_COUNT,
};

// --------------------
// STRUCTS
// --------------------

typedef struct exMsgTitleTask_
{
    s16 timer;
    s16 nameplaceEnterPercent;
    s16 nameplaceExitPercent;
    EX_ACTION_BAC2D_WORK *aniBackdrop;
    EX_ACTION_BAC2D_WORK *aniZoneNameTextJP;
    EX_ACTION_BAC2D_WORK *aniZoneIcon;
    EX_ACTION_BAC2D_WORK *aniActBanner;
    EX_ACTION_BAC2D_WORK *aniZoneLetter[EXTITLECARD_ZONELETTER_COUNT];
    EX_ACTION_BAC2D_WORK *aniReadyText;
    EX_ACTION_BAC2D_WORK *aniGoText;
} exMsgTitleTask;

// --------------------
// FUNCTIONS
// --------------------

BOOL CreateExTitleCard(void);
Task *GetExTitleCardTaskSingleton(void);

#endif // RUSH_EXTITLECARD_H
