
#ifndef RUSH_MESSAGECONTROLLER_H
#define RUSH_MESSAGECONTROLLER_H

#include <game/text/fontField9C.h>
#include <game/math/mtMath.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// STRUCTS
// --------------------

typedef struct MessageController_
{
    u8 field_0;
    u8 field_1;
    u8 field_2;
    u8 field_3;
    Vec2Fx16 field_4;
    Vec2Fx16 position;
    u16 sequenceID;
    u16 dialogID;
    u16 mpcLineID;
    u16 mpcTextOffset;
    u16 displayLineLength;
    u16 lineLength;
    FontField_9C unknown[2];
    u32 alignment;
    s16 startX;
    u16 field_2E;
    u16 fontPixelHeight;
    u16 callbackValue;
    u8 *pixels;
    u32 pixelSize;
    u16 width;
    u16 height;
    u32 field_40;
    u16 field_44;
    u16 field_46;
    u32 field_48;
    u16 field_4C;
    u16 field_4E;
    u16 field_50;
    u16 field_52;
    u16 field_54;
    u16 field_56;
    void (*clearPixelCallback)(void *context);
    BOOL clearedPixels;
    void *clearPixelContext;
    void *mpcFile;
    struct FontWindow_ *fontFile;
    void *callbackContext;
    void (*callback)(int, struct MessageController_ *, void *);
} MessageController;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void MessageController__Init(MessageController *work);
NOT_DECOMPILED void MessageController__SetFont(MessageController *work, void *file);
NOT_DECOMPILED void MessageController__LoadMPCFile(MessageController *work, void *file);
NOT_DECOMPILED void MessageController__Setup(MessageController *work, void *pixels, s32 width, s32 height, u16 a5, u16 a6, s32 a7);
NOT_DECOMPILED void MessageController__AdvanceLine(MessageController *work, u16 a2);
NOT_DECOMPILED void MessageController__SetCallbackValue(MessageController *work, u16 a2);
NOT_DECOMPILED void MessageController__InitStartPos(MessageController *work, s32 alignment, u16 startPos);
NOT_DECOMPILED void MessageController__SetClearPixelCallback(MessageController *work, s32 a2, s32 a3);
NOT_DECOMPILED void MessageController__SetCallback(MessageController *work, void (*callback)(int, MessageController *work, void *context), void *context);
NOT_DECOMPILED void MessageController__InitFunc(MessageController *work);
NOT_DECOMPILED void MessageController__GetSequenceCount(MessageController *work);
NOT_DECOMPILED void MessageController__SetSequence(MessageController *work, u16 id);
NOT_DECOMPILED u16 MessageController__GetCurrentSequence(MessageController *work);
NOT_DECOMPILED u16 MessageController__GetSequenceDialogCount(MessageController *work);
NOT_DECOMPILED void MessageController__SetDialog(MessageController *work, u16 id);
NOT_DECOMPILED u16 MessageController__GetDialogID(MessageController *work);
NOT_DECOMPILED u16 MessageController__GetDialogLineCount(MessageController *work);
NOT_DECOMPILED void MessageController__SetLineID(MessageController *work, u16 id);
NOT_DECOMPILED s32 MessageController__GetLineWidth(MessageController *work);
NOT_DECOMPILED void MessageController__SetPosition(void);
NOT_DECOMPILED void MessageController__SetPosX(void);
NOT_DECOMPILED void MessageController__GetPosition(void);
NOT_DECOMPILED void MessageController__LoadCharacters(void);
NOT_DECOMPILED void MessageController__Func_205416C(void);
NOT_DECOMPILED void MessageController__IsLastDialog(void);
NOT_DECOMPILED void MessageController__IsEndOfLine(void);
NOT_DECOMPILED void MessageController__AdvanceDialog(void);
NOT_DECOMPILED void MessageController__AdvanceLineID(void);
NOT_DECOMPILED void MessageController__ClearPixels(void);
NOT_DECOMPILED void MessageController__UnknownIsValid1(void);
NOT_DECOMPILED void MessageController__UnknownIsValid2(void);
NOT_DECOMPILED void MessageController__GetUnknown(void);
NOT_DECOMPILED void MessageController__GetLineWidthEx(void);
NOT_DECOMPILED void MessageController__GetStartPos(void);
NOT_DECOMPILED void MessageController__ClearUnknown(void);
NOT_DECOMPILED void MessageController__ResetUnknown(void);
NOT_DECOMPILED void MessageController__ApplyUnknown(void);
NOT_DECOMPILED void MessageController__SetUnknown(void);
NOT_DECOMPILED void MessageController__ValidateUnknown(void);
NOT_DECOMPILED void MessageController__RunCallback(void);
NOT_DECOMPILED void MessageController__DrawCharacter(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_MESSAGECONTROLLER_H
