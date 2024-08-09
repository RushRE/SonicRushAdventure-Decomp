
#ifndef RUSH2_FONTWINDOWMWCONTROL_H
#define RUSH2_FONTWINDOWMWCONTROL_H

#include <game/text/fontAnimatorCore.h>
#include <game/graphics/paletteAnimation.h>

// --------------------
// CONSTANTS
// --------------------

// --------------------
// STRUCTS
// --------------------

typedef struct FontWindowMWControl_
{
    FontAnimatorCore base;
    u32 paletteAnimFlags;
    u32 paletteAnimID;
    BOOL useEngineB;
    Vec2Fx16 pos;
    u16 offsetX;
    u16 offsetY;
    u8 oamMode;
    u8 oamOrder;
    u8 paletteRow;
    void *dstPixels;
    u16 vramPixelsSlot;
    u16 pixelSize;
    BOOL renderedPixels;
    u16 tileCount;
    u16 funcID;
    void *pixels;
    PaletteAnimator paletteAnim;
} FontWindowMWControl;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void FontWindowMWControl__Init(FontWindowMWControl *work);
NOT_DECOMPILED void FontWindowMWControl__Load(FontWindowMWControl *work, FontWindow *window, s32 a3, s32 fileID, s16 offsetX, s16 offsetY, BOOL useEngineB, u8 oamMode, u8 oamOrder, u8 paletteRow);
NOT_DECOMPILED void FontWindowMWControl__Release(FontWindowMWControl *work);
NOT_DECOMPILED void FontWindowMWControl__SetPaletteAnim(FontWindowMWControl *work, u16 anim);
NOT_DECOMPILED void FontWindowMWControl__ValidatePaletteAnim(FontWindowMWControl *work, u16 anim);
NOT_DECOMPILED void FontWindowMWControl__SetPosition(FontWindowMWControl *work, s16 x, s16 y);
NOT_DECOMPILED void FontWindowMWControl__SetOffset(void);
NOT_DECOMPILED void FontWindowMWControl__GetOffset(void);
NOT_DECOMPILED void FontWindowMWControl__Draw(FontWindowMWControl *work);
NOT_DECOMPILED void FontWindowMWControl__CallWindowFunc2(FontWindowMWControl *work);
NOT_DECOMPILED void FontWindowMWControl__ApplyPaletteAnimFlags(void);
NOT_DECOMPILED void FontWindowMWControl__WindowFunc_205A66C(void);
NOT_DECOMPILED void FontWindowMWControl__WindowFunc_205A72C(void);
NOT_DECOMPILED void FontWindowMWControl__WindowFunc_205A804(void);
NOT_DECOMPILED void FontWindowMWControl__RenderPixels(void);
NOT_DECOMPILED void FontWindowMWControl__WindowFunc2_205A938(void);
NOT_DECOMPILED void FontWindowMWControl__Func_205AA90(void);
NOT_DECOMPILED void FontWindowMWControl__Func_205AB14(void);
NOT_DECOMPILED void FontWindowMWControl__Func_205AD4C(void);
NOT_DECOMPILED void FontWindowMWControl__WindowFunc2_205AF50(void);
NOT_DECOMPILED void FontWindowMWControl__Func_205B1B0(void);
NOT_DECOMPILED void FontWindowMWControl__Func_205B250(void);
NOT_DECOMPILED void FontWindowMWControl__Func_205B2E0(void);
NOT_DECOMPILED void FontWindowMWControl__Func_205B37C(void);
NOT_DECOMPILED void FontWindowMWControl__SetSprite(void);

#endif // RUSH2_FONTWINDOWMWCONTROL_H
