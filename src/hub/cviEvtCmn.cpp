#include <hub/cviEvtCmn.hpp>
#include <hub/hubAudio.h>
#include <game/input/padInput.h>
#include <game/file/fileUnknown.h>
#include <game/text/mpc.h>
#include <game/graphics/background.h>
#include <game/util/advancePrompt.h>

// resources
#include <resources/narc/vi_act_lz7.h>

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE BOOL CheckTouchPushEnabled()
{
    if (IsTouchInputEnabled())
    {
        if (TOUCH_HAS_PUSH(touchInput.flags))
            return TRUE;
    }

    return FALSE;
}

RUSH_INLINE BOOL CheckTouchPullEnabled()
{
    if (IsTouchInputEnabled())
    {
        if (TOUCH_HAS_PULL(touchInput.flags))
            return TRUE;
    }

    return FALSE;
}

// --------------------
// FUNCTIONS
// --------------------

// CViEvtCmnMsg
CViEvtCmnMsg::CViEvtCmnMsg()
{
    FontAnimator__Init(&this->fontAnimator);
    FontWindowAnimator__Init(&this->fontWindowAnimator);
    this->vramName       = NULL;
    this->vramNextButton = NULL;
    this->Release();
}

CViEvtCmnMsg::~CViEvtCmnMsg(void)
{
    this->Release();
}

void CViEvtCmnMsg::Init(void *mpcFile)
{
    this->Release();

    this->mpcFile = mpcFile;

    FontAnimator__LoadFont1(&this->fontAnimator, HubControl::GetField54(), 0, PIXEL_TO_TILE(16), PIXEL_TO_TILE(24), PIXEL_TO_TILE(208), PIXEL_TO_TILE(48), GRAPHICS_ENGINE_A,
                            BACKGROUND_3, PALETTE_ROW_0, 128);
    FontAnimator__ClearPixels(&this->fontAnimator);
    FontWindowAnimator__Load1(&this->fontWindowAnimator, HubControl::GetField54(), 0, FONTWINDOWANIMATOR_ARC_WIN_SIMPLE, ARCHIVE_WIN_SIMPLE_LZ7_FILE_WIN_SIMPLE_C_BBG, PIXEL_TO_TILE(0),
                              PIXEL_TO_TILE(0), PIXEL_TO_TILE(HW_LCD_WIDTH), PIXEL_TO_TILE(80), GRAPHICS_ENGINE_A, BACKGROUND_2, PALETTE_ROW_3, 960, 1023);
    FontAnimator__LoadMPCFile(&this->fontAnimator, this->mpcFile);
    FontAnimator__ClearPixels(&this->fontAnimator);
    FontAnimator__Draw(&this->fontAnimator);
    FontAnimator__LoadPaletteFunc(&this->fontAnimator);
    FontAnimator__LoadMappingsFunc(&this->fontAnimator);
    FontWindowAnimator__SetWindowClosed(&this->fontWindowAnimator);

    this->dialogState     = CViEvtCmnMsg::DIALOGSTATE_DONE;
    this->nextDialogState = CViEvtCmnMsg::DIALOGSTATE_DONE;

    this->sprName  = HubControl::GetTKDMNameSprite();
    this->vramName = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize1(this->sprName));
    AnimatorSprite__Init(&this->aniName, this->sprName, 0, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE, this->vramName, PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT,
                         SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    this->aniName.pos.x          = 8;
    this->aniName.pos.y          = 8;
    this->aniName.cParam.palette = PALETTE_ROW_6;

    this->sprNextButton  = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_DMCMN_FIX_NEXT_BAC);
    this->vramNextButton = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize1(this->sprNextButton));
    AnimatorSprite__Init(&this->aniNextButton, this->sprNextButton, ADVANCEPROMPT_ANI_DISABLED, ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE,
                         this->vramNextButton, PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    this->aniNextButton.pos.x          = HW_LCD_WIDTH - 32;
    this->aniNextButton.pos.y          = 48;
    this->aniNextButton.cParam.palette = PALETTE_ROW_4;

    this->nextButtonState = CViEvtCmnMsg::NEXTBTNSTATE_INACTIVE;
    this->autoAdvanceFlag = FALSE;

    TouchField__Init(&this->touchField);
    TouchField__InitAreaShape(&this->touchArea, NULL, TouchField__PointInRect, NULL, CViEvtCmnMsg::TouchAreaCallback, this);
    TouchField__AddArea(&this->touchField, &this->touchArea, TOUCHAREA_PRIORITY_FIRST);
}

void CViEvtCmnMsg::Release()
{
    if (this->vramNextButton != NULL)
    {
        AnimatorSprite__Release(&this->aniNextButton);
        this->vramNextButton = NULL;
    }

    if (this->vramName != NULL)
    {
        AnimatorSprite__Release(&this->aniName);
        this->vramName = NULL;
    }

    FontWindowAnimator__Release(&this->fontWindowAnimator);
    FontAnimator__Release(&this->fontAnimator);

    this->dialogState        = CViEvtCmnMsg::DIALOGSTATE_DONE;
    this->nextDialogState    = CViEvtCmnMsg::DIALOGSTATE_DONE;
    this->mpcFile            = NULL;
    this->sequenceID         = CVIEVTCMN_RESOURCE_NONE;
    this->nameAnimID         = CVIEVTCMN_RESOURCE_NONE;
    this->nextSequence       = CVIEVTCMN_RESOURCE_NONE;
    this->nextNameAnimID     = CVIEVTCMN_RESOURCE_NONE;
    this->prevNameAnimID     = CVIEVTCMN_RESOURCE_NONE;
    this->unused             = 0;
    this->isLastSequence     = TRUE;
    this->dialogStateChanged = TRUE;
    this->sprName            = NULL;
    this->sprNextButton      = NULL;
    this->timer              = 0;
}

void CViEvtCmnMsg::SetSequence(u16 sequence, u16 nameAnimID, u16 nextSequence, u16 nextName, BOOL isLastSequence)
{
    this->nextDialogState    = CViEvtCmnMsg::DIALOGSTATE_INIT;
    this->sequenceID         = sequence;
    this->nameAnimID         = nameAnimID;
    this->nextSequence       = nextSequence;
    this->nextNameAnimID     = nextName;
    this->isLastSequence     = isLastSequence;
    this->dialogStateChanged = TRUE;
    this->allowBackPress     = FALSE;
}

void CViEvtCmnMsg::SetSequenceFromMPC(u16 sequenceID, u16 nameAnimID, u16 nextSequence, u16 nextName, BOOL isLastSequence)
{
    if (sequenceID >= MPC__GetSequenceCount(this->mpcFile))
    {
        this->nextDialogState    = CViEvtCmnMsg::DIALOGSTATE_CLOSING_WINDOW;
        this->sequenceID         = CVIEVTCMN_RESOURCE_NONE;
        this->nameAnimID         = CVIEVTCMN_RESOURCE_NONE;
        this->nextSequence       = CVIEVTCMN_RESOURCE_NONE;
        this->nextNameAnimID     = CVIEVTCMN_RESOURCE_NONE;
        this->isLastSequence     = TRUE;
        this->dialogStateChanged = TRUE;
        this->allowBackPress     = FALSE;
    }
    else
    {
        this->nextDialogState    = CViEvtCmnMsg::DIALOGSTATE_REVEALING_TEXT;
        this->sequenceID         = sequenceID;
        this->nameAnimID         = nameAnimID;
        this->nextSequence       = nextSequence;
        this->nextNameAnimID     = nextName;
        this->isLastSequence     = isLastSequence;
        this->dialogStateChanged = TRUE;
        this->allowBackPress     = FALSE;
    }
}

