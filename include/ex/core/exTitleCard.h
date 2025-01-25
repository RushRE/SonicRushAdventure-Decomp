#ifndef RUSH_EXTITLECARD_H
#define RUSH_EXTITLECARD_H

#include <ex/system/exTask.h>
#include <ex/system/exDrawReq.h>

// --------------------
// STRUCTS
// --------------------

typedef struct exMsgTitleTask_
{
    s16 timer;
    s16 percent;
    s16 percent2;
    s16 field_6;
    EX_ACTION_BAC2D_WORK *aniBackdrop;
    EX_ACTION_BAC2D_WORK *aniZoneNameTextJP;
    EX_ACTION_BAC2D_WORK *aniZoneIcon;
    EX_ACTION_BAC2D_WORK *aniActBanner;
    EX_ACTION_BAC2D_WORK *aniZoneLetter[5];
    EX_ACTION_BAC2D_WORK *aniReadyText;
    EX_ACTION_BAC2D_WORK *aniGoText;
} exMsgTitleTask;

// --------------------
// FUNCTIONS
// --------------------

// ExTitleCard
NOT_DECOMPILED void exMsgTitleTask__Main(void);
NOT_DECOMPILED void exMsgTitleTask__Func8(void);
NOT_DECOMPILED void exMsgTitleTask__Destructor(void);
NOT_DECOMPILED void exMsgTitleTask__Main_216CCF4(void);
NOT_DECOMPILED void exMsgTitleTask__Func_216CD28(void);
NOT_DECOMPILED void exMsgTitleTask__Main_216CDC8(void);
NOT_DECOMPILED void exMsgTitleTask__Func_216CF94(void);
NOT_DECOMPILED void exMsgTitleTask__Func_216D1D0(void);
NOT_DECOMPILED void exMsgTitleTask__Func_216D300(void);
NOT_DECOMPILED void exMsgTitleTask__Func_216D328(void);
NOT_DECOMPILED void exMsgTitleTask__Func_216D564(void);
NOT_DECOMPILED void exMsgTitleTask__Func_216D6B0(void);
NOT_DECOMPILED void exMsgTitleTask__Func_216D6F8(void);
NOT_DECOMPILED void exMsgTitleTask__Func_216D720(void);
NOT_DECOMPILED void exMsgTitleTask__Func_216D760(void);
NOT_DECOMPILED void exMsgTitleTask__Func_216D794(void);
NOT_DECOMPILED void exMsgTitleTask__Func_216D7DC(void);
NOT_DECOMPILED void exMsgTitleTask__Func_216D804(void);
NOT_DECOMPILED void exMsgTitleTask__Create(void);
NOT_DECOMPILED void exMsgTitleTask__GetTask(void);

#endif // RUSH_EXTITLECARD_H
