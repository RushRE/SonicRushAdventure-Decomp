#ifndef RUSH_CVIEVTCMN_HPP
#define RUSH_CVIEVTCMN_HPP

#include <game/text/fontAnimator.h>
#include <game/text/fontWindowAnimator.h>
#include <game/text/fontWindowMWControl.h>
#include <game/graphics/sprite.h>
#include <game/input/touchField.h>
#include <hub/viMessageController.h>

// --------------------
// STRUCTS
// --------------------

class CViEvtCmnMsg
{
public:
    CViEvtCmnMsg();
    virtual ~CViEvtCmnMsg();

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
    u16 word1A;
    u32 field_1C;
    FontAnimator fontAnimator;
    FontWindowAnimator fontWindowAnimator;
    AnimatorSprite aniName;
    VRAMPixelKey vramName;
    void *sprName;
    AnimatorSprite aniNextButton;
    VRAMPixelKey vramNextButton;
    void *sprNextButton;
    BOOL nextButtonState;
    BOOL autoAdvanceFlag;
    TouchArea touchArea;
    TouchField touchField;
    u32 field_278;
    u32 timer;
    s32 field_280;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------
};

class CViEvtCmnSelect
{
public:
    CViEvtCmnSelect();
    virtual ~CViEvtCmnSelect();

    // --------------------
    // VARIABLES
    // --------------------

    u32 dialogState;
    u32 nextDialogState;
    s32 field_C;
    void *mpcFile;
    u16 dialogID;
    s16 field_16;
    s32 field_18;
    u16 selection;
    u16 selectionCount;
    s16 field_20;
    s16 field_22;
    s16 field_24;
    s16 field_26;
    s16 field_28;
    s16 field_2A;
    s16 field_2C;
    s16 field_2E;
    s16 field_30;
    s16 field_32;
    FontAnimator fontAnimator;
    FontWindowAnimator fontWindowAnimator;
    FontWindowMWControl fontWindowMWControl;
    AnimatorSprite aniSprite1;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------
};

class CViEvtCmnAnnounce
{
public:
    CViEvtCmnAnnounce();
    virtual ~CViEvtCmnAnnounce();

    // --------------------
    // VARIABLES
    // --------------------

    u16 dialogState;
    u16 prevDialogState;
    u16 timer;
    s16 field_A;
    void *mpcFile;
    s16 field_10;
    s16 field_12;
    s16 field_14;
    s16 field_16;
    s16 field_18;
    s16 field_1A;
    s16 field_1C;
    s16 field_1E;
    s16 field_20;
    s16 field_22;
    FontAnimator fontAnimator;
    FontWindowAnimator fontWindowAnimator;
    u32 sfx;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------
};

class CViEvtCmnTalk
{
public:
    CViEvtCmnTalk();
    virtual ~CViEvtCmnTalk();

    // --------------------
    // VARIABLES
    // --------------------

    s16 dialogState;
    u16 ctrlEntry3Value1;
    u16 ctrlEntry3Value2;
    u16 interactionID;
    u16 pageID;
    s16 field_E;
    void *msgText;
    void *msgCtrlFile;
    ViMessageController msgCtrl;
    CViEvtCmnMsg evtCmnMsg;
    CViEvtCmnSelect evtCmnSelect;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------
};

// --------------------
// FUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

// CViEvtCmnMsg
void ViEvtCmnMsg__Func_216B9D4(void);
void ViEvtCmnMsg__ReleaseGraphics(CViEvtCmnMsg *work);
void ViEvtCmnMsg__Func_216BCA8(void);
void ViEvtCmnMsg__Func_216BCDC(void);
void ViEvtCmnMsg__Func_216BD70(void);
void ViEvtCmnMsg__Func_216BD7C(void);
void ViEvtCmnMsg__Func_216BD98(void);
void ViEvtCmnMsg__Func_216BDA0(void);
void ViEvtCmnMsg__Func_216BED8(void);
void ViEvtCmnMsg__Func_216BF00(void);
void ViEvtCmnMsg__Func_216BF20(void);
void ViEvtCmnMsg__Func_216BF2C(void);
void ViEvtCmnMsg__Func_216BF3C(void);
void ViEvtCmnMsg__Func_216BF58(void);
void ViEvtCmnMsg__Func_216BFA0(void);
void ViEvtCmnMsg__Func_216BFE8(void);
void ViEvtCmnMsg__Func_216C044(void);
void ViEvtCmnMsg__Func_216C2C4(void);
void ViEvtCmnMsg__Func_216C2D4(void);
void ViEvtCmnMsg__Func_216C31C(void);
void ViEvtCmnMsg__Func_216C36C(void);
void ViEvtCmnMsg__Func_216C3B4(void);
void ViEvtCmnMsg__Func_216C3B8(void);
void ViEvtCmnMsg__Func_216C3F4(void);
void ViEvtCmnMsg__Func_216C410(void);
void ViEvtCmnMsg__Func_216C448(void);
void ViEvtCmnMsg__Func_216C4D4(void);
void ViEvtCmnMsg__Func_216C4F4(void);
void ViEvtCmnMsg__Func_216C510(void);