void CViEvtCmnMsg::SetNextSequence(u16 nextSequence, u16 nextNameAnimID)
{
    this->nextSequence   = nextSequence;
    this->nextNameAnimID = nextNameAnimID;
}

BOOL CViEvtCmnMsg::HasNoNextSequence()
{
    return this->nextSequence == CVIEVTCMN_RESOURCE_NONE;
}

void CViEvtCmnMsg::SetIsLastSequence(BOOL isLastSequence)
{
    this->isLastSequence = isLastSequence;
}

void CViEvtCmnMsg::ProcessDialog()
{
    BOOL stateChanged        = this->dialogStateChanged;
    this->dialogState        = this->nextDialogState;
    this->dialogStateChanged = FALSE;

    switch (this->dialogState)
    {
        case CViEvtCmnMsg::DIALOGSTATE_INIT:
            if (stateChanged)
                this->InitDialogState_Init();

            this->nextDialogState = this->DialogState_Init();

            if (this->nextDialogState != CViEvtCmnMsg::DIALOGSTATE_INIT)
                this->dialogStateChanged = TRUE;
            break;

        case CViEvtCmnMsg::DIALOGSTATE_OPENING_WINDOW:
            if (stateChanged)
                this->InitDialogState_OpenWindow();

            this->nextDialogState = this->DialogState_OpenWindow();

            if (this->nextDialogState != CViEvtCmnMsg::DIALOGSTATE_OPENING_WINDOW)
                this->dialogStateChanged = TRUE;
            break;

        case CViEvtCmnMsg::DIALOGSTATE_REVEALING_TEXT:
            if (stateChanged)
                this->InitDialogState_ProcessTextReveal();

            this->nextDialogState = this->DialogState_ProcessTextReveal();

            if (this->nextDialogState != CViEvtCmnMsg::DIALOGSTATE_REVEALING_TEXT)
                this->dialogStateChanged = TRUE;
            break;

        case CViEvtCmnMsg::DIALOGSTATE_SHOW_TEXT:
            if (stateChanged)
                this->InitDialogState_ShowText();

            this->nextDialogState = this->DialogState_ShowText();

            if (this->nextDialogState != CViEvtCmnMsg::DIALOGSTATE_SHOW_TEXT)
                this->dialogStateChanged = TRUE;
            break;

        case CViEvtCmnMsg::DIALOGSTATE_CLOSING_WINDOW:
            if (stateChanged)
                this->InitDialogState_CloseWindow();

            this->nextDialogState = this->DialogState_CloseWindow();

            if (this->nextDialogState != CViEvtCmnMsg::DIALOGSTATE_CLOSING_WINDOW)
                this->dialogStateChanged = TRUE;
            break;

        case CViEvtCmnMsg::DIALOGSTATE_CLOSED_WINDOW:
            if (stateChanged)
                this->InitDialogState_ClosedWindow();

            this->nextDialogState = this->DialogState_ClosedWindow();

            if (this->nextDialogState != CViEvtCmnMsg::DIALOGSTATE_CLOSED_WINDOW)
                this->dialogStateChanged = TRUE;
            break;
    }
}

BOOL CViEvtCmnMsg::CheckIdle()
{
    if (this->dialogState != this->nextDialogState)
        return FALSE;

    return this->dialogState == CViEvtCmnMsg::DIALOGSTATE_DONE || this->dialogState == CViEvtCmnMsg::DIALOGSTATE_SHOW_TEXT;
}

void CViEvtCmnMsg::TrySetNextButtonState(u32 state)
{
    if (this->nextButtonState <= CViEvtCmnMsg::NEXTBTNSTATE_DISABLED)
    {
        if (state == CViEvtCmnMsg::NEXTBTNSTATE_PROMPTING || state == CViEvtCmnMsg::NEXTBTNSTATE_HELD)
            return;
    }

    this->SetNextButtonState(state);
}

void CViEvtCmnMsg::SetAutoAdvance()
{
    this->autoAdvanceFlag = TRUE;
}

void CViEvtCmnMsg::InitDialogState_Init()
{
    this->SetNextButtonState(CViEvtCmnMsg::NEXTBTNSTATE_INACTIVE);
}

s32 CViEvtCmnMsg::DialogState_Init()
{
    this->ProcessNextButtonAnimation();
    this->DrawNextButton();
    return CViEvtCmnMsg::DIALOGSTATE_OPENING_WINDOW;
}

void CViEvtCmnMsg::InitDialogState_OpenWindow()
{
    FontWindowAnimator__InitAnimation(&this->fontWindowAnimator, 1, 8, 0, 0);
    FontWindowAnimator__StartAnimating(&this->fontWindowAnimator);
    FontWindowAnimator__Draw(&this->fontWindowAnimator);

    this->SetNextButtonState(CViEvtCmnMsg::NEXTBTNSTATE_INACTIVE);
}

s32 CViEvtCmnMsg::DialogState_OpenWindow()
{
    s32 nextState = CViEvtCmnMsg::DIALOGSTATE_OPENING_WINDOW;

    FontWindowAnimator__ProcessWindowAnim(&this->fontWindowAnimator);
    this->ProcessNextButtonAnimation();
    this->DrawNextButton();

    if (FontWindowAnimator__IsFinishedAnimating(&this->fontWindowAnimator))
    {
        FontWindowAnimator__SetWindowOpen(&this->fontWindowAnimator);
        nextState = CViEvtCmnMsg::DIALOGSTATE_REVEALING_TEXT;
    }

    return nextState;
}

void CViEvtCmnMsg::InitDialogState_ProcessTextReveal()
{
    if (this->nameAnimID != this->prevNameAnimID)
    {
        if (this->nameAnimID != CVIEVTCMN_RESOURCE_NONE)
            AnimatorSprite__SetAnimation(&this->aniName, this->nameAnimID);

        this->prevNameAnimID = this->nameAnimID;
    }

    FontAnimator__SetMsgSequence(&this->fontAnimator, this->sequenceID);
    this->SetNextButtonState(CViEvtCmnMsg::NEXTBTNSTATE_DISABLED);

    this->timer = 0;
}

