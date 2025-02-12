#include <hub/cviSailPrompt.hpp>
#include <hub/hubControl.hpp>
#include <hub/hubAudio.h>
#include <hub/cviDockNpcTalk.hpp>
#include <game/save/saveGame.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/file/fileUnknown.h>

// resources
#include <resources/bb/vi_msg/vi_msg_eng.h>
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

void CViSailPrompt::Create(s32 param)
{
    CViSailPrompt::CreatePrivate(param);
}

void CViSailPrompt::CreatePrivate(s32 param)
{
    Task *task = TaskCreate(CViSailPrompt::Main_Init, CViSailPrompt::Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1010, TASK_GROUP(16), CViSailPrompt);

    CViSailPrompt *work  = TaskGetWork(task, CViSailPrompt);
    work->type           = param;
    work->touchSelection = -1;

    work->InitDisplay();
    work->InitGraphics();
}

void CViSailPrompt::InitDisplay()
{
    HubControl::InitEngineAForTalk();

    this->InitBackgroundVRAM();
    this->InitBackground2VRAM();
}

void CViSailPrompt::InitGraphics()
{
    CViSailPrompt::SetBackground2Visible(FALSE);
    CViSailPrompt::SetBackground3Visible(FALSE);

    FontWindowAnimator__Init(&this->fontWindowAnimator);
    FontAnimator__Init(&this->fontAnimator);
    FontWindowMWControl__Init(&this->fontWindowMWControl);
    MI_CpuClear16(&this->aniCursor, sizeof(this->aniCursor));

    this->archive = HubControl::GetFileFrom_ViMsg();
}

void CViSailPrompt::Release()
{
    this->ReleaseGraphics();
    this->ResetDisplay();
}

void CViSailPrompt::ResetDisplay()
{
    HubControl::InitEngineAFor3DHub();
}

void CViSailPrompt::ReleaseGraphics()
{
    AnimatorSprite__Release(&this->aniCursor);
    FontWindowMWControl__Release(&this->fontWindowMWControl);
    FontAnimator__Release(&this->fontAnimator);
    FontWindowAnimator__Release(&this->fontWindowAnimator);
}

void CViSailPrompt::Main_Init(void)
{
    CViSailPrompt *work = TaskGetWorkCurrent(CViSailPrompt);

    s32 windowSizeY;
    if (CViSailPrompt::CheckTrainingDisabled())
        windowSizeY = PIXEL_TO_TILE(48);
    else
        windowSizeY = PIXEL_TO_TILE(64);

    FontWindowAnimator__Load1(&work->fontWindowAnimator, HubControl::GetField54(), 0, FONTWINDOWANIMATOR_ARC_0, ARCHIVE_WIN_SIMPLE_LZ7_FILE_WIN_SIMPLE_C_BBG, PIXEL_TO_TILE(32),
                              PIXEL_TO_TILE(0), PIXEL_TO_TILE(192), windowSizeY, GRAPHICS_ENGINE_A, BACKGROUND_2, PALETTE_ROW_3, 960, 1023);
    FontWindowAnimator__SetWindowClosed(&work->fontWindowAnimator);
    FontWindowAnimator__InitAnimation(&work->fontWindowAnimator, 1, 8, 0, 0);
    FontWindowAnimator__StartAnimating(&work->fontWindowAnimator);
    FontWindowAnimator__Draw(&work->fontWindowAnimator);

    SetCurrentTaskMainEvent(CViSailPrompt::Main_OpeningWindow);

    PlayHubSfx(HUB_SFX_V_POPUP);
}

