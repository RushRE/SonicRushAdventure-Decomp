#ifndef RUSH_CVIEVTCMN_HPP
#define RUSH_CVIEVTCMN_HPP

#include <game/text/fontAnimator.h>
#include <game/text/fontWindowAnimator.h>
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
    u32 vramName;
    void *sprName;
    AnimatorSprite aniNextButton;
    u32 vramNextButton;
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
    FontAnimator fontAni1;
    FontWindowAnimator fontAni2;
    s32 field_15C;
    s32 field_160;
    s32 field_164;
    s32 field_168;
    s32 field_16C;
    s32 field_170;
    s32 field_174;
    s32 field_178;
    s32 field_17C;
    s32 field_180;
    s32 field_184;
    s32 field_188;
    s32 field_18C;
    s32 field_190;
    s32 field_194;
    s32 field_198;
    s32 field_19C;
    s32 field_1A0;
    s32 field_1A4;
    s32 field_1A8;
    s32 field_1AC;
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
NOT_DECOMPILED void ViEvtCmnMsg__Constructor(void);
NOT_DECOMPILED void ViEvtCmnMsg__VTableFunc_216B98C(void);
NOT_DECOMPILED void ViEvtCmnMsg__VTableFunc_216B9AC(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216B9D4(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216BC08(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216BCA8(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216BCDC(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216BD70(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216BD7C(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216BD98(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216BDA0(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216BED8(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216BF00(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216BF20(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216BF2C(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216BF3C(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216BF58(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216BFA0(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216BFE8(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216C044(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216C2C4(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216C2D4(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216C31C(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216C36C(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216C3B4(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216C3B8(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216C3F4(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216C410(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216C448(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216C4D4(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216C4F4(void);
NOT_DECOMPILED void ViEvtCmnMsg__Func_216C510(void);

// CViEvtCmnSelect
NOT_DECOMPILED void ViEvtCmnSelect__Constructor(void);
NOT_DECOMPILED void ViEvtCmnSelect__VTableFunc_216C578(void);
NOT_DECOMPILED void ViEvtCmnSelect__VTableFunc_216C598(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216C5C0(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216C70C(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216C79C(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216C7B4(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216C92C(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216C940(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216C948(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216CAA4(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216CAAC(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216CAF0(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216CB28(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216CB64(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216CB88(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216CBA0(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216CD5C(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216CD60(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216CDE8(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216CE2C(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216CE64(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216CE68(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216CE7C(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216CE98(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216CEB4(void);
NOT_DECOMPILED void ViEvtCmnSelect__Func_216CF08(void);

// CViEvtCmnAnnounce
NOT_DECOMPILED void ViEvtCmnAnnounce__Constructor(void);
NOT_DECOMPILED void ViEvtCmnAnnounce__VTableFunc_216D040(void);
NOT_DECOMPILED void ViEvtCmnAnnounce__VTableFunc_216D060(void);
NOT_DECOMPILED void ViEvtCmnAnnounce__Func_216D088(void);
NOT_DECOMPILED void ViEvtCmnAnnounce__Func_216D194(void);
NOT_DECOMPILED void ViEvtCmnAnnounce__Func_216D1F4(void);
NOT_DECOMPILED void ViEvtCmnAnnounce__Func_216D208(void);
NOT_DECOMPILED void ViEvtCmnAnnounce__Func_216D2E8(void);
NOT_DECOMPILED void ViEvtCmnAnnounce__Func_216D318(void);
NOT_DECOMPILED void ViEvtCmnAnnounce__Func_216D38C(void);
NOT_DECOMPILED void ViEvtCmnAnnounce__Func_216D3CC(void);
NOT_DECOMPILED void ViEvtCmnAnnounce__Func_216D440(void);
NOT_DECOMPILED void ViEvtCmnAnnounce__Func_216D4E8(void);
NOT_DECOMPILED void ViEvtCmnAnnounce__Func_216D558(void);
NOT_DECOMPILED void ViEvtCmnAnnounce__Func_216D598(void);
NOT_DECOMPILED void ViEvtCmnAnnounce__Func_216D5DC(void);

// CViEvtCmnTalk
NOT_DECOMPILED void ViEvtCmnTalk__Constructor(void);
NOT_DECOMPILED void ViEvtCmnTalk__VTableFunc_216D618(void);
NOT_DECOMPILED void ViEvtCmnTalk__VTableFunc_216D648(void);
NOT_DECOMPILED void ViEvtCmnTalk__Func_216D680(void);
NOT_DECOMPILED void ViEvtCmnTalk__Func_216D72C(void);
NOT_DECOMPILED void ViEvtCmnTalk__Func_216D778(void);
NOT_DECOMPILED void ViEvtCmnTalk__Func_216D7D0(void);
NOT_DECOMPILED void ViEvtCmnTalk__Func_216D81C(void);
NOT_DECOMPILED void ViEvtCmnTalk__Func_216D888(void);
NOT_DECOMPILED void ViEvtCmnTalk__Func_216D89C(void);
NOT_DECOMPILED void ViEvtCmnTalk__Func_216D8A4(void);
NOT_DECOMPILED void ViEvtCmnTalk__Func_216D8AC(void);
NOT_DECOMPILED void ViEvtCmnTalk__Func_216D8BC(void);
NOT_DECOMPILED void ViEvtCmnTalk__Func_216D944(void);
NOT_DECOMPILED void ViEvtCmnTalk__Func_216DA64(void);
NOT_DECOMPILED void ViEvtCmnTalk__Func_216DBC8(void);
NOT_DECOMPILED void ViEvtCmnTalk__Func_216DC0C(void);
NOT_DECOMPILED void ViEvtCmnTalk__Func_216DC14(void);
NOT_DECOMPILED void ViEvtCmnTalk__Func_216DC84(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIEVTCMN_HPP