s32 CViEvtCmnMsg::DialogState_ProcessTextReveal()
{
    s32 nextState = CViEvtCmnMsg::DIALOGSTATE_INIT;

    TouchField__Process(&this->touchField);

    BOOL confirmPress = this->CheckConfirmBtnPress() || this->ShouldAutoAdvance();
    BOOL backPress    = this->CheckBackBtnPress();

    if (FontAnimator__IsLastDialog(&this->fontAnimator))
    {
        if (this->HasNoNextSequence())
        {
            if (this->isLastSequence)
            {
                if (confirmPress || backPress && this->timer >= 4)
                {
                    FontAnimator__ClearPixels(&this->fontAnimator);
                    FontAnimator__Draw(&this->fontAnimator);

                    this->ProcessNextButtonAnimation();
                    this->DrawNextButton();

                    return CViEvtCmnMsg::DIALOGSTATE_CLOSING_WINDOW;
                }
            }
            else
            {
                if (this->nameAnimID != CVIEVTCMN_RESOURCE_NONE)
                {
                    AnimatorSprite__ProcessAnimationFast(&this->aniName);
                    AnimatorSprite__DrawFrame(&this->aniName);
                }

                this->ProcessNextButtonAnimation();
                this->DrawNextButton();
                return CViEvtCmnMsg::DIALOGSTATE_SHOW_TEXT;
            }
        }
        else
        {
            if (confirmPress || backPress && this->timer >= 4)
            {
                this->sequenceID     = this->nextSequence;
                this->nameAnimID     = this->nextNameAnimID;
                this->nextSequence   = CVIEVTCMN_RESOURCE_NONE;
                this->nextNameAnimID = CVIEVTCMN_RESOURCE_NONE;
                FontAnimator__SetMsgSequence(&this->fontAnimator, this->sequenceID);

                if (this->nameAnimID != this->prevNameAnimID)
                {
                    if (this->nameAnimID != CVIEVTCMN_RESOURCE_NONE)
                        AnimatorSprite__SetAnimation(&this->aniName, this->nameAnimID);
                    this->prevNameAnimID = this->nameAnimID;
                }

                nextState = CViEvtCmnMsg::DIALOGSTATE_OPENING_WINDOW;
            }
        }
    }
    else
    {
        if (FontAnimator__IsEndOfLine(&this->fontAnimator) && (confirmPress || backPress && this->timer >= 4))
        {
            FontAnimator__AdvanceDialog(&this->fontAnimator);
            nextState = CViEvtCmnMsg::DIALOGSTATE_OPENING_WINDOW;
            this->SetNextButtonState(CViEvtCmnMsg::NEXTBTNSTATE_DISABLED);
        }
    }

    if (FontAnimator__IsEndOfLine(&this->fontAnimator))
    {
        this->timer++;
        if (this->timer > 1 && this->nextButtonState <= CViEvtCmnMsg::NEXTBTNSTATE_DISABLED)
            this->SetNextButtonState(CViEvtCmnMsg::NEXTBTNSTATE_PROMPTING);
    }
    else
    {
        this->timer = 0;
    }

    if (confirmPress && nextState == CViEvtCmnMsg::DIALOGSTATE_INIT || backPress)
        FontAnimator__LoadCharacters(&this->fontAnimator, 0);
    else
        FontAnimator__LoadCharacters(&this->fontAnimator, 1);

    if (this->nameAnimID != CVIEVTCMN_RESOURCE_NONE)
    {
        AnimatorSprite__ProcessAnimationFast(&this->aniName);
        AnimatorSprite__DrawFrame(&this->aniName);
    }

    FontAnimator__Draw(&this->fontAnimator);

    this->ProcessNextButtonAnimation();
    this->DrawNextButton();

    return CViEvtCmnMsg::DIALOGSTATE_REVEALING_TEXT;
}

void CViEvtCmnMsg::InitDialogState_ShowText()
{
    this->SetNextButtonState(CViEvtCmnMsg::NEXTBTNSTATE_DISABLED);
}

s32 CViEvtCmnMsg::DialogState_ShowText()
{
    this->ProcessNextButtonAnimation();
    this->DrawNextButton();

    if (this->nameAnimID != CVIEVTCMN_RESOURCE_NONE)
    {
        AnimatorSprite__ProcessAnimationFast(&this->aniName);
        AnimatorSprite__DrawFrame(&this->aniName);
    }

    return CViEvtCmnMsg::DIALOGSTATE_SHOW_TEXT;
}

void CViEvtCmnMsg::InitDialogState_CloseWindow()
{
    FontWindowAnimator__InitAnimation(&this->fontWindowAnimator, 4, 8, 0, 0);
    FontWindowAnimator__StartAnimating(&this->fontWindowAnimator);

    FontAnimator__ClearPixels(&this->fontAnimator);
    FontAnimator__Draw(&this->fontAnimator);

    this->SetNextButtonState(CViEvtCmnMsg::NEXTBTNSTATE_INACTIVE);
}

s32 CViEvtCmnMsg::DialogState_CloseWindow()
{
    s32 nextState = CViEvtCmnMsg::DIALOGSTATE_CLOSING_WINDOW;

    FontWindowAnimator__ProcessWindowAnim(&this->fontWindowAnimator);

    this->ProcessNextButtonAnimation();
    this->DrawNextButton();

    if (FontWindowAnimator__IsFinishedAnimating(&this->fontWindowAnimator))
    {
        FontWindowAnimator__SetWindowClosed(&this->fontWindowAnimator);
        nextState = CViEvtCmnMsg::DIALOGSTATE_CLOSED_WINDOW;
    }

    return nextState;
}

void CViEvtCmnMsg::InitDialogState_ClosedWindow()
{
    // Nothing to do!
}

s32 CViEvtCmnMsg::DialogState_ClosedWindow()
{
    FontWindowAnimator__SetWindowOpen(&this->fontWindowAnimator);
    this->sequenceID     = CVIEVTCMN_RESOURCE_NONE;
    this->nameAnimID     = CVIEVTCMN_RESOURCE_NONE;
    this->nextSequence   = CVIEVTCMN_RESOURCE_NONE;
    this->nextNameAnimID = CVIEVTCMN_RESOURCE_NONE;
    this->prevNameAnimID = CVIEVTCMN_RESOURCE_NONE;
    this->timer          = 0;
    return CViEvtCmnMsg::DIALOGSTATE_DONE;
}

BOOL CViEvtCmnMsg::CheckConfirmBtnPress()
{
    if ((padInput.btnPress & PAD_BUTTON_A) != 0)
        return TRUE;
    else
        return FALSE;
}

BOOL CViEvtCmnMsg::CheckBackBtnPress()
{
    if ((padInput.btnDown & PAD_BUTTON_B) != 0)
    {
        if (this->allowBackPress)
            return TRUE;
    }
    else
    {
        this->allowBackPress = TRUE;
    }

    return FALSE;
}

void CViEvtCmnMsg::SetNextButtonState(s32 state)
{
    if (state != this->nextButtonState)
    {
        BOOL resetArea = TRUE;
        u16 anim;

        switch (state)
        {
            case CViEvtCmnMsg::NEXTBTNSTATE_INACTIVE:
                anim = ADVANCEPROMPT_ANI_DISABLED;
                break;

            case CViEvtCmnMsg::NEXTBTNSTATE_DISABLED:
                anim = ADVANCEPROMPT_ANI_DISABLED;
                break;

            case CViEvtCmnMsg::NEXTBTNSTATE_PROMPTING:
                anim = ADVANCEPROMPT_ANI_PROMPTING;
                if (this->nextButtonState == CViEvtCmnMsg::NEXTBTNSTATE_HELD)
                    resetArea = FALSE;
                break;

            case CViEvtCmnMsg::NEXTBTNSTATE_HELD:
                anim = ADVANCEPROMPT_ANI_HELD;
                if (this->nextButtonState == CViEvtCmnMsg::NEXTBTNSTATE_PROMPTING)
                    resetArea = FALSE;
                break;

            default:
                return;
        }

        AnimatorSprite__SetAnimation(&this->aniNextButton, anim);
        if (resetArea)
            TouchField__ResetArea(&this->touchArea);

        this->nextButtonState = state;
    }
}

void CViEvtCmnMsg::ProcessNextButtonAnimation()
{
    AnimatorSprite__ProcessAnimation(&this->aniNextButton, CViEvtCmnMsg::SpriteCallback, &this->touchArea);
}

void CViEvtCmnMsg::DrawNextButton()
{
    if (this->nextButtonState != CViEvtCmnMsg::NEXTBTNSTATE_INACTIVE)
        AnimatorSprite__DrawFrame(&this->aniNextButton);
}

BOOL CViEvtCmnMsg::ShouldAutoAdvance()
{
    BOOL autoAdvance      = this->autoAdvanceFlag;
    this->autoAdvanceFlag = FALSE;

    return autoAdvance;
}

// CViEvtCmnSelect
CViEvtCmnSelect::CViEvtCmnSelect()
{
    this->mpcFile = NULL;

    FontAnimator__Init(&this->fontAnimator);
    FontWindowAnimator__Init(&this->fontWindowAnimator);
    FontWindowMWControl__Init(&this->fontWindowMWControl);
    MI_CpuClear16(&this->aniSprite1, sizeof(this->aniSprite1));

    this->Release();
}

CViEvtCmnSelect::~CViEvtCmnSelect()
{
    this->Release();
}