// CViEvtCmnSelect
void ViEvtCmnSelect__Func_216C5C0(void);
void ViEvtCmnSelect__Func_216C70C(CViEvtCmnSelect *work);
void ViEvtCmnSelect__Func_216C79C(void);
void ViEvtCmnSelect__Func_216C7B4(void);
void ViEvtCmnSelect__Func_216C92C(void);
void ViEvtCmnSelect__Func_216C940(void);
void ViEvtCmnSelect__Func_216C948(void);
void ViEvtCmnSelect__Func_216CAA4(void);
void ViEvtCmnSelect__Func_216CAAC(void);
void ViEvtCmnSelect__Func_216CAF0(void);
void ViEvtCmnSelect__Func_216CB28(void);
void ViEvtCmnSelect__Func_216CB64(void);
void ViEvtCmnSelect__Func_216CB88(void);
void ViEvtCmnSelect__Func_216CBA0(void);
void ViEvtCmnSelect__Func_216CD5C(void);
void ViEvtCmnSelect__Func_216CD60(void);
void ViEvtCmnSelect__Func_216CDE8(void);
void ViEvtCmnSelect__Func_216CE2C(void);
void ViEvtCmnSelect__Func_216CE64(void);
void ViEvtCmnSelect__Func_216CE68(void);
void ViEvtCmnSelect__Func_216CE7C(void);
void ViEvtCmnSelect__Func_216CE98(void);
void ViEvtCmnSelect__Func_216CEB4(void);
void ViEvtCmnSelect__Func_216CF08(void);

// CViEvtCmnAnnounce
void ViEvtCmnAnnounce__Func_216D088(void);
void ViEvtCmnAnnounce__Func_216D194(CViEvtCmnAnnounce *work);
void ViEvtCmnAnnounce__Func_216D1F4(void);
void ViEvtCmnAnnounce__Func_216D208(void);
void ViEvtCmnAnnounce__Func_216D2E8(void);
void ViEvtCmnAnnounce__Func_216D318(void);
void ViEvtCmnAnnounce__Func_216D38C(void);
void ViEvtCmnAnnounce__Func_216D3CC(void);
void ViEvtCmnAnnounce__Func_216D440(void);
void ViEvtCmnAnnounce__Func_216D4E8(void);
void ViEvtCmnAnnounce__Func_216D558(void);
void ViEvtCmnAnnounce__Func_216D598(void);
void ViEvtCmnAnnounce__Func_216D5DC(void);

// CViEvtCmnTalk
void ViEvtCmnTalk__Func_216D680(void);
void ViEvtCmnTalk__Func_216D72C(CViEvtCmnTalk *work);
void ViEvtCmnTalk__Func_216D778(void);
void ViEvtCmnTalk__Func_216D7D0(void);
void ViEvtCmnTalk__Func_216D81C(void);
void ViEvtCmnTalk__Func_216D888(void);
void ViEvtCmnTalk__Func_216D89C(void);
void ViEvtCmnTalk__Func_216D8A4(void);
void ViEvtCmnTalk__Func_216D8AC(void);
void ViEvtCmnTalk__Func_216D8BC(void);
void ViEvtCmnTalk__Func_216D944(void);
void ViEvtCmnTalk__Func_216DA64(void);
void ViEvtCmnTalk__Func_216DBC8(void);
void ViEvtCmnTalk__Func_216DC0C(void);
void ViEvtCmnTalk__Func_216DC14(void);
void ViEvtCmnTalk__Func_216DC84(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIEVTCMN_HPP