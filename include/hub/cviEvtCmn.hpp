#ifndef RUSH_CVIEVTCMN_HPP
#define RUSH_CVIEVTCMN_HPP

#include <game/text/fontAnimator.h>
#include <game/text/fontWindowAnimator.h>
#include <game/text/fontWindowMWControl.h>
#include <game/graphics/sprite.h>
#include <game/input/touchField.h>
#include <hub/cviMessageController.hpp>

// --------------------
// CONSTANTS/MACROS
// --------------------

#define CVIEVTCMN_RESOURCE_NONE (u16)(-1)

// --------------------
// STRUCTS
// --------------------

#ifdef __cplusplus

class CViEvtCmnMsg
{
public:
    CViEvtCmnMsg();
    virtual ~CViEvtCmnMsg();

    // --------------------
    // ENUMS
    // --------------------

    enum DialogState
    {
        DIALOGSTATE_INIT,
        DIALOGSTATE_OPENING_WINDOW,
        DIALOGSTATE_REVEALING_TEXT,
        DIALOGSTATE_SHOW_TEXT,
        DIALOGSTATE_UNUSED1,
        DIALOGSTATE_CLOSING_WINDOW,
        DIALOGSTATE_CLOSED_WINDOW,
        DIALOGSTATE_UNUSED2,
        DIALOGSTATE_DONE,
    };

    enum NextButtonState
    {
        NEXTBTNSTATE_INACTIVE,
        NEXTBTNSTATE_DISABLED,
        NEXTBTNSTATE_PROMPTING,
        NEXTBTNSTATE_HELD,
    };

    // --------------------
    // VARIABLES
    // --------------------

    u32 dialogState;
    u32 nextDialogState;
    void *mpcFile;
    u16 sequenceID;
    u16 nameAnimID;
    u16 nextSequence;
    u16 nextNameAnimID;
    u16 prevNameAnimID;
    u16 unused;
    BOOL isLastSequence;
    FontAnimator fontAnimator;
    FontWindowAnimator fontWindowAnimator;
    AnimatorSprite aniName;
    VRAMPixelKey vramName;
    void *sprName;
    AnimatorSprite aniNextButton;
    VRAMPixelKey vramNextButton;
    void *sprNextButton;
    u32 nextButtonState;
    BOOL autoAdvanceFlag;
    TouchArea touchArea;
    TouchField touchField;
    BOOL dialogStateChanged;
    u32 timer;
    BOOL allowBackPress;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void Init(void *mpcFile);
    void Release();
    void SetSequence(u16 sequence, u16 nameAnimID, u16 nextSequence, u16 nextName, BOOL isLastSequence);
    void SetSequenceFromMPC(u16 sequence, u16 nameAnimID, u16 nextSequence, u16 nextName, BOOL isLastSequence);
    void SetNextSequence(u16 nextSequence, u16 nextNameAnimID);
    BOOL HasNoNextSequence();
    void SetIsLastSequence(BOOL isLastSequence);
    void ProcessDialog();
    BOOL CheckIdle();
    void TrySetNextButtonState(u32 a2);
    void SetAutoAdvance();

    void InitDialogState_Init();
    s32 DialogState_Init();
    void InitDialogState_OpenWindow();
    s32 DialogState_OpenWindow();
    void InitDialogState_ProcessTextReveal();
    s32 DialogState_ProcessTextReveal();
    void InitDialogState_ShowText();
    s32 DialogState_ShowText();
    void InitDialogState_CloseWindow();
    s32 DialogState_CloseWindow();
    void InitDialogState_ClosedWindow();
    s32 DialogState_ClosedWindow();

    BOOL CheckConfirmBtnPress();
    BOOL CheckBackBtnPress();
    void SetNextButtonState(s32 state);
    void ProcessNextButtonAnimation();
    void DrawNextButton();
    BOOL ShouldAutoAdvance();

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void SpriteCallback(BACFrameGroupBlockHeader *block, AnimatorSprite *animator, void *userData);
    static void TouchAreaCallback(TouchAreaResponse *responce, TouchArea *area, void *userData);
};

class CViEvtCmnSelect
{
public:
    CViEvtCmnSelect();
    virtual ~CViEvtCmnSelect();

    // --------------------
    // ENUMS
    // --------------------

    enum DialogState
    {
        DIALOGSTATE_INIT,
        DIALOGSTATE_OPENING_WINDOW,
        DIALOGSTATE_PREPARE_CHARS,
        DIALOGSTATE_SELECTION_ACTIVE,
        DIALOGSTATE_SELECTION_MADE,
        DIALOGSTATE_CLOSING_WINDOW,
        DIALOGSTATE_CLOSED_WINDOW,
        DIALOGSTATE_UNUSED1,
        DIALOGSTATE_FINISHED,
    };

    // --------------------
    // VARIABLES
    // --------------------