void CViEvtCmnSelect::Init(void *mpcFile)
{
    this->Release();

    this->mpcFile = mpcFile;

    FontAnimator__LoadFont1(&this->fontAnimator, HubControl::GetField54(), 0, PIXEL_TO_TILE(8), PIXEL_TO_TILE(88), PIXEL_TO_TILE(240), PIXEL_TO_TILE(64), GRAPHICS_ENGINE_A,
                            BACKGROUND_3, PALETTE_ROW_0, 296);
    FontAnimator__LoadMPCFile(&this->fontAnimator, this->mpcFile);
    FontAnimator__ClearPixels(&this->fontAnimator);
    FontAnimator__Draw(&this->fontAnimator);
    FontAnimator__LoadPaletteFunc(&this->fontAnimator);
    FontAnimator__LoadMappingsFunc(&this->fontAnimator);

    FontWindowMWControl__Load(&this->fontWindowMWControl, HubControl::GetField54(), 0, FONTWINDOWMW_FILL, 8, 8, GRAPHICS_ENGINE_A, SPRITE_PRIORITY_1, SPRITE_ORDER_0,
                              PALETTE_ROW_5);

    void *sprFile = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_NL_CURSOR_IKARI_BAC);
    AnimatorSprite__Init(&this->aniSprite1, sprFile, 0, ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize1FromAnim(sprFile, 0)), PALETTE_MODE_SPRITE, (u16 *)VRAM_OBJ_PLTT, SPRITE_PRIORITY_0,
                         SPRITE_ORDER_0);
    this->aniSprite1.cParam.palette = PALETTE_ROW_7;
    AnimatorSprite__ProcessAnimationFast(&this->aniSprite1);

    this->dialogState     = CViEvtCmnSelect::DIALOGSTATE_FINISHED;
    this->nextDialogState = CViEvtCmnSelect::DIALOGSTATE_FINISHED;
}

void CViEvtCmnSelect::Release()
{
    AnimatorSprite__Release(&this->aniSprite1);
    MI_CpuClear16(&this->aniSprite1, sizeof(this->aniSprite1));

    FontWindowMWControl__Release(&this->fontWindowMWControl);
    FontWindowAnimator__Release(&this->fontWindowAnimator);
    FontAnimator__Release(&this->fontAnimator);

    this->dialogState        = CViEvtCmnSelect::DIALOGSTATE_FINISHED;
    this->nextDialogState    = CViEvtCmnSelect::DIALOGSTATE_FINISHED;
    this->mpcFile            = NULL;
    this->sequence           = CVIEVTCMN_RESOURCE_NONE;
    this->dialogStateChanged = TRUE;
    this->selection          = 0;
    this->selectionCount     = 0;
    this->windowStartX       = 0;
    this->windowStartY       = 0;
    this->windowSizeX        = 0;
    this->windowSizeY        = 0;
    this->lineStart          = 0;
    this->lineHeight         = 0;
    this->lineSize           = 0;
    this->field_32           = 0;
    this->timer              = 0;
}

void CViEvtCmnSelect::SetSequence(u16 id)
{
    this->nextDialogState    = CViEvtCmnSelect::DIALOGSTATE_INIT;
    this->sequence           = id;
    this->dialogStateChanged = TRUE;
}

void CViEvtCmnSelect::ProcessDialog()
{
    BOOL stateChanged = this->dialogStateChanged;

    this->dialogState        = this->nextDialogState;
    this->dialogStateChanged = FALSE;

    switch (this->dialogState)
    {
        case CViEvtCmnSelect::DIALOGSTATE_INIT:
            if (stateChanged)
                this->InitDialogState_Init();

            this->nextDialogState = this->DialogState_Init();

            if (this->nextDialogState != CViEvtCmnSelect::DIALOGSTATE_INIT)
                this->dialogStateChanged = TRUE;
            break;

        case CViEvtCmnSelect::DIALOGSTATE_OPENING_WINDOW:
            if (stateChanged)
                this->InitDialogState_OpeningWindow();

            this->nextDialogState = this->DialogState_OpeningWindow();

            if (this->nextDialogState != CViEvtCmnSelect::DIALOGSTATE_OPENING_WINDOW)
                this->dialogStateChanged = TRUE;
            break;

        case CViEvtCmnSelect::DIALOGSTATE_PREPARE_CHARS:
            if (stateChanged)
                this->InitDialogState_PrepareCharacters();

            this->nextDialogState = this->DialogState_PrepareCharacters();

            if (this->nextDialogState != CViEvtCmnSelect::DIALOGSTATE_PREPARE_CHARS)
                this->dialogStateChanged = TRUE;
            break;

        case CViEvtCmnSelect::DIALOGSTATE_SELECTION_ACTIVE:
            if (stateChanged)
                this->InitDialogState_SelectionActive();

            this->nextDialogState = this->DialogState_SelectionActive();

            if (this->nextDialogState != CViEvtCmnSelect::DIALOGSTATE_SELECTION_ACTIVE)
                this->dialogStateChanged = TRUE;
            break;

        case CViEvtCmnSelect::DIALOGSTATE_SELECTION_MADE:
            if (stateChanged)
                this->InitDialogState_SelectionMade();

            this->nextDialogState = this->DialogState_SelectionMade();

            if (this->nextDialogState != CViEvtCmnSelect::DIALOGSTATE_SELECTION_MADE)
                this->dialogStateChanged = TRUE;
            break;

        case CViEvtCmnSelect::DIALOGSTATE_CLOSING_WINDOW:
            if (stateChanged)
                this->InitDialogState_ClosingWindow();

            this->nextDialogState = this->DialogState_ClosingWindow();

            if (this->nextDialogState != CViEvtCmnSelect::DIALOGSTATE_CLOSING_WINDOW)
                this->dialogStateChanged = TRUE;
            break;

        case CViEvtCmnSelect::DIALOGSTATE_CLOSED_WINDOW:
            if (stateChanged)
                this->InitDialogState_ClosedWindow();

            this->nextDialogState = this->DialogState_ClosedWindow();

            if (this->nextDialogState != CViEvtCmnSelect::DIALOGSTATE_CLOSED_WINDOW)
                this->dialogStateChanged = TRUE;
            break;
    }

    if (this->dialogStateChanged)
        this->timer = 0;
    else
        this->timer++;
}

BOOL CViEvtCmnSelect::CheckFinished()
{
    return this->dialogState == CViEvtCmnSelect::DIALOGSTATE_FINISHED;
}

u16 CViEvtCmnSelect::GetSelection()
{
    return this->selection;
}

void CViEvtCmnSelect::InitDialogState_Init()
{
    this->selection      = 0;
    this->selectionCount = MPC__GetDialogLineCount(this->mpcFile, this->sequence, 0);

    void *fontFile = FontWindow__GetFont(HubControl::GetField54());

    s32 i;
    u32 maxLineWidth = 0;
    for (i = 0; i < this->selectionCount; i++)
    {
        u32 lineWidth = MessageController__GetLineWidthEx(this->mpcFile, this->sequence, 0, i, fontFile);
        if (lineWidth > maxLineWidth)
            maxLineWidth = lineWidth;
    }

    u16 lineSize = (maxLineWidth + 15) >> 3;
    if (lineSize > PIXEL_TO_TILE(HW_LCD_WIDTH) - PIXEL_TO_TILE(16))
    {
        lineSize = PIXEL_TO_TILE(HW_LCD_WIDTH) - PIXEL_TO_TILE(16);
    }
    else
    {
        if (lineSize + PIXEL_TO_TILE(16) < (u32)PIXEL_TO_TILE(112))
            lineSize = PIXEL_TO_TILE(96);
    }
    u32 sizeX = lineSize + PIXEL_TO_TILE(16);

    this->windowStartX = PIXEL_TO_TILE(HW_LCD_WIDTH) - sizeX;
    this->windowStartY = PIXEL_TO_TILE(80);
    this->windowSizeX  = sizeX;
    this->windowSizeY  = (PIXEL_TO_TILE(16) * this->selectionCount) + PIXEL_TO_TILE(16);
    this->lineStart    = this->windowStartX + 1;
    this->lineHeight   = 11;
    this->lineSize     = lineSize;
    this->field_32     = 2 * this->selectionCount;

    FontWindowAnimator__Load1(&this->fontWindowAnimator, HubControl::GetField54(), 0, FONTWINDOWANIMATOR_ARC_WIN_SIMPLE, ARCHIVE_WIN_SIMPLE_LZ7_FILE_WIN_SIMPLE_C_BBG, this->windowStartX,
                              this->windowStartY, this->windowSizeX, this->windowSizeY, GRAPHICS_ENGINE_A, BACKGROUND_2, PALETTE_ROW_3, 960, 1023);
    FontWindowAnimator__SetWindowClosed(&this->fontWindowAnimator);
}

