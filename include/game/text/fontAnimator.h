#ifndef RUSH_FONTANIMATOR_H
#define RUSH_FONTANIMATOR_H

#include <game/text/fontAnimatorCore.h>
#include <game/text/messageController.h>

// --------------------
// TYPES
// --------------------

typedef struct FontAnimator_ FontAnimator;

typedef void (*FontCallback)(u32 type, struct FontAnimator_ *animator, void *context);

// --------------------
// STRUCTS
// --------------------

typedef struct FontAnimatorPalette_
{
    BOOL useEngineB;
    u16 field_4;
    u16 field_6;
    void *dstPixels;
    void *pixelPtr;
} FontAnimatorPalette;

typedef struct FontUnknown2058D78_
{
    u32 flags;
    u16 field_4;
    u16 field_6;
    FontField_9C unknown;
    u32 applyMode;
    FontAnimatorPalette paletteControl;
    struct FontUnknown2058D78_ *next;
    struct FontAnimator_ *parent;
} FontUnknown2058D78;

struct FontAnimator_
{
    FontAnimatorCore base;
    u32 flags;
    u16 field_C;
    u16 field_E;
    u16 pixelWidth;
    u16 pixelHeight;
    u16 width;
    u16 height;
    u16 field_18;
    u16 field_1A;
    u32 callbackType;
    MessageController msgControl;
    void *pixels;
    u32 field_98;
    FontField_9C field_9C;
    u32 applyMode;
    FontAnimatorPalette paletteControl;
    FontCallback callback;
    void *callbackContext;
    FontUnknown2058D78 *unknownList;
};

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED GXRgb FontAnimator__Palettes[9][4];

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void FontAnimator__Init(FontAnimator *work);
NOT_DECOMPILED void FontAnimator__LoadFont1(FontAnimator *work, struct FontWindow_ *window, u32 flags, u16 a4, u16 a5, u16 width, u16 height, BOOL useEngineB, u8 bgID, u8 a10,
                                            u32 a11);
NOT_DECOMPILED void FontAnimator__LoadFont2(FontAnimator *work, struct FontWindow_ *window, u32 flags, u16 a4, u16 a5, u16 width, u16 height, BOOL useEngineB, u8 bgID, u8 a10,
                                            u32 a11);
NOT_DECOMPILED void FontAnimator__Release(FontAnimator *work);
NOT_DECOMPILED void FontAnimator__EnableFlags(FontAnimator *work, u32 flags);
NOT_DECOMPILED void FontAnimator__DisableFlags(FontAnimator *work, u32 flags);
NOT_DECOMPILED void FontAnimator__LoadMPCFile(FontAnimator *work, void *file);
NOT_DECOMPILED void FontAnimator__SetCallbackType(FontAnimator *work, u32 type);
NOT_DECOMPILED void FontAnimator__InitStartPos(FontAnimator *work, s32 x, u16 align);
NOT_DECOMPILED void FontAnimator__AdvanceLine(FontAnimator *work, s16 a2);
NOT_DECOMPILED void FontAnimator__AdvanceXPos(FontAnimator *work, u16 a2);
NOT_DECOMPILED void FontAnimator__GetMsgPosition(FontAnimator *work, s16 *x, s16 *y);
NOT_DECOMPILED void FontAnimator__SetCallback(FontAnimator *work, FontCallback callback, void *context);
NOT_DECOMPILED void FontAnimator__SetMsgSequence(FontAnimator *work, u16 id);
NOT_DECOMPILED u32 FontAnimator__GetCurrentSequence(FontAnimator *work);
NOT_DECOMPILED u32 FontAnimator__GetSequenceDialogCount(FontAnimator *work);
NOT_DECOMPILED u32 FontAnimator__GetDialogLineCount(FontAnimator *work, u16 id);
NOT_DECOMPILED void FontAnimator__SetDialog(FontAnimator *work, u16 dialogID);
NOT_DECOMPILED u32 FontAnimator__GetDialogID(FontAnimator *work);
NOT_DECOMPILED void FontAnimator__LoadCharacters(FontAnimator *work, s32 count);
NOT_DECOMPILED BOOL FontAnimator__IsEndOfLine(FontAnimator *work);
NOT_DECOMPILED BOOL FontAnimator__AdvanceDialog(FontAnimator *work);
NOT_DECOMPILED BOOL FontAnimator__IsLastDialog(FontAnimator *work);
NOT_DECOMPILED void FontAnimator__ClearPixels(FontAnimator *work);
NOT_DECOMPILED void FontAnimator__Draw(FontAnimator *work);
NOT_DECOMPILED void FontAnimator__LoadMappingsFunc(FontAnimator *work);
NOT_DECOMPILED void FontAnimator__LoadPaletteFunc(FontAnimator *work);
NOT_DECOMPILED void FontAnimator__LoadPaletteFunc2(FontAnimator *work);
NOT_DECOMPILED void FontAnimator__Func_2058D48(FontAnimator *work, s16 x, s16 y);

NOT_DECOMPILED void FontUnknown2058D78__Func_2058D54(FontUnknown2058D78 *work);
NOT_DECOMPILED void FontUnknown2058D78__Init(FontUnknown2058D78 *work, FontAnimator *parent, s32 a3, s16 a4, s16 a5, BOOL useEngineB, u8 a7, u8 a8, u8 a9);
NOT_DECOMPILED void FontUnknown2058D78__Release(FontUnknown2058D78 *work, FontAnimator *a2);
NOT_DECOMPILED void FontUnknown2058D78__EnableFlags(FontUnknown2058D78 *work, u32 mask);
NOT_DECOMPILED void FontUnknown2058D78__DisableFlags(FontUnknown2058D78 *work, u32 mask);
NOT_DECOMPILED void FontUnknown2058D78__LoadPalette2(FontUnknown2058D78 *work);
NOT_DECOMPILED void FontUnknown2058D78__Func_2058F2C(FontUnknown2058D78 *work, s16 x, s16 y);

NOT_DECOMPILED void FontAnimator__Apply0(void);
NOT_DECOMPILED void FontAnimator__Apply1(void);
NOT_DECOMPILED void FontAnimator__LoadMappings(void);
NOT_DECOMPILED void FontAnimator__LoadPalette(void);
NOT_DECOMPILED void FontAnimator__LoadPalette2(void);
NOT_DECOMPILED void FontAnimator__DefaultMessageCallback(void);
NOT_DECOMPILED void FontAnimator__MessageCallback(void);
NOT_DECOMPILED void FontAnimator__AddUnknown(void);
NOT_DECOMPILED void FontAnimator__RemoveUnknown(void);

#endif // RUSH_FONTANIMATOR_H