void CViSailPrompt::Main_OpeningWindow(void)
{
    CViSailPrompt *work = TaskGetWorkCurrent(CViSailPrompt);

    CViSailPrompt::SetBackground2Visible(TRUE);

    FontWindowAnimator__Draw(&work->fontWindowAnimator);
    FontWindowAnimator__ProcessWindowAnim(&work->fontWindowAnimator);
    if (FontWindowAnimator__IsFinishedAnimating(&work->fontWindowAnimator))
    {
        FontWindowAnimator__SetWindowOpen(&work->fontWindowAnimator);

        FontAnimator__LoadFont1(&work->fontAnimator, HubControl::GetField54(), 0, PIXEL_TO_TILE(40), PIXEL_TO_TILE(8), PIXEL_TO_TILE(176), PIXEL_TO_TILE(48), GRAPHICS_ENGINE_A,
                                BACKGROUND_3, PALETTE_ROW_0, 128);
        FontAnimator__LoadPaletteFunc(&work->fontAnimator);
        FontAnimator__LoadMappingsFunc(&work->fontAnimator);
        FontAnimator__LoadMPCFile(&work->fontAnimator, FileUnknown__GetAOUFile(work->archive, ARCHIVE_VI_MSG_ENG_FILE_VI_MSG_COMMON_MPC));
        if (CViSailPrompt::CheckTrainingDisabled())
            FontAnimator__SetMsgSequence(&work->fontAnimator, 1);
        else
            FontAnimator__SetMsgSequence(&work->fontAnimator, 0);
        FontAnimator__InitStartPos(&work->fontAnimator, 1, 0);
        FontAnimator__ClearPixels(&work->fontAnimator);
        FontAnimator__Draw(&work->fontAnimator);

        SetCurrentTaskMainEvent(CViSailPrompt::Main_ShowingText);
    }
}

void CViSailPrompt::Main_ShowingText(void)
{
    CViSailPrompt *work = TaskGetWorkCurrent(CViSailPrompt);

    CViSailPrompt::SetBackground3Visible(TRUE);

    FontAnimator__LoadCharacters(&work->fontAnimator, 1);
    FontWindowAnimator__Draw(&work->fontWindowAnimator);
    FontAnimator__Draw(&work->fontAnimator);

    if (FontAnimator__IsEndOfLine(&work->fontAnimator))
    {
        FontWindowMWControl__Load(&work->fontWindowMWControl, HubControl::GetField54(), 0, FONTWINDOWMW_FILL, 176, 16, GRAPHICS_ENGINE_A, SPRITE_PRIORITY_1, SPRITE_ORDER_0,
                                  PALETTE_ROW_12);

        void *sprCursor         = HubControl::GetFileFrom_ViAct(ARCHIVE_VI_ACT_LZ7_FILE_NL_CURSOR_IKARI_BAC);
        VRAMPixelKey vramPixels = VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, Sprite__GetSpriteSize1FromAnim(sprCursor, 0));
        AnimatorSprite__Init(&work->aniCursor, sprCursor, 0, ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE, vramPixels, PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT,
                             SPRITE_PRIORITY_0, SPRITE_ORDER_0);
        work->aniCursor.cParam.palette = PALETTE_ROW_13;
        AnimatorSprite__ProcessAnimationFast(&work->aniCursor);

        if (CViSailPrompt::CheckTrainingDisabled() || !CViSailPrompt::Func_21696F0(work->type))
        {
            work->selection = 0;
        }
        else
        {
            if (SaveGame__Func_205BF78(CViSailPrompt::Func_2169754(work->type)))
                work->selection = 0;
            else
                work->selection = 1;
        }

        work->selectionCount = FontAnimator__GetDialogLineCount(&work->fontAnimator, 0);
        work->touchSelection = -1;

        SetCurrentTaskMainEvent(CViSailPrompt::Main_SelectionActive);
    }
}