s32 CViEvtCmnSelect::DialogState_Init()
{
    return CViEvtCmnSelect::DIALOGSTATE_OPENING_WINDOW;
}

void CViEvtCmnSelect::InitDialogState_OpeningWindow()
{
    FontWindowAnimator__InitAnimation(&this->fontWindowAnimator, 1, 8, 0, 0);
    FontWindowAnimator__StartAnimating(&this->fontWindowAnimator);
    FontWindowAnimator__Draw(&this->fontWindowAnimator);
    PlayHubSfx(HUB_SFX_V_POPUP);
}

s32 CViEvtCmnSelect::DialogState_OpeningWindow()
{
    s32 nextState = CViEvtCmnSelect::DIALOGSTATE_OPENING_WINDOW;

    FontWindowAnimator__ProcessWindowAnim(&this->fontWindowAnimator);
    if (FontWindowAnimator__IsFinishedAnimating(&this->fontWindowAnimator))
    {
        FontWindowAnimator__SetWindowOpen(&this->fontWindowAnimator);
        nextState = CViEvtCmnSelect::DIALOGSTATE_PREPARE_CHARS;
    }

    return nextState;
}

void CViEvtCmnSelect::InitDialogState_PrepareCharacters()
{
    FontAnimator__SetMsgSequence(&this->fontAnimator, this->sequence);
    FontAnimator__InitStartPos(&this->fontAnimator, 0, 8 * (this->lineStart - 1) + 4);
}

s32 CViEvtCmnSelect::DialogState_PrepareCharacters()
{
    FontAnimator__LoadCharacters(&this->fontAnimator, 0);
    FontAnimator__Draw(&this->fontAnimator);
    return CViEvtCmnSelect::DIALOGSTATE_SELECTION_ACTIVE;
}

void CViEvtCmnSelect::InitDialogState_SelectionActive()
{
    this->selection          = 0;
    this->prevTouchSelection = CVIEVTCMN_RESOURCE_NONE;
}

s32 CViEvtCmnSelect::DialogState_SelectionActive()
{
    s32 nextState      = CViEvtCmnSelect::DIALOGSTATE_SELECTION_ACTIVE;
    BOOL buttonPressed = FALSE;

    s32 selection = this->HandleBtnSelectionControl();
    if (selection >= 0)
    {
        FontWindowMWControl__ValidatePaletteAnim(&this->fontWindowMWControl);
        AnimatorSprite__SetAnimation(&this->aniSprite1, 0);
        PlayHubSfx(HUB_SFX_CURSOL);
        this->selection          = selection;
        this->prevTouchSelection = CVIEVTCMN_RESOURCE_NONE;
    }
    else
    {
        selection = this->HandleTouchSelectionControl(TRUE);
        if (selection >= 0)
        {
            this->selection          = selection;
            this->prevTouchSelection = selection;
        }
        else
        {
            if (this->prevTouchSelection != CVIEVTCMN_RESOURCE_NONE)
            {
                if (this->prevTouchSelection == (u16)this->HandleTouchSelectionControl(FALSE) && this->prevTouchSelection == this->selection)
                {
                    buttonPressed = TRUE;
                    PlayHubSfx(HUB_SFX_V_DECIDE);
                }
            }
        }
    }

    if (this->CheckConfirmBtnPress())
    {
        buttonPressed = TRUE;
        PlayHubSfx(HUB_SFX_V_DECIDE);
    }
    else if (this->CheckBackBtnPress())
    {
        if (this->selection == this->selectionCount - 1)
        {
            buttonPressed = TRUE;
            PlayHubSfx(HUB_SFX_V_CANCELL);
        }
        else
        {
            this->selection = this->selectionCount - 1;
            PlayHubSfx(HUB_SFX_CURSOL);
        }
    }

    FontWindowMWControl__Draw(&this->fontWindowMWControl);

    AnimatorSprite__ProcessAnimationFast(&this->aniSprite1);
    s16 x       = 8 * this->lineStart;
    s16 y       = 8 * this->lineHeight + 16 * this->selection;
    u16 offsetX = 8 * this->lineSize;
    FontWindowMWControl__SetPaletteAnim(&this->fontWindowMWControl, 0);
    FontWindowMWControl__SetPosition(&this->fontWindowMWControl, x, y);
    FontWindowMWControl__SetOffset(&this->fontWindowMWControl, offsetX, 16);
    FontWindowMWControl__CallWindowFunc2(&this->fontWindowMWControl);

    if (!buttonPressed)
    {
        this->aniSprite1.pos.x = x;
        this->aniSprite1.pos.y = y + 8;
        AnimatorSprite__DrawFrame(&this->aniSprite1);
    }

    if (buttonPressed)
        nextState = CViEvtCmnSelect::DIALOGSTATE_SELECTION_MADE;

    return nextState;
}

void CViEvtCmnSelect::InitDialogState_SelectionMade()
{
    // Nothing to do.
}

s32 CViEvtCmnSelect::DialogState_SelectionMade()
{
    FontWindowMWControl__Draw(&this->fontWindowMWControl);

    s16 x       = 8 * this->lineStart;
    s16 y       = 8 * this->lineHeight + 16 * this->selection;
    u16 offsetX = 8 * this->lineSize;
    FontWindowMWControl__SetPaletteAnim(&this->fontWindowMWControl, 1);
    FontWindowMWControl__SetPosition(&this->fontWindowMWControl, x, y);
    FontWindowMWControl__SetOffset(&this->fontWindowMWControl, offsetX, 16);
    FontWindowMWControl__CallWindowFunc2(&this->fontWindowMWControl);

    if (this->timer >= 16)
        return CViEvtCmnSelect::DIALOGSTATE_CLOSING_WINDOW;
    else
        return CViEvtCmnSelect::DIALOGSTATE_SELECTION_MADE;
}

void CViEvtCmnSelect::InitDialogState_ClosingWindow()
{
    FontWindowAnimator__InitAnimation(&this->fontWindowAnimator, 4, 8, 0, 0);
    FontWindowAnimator__StartAnimating(&this->fontWindowAnimator);
    FontAnimator__ClearPixels(&this->fontAnimator);
    FontAnimator__Draw(&this->fontAnimator);
}

s32 CViEvtCmnSelect::DialogState_ClosingWindow()
{
    s32 nextState = CViEvtCmnSelect::DIALOGSTATE_CLOSING_WINDOW;

    FontWindowAnimator__ProcessWindowAnim(&this->fontWindowAnimator);
    if (FontWindowAnimator__IsFinishedAnimating(&this->fontWindowAnimator))
    {
        FontWindowAnimator__SetWindowClosed(&this->fontWindowAnimator);
        nextState = CViEvtCmnSelect::DIALOGSTATE_CLOSED_WINDOW;
    }

    return nextState;
}

