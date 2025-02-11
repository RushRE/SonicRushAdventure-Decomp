
#ifndef RUSH_FONTWINDOWANIMATOR_H
#define RUSH_FONTWINDOWANIMATOR_H

#include <game/text/fontAnimatorCore.h>
#include <game/text/fontWindow.h>
#include <game/text/fontWindowAnimatorUnknown.h>
#include <game/graphics/tileHelpers.h>

// resources
#include <resources/narc/win_simple_lz7.h>
#include <resources/narc/mw_frame_lz7.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// ENUMS
// --------------------

enum FontWindowAnimatorArchive
{
    FONTWINDOWANIMATOR_ARC_0,
    FONTWINDOWANIMATOR_ARC_1,
    FONTWINDOWANIMATOR_ARC_COUNT,
};

// --------------------
// STRUCTS
// --------------------

typedef struct FontWindowAnimator_
{
    FontAnimatorCore base;
    u32 flags;
    FontWindowAnimatorUnknown unknown;
    u32 type;
    BOOL useEngineB;
    s16 bgID;
    s16 field_4E;
    s16 field_50;
    u16 field_52;
    u32 animType;
    BOOL isAnimating;
    u16 duration;
    u16 delay;
    u16 timer;
    u16 field_62;
} FontWindowAnimator;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void FontWindowAnimator__Init(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Load1(FontWindowAnimator *work, FontWindow *file, u32 flags, u32 archiveID, u16 fileID, u16 startX, u16 startY, u16 sizeX, u16 sizeY,
                                              BOOL useEngineB, u8 bgID, u8 paletteRow, u16 startTile, u16 fillTile);
NOT_DECOMPILED void FontWindowAnimator__Load2(FontWindowAnimator *work, FontWindow *font, u32 flags, u32 archiveID, u16 fileID, u16 startX, u16 startY, u16 sizeX, u16 sizeY,
                                              BOOL useEngineB, u8 oamPriority, u8 oamOrder, u8 paletteRow);
NOT_DECOMPILED void FontWindowAnimator__Release(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__EnableFlags(FontWindowAnimator *work, u32 flags);
NOT_DECOMPILED void FontWindowAnimator__DisableFlags(FontWindowAnimator *work, u32 flags);
NOT_DECOMPILED void FontWindowAnimator__Func_20599B4(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_20599C4(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Draw(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__InitAnimation(FontWindowAnimator *work, s32 type, u16 delay, u16 duration, u16 a5);
NOT_DECOMPILED void FontWindowAnimator__StartAnimating(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__ProcessWindowAnim(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__SetWindowOpen(FontWindowAnimator *work);
NOT_DECOMPILED BOOL FontWindowAnimator__IsTimerPaused(FontWindowAnimator *work);
NOT_DECOMPILED BOOL FontWindowAnimator__IsFinishedAnimating(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__SetWindowClosed(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_2059B88(FontWindowAnimator *work, s32 bgID, s32 paletteRow);
NOT_DECOMPILED void FontWindowAnimator__UpdateUnknownFlags(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_2059BD8(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_2059C94(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_2059CE4(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_2059D00(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_2059D24(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_2059D48(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_2059D64(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_2059D88(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_2059DAC(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_2059DD8(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_2059E04(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_2059E30(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_2059E60(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_2059E90(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_2059EC0(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_2059FE0(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_205A180(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_205A2A4(FontWindowAnimator *work);
NOT_DECOMPILED void FontWindowAnimator__Func_205A2D4(FontWindowAnimator *work);

#ifdef __cplusplus
}
#endif

#endif // RUSH_FONTWINDOWANIMATOR_H
