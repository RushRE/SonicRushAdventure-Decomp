#ifndef RUSH_CVIEVTCMNLIST_HPP
#define RUSH_CVIEVTCMNLIST_HPP

#include <game/text/fontWindow.h>
#include <game/text/fontWindowAnimator.h>
#include <game/text/fontWindowMWControl.h>
#include <game/text/messageController.h>
#include <game/graphics/sprite.h>
#include <game/input/touchField.h>

// --------------------
// CONSTANTS/MACROS
// --------------------

#define CVIEVTCMNLIST_SELECTION_NONE (-1)

// --------------------
// ENUMS
// --------------------

enum CViEvtCmnListConfigEntryFlag_
{
    CVIEVTCMNLISTENTRY_FLAG_NONE = 0x00,

    CVIEVTCMNLISTENTRY_FLAG_UNLOCKED  = 1 << 0,
    CVIEVTCMNLISTENTRY_FLAG_ATTEMPTED = 1 << 1,
    CVIEVTCMNLISTENTRY_FLAG_CLEARED   = 1 << 2,
};
typedef u8 CViEvtCmnListConfigEntryFlag;

// --------------------
// STRUCTS
// --------------------

#ifdef __cplusplus

typedef struct CViEvtCmnListConfigEntry_
{
    CViEvtCmnListConfigEntryFlag flags;
    u8 lineCount;
    u16 scrollPos;
    u16 sequence;
    u8 field_6;
    u8 field_7;
} CViEvtCmnListConfigEntry;

typedef struct CViEvtCmnListEntry_
{
    u16 flags;
    u16 id;
} CViEvtCmnListEntry;

typedef struct CViEvtCmnListConfig
{
    FontWindow *fontWindow;
    void *mpcFile;
    CViEvtCmnListEntry *entryList;
    u16 entryCount;
    u16 selection;
    void *sprMapLocHUD;
    void *sprMenu;
    void *sprBackButton;
    void *sprCursor;
    u16 headerAnim;
    u16 numDigitCount; // how many digits to display for entry numbers
    u16 windowSizeX;
    u16 windowSizeY;
    u16 windowFrame;
} CViEvtCmnListConfig;

class CViEvtCmnList
{
public:
    // --------------------
    // VARIABLES
    // --------------------

    u32 timer;
    CViEvtCmnListEntry *entryList;
    u16 entryCount;
    u16 currentSelection;
    u16 chosenSelection;
    u16 selectedEntry;
    s16 unused;
    s16 numDigitCount;
    u16 lastHeldTouchSelection;
    CViEvtCmnListConfig listConfig;
    BOOL isWindowOpen;
    BOOL isWindowAnimating;
    BOOL isWindowClosing;
    FontWindow *fontWindow;
    FontWindowAnimator fontWindowAnimator;
    FontWindowMWControl fontWindowMWControl;
    AnimatorSprite aniHeader;
    AnimatorSprite aniButtonUp;
    AnimatorSprite aniButtonDown;
    AnimatorSprite aniBackButton;
    AnimatorSprite aniCursor;
    MessageController msgController;
    void *listTextVRAMPixels;
    u32 listTextPixelSize;
    void *listTextPixels;
    GXScrText32x32 *listTextMappings;
    CViEvtCmnListConfigEntry *entries;
    s32 scrollPos;
    s32 prevScrollPos;
    u32 scrollPosLimit;
    u16 firstVisibleEntry;
    u16 lastVisibleEntry;
    BOOL unknownFlag;
    GXScrText32x32 *listEntryMappings;
    GXScrFmtText *listEntryMapping_EntryBG;
    GXScrFmtText *listEntryMapping_Unknown;
    GXScrFmtText *listEntryMapping_Blank;
    TouchField touchField;
    TouchArea touchArea[3];
    BOOL touchAreaEnabled[3];
    void (*state)(CViEvtCmnList *work);
    void (*prevState)(CViEvtCmnList *work);

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void Init();
    void Load(CViEvtCmnListConfig *config);
    void Release();
    void ShowWindow(s32 selection, BOOL flag);
    void Process();
    u16 GetSelection();
    BOOL IsWindowOpen();
    BOOL IsWindowClosing();
    BOOL CheckSelectionMade();
    BOOL IsFinished();
    u16 GetSelectedEntry();

private:
    void InitSprites(CViEvtCmnListConfig *config);
    void InitMappings(CViEvtCmnListConfig *config);
    void InitTouchField(CViEvtCmnListConfig *config);
    void ReleaseList();
    void ReleaseMappings();
    void ReleaseTouchField();
    void InitListTextGraphics();
    void UpdateListBorderMappings(u32 scrollPos, u16 entrySize);
    void UpdateListBackgroundMappings(u16 id);
    void UpdateListTextMappings(s32 id, s16 scroll, u16 sequence);
    s16 GetScrollDistance(s32 id, u32 scrollPos);
    u16 HandleTouchSelectionControl(BOOL usePush);
    void UpdateListBackgroundGraphics(u32 scrollPos);
    void GetVisibleEntryBounds(u32 scrollPos, u16 *firstVisibleEntry, u16 *lastVisibleEntry);
    void ApplyListTextGraphics(BOOL uncompressed);
    void ApplyListTextMappings();
    void ResetListTextBackground();
    void DrawHeader();
    void DrawSelectionBox(BOOL enabled);
    void SetSelectionBoxSelected(BOOL enabled);
    void DrawCursor(BOOL useChosenSelection);
    void InitCursor();
    void DrawUpDownButtons();
    void DrawBackButton();
    void UpdateListEntryMappings(u16 id);
    void ApplyListEntryMappings(BOOL uncompressed);
    void EnableAllTouchAreas(BOOL enabled);
    void EnableUpButtonTouchArea(BOOL enabled);
    void EnableDownButtonTouchArea(BOOL enabled);
    void EnableBackButtonTouchArea(BOOL enabled);
    BOOL CheckUpButtonTouchHeld();
    BOOL CheckDownButtonTouchHeld();
    BOOL CheckBackButtonTouchHeld();
    void SetListWindowVisible(BOOL enabled);
    void SetListTextVisible(BOOL enabled);
    void InitWindow(BOOL enabled);

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void PixelClearCallback(void *context);
    static void SpriteCallback(BACFrameGroupBlockHeader *block, AnimatorSprite *animator, void *userData);

    static void State_OpenWindow(CViEvtCmnList *work);
    static void State_ListActive(CViEvtCmnList *work);
    static void State_SelectionMade(CViEvtCmnList *work);
    static void State_CloseWindow(CViEvtCmnList *work);
    static void State_ClosedWindow(CViEvtCmnList *work);
    static void State_Finished(CViEvtCmnList *work);
    static void EnableKeyRepeat(BOOL enabled);
};

#endif

#endif // RUSH_CVIEVTCMNLIST_HPP