void CViEvtCmnSelect::InitDialogState_ClosedWindow()
{
    // Nothing to do.
}

s32 CViEvtCmnSelect::DialogState_ClosedWindow()
{
    FontWindowAnimator__SetWindowOpen(&this->fontWindowAnimator);
    return CViEvtCmnSelect::DIALOGSTATE_FINISHED;
}

BOOL CViEvtCmnSelect::CheckConfirmBtnPress()
{
    return (padInput.btnPress & PAD_BUTTON_A) != 0;
}

BOOL CViEvtCmnSelect::CheckBackBtnPress()
{
    return (padInput.btnPress & PAD_BUTTON_B) != 0;
}

s32 CViEvtCmnSelect::HandleBtnSelectionControl()
{
    s32 selection = -1;

    if ((padInput.btnPressRepeat & PAD_KEY_UP) != 0)
    {
        if (this->selection > 0)
        {
            selection = this->selection - 1;
        }
        else
        {
            selection = this->selectionCount - 1;
        }
    }

    if ((padInput.btnPressRepeat & PAD_KEY_DOWN) != 0)
    {
        if (this->selection < this->selectionCount - 1)
        {
            selection = this->selection + 1;
        }
        else
        {
            selection = 0;
        }
    }

    return selection;
}

s32 CViEvtCmnSelect::HandleTouchSelectionControl(BOOL usePush)
{
    s32 selection = -1;

    u16 x;
    u16 y;
    if (usePush)
    {
        if (!CheckTouchPushEnabled())
            return -1;

        x = touchInput.push.x;
        y = touchInput.push.y;
    }
    else
    {
        if (!CheckTouchPullEnabled())
            return -1;

        x = touchInput.pull.x;
        y = touchInput.pull.y;
    }

    s32 i;
    for (i = 0; i < this->selectionCount; i++)
    {
        u16 x2    = this->lineStart * 8;
        u16 sizeX = this->lineSize * 8;
        u16 pos   = (this->lineHeight + 2 * i) * 8;
        if ((u16)(x - x2) < sizeX && (u16)(y - pos) < 16)
        {
            selection = i;
            break;
        }
    }

    return selection;
}

// CViEvtCmnAnnounce
CViEvtCmnAnnounce::CViEvtCmnAnnounce()
{
    FontAnimator__Init(&this->fontAnimator);
    FontWindowAnimator__Init(&this->fontWindowAnimator);
    this->Release();
}

CViEvtCmnAnnounce::~CViEvtCmnAnnounce()
{
    this->Release();
}

void CViEvtCmnAnnounce::Init(void *mpcFile)
{
    this->Release();

    this->mpcFile = mpcFile;

    FontAnimator__LoadFont1(&this->fontAnimator, HubControl::GetField54(), 0, PIXEL_TO_TILE(16), PIXEL_TO_TILE(80), PIXEL_TO_TILE(224), PIXEL_TO_TILE(32), GRAPHICS_ENGINE_A,
                            BACKGROUND_3, PALETTE_ROW_0, 128);
    FontAnimator__LoadMPCFile(&this->fontAnimator, this->mpcFile);
    FontAnimator__ClearPixels(&this->fontAnimator);
    FontAnimator__Draw(&this->fontAnimator);
    FontAnimator__LoadPaletteFunc(&this->fontAnimator);
    FontAnimator__LoadMappingsFunc(&this->fontAnimator);

    FontWindowAnimator__Load1(&this->fontWindowAnimator, HubControl::GetField54(), 0, FONTWINDOWANIMATOR_ARC_WIN_SIMPLE, ARCHIVE_WIN_SIMPLE_LZ7_FILE_WIN_SIMPLE_C_BBG, PIXEL_TO_TILE(8),
                              PIXEL_TO_TILE(72), PIXEL_TO_TILE(240), PIXEL_TO_TILE(48), GRAPHICS_ENGINE_A, BACKGROUND_2, PALETTE_ROW_3, 960, 1023);
    FontWindowAnimator__SetWindowClosed(&this->fontWindowAnimator);

    this->sfx         = HUB_SFX_INVALID;
    this->dialogState = CViEvtCmnAnnounce::DIALOGSTATE_IDLE;
}

void CViEvtCmnAnnounce::Release()
{
    FontWindowAnimator__Release(&this->fontWindowAnimator);
    FontAnimator__Release(&this->fontAnimator);
    this->dialogState     = CViEvtCmnAnnounce::DIALOGSTATE_INACTIVE;
    this->prevDialogState = CViEvtCmnAnnounce::DIALOGSTATE_INACTIVE;
    this->msgSequence     = CVIEVTCMN_RESOURCE_NONE;
    this->mpcFile         = NULL;
    this->unused10        = 0;
    this->unused12        = 0;
    this->unused14        = 0;
    this->unused16        = 0;
    this->unused18        = 0;
    this->unused1A        = 0;
    this->unused1C        = 0;
    this->unused1E        = 0;
    this->startPos        = 0;
}

void CViEvtCmnAnnounce::SetSequence(u16 msgSequence, u16 sfx)
{
    this->msgSequence = msgSequence;
    this->sfx         = sfx;
    this->dialogState = CViEvtCmnAnnounce::DIALOGSTATE_OPENING_WINDOW;
}

void CViEvtCmnAnnounce::Process()
{
    s32 dialogState     = this->dialogState;
    s32 prevDialogState = this->prevDialogState;

    BOOL changed;
    if (dialogState != prevDialogState)
        changed = TRUE;
    else
        changed = FALSE;

    this->prevDialogState = dialogState;
    if (changed)
        this->timer = 0;

    switch (this->dialogState)
    {
        case CViEvtCmnAnnounce::DIALOGSTATE_OPENING_WINDOW:
            if (changed)
                this->InitDialogState_OpeningWindow();

            this->dialogState = this->DialogState_OpeningWindow();
            break;

        case CViEvtCmnAnnounce::DIALOGSTATE_SHOW_TEXT:
            if (changed)
                this->InitDialogState_ShowText();

            this->dialogState = this->DialogState_ShowText();
            break;

        case CViEvtCmnAnnounce::DIALOGSTATE_CLOSING_WINDOW:
            if (changed)
                this->InitDialogState_ClosingWindow();

            this->dialogState = this->DialogState_ClosingWindow();
            break;

        case CViEvtCmnAnnounce::DIALOGSTATE_CLOSED_WINDOW:
            if (changed)
                this->InitDialogState_ClosedWindow();

            this->dialogState = this->DialogState_ClosedWindow();
            break;

        case CViEvtCmnAnnounce::DIALOGSTATE_INACTIVE:
            break;
    }

    this->timer++;
}

BOOL CViEvtCmnAnnounce::CheckIdle()
{
    if (this->dialogState != this->prevDialogState)
        return FALSE;

    if (this->dialogState == CViEvtCmnAnnounce::DIALOGSTATE_IDLE)
        return TRUE;

    return this->dialogState == CViEvtCmnAnnounce::DIALOGSTATE_INACTIVE;
}

void CViEvtCmnAnnounce::InitDialogState_OpeningWindow()
{
    FontWindowAnimator__InitAnimation(&this->fontWindowAnimator, 1, 8, 0, 0);
    FontWindowAnimator__StartAnimating(&this->fontWindowAnimator);
    FontWindowAnimator__Func_20599B4(&this->fontWindowAnimator);

    GX_SetVisiblePlane(GX_GetVisiblePlane() | GX_PLANEMASK_BG2);

    if (this->sfx < HUB_SFX_COUNT)
        PlayHubSfx(this->sfx);
}