    u32 dialogState;
    u32 nextDialogState;
    u32 timer;
    void *mpcFile;
    u16 sequence;
    u16 field_16;
    s32 dialogStateChanged;
    u16 selection;
    u16 selectionCount;
    u16 prevTouchSelection;
    u16 unused22;
    u16 lineWidthInner;
    u16 lineHeightInnter;
    u16 windowWidth;
    u16 windowHeight;
    u16 lineStart;
    u16 lineHeight;
    u16 lineSize;
    u16 field_32;
    FontAnimator fontAnimator;
    FontWindowAnimator fontWindowAnimator;
    FontWindowMWControl fontWindowMWControl;
    AnimatorSprite aniSprite1;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void Init(void *mpcFile);
    void Release();
    void SetSequence(u16 id);
    void ProcessDialog();
    BOOL CheckFinished();
    u16 GetSelection();

    void InitDialogState_Init();
    s32 DialogState_Init();
    void InitDialogState_OpeningWindow();
    s32 DialogState_OpeningWindow();
    void InitDialogState_PrepareCharacters();
    s32 DialogState_PrepareCharacters();
    void InitDialogState_SelectionActive();
    s32 DialogState_SelectionActive();
    void InitDialogState_SelectionMade();
    s32 DialogState_SelectionMade();
    void InitDialogState_ClosingWindow();
    s32 DialogState_ClosingWindow();
    void InitDialogState_ClosedWindow();
    s32 DialogState_ClosedWindow();

    BOOL CheckConfirmBtnPress();
    BOOL CheckBackBtnPress();
    s32 HandleBtnSelectionControl();
    s32 HandleTouchSelectionControl(BOOL usePush);
};

class CViEvtCmnAnnounce
{
public:
    CViEvtCmnAnnounce();
    virtual ~CViEvtCmnAnnounce();

    // --------------------
    // ENUMS
    // --------------------

    enum DialogState
    {
        DIALOGSTATE_IDLE,
        DIALOGSTATE_OPENING_WINDOW,
        DIALOGSTATE_SHOW_TEXT,
        DIALOGSTATE_CLOSING_WINDOW,
        DIALOGSTATE_CLOSED_WINDOW,
        DIALOGSTATE_INACTIVE,
    };

    // --------------------
    // VARIABLES
    // --------------------

    u16 dialogState;
    u16 prevDialogState;
    u16 timer;
    u16 msgSequence;
    void *mpcFile;
    s16 unused10;
    s16 unused12;
    s16 unused14;
    s16 unused16;
    s16 unused18;
    s16 unused1A;
    s16 unused1C;
    s16 unused1E;
    s16 startPos;
    FontAnimator fontAnimator;
    FontWindowAnimator fontWindowAnimator;
    s32 sfx;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void Init(void *mpcFile);
    void Release();
    void SetSequence(u16 msgSequence, u16 sfx);
    void Process();
    BOOL CheckIdle();

    void InitDialogState_OpeningWindow();
    s32 DialogState_OpeningWindow();
    void InitDialogState_ShowText();
    s32 DialogState_ShowText();
    void InitDialogState_ClosingWindow();
    s32 DialogState_ClosingWindow();
    void InitDialogState_ClosedWindow();
    s32 DialogState_ClosedWindow();
};

class CViEvtCmnTalk
{
public:
    CViEvtCmnTalk();
    virtual ~CViEvtCmnTalk();

    // --------------------
    // ENUMS
    // --------------------

    enum DialogState
    {
        DIALOGSTATE_INACTIVE,
        DIALOGSTATE_INIT,
        DIALOGSTATE_REVEALING_TEXT,
        DIALOGSTATE_SELECTION_ACTIVE,
        DIALOGSTATE_FINALIZE_ACTIONS,
        DIALOGSTATE_FINISHED,
    };

    // --------------------
    // VARIABLES
    // --------------------

    u16 dialogState;
    u16 ctrlAction;
    u16 ctrlSelection;
    u16 interactionID;
    u16 pageID;
    void *msgText;
    void *msgCtrlFile;
    CViMessageController msgCtrl;
    CViEvtCmnMsg evtCmnMsg;
    CViEvtCmnSelect evtCmnSelect;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void Init(void *mpcCtrlFile, u16 interactionID, u16 interactionID2);
    void Release();
    u16 SetInteraction();
    void SetPage(u16 pageID);
    void ProcessDialog();
    BOOL IsFinished();
    s32 GetAction();
    s32 GetSelection();
    void SetCallback(FontCallback callback, void *context);

    s32 DialogState_Init();
    s32 DialogState_ProcessTextReveal();
    s32 DialogState_ProcessSelections();
    s32 DialogState_FinalizeActions();
    s32 DialogState_Finished();
};

#endif

#endif // RUSH_CVIEVTCMN_HPP