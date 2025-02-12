
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
NOT_DECOMPILED void MessageController__AdvanceLine(MessageController *work, s16 advance);
NOT_DECOMPILED void MessageController__SetCallbackValue(MessageController *work, u16 a2);
NOT_DECOMPILED void MessageController__InitStartPos(MessageController *work, s32 alignment, u16 startPos);
NOT_DECOMPILED void MessageController__SetClearPixelCallback(MessageController *work, void (*callback)(void *context), void *context);
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
NOT_DECOMPILED void MessageController__SetPosition(MessageController *work, s16 x, s16 y);
NOT_DECOMPILED void MessageController__SetPosX(MessageController *work);
NOT_DECOMPILED void MessageController__GetPosition(MessageController *work);
NOT_DECOMPILED void MessageController__LoadCharacters(MessageController *work);
NOT_DECOMPILED void MessageController__Func_205416C(MessageController *work, s32 a2);
NOT_DECOMPILED BOOL MessageController__IsLastDialog(MessageController *work);
NOT_DECOMPILED BOOL MessageController__IsEndOfLine(MessageController *work);
NOT_DECOMPILED void MessageController__AdvanceDialog(MessageController *work);
NOT_DECOMPILED void MessageController__AdvanceLineID(MessageController *work);
NOT_DECOMPILED void MessageController__ClearPixels(MessageController *work);
NOT_DECOMPILED BOOL MessageController__UnknownIsValid1(MessageController *work);
NOT_DECOMPILED BOOL MessageController__UnknownIsValid2(MessageController *work);
NOT_DECOMPILED s32 MessageController__GetUnknown(MessageController *work);
NOT_DECOMPILED s32 MessageController__GetLineWidthEx(void *work, u16 sequenceID, u16 dialogID, u16 lineID, void *fontFile);
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