s32 CViEvtCmnAnnounce::DialogState_OpeningWindow()
{
    s32 nextState = CViEvtCmnAnnounce::DIALOGSTATE_OPENING_WINDOW;

    FontWindowAnimator__ProcessWindowAnim(&this->fontWindowAnimator);
    FontWindowAnimator__Draw(&this->fontWindowAnimator);

    if (FontWindowAnimator__IsFinishedAnimating(&this->fontWindowAnimator))
    {
        FontWindowAnimator__SetWindowOpen(&this->fontWindowAnimator);
        nextState = CViEvtCmnAnnounce::DIALOGSTATE_SHOW_TEXT;
    }

    return nextState;
}

void CViEvtCmnAnnounce::InitDialogState_ShowText()
{
    FontAnimator__SetMsgSequence(&this->fontAnimator, this->msgSequence);
    FontAnimator__InitStartPos(&this->fontAnimator, 1, this->startPos);
    FontAnimator__AdvanceLine(&this->fontAnimator, 16 - ((16 * (s32)FontAnimator__GetDialogLineCount(&this->fontAnimator, 0)) >> 1));

    GX_SetVisiblePlane(GX_GetVisiblePlane() | GX_PLANEMASK_BG3);
}

s32 CViEvtCmnAnnounce::DialogState_ShowText()
{
    BOOL done     = FALSE;
    s32 nextState = CViEvtCmnAnnounce::DIALOGSTATE_SHOW_TEXT;

    FontAnimator__LoadCharacters(&this->fontAnimator, 0);
    FontAnimator__Draw(&this->fontAnimator);

    FontWindowAnimator__Draw(&this->fontWindowAnimator);

    if (FontAnimator__IsLastDialog(&this->fontAnimator))
    {
        if (this->timer >= SECONDS_TO_FRAMES(6.0))
            done = TRUE;

        if (this->timer >= SECONDS_TO_FRAMES(1.0))
        {
            if ((padInput.btnPress & PAD_BUTTON_A) != 0 || (!IsTouchInputEnabled() || TOUCH_HAS_PUSH(touchInput.flags) == 0 ? FALSE : TRUE))
            {
                done = TRUE;
            }
        }

        if (done)
            nextState = CViEvtCmnAnnounce::DIALOGSTATE_CLOSING_WINDOW;
    }

    return nextState;
}

void CViEvtCmnAnnounce::InitDialogState_ClosingWindow()
{
    FontWindowAnimator__InitAnimation(&this->fontWindowAnimator, 4, 8, 0, 0);
    FontWindowAnimator__StartAnimating(&this->fontWindowAnimator);
    FontWindowAnimator__Func_20599B4(&this->fontWindowAnimator);

    FontAnimator__ClearPixels(&this->fontAnimator);
    FontAnimator__Draw(&this->fontAnimator);

    GX_SetVisiblePlane(GX_GetVisiblePlane() & ~GX_PLANEMASK_BG3);
}

s32 CViEvtCmnAnnounce::DialogState_ClosingWindow()
{
    s32 nextState = CViEvtCmnAnnounce::DIALOGSTATE_CLOSING_WINDOW;

    FontWindowAnimator__ProcessWindowAnim(&this->fontWindowAnimator);
    FontWindowAnimator__Draw(&this->fontWindowAnimator);

    if (FontWindowAnimator__IsFinishedAnimating(&this->fontWindowAnimator))
    {
        FontWindowAnimator__SetWindowClosed(&this->fontWindowAnimator);
        nextState = CViEvtCmnAnnounce::DIALOGSTATE_CLOSED_WINDOW;
    }

    return nextState;
}

void CViEvtCmnAnnounce::InitDialogState_ClosedWindow()
{
    FontWindowAnimator__SetWindowOpen(&this->fontWindowAnimator);
    this->msgSequence = CVIEVTCMN_RESOURCE_NONE;
    GX_SetVisiblePlane(GX_GetVisiblePlane() & ~GX_PLANEMASK_BG2);
}

s32 CViEvtCmnAnnounce::DialogState_ClosedWindow()
{
    return CViEvtCmnAnnounce::DIALOGSTATE_IDLE;
}

// CViEvtCmnTalk
CViEvtCmnTalk::CViEvtCmnTalk()
{
    this->Release();
}

CViEvtCmnTalk::~CViEvtCmnTalk()
{
    this->Release();
}

void CViEvtCmnTalk::Init(void *mpcCtrlFile, u16 interactionID, u16 interactionID2)
{
    this->Release();

    this->msgCtrlFile = mpcCtrlFile;

    this->msgCtrl.SetControlFile(mpcCtrlFile);
    if (interactionID2 != CVIEVTCMN_RESOURCE_NONE)
    {
        this->msgCtrl.SetInteraction(interactionID2);
        this->interactionID = interactionID;
        this->pageID        = CVIEVTCMN_RESOURCE_NONE;
    }
    else
    {
        this->msgCtrl.SetInteraction(interactionID);
        this->interactionID = CVIEVTCMN_RESOURCE_NONE;
        this->pageID        = CVIEVTCMN_RESOURCE_NONE;
    }

    this->msgText = FileUnknown__GetAOUFile(HubControl::GetFileFrom_ViMsg(), this->msgCtrl.GetTextFileIndex());
    this->eventMessage.Init(this->msgText);
    this->eventSelection.Init(this->msgText);
    this->dialogState = CViEvtCmnTalk::DIALOGSTATE_INACTIVE;
}

void CViEvtCmnTalk::Release()
{
    this->dialogState   = CViEvtCmnTalk::DIALOGSTATE_FINISHED;
    this->ctrlAction    = 24;
    this->ctrlSelection = 0;
    this->interactionID = CVIEVTCMN_RESOURCE_NONE;
    this->pageID        = CVIEVTCMN_RESOURCE_NONE;
    this->msgText       = NULL;
    this->msgCtrlFile   = NULL;

    this->eventMessage.Release();
    this->eventSelection.Release();
}

u16 CViEvtCmnTalk::SetInteraction()
{
    if (this->interactionID != CVIEVTCMN_RESOURCE_NONE)
    {
        CViMessageController controller;
        controller.SetControlFile(this->msgCtrlFile);
        controller.SetInteraction(this->interactionID);
        return controller.GetPageCount();
    }

    return this->msgCtrl.GetPageCount();
}

void CViEvtCmnTalk::SetPage(u16 pageID)
{
    if (this->interactionID != CVIEVTCMN_RESOURCE_NONE)
    {
        this->msgCtrl.SetPageID(0);
        this->pageID = pageID;
    }
    else
    {
        this->msgCtrl.SetPageID(pageID);
        this->pageID = CVIEVTCMN_RESOURCE_NONE;
    }
    this->dialogState = CViEvtCmnTalk::DIALOGSTATE_INIT;
}

void CViEvtCmnTalk::ProcessDialog()
{
    switch (this->dialogState)
    {
        case CViEvtCmnTalk::DIALOGSTATE_INIT:
            this->dialogState = this->DialogState_Init();
            break;

        case CViEvtCmnTalk::DIALOGSTATE_REVEALING_TEXT:
            this->dialogState = this->DialogState_ProcessTextReveal();
            break;

        case CViEvtCmnTalk::DIALOGSTATE_SELECTION_ACTIVE:
            this->dialogState = this->DialogState_ProcessSelections();
            break;

        case CViEvtCmnTalk::DIALOGSTATE_FINALIZE_ACTIONS:
            this->dialogState = this->DialogState_FinalizeActions();
            break;

        case CViEvtCmnTalk::DIALOGSTATE_FINISHED:
            this->dialogState = this->DialogState_Finished();
            break;
    }
}

BOOL CViEvtCmnTalk::IsFinished()
{
    return this->dialogState == CViEvtCmnTalk::DIALOGSTATE_FINISHED;
}

s32 CViEvtCmnTalk::GetAction()
{
    return this->ctrlAction;
}

s32 CViEvtCmnTalk::GetSelection()
{
    return this->ctrlSelection;
}