void CViSailPrompt::Main_SelectionActive(void)
{
    CViSailPrompt *work;
    BOOL didAction;
    u16 selection;

    selection = 0xFFFF;

    work = TaskGetWorkCurrent(CViSailPrompt);

    didAction = FALSE;
    if ((padInput.btnPressRepeat & PAD_KEY_UP) != 0)
    {
        if (work->selection <= 0)
            selection = work->selectionCount - 1;
        else
            selection = work->selection - 1;

        work->touchSelection = -1;
        PlayHubSfx(HUB_SFX_CURSOL);
    }

    if ((padInput.btnPressRepeat & PAD_KEY_DOWN) != 0)
    {
        if (work->selection < work->selectionCount - 1)
            selection = work->selection + 1;
        else
            selection = 0;

        work->touchSelection = -1;
        PlayHubSfx(HUB_SFX_CURSOL);
    }

    if (selection == 0xFFFF)
    {
        selection = work->HandleTouchSelectionControl(TRUE);

        if (selection != 0xFFFF)
        {
            work->touchSelection = selection;
        }
        else
        {
            if (work->touchSelection != 0xFFFF)
            {
                if (work->touchSelection == work->HandleTouchSelectionControl(FALSE) && work->touchSelection == work->selection)
                {
                    didAction = TRUE;
                    PlayHubSfx(HUB_SFX_V_DECIDE);
                }
            }
        }
    }

    if (selection < work->selectionCount && selection != work->selection)
    {
        work->selection = selection;
        FontWindowMWControl__ValidatePaletteAnim(&work->fontWindowMWControl);
        AnimatorSprite__SetAnimation(&work->aniCursor, 0);
    }

    if ((padInput.btnPress & PAD_BUTTON_A) != 0)
    {
        didAction = TRUE;
        PlayHubSfx(HUB_SFX_V_DECIDE);
    }

    if (!didAction && (padInput.btnPress & PAD_BUTTON_B) != 0)
    {
        if (CViSailPrompt::CheckTrainingDisabled())
        {
            if (work->selection != 1)
            {
                work->selection = 1;
                PlayHubSfx(HUB_SFX_CURSOL);
            }
            else
            {
                didAction = TRUE;
                PlayHubSfx(HUB_SFX_V_CANCELL);
            }
        }
        else
        {
            if (work->selection != 2)
            {
                work->selection = 2;
                PlayHubSfx(HUB_SFX_CURSOL);
            }
            else
            {
                didAction = TRUE;
                PlayHubSfx(HUB_SFX_V_CANCELL);
            }
        }
    }

    FontWindowMWControl__SetPosition(&work->fontWindowMWControl, 40, 8 * (2 * work->selection + 1));
    FontWindowMWControl__Draw(&work->fontWindowMWControl);

    work->aniCursor.pos.x = 40;
    work->aniCursor.pos.y = 8 * (2 * work->selection + 1) + 8;
    AnimatorSprite__ProcessAnimationFast(&work->aniCursor);

    FontWindowAnimator__Draw(&work->fontWindowAnimator);
    FontAnimator__Draw(&work->fontAnimator);
    FontWindowMWControl__CallWindowFunc2(&work->fontWindowMWControl);

    if (!didAction)
        AnimatorSprite__DrawFrame(&work->aniCursor);

    if (didAction)
    {
        work->timer = 0;
        FontWindowMWControl__SetPaletteAnim(&work->fontWindowMWControl, 1);
        SetCurrentTaskMainEvent(CViSailPrompt::Main_MadeChoice);
    }
}

void CViSailPrompt::Main_MadeChoice(void)
{
    CViSailPrompt *work = TaskGetWorkCurrent(CViSailPrompt);

    FontWindowMWControl__Draw(&work->fontWindowMWControl);
    AnimatorSprite__ProcessAnimationFast(&work->aniCursor);
    FontWindowAnimator__Draw(&work->fontWindowAnimator);
    FontAnimator__Draw(&work->fontAnimator);
    FontWindowMWControl__CallWindowFunc2(&work->fontWindowMWControl);

    work->timer++;
    if (work->timer >= 16)
    {
        CViSailPrompt::SetBackground3Visible(FALSE);
        FontWindowAnimator__InitAnimation(&work->fontWindowAnimator, 4, 8, 0, 0);
        FontWindowAnimator__StartAnimating(&work->fontWindowAnimator);
        SetCurrentTaskMainEvent(CViSailPrompt::Main_ClosingWindow);
    }
}

void CViSailPrompt::Main_ClosingWindow(void)
{
    CViSailPrompt *work = TaskGetWorkCurrent(CViSailPrompt);

    CViSailPrompt::SetBackground2Visible(TRUE);

    FontWindowAnimator__Draw(&work->fontWindowAnimator);
    FontWindowAnimator__ProcessWindowAnim(&work->fontWindowAnimator);
    if (FontWindowAnimator__IsFinishedAnimating(&work->fontWindowAnimator))
    {
        CViSailPrompt::SetBackground2Visible(FALSE);
        FontWindowAnimator__SetWindowClosed(&work->fontWindowAnimator);
        SetCurrentTaskMainEvent(CViSailPrompt::Main_ApplyChoice);
    }
}

