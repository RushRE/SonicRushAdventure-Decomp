#ifndef RUSH_NAMEMENU_H
#define RUSH_NAMEMENU_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/graphics/background.h>
#include <game/input/touchField.h>
#include <game/graphics/unknown2056570.h>
#include <game/text/fontWindow.h>
#include <game/save/saveGame.h>
#include <game/system/threadWorker.h>

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
    SavePlayerName name;
    s32 nameLength;
    u16 cursorX;
    u16 cursorY;
    s32 field_34;
    s32 menuSelection;
    s32 field_3C[3];
    s32 currentPageID;
    Background backgrounds[8];
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
    Thread thread;
} NameMenuWorker;

// --------------------
// FUNCTIONS
// --------------------

void NameMenu__LoadAssets(void);
void NameMenu__Create(u32 flags, SavePlayerName *name, FontWindow *fontWindow);
BOOL NameMenu__IsFinished(void);
BOOL NameMenu__ShouldApplyName(void);
SavePlayerName *NameMenu__GetName(void);
void NameMenu__ReleaseAssets(void);
void NameMenu__Init(NameMenuWorker *work);
void NameMenu__SetupDisplay(NameMenuWorker *work);
void NameMenu__InitAnimators(NameMenuWorker *work);
void NameMenu__InitBackgrounds(NameMenuWorker *work);
void NameMenu__InitUnknown2056570(NameMenuWorker *work);
void NameMenu__InitTouchField(NameMenuWorker *work);
void NameMenu__ThreadFunc(void *arg);
void NameMenu__InitAnimator(AnimatorSprite *work, void *fileData, BOOL useEngineB, BOOL disableLooping, BOOL enableScale, GetSpriteSizeFromAnimFunc getSpriteSize,
                                           u16 animID, u16 paletteRow, u8 oamPriority, u8 oamOrder);
void NameMenu__InitFontWindow(NameMenuWorker *work);
void NameMenu__Release(NameMenuWorker *work);
void NameMenu__ResetDisplay(NameMenuWorker *work);
void NameMenu__ReleaseAnimators(NameMenuWorker *work);
void NameMenu__ReleaseBackgrounds(NameMenuWorker *work);
void NameMenu__ReleaseUnknown2056570(NameMenuWorker *work);
void NameMenu__ReleaseTouchField(NameMenuWorker *work);
void NameMenu__Main_Loading(void);
void NameMenu__Main_Active(void);
void NameMenu__Destructor(Task *task);
void NameMenu__State_FadeIn(NameMenuWorker *work);
void NameMenu__State_Active(NameMenuWorker *work);
void NameMenu__State_FadeOut(NameMenuWorker *work);
void NameMenu__SetCharacter(NameMenuWorker *work, char16 character);
void NameMenu__DeleteCharacter(NameMenuWorker *work);
BOOL NameMenu__Func_215FFE8(NameMenuWorker *work);
BOOL NameMenu__Func_2160028(NameMenuWorker *work);
BOOL NameMenu__Func_2160068(NameMenuWorker *work);
void NameMenu__Func_21600A8(NameMenuWorker *work, u16 id, char16 character);
void NameMenu__DrawCharacterCursor(NameMenuWorker *work);
void NameMenu__InitName(NameMenuWorker *work);
void NameMenu__Func_2160218(NameMenuWorker *work, s32 a2);
void NameMenu__UpdateTextPage(NameMenuWorker *work, s32 page);
void NameMenu__SetTextPage(NameMenuWorker *work, s32 page);
void NameMenu__SetCharacterSelection(NameMenuWorker *work, s32 x, s32 y);
void NameMenu__SetMenuSelection(NameMenuWorker *work, s32 selectio);
void NameMenu__ChangePageVariant_JPN_Hiragana(NameMenuWorker *work, s32 a2);
void NameMenu__ChangePageVariant_JPN_Katakana(NameMenuWorker *work, s32 a2);
void NameMenu__ChangePageVariant_ENG_Lower(NameMenuWorker *work, s32 a2);
void NameMenu__ChangePageVariant_ENG_Upper(NameMenuWorker *work, s32 a2);
void NameMenu__SetUnknown(NameMenuWorker *work, s32 id, BOOL flag);
BOOL NameMenu__DrawMenuInitial(NameMenuWorker *work);
BOOL NameMenu__DrawPageSelectionsInitial(NameMenuWorker *work, s32 timer);
BOOL NameMenu__DrawMenuOptionsInitial(NameMenuWorker *work, s32 timer);
void NameMenu__DrawMenu(NameMenuWorker *work);
void NameMenu__DrawPageVariants_JPN(NameMenuWorker *work);
void NameMenu__DrawPageVariants_ENG(NameMenuWorker *work);
void NameMenu__DrawPageSelections(NameMenuWorker *work);
void NameMenu__DrawMenuOptions(NameMenuWorker *work);
BOOL NameMenu__CheckPageChange(NameMenuWorker *work);
BOOL NameMenu__GetCursorPositionFromTouch(NameMenuWorker *work, fx16 *x, fx16 *y);
s32 NameMenu__GetMenuSelectionFromTouch(NameMenuWorker *work);
void NameMenu__SetupBlending(NameMenuWorker *work, u16 alpha);
u16 NameMenu__GetCharacter_JPN_Hiragana(s32 x, s32 y);
u16 NameMenu__GetCharacter_JPN_Katakana(s32 x, s32 y);
u16 NameMenu__GetCharacter_ENG_Lower(s32 x, s32 y);
u16 NameMenu__GetCharacter_ENG_Upper(s32 x, s32 y);
u16 NameMenu__GetCharacter_Latin(s32 x, s32 y);
u16 NameMenu__GetCharacter_Symbols(s32 x, s32 y);
u16 NameMenu__GetCharacter_Icons(s32 x, s32 y);
char16 NameMenu__GetCharacterFromIndex(char16 character);
char16 NameMenu__Func_2160DDC(char16 character);
char16 NameMenu__Func_2160DF8(char16 character);
char16 NameMenu__Func_2160E14(char16 character);
u16 NameMenu__GetNameLength(SavePlayerName *name, s32 maxLength);

#endif // RUSH_NAMEMENU_H