void CViEvtCmnTalk::SetCallback(FontCallback callback, void *context)
{
    FontAnimator__SetCallback(&this->eventMessage.fontAnimator, callback, context);
}

s32 CViEvtCmnTalk::DialogState_Init()
{
    u16 pageSequence = this->msgCtrl.GetPageSequence();

    u16 nameAnimID;
    if (this->msgCtrl.CheckPageHasNameAnim() == FALSE)
        nameAnimID = CVIEVTCMN_RESOURCE_NONE;
    else
        nameAnimID = this->msgCtrl.GetPageNameAnim();
    this->eventMessage.SetSequence(pageSequence, nameAnimID, CVIEVTCMN_RESOURCE_NONE, CVIEVTCMN_RESOURCE_NONE, 1);

    GX_SetVisiblePlane(GX_GetVisiblePlane() | GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3);

    return CViEvtCmnTalk::DIALOGSTATE_REVEALING_TEXT;
}

s32 CViEvtCmnTalk::DialogState_ProcessTextReveal()
{
    s32 nextState = CViEvtCmnTalk::DIALOGSTATE_REVEALING_TEXT;

    if (this->eventMessage.HasNoNextSequence() && !this->msgCtrl.CheckPageHasActions())
    {
        if (this->msgCtrl.CheckPageHasSequenceUnknown())
        {
            this->eventMessage.SetIsLastSequence(FALSE);
        }
        else
        {
            this->msgCtrl.AdvancePage(0);

            if (this->msgCtrl.CheckPageHasActions())
            {
                this->eventMessage.SetIsLastSequence(TRUE);
            }
            else
            {
                this->eventMessage.SetIsLastSequence(FALSE);
                u16 pageSequence = this->msgCtrl.GetPageSequence();

                u16 nameAnim;
                if (!this->msgCtrl.CheckPageHasNameAnim())
                    nameAnim = CVIEVTCMN_RESOURCE_NONE;
                else
                    nameAnim = this->msgCtrl.GetPageNameAnim();

                this->eventMessage.SetNextSequence(pageSequence, nameAnim);
            }
        }
    }

    this->eventMessage.ProcessDialog();
    this->eventSelection.ProcessDialog();

    if (this->eventMessage.CheckIdle())
    {
        if (this->msgCtrl.CheckPageHasActions())
        {
            nextState = CViEvtCmnTalk::DIALOGSTATE_FINALIZE_ACTIONS;
        }
        else
        {
            if (!this->msgCtrl.CheckPageHasSequenceUnknown())
            {
                nextState = CViEvtCmnTalk::DIALOGSTATE_FINALIZE_ACTIONS;
            }
            else
            {
                this->eventSelection.SetSequence(this->msgCtrl.GetPageSequenceUnknown());
                nextState = CViEvtCmnTalk::DIALOGSTATE_SELECTION_ACTIVE;
            }
        }
    }

    return nextState;
}

s32 CViEvtCmnTalk::DialogState_ProcessSelections()
{
    s32 nextState = CViEvtCmnTalk::DIALOGSTATE_SELECTION_ACTIVE;

    this->eventMessage.ProcessDialog();
    this->eventSelection.ProcessDialog();

    if (this->eventSelection.CheckFinished())
    {
        this->msgCtrl.AdvancePage(this->eventSelection.GetSelection());

        u16 sequence;
        u16 nameAnimID;
        if (this->msgCtrl.CheckPageHasActions())
        {
            if (this->interactionID != CVIEVTCMN_RESOURCE_NONE && this->msgCtrl.GetPageActionType() == 9)
            {
                this->msgCtrl.SetInteraction(this->interactionID);
                this->msgCtrl.SetPageID(this->pageID);
                this->interactionID = CVIEVTCMN_RESOURCE_NONE;
                this->pageID        = CVIEVTCMN_RESOURCE_NONE;

                sequence = this->msgCtrl.GetPageSequence();
                if (!this->msgCtrl.CheckPageHasNameAnim())
                {
                    nameAnimID = CVIEVTCMN_RESOURCE_NONE;
                }
                else
                {
                    nameAnimID = this->msgCtrl.GetPageNameAnim();
                }

                this->eventMessage.SetSequenceFromMPC(sequence, nameAnimID, CVIEVTCMN_RESOURCE_NONE, CVIEVTCMN_RESOURCE_NONE, TRUE);
            }
            else
            {
                this->eventMessage.SetSequenceFromMPC(CVIEVTCMN_RESOURCE_NONE, CVIEVTCMN_RESOURCE_NONE, CVIEVTCMN_RESOURCE_NONE, CVIEVTCMN_RESOURCE_NONE, TRUE);
            }
        }
        else
        {
            sequence = this->msgCtrl.GetPageSequence();
            if (!this->msgCtrl.CheckPageHasNameAnim())
            {
                nameAnimID = CVIEVTCMN_RESOURCE_NONE;
            }
            else
            {
                nameAnimID = this->msgCtrl.GetPageNameAnim();
            }

            this->eventMessage.SetSequenceFromMPC(sequence, nameAnimID, CVIEVTCMN_RESOURCE_NONE, CVIEVTCMN_RESOURCE_NONE, TRUE);
        }

        nextState = CViEvtCmnTalk::DIALOGSTATE_REVEALING_TEXT;
    }

    return nextState;
}

s32 CViEvtCmnTalk::DialogState_FinalizeActions()
{
    if (this->msgCtrl.CheckPageActionEnabled())
    {
        this->ctrlAction    = this->msgCtrl.GetPageActionType();
        this->ctrlSelection = this->msgCtrl.GetPageActionSelection();
    }
    else
    {
        this->ctrlAction    = 24;
        this->ctrlSelection = 0;
    }

    return CViEvtCmnTalk::DIALOGSTATE_FINISHED;
}

s32 CViEvtCmnTalk::DialogState_Finished()
{
    return CViEvtCmnTalk::DIALOGSTATE_FINISHED;
}

void CViEvtCmnMsg::SpriteCallback(BACFrameGroupBlockHeader *block, AnimatorSprite *animator, void *userData)
{
    BACFrameGroupBlock_Hitbox *blocKHitbox = (BACFrameGroupBlock_Hitbox *)block;

    if (blocKHitbox->header.blockID == SPRITE_BLOCK_CALLBACK2)
    {
        TouchRectUnknown touchRect;
        MI_CpuCopy16(&blocKHitbox->hitbox, &touchRect.box, sizeof(touchRect.box));
        touchRect.box.left += (HW_LCD_WIDTH - 32);
        touchRect.box.top += 48;
        touchRect.box.right += (HW_LCD_WIDTH - 32);
        touchRect.box.bottom += 48;
        TouchField__SetHitbox((TouchArea *)userData, &touchRect);
    }
}

void CViEvtCmnMsg::TouchAreaCallback(TouchAreaResponse *responce, TouchArea *area, void *userData)
{
    CViEvtCmnMsg *eventMessage = (CViEvtCmnMsg *)userData;

    switch (responce->flags)
    {
        case TOUCHAREA_RESPONSE_40000:
            eventMessage->SetAutoAdvance();
            break;

        case TOUCHAREA_RESPONSE_ENTERED_AREA_ALT:
            eventMessage->TrySetNextButtonState(CViEvtCmnMsg::NEXTBTNSTATE_HELD);
            break;

        case TOUCHAREA_RESPONSE_ENTERED_AREA:
            if ((area->responseFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
                eventMessage->TrySetNextButtonState(CViEvtCmnMsg::NEXTBTNSTATE_HELD);
            break;

        case TOUCHAREA_RESPONSE_EXITED_AREA:
            if ((area->responseFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
                eventMessage->TrySetNextButtonState(CViEvtCmnMsg::NEXTBTNSTATE_PROMPTING);
            break;
    }
}