void CViSailPrompt::Main_ApplyChoice(void)
{
    CViSailPrompt *work = TaskGetWorkCurrent(CViSailPrompt);

    FontWindowAnimator__SetWindowOpen(&work->fontWindowAnimator);
    if (CViSailPrompt::CheckTrainingDisabled())
    {
        switch (work->selection)
        {
            case 0:
                CViDockNpcTalk::SetTalkAction(1);
                CViDockNpcTalk::SetSelection(work->type);
                break;

            // case 1:
            default:
                CViDockNpcTalk::SetTalkAction(0);
                CViDockNpcTalk::SetSelection(0);
                break;
        }
    }
    else
    {
        switch (work->selection)
        {
            case 0:
                CViDockNpcTalk::SetTalkAction(1);
                CViDockNpcTalk::SetSelection(work->type);
                break;

            case 1:
                CViDockNpcTalk::SetTalkAction(2);
                CViDockNpcTalk::SetSelection(work->type);
                SaveGame__Func_205BF5C(CViSailPrompt::Func_2169754(work->type));
                break;

            // case 2:
            default:
                CViDockNpcTalk::SetTalkAction(0);
                CViDockNpcTalk::SetSelection(0);
                break;
        }
    }

    DestroyCurrentTask();
}

void CViSailPrompt::Destructor(Task *task)
{
    CViSailPrompt *work = TaskGetWork(task, CViSailPrompt);

    work->Release();
}

u16 CViSailPrompt::HandleTouchSelectionControl(BOOL usePush)
{
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
        u16 pos = (1 + 2 * i) * 8;
        if ((u16)(x - 40) < 176 && (u16)(y - pos) < 16)
        {
            return i;
        }
    }

    return -1;
}

void CViSailPrompt::SetBackground2Visible(BOOL enabled)
{
    if (enabled)
        GX_SetVisiblePlane(GX_GetVisiblePlane() | GX_PLANEMASK_BG2);
    else
        GX_SetVisiblePlane(GX_GetVisiblePlane() & ~GX_PLANEMASK_BG2);
}

void CViSailPrompt::SetBackground3Visible(BOOL enabled)
{
    if (enabled)
        GX_SetVisiblePlane(GX_GetVisiblePlane() | GX_PLANEMASK_BG3);
    else
        GX_SetVisiblePlane(GX_GetVisiblePlane() & ~GX_PLANEMASK_BG3);
}

void CViSailPrompt::InitBackgroundVRAM()
{
    MI_CpuFill32((u8 *)VRAM_BG + sizeof(GXScrText32x32), VRAM_SCRFMT_TEXT_x2(VRAM_SCRFMT_TEXT(1023, FALSE, FALSE, PALETTE_ROW_0), VRAM_SCRFMT_TEXT(1023, FALSE, FALSE, PALETTE_ROW_0)),
                 sizeof(GXScrText32x32));
}

void CViSailPrompt::InitBackground2VRAM()
{
    MI_CpuClearFast((u8 *)VRAM_BG + (0x8000 - sizeof(GXCharFmt16)), sizeof(GXCharFmt16));
    MI_CpuClearFast((u8 *)VRAM_BG, 0x600);
}

BOOL CViSailPrompt::CheckTrainingDisabled()
{
    return SaveGame__GetGameProgress() < SAVE_PROGRESS_3;
}

BOOL CViSailPrompt::Func_21696F0(u16 a1)
{
    s32 progress = SaveGame__GetGameProgress();
    switch (a1)
    {
        case 0:
        case 1:
        case 2:
            break;

        case 3:
            if (progress < SAVE_PROGRESS_11)
                return TRUE;
            break;

        case 4:
            if (progress < SAVE_PROGRESS_24)
                return TRUE;
            break;

        case 5:
            if (progress < SAVE_PROGRESS_28)
                return TRUE;
            break;
    }

    return FALSE;
}

s32 CViSailPrompt::Func_2169754(u16 a1)
{
    switch (a1)
    {
        case 2:
            return 0;

        case 3:
            return 1;

        case 4:
            return 2;

        case 5:
            return 3;

        default:
            return 0;
    }
}