#ifndef RUSH2_NAMEMENU_H
#define RUSH2_NAMEMENU_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/graphics/background.h>
#include <game/input/touchField.h>
#include <game/graphics/unknown2056570.h>
#include <game/text/fontWindow.h>
#include <game/save/saveGame.h>

// --------------------
// STRUCTS
// --------------------

typedef struct NameMenuWorker_
{
    s32 field_0;
    u32 flags;
    s32 textPageID;
    BOOL isActive;
    BOOL applyName;
    s32 field_14;
    s32 selectionTimer;
    char16 name[SAVEGAME_MAX_NAME_LEN];
    s32 nameLength;
    u16 cursorX;
    u16 cursorY;
    s32 field_34;
    s32 menuSelection;
    s32 field_3C[3];
    s32 currentPageID;
    Background background;
    Background backgrounds[7];
    AnimatorSprite aniSprites[27];
    void (*state)(struct NameMenuWorker_ *work);
    u32 field_D1C[5];
    TouchArea touchAreas[3];
    TouchField touchField;
    void *archiveDmni;
    FontWindow *fontWindowPtr;
    Unknown2056570 field_DF8;
    void *field_E28;
    Task *task;
} NameMenuWorker;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void NameMenu__LoadAssets(void);
NOT_DECOMPILED void NameMenu__Create(u32 flags, SavePlayerName *name, FontWindow *fontWindow);
NOT_DECOMPILED BOOL NameMenu__IsFinished(void);
NOT_DECOMPILED BOOL NameMenu__ShouldApplyName(void);
NOT_DECOMPILED SavePlayerName *NameMenu__GetName(void);
NOT_DECOMPILED void NameMenu__ReleaseAssets(void);
NOT_DECOMPILED void NameMenu__Init(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__SetupDisplay(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__InitAnimators(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__InitBackgrounds(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__InitUnknown2056570(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__InitTouchField(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__ThreadFunc(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__InitAnimator(NameMenuWorker *work, void *fileData, BOOL useEngineB, BOOL disableLooping, BOOL enableScale,
                                           u32 (*getSpriteSize)(void *fileData, BOOL useEngineB), u16 animID, u16 paletteRow, u8 oamPriority, u8 oamOrder);
NOT_DECOMPILED void NameMenu__InitFontWindow(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__Release(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__ResetDisplay(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__ReleaseAnimators(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__ReleaseBackgrounds(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__ReleaseUnknown2056570(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__ReleaseTouchField(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__Main_Loading(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__Main_Active(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__Destructor(Task *task);
NOT_DECOMPILED void NameMenu__State_FadeIn(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__State_Active(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__State_FadeOut(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__SetCharacter(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__DeleteCharacter(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__Func_215FFE8(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__Func_2160028(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__Func_2160068(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__Func_21600A8(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__DrawCharacterCursor(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__InitName(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__Func_2160218(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__UpdateTextPage(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__SetTextPage(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__SetCharacterSelection(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__SetMenuSelection(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__ChangePageVariant_JPN_Hiragana(NameMenuWorker *work, s32 a2);
NOT_DECOMPILED void NameMenu__ChangePageVariant_JPN_Katakana(NameMenuWorker *work, s32 a2);
NOT_DECOMPILED void NameMenu__ChangePageVariant_ENG_Lower(NameMenuWorker *work, s32 a2);
NOT_DECOMPILED void NameMenu__ChangePageVariant_ENG_Upper(NameMenuWorker *work, s32 a2);
NOT_DECOMPILED void NameMenu__SetUnknown(NameMenuWorker *work, s32 id, BOOL flag);
NOT_DECOMPILED BOOL NameMenu__DrawMenuInitial(NameMenuWorker *work);
NOT_DECOMPILED BOOL NameMenu__DrawPageSelectionsInitial(NameMenuWorker *work, s32 timer);
NOT_DECOMPILED BOOL NameMenu__DrawMenuOptionsInitial(NameMenuWorker *work, s32 timer);
NOT_DECOMPILED void NameMenu__DrawMenu(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__DrawPageVariants_JPN(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__DrawPageVariants_ENG(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__DrawPageSelections(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__DrawMenuOptions(NameMenuWorker *work);
NOT_DECOMPILED BOOL NameMenu__CheckPageChange(NameMenuWorker *work);
NOT_DECOMPILED BOOL NameMenu__GetCursorPositionFromTouch(NameMenuWorker *work, fx16 *x, fx16 *y);
NOT_DECOMPILED s32 NameMenu__GetMenuSelectionFromTouch(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__SetupBlending(NameMenuWorker *work);
NOT_DECOMPILED void NameMenu__GetCharacter_JPN_Hiragana(fx16 x, fx16 y);
NOT_DECOMPILED void NameMenu__GetCharacter_JPN_Katakana(fx16 x, fx16 y);
NOT_DECOMPILED void NameMenu__GetCharacter_ENG_Lower(fx16 x, fx16 y);
NOT_DECOMPILED void NameMenu__GetCharacter_ENG_Upper(fx16 x, fx16 y);
NOT_DECOMPILED void NameMenu__GetCharacter_Latin(fx16 x, fx16 y);
NOT_DECOMPILED void NameMenu__GetCharacter_Symbols(fx16 x, fx16 y);
NOT_DECOMPILED void NameMenu__GetCharacter_Icons(fx16 x, fx16 y);
NOT_DECOMPILED char16 NameMenu__GetCharacterFromIndex(char16 character);
NOT_DECOMPILED char16 NameMenu__Func_2160DDC(char16 character);
NOT_DECOMPILED char16 NameMenu__Func_2160DF8(char16 character);
NOT_DECOMPILED char16 NameMenu__Func_2160E14(char16 character);
NOT_DECOMPILED s32 NameMenu__GetNameLength(SavePlayerName *name, s32 maxLength);

#endif // RUSH2_NAMEMENU_H
