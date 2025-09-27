#include <ex/core/exPauseMenu.h>
#include <ex/core/exHUD.h>
#include <ex/system/exSystem.h>
#include <game/audio/audioSystem.h>
#include <game/input/padInput.h>

// --------------------
// MACROS
// --------------------

#define EXPAUSEMENU_OVERSHOOT_X (HW_LCD_CENTER_X + 4)

// --------------------
// VARIABLES
// --------------------

static ExPauseMenuAction exPauseMenuSelectedAction;
static Task *exPauseMenuTaskSingleton;

static u16 exPauseMenuPausedTextAnimTable[OS_LANGUAGE_CODE_MAX] = {
    [OS_LANGUAGE_JAPANESE] = EX_ACTCOM_ANI_PAUSE_TEXT_JPN, [OS_LANGUAGE_ENGLISH] = EX_ACTCOM_ANI_PAUSE_TEXT_ENG, [OS_LANGUAGE_FRENCH] = EX_ACTCOM_ANI_PAUSE_TEXT_FRA,
    [OS_LANGUAGE_GERMAN] = EX_ACTCOM_ANI_PAUSE_TEXT_DEU,   [OS_LANGUAGE_ITALIAN] = EX_ACTCOM_ANI_PAUSE_TEXT_ITA, [OS_LANGUAGE_SPANISH] = EX_ACTCOM_ANI_PAUSE_TEXT_SPA
};

static u16 exPauseMenuBackButtonAnimTable[2][OS_LANGUAGE_CODE_MAX] = {
    [0] = { [OS_LANGUAGE_JAPANESE] = EX_ACTCOM_ANI_BACK_BUTTON_JPN,
            [OS_LANGUAGE_ENGLISH]  = EX_ACTCOM_ANI_BACK_BUTTON_ENG,
            [OS_LANGUAGE_FRENCH]   = EX_ACTCOM_ANI_BACK_BUTTON_FRA,
            [OS_LANGUAGE_GERMAN]   = EX_ACTCOM_ANI_BACK_BUTTON_DEU,
            [OS_LANGUAGE_ITALIAN]  = EX_ACTCOM_ANI_BACK_BUTTON_ITA,
            [OS_LANGUAGE_SPANISH]  = EX_ACTCOM_ANI_BACK_BUTTON_SPA },

    [1] = { [OS_LANGUAGE_JAPANESE] = EX_ACTCOM_ANI_BACK_BUTTON_SELECTED_JPN,
            [OS_LANGUAGE_ENGLISH]  = EX_ACTCOM_ANI_BACK_BUTTON_SELECTED_ENG,
            [OS_LANGUAGE_FRENCH]   = EX_ACTCOM_ANI_BACK_BUTTON_SELECTED_FRA,
            [OS_LANGUAGE_GERMAN]   = EX_ACTCOM_ANI_BACK_BUTTON_SELECTED_DEU,
            [OS_LANGUAGE_ITALIAN]  = EX_ACTCOM_ANI_BACK_BUTTON_SELECTED_ITA,
            [OS_LANGUAGE_SPANISH]  = EX_ACTCOM_ANI_BACK_BUTTON_SELECTED_SPA },
};

static u16 exPauseMenuContinueButtonAnimTable[2][OS_LANGUAGE_CODE_MAX] = {
    [0] = { [OS_LANGUAGE_JAPANESE] = EX_ACTCOM_ANI_CONTINUE_BUTTON_JPN,
            [OS_LANGUAGE_ENGLISH]  = EX_ACTCOM_ANI_CONTINUE_BUTTON_ENG,
            [OS_LANGUAGE_FRENCH]   = EX_ACTCOM_ANI_CONTINUE_BUTTON_FRA,
            [OS_LANGUAGE_GERMAN]   = EX_ACTCOM_ANI_CONTINUE_BUTTON_DEU,
            [OS_LANGUAGE_ITALIAN]  = EX_ACTCOM_ANI_CONTINUE_BUTTON_ITA,
            [OS_LANGUAGE_SPANISH]  = EX_ACTCOM_ANI_CONTINUE_BUTTON_SPA },

    [1] = { [OS_LANGUAGE_JAPANESE] = EX_ACTCOM_ANI_CONTINUE_BUTTON_SELECTED_JPN,
            [OS_LANGUAGE_ENGLISH]  = EX_ACTCOM_ANI_CONTINUE_BUTTON_SELECTED_ENG,
            [OS_LANGUAGE_FRENCH]   = EX_ACTCOM_ANI_CONTINUE_BUTTON_SELECTED_FRA,
            [OS_LANGUAGE_GERMAN]   = EX_ACTCOM_ANI_CONTINUE_BUTTON_SELECTED_DEU,
            [OS_LANGUAGE_ITALIAN]  = EX_ACTCOM_ANI_CONTINUE_BUTTON_SELECTED_ITA,
            [OS_LANGUAGE_SPANISH]  = EX_ACTCOM_ANI_CONTINUE_BUTTON_SELECTED_SPA },
};

// --------------------
// FUNCTION DECLS
// --------------------

// ExPauseMenu
static void ExPauseMenu_Main_Init(void);
static void ExPauseMenu_OnCheckStageFinished(void);
static void ExPauseMenu_Destructor(void);
static void ExPauseMenu_Main_EnterButtons(void);
static void ExPauseMenu_Action_Ready(void);
static void ExPauseMenu_Main_Selecting(void);
static void ExPauseMenu_Action_Select(void);
static void ExPauseMenu_Main_SelectionMade(void);
static void ExPauseMenu_Main_Exit(void);
static void ExPauseMenu_Draw(void);

// --------------------
// FUNCTIONS
// --------------------

// ExPauseMenu
void ExPauseMenu_Main_Init(void)
{
    exPauseTask *work = ExTaskGetWorkCurrent(exPauseTask);

    exPauseMenuTaskSingleton = GetCurrentTask();

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_PAUSE);

    switch (*RenderCore_GetLanguagePtr())
    {
        case OS_LANGUAGE_JAPANESE:
            work->language = OS_LANGUAGE_JAPANESE;
            break;

        case OS_LANGUAGE_ENGLISH:
            work->language = OS_LANGUAGE_ENGLISH;
            break;

        case OS_LANGUAGE_FRENCH:
            work->language = OS_LANGUAGE_FRENCH;
            break;

        case OS_LANGUAGE_GERMAN:
            work->language = OS_LANGUAGE_GERMAN;
            break;

        case OS_LANGUAGE_ITALIAN:
            work->language = OS_LANGUAGE_ITALIAN;
            break;

        case OS_LANGUAGE_SPANISH:
            work->language = OS_LANGUAGE_SPANISH;
            break;

        default:
            work->language = OS_LANGUAGE_ENGLISH;
            break;
    }

    work->aniPauseText.sprite.anim       = exPauseMenuPausedTextAnimTable[work->language];
    work->aniPauseText.sprite.paletteRow = PALETTE_ROW_8;
    SetupExHUDSprite(&work->aniPauseText);
    SetExDrawRequestPriority(&work->aniPauseText.config, EXDRAWREQTASK_PRIORITY_HUD);
    work->aniPauseText.sprite.pos.x = -36;
    work->aniPauseText.sprite.pos.y = 60;
    SetExDrawRequestSprite2DOnlyEngineB(&work->aniPauseText);
    SetExDrawRequestAnimAsOneShot(&work->aniPauseText.config);

    work->aniPauseText.config.display.disableAffine = TRUE;
    work->aniPauseText.sprite.animator.oamPriority  = SPRITE_PRIORITY_0;

    for (u16 i = 0; i < 2; i++)
    {
        work->aniContinueButton[i].sprite.anim       = exPauseMenuContinueButtonAnimTable[i][work->language];
        work->aniContinueButton[i].sprite.paletteRow = PALETTE_ROW_8;
        SetupExHUDSprite(&work->aniContinueButton[i]);
        SetExDrawRequestPriority(&work->aniContinueButton[i].config, EXDRAWREQTASK_PRIORITY_HUD);
        work->aniContinueButton[i].sprite.pos.x = -36;
        work->aniContinueButton[i].sprite.pos.y = 72;
        SetExDrawRequestSprite2DOnlyEngineB(&work->aniContinueButton[i]);
        SetExDrawRequestAnimStopOnFinish(&work->aniContinueButton[i].config);
        work->aniContinueButton[i].config.display.disableAffine = TRUE;
        work->aniContinueButton[i].sprite.animator.oamPriority  = SPRITE_PRIORITY_0;

        work->aniBackButton[i].sprite.anim       = exPauseMenuBackButtonAnimTable[i][work->language];
        work->aniBackButton[i].sprite.paletteRow = PALETTE_ROW_8;
        SetupExHUDSprite(&work->aniBackButton[i]);
        SetExDrawRequestPriority(&work->aniBackButton[i].config, EXDRAWREQTASK_PRIORITY_HUD);
        work->aniBackButton[i].sprite.pos.x = -36;
        work->aniBackButton[i].sprite.pos.y = 88;
        SetExDrawRequestSprite2DOnlyEngineB(&work->aniBackButton[i]);
        SetExDrawRequestAnimStopOnFinish(&work->aniBackButton[i].config);
        work->aniBackButton[i].config.display.disableAffine = TRUE;
        work->aniBackButton[i].sprite.animator.oamPriority  = SPRITE_PRIORITY_0;
    }

    work->buttonSelected[EXPAUSEMENU_BUTTON_CONTINUE] = TRUE;
    work->buttonSelected[EXPAUSEMENU_BUTTON_BACK]     = FALSE;

    work->pauseTextLerpPercent                           = FLOAT_TO_FX32(0.0);
    work->buttonLerpPercent[EXPAUSEMENU_BUTTON_CONTINUE] = FLOAT_TO_FX32(0.0);
    work->buttonLerpPercent[EXPAUSEMENU_BUTTON_BACK]     = FLOAT_TO_FX32(0.0);

    work->pauseTextOvershootPercent                           = FLOAT_TO_FX32(0.0);
    work->buttonOvershootPercent[EXPAUSEMENU_BUTTON_CONTINUE] = FLOAT_TO_FX32(0.0);
    work->buttonOvershootPercent[EXPAUSEMENU_BUTTON_BACK]     = FLOAT_TO_FX32(0.0);

    work->timer = 0;

    SetCurrentExTaskMainEvent(ExPauseMenu_Main_EnterButtons);
}

void ExPauseMenu_OnCheckStageFinished(void)
{
    exPauseTask *work = ExTaskGetWorkCurrent(exPauseTask);
    UNUSED(work);
}

void ExPauseMenu_Destructor(void)
{
    exPauseTask *work = ExTaskGetWorkCurrent(exPauseTask);

    ReleaseExHUDSprite(&work->aniPauseText);

    for (u16 i = 0; i < 2; i++)
    {
        ReleaseExHUDSprite(&work->aniContinueButton[i]);
        ReleaseExHUDSprite(&work->aniBackButton[i]);
    }

    exPauseMenuTaskSingleton = NULL;
}

void ExPauseMenu_Main_EnterButtons(void)
{
    exPauseTask *work = ExTaskGetWorkCurrent(exPauseTask);

    if (work->pauseTextLerpPercent >= FLOAT_TO_FX32(1.0))
    {
        if (work->pauseTextOvershootPercent < FLOAT_TO_FX32(1.0))
        {
            work->pauseTextOvershootPercent += FLOAT_TO_FX32(0.5);
            work->aniPauseText.sprite.pos.x =
                (MultiplyFX(-FLOAT_TO_FX32(4.0), work->pauseTextOvershootPercent) + FLOAT_TO_FX32(EXPAUSEMENU_OVERSHOOT_X)) / (float)FLOAT_TO_FX32(1.0);
        }
    }
    else
    {
        work->pauseTextLerpPercent += FLOAT_TO_FX32(0.125);
        work->aniPauseText.sprite.pos.x = mtLerpEx2(work->pauseTextLerpPercent, -FLOAT_TO_FX32(36.0), FLOAT_TO_FX32(EXPAUSEMENU_OVERSHOOT_X), 2) / (float)FLOAT_TO_FX32(1.0);
    }

    if (work->timer > 2)
    {
        if (work->buttonLerpPercent[EXPAUSEMENU_BUTTON_CONTINUE] >= FLOAT_TO_FX32(1.0))
        {
            if (work->buttonOvershootPercent[EXPAUSEMENU_BUTTON_CONTINUE] < FLOAT_TO_FX32(1.0))
            {
                work->buttonOvershootPercent[EXPAUSEMENU_BUTTON_CONTINUE] += FLOAT_TO_FX32(0.5);
                work->aniContinueButton[work->buttonSelected[EXPAUSEMENU_BUTTON_CONTINUE]].sprite.pos.x =
                    (MultiplyFX(-FLOAT_TO_FX32(4.0), work->buttonOvershootPercent[EXPAUSEMENU_BUTTON_CONTINUE]) + FLOAT_TO_FX32(EXPAUSEMENU_OVERSHOOT_X))
                    / (float)FLOAT_TO_FX32(1.0);
            }
        }
        else
        {
            work->buttonLerpPercent[EXPAUSEMENU_BUTTON_CONTINUE] += FLOAT_TO_FX32(0.125);
            work->aniContinueButton[work->buttonSelected[EXPAUSEMENU_BUTTON_CONTINUE]].sprite.pos.x =
                mtLerpEx2(work->buttonLerpPercent[EXPAUSEMENU_BUTTON_CONTINUE], -FLOAT_TO_FX32(36.0), FLOAT_TO_FX32(EXPAUSEMENU_OVERSHOOT_X), 2) / (float)FLOAT_TO_FX32(1.0);
        }
    }

    if (work->timer > 4)
    {
        if (work->buttonLerpPercent[EXPAUSEMENU_BUTTON_BACK] >= FLOAT_TO_FX32(1.0))
        {
            if (work->buttonOvershootPercent[EXPAUSEMENU_BUTTON_BACK] >= FLOAT_TO_FX32(1.0))
            {
                ExPauseMenu_Action_Ready();
                return;
            }

            work->buttonOvershootPercent[EXPAUSEMENU_BUTTON_BACK] += FLOAT_TO_FX32(0.5);
            work->aniBackButton[work->buttonSelected[EXPAUSEMENU_BUTTON_BACK]].sprite.pos.x =
                (MultiplyFX(-FLOAT_TO_FX32(4.0), work->buttonOvershootPercent[EXPAUSEMENU_BUTTON_BACK]) + FLOAT_TO_FX32(EXPAUSEMENU_OVERSHOOT_X)) / (float)FLOAT_TO_FX32(1.0);
        }
        else
        {
            work->buttonLerpPercent[EXPAUSEMENU_BUTTON_BACK] += FLOAT_TO_FX32(0.125);
            work->aniBackButton[work->buttonSelected[EXPAUSEMENU_BUTTON_BACK]].sprite.pos.x =
                mtLerpEx2(work->buttonLerpPercent[EXPAUSEMENU_BUTTON_BACK], -FLOAT_TO_FX32(36.0), FLOAT_TO_FX32(EXPAUSEMENU_OVERSHOOT_X), 2) / (float)FLOAT_TO_FX32(1.0);
        }
    }
    else
    {
        work->timer++;
    }

    ExPauseMenu_Draw();

    RunCurrentExTaskOnCheckStageFinishedEvent();
}

void ExPauseMenu_Action_Ready(void)
{
    exPauseTask *work = ExTaskGetWorkCurrent(exPauseTask);

    work->aniPauseText.sprite.pos.x = HW_LCD_CENTER_X;

    for (u16 i = 0; i < 2; i++)
    {
        work->aniContinueButton[i].sprite.pos.x = HW_LCD_CENTER_X;
        work->aniBackButton[i].sprite.pos.x     = HW_LCD_CENTER_X;
    }

    SetCurrentExTaskMainEvent(ExPauseMenu_Main_Selecting);
    ExPauseMenu_Main_Selecting();
}

void ExPauseMenu_Main_Selecting(void)
{
    exPauseTask *work = ExTaskGetWorkCurrent(exPauseTask);

    if ((padInput.btnPress & PAD_KEY_UP) != 0)
    {
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_CURSOL);
        work->buttonSelected[EXPAUSEMENU_BUTTON_CONTINUE] = TRUE;
        work->buttonSelected[EXPAUSEMENU_BUTTON_BACK]     = FALSE;
    }
    else if ((padInput.btnPress & PAD_KEY_DOWN) != 0)
    {
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_CURSOL);
        work->buttonSelected[EXPAUSEMENU_BUTTON_CONTINUE] = FALSE;
        work->buttonSelected[EXPAUSEMENU_BUTTON_BACK]     = TRUE;
    }
    else
    {
        if ((padInput.btnPress & PAD_BUTTON_A) != 0)
        {
            work->madeSelection = TRUE;
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DECISION);
            ExPauseMenu_Action_Select();
            return;
        }
        else if ((padInput.btnPress & PAD_BUTTON_START) != 0)
        {
            work->madeSelection                               = FALSE;
            work->buttonSelected[EXPAUSEMENU_BUTTON_CONTINUE] = TRUE;
            work->buttonSelected[EXPAUSEMENU_BUTTON_BACK]     = FALSE;
            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_PAUSE);
            ExPauseMenu_Action_Select();
            return;
        }
    }

    ExPauseMenu_Draw();

    RunCurrentExTaskOnCheckStageFinishedEvent();
}

void ExPauseMenu_Action_Select(void)
{
    exPauseTask *work = ExTaskGetWorkCurrent(exPauseTask);

    work->buttonLerpPercent[EXPAUSEMENU_BUTTON_CONTINUE] = work->buttonLerpPercent[EXPAUSEMENU_BUTTON_BACK] = FLOAT_TO_FX32(0.0);
    work->timer                                                                                             = 16;

    SetCurrentExTaskMainEvent(ExPauseMenu_Main_SelectionMade);
    ExPauseMenu_Main_SelectionMade();
}

void ExPauseMenu_Main_SelectionMade(void)
{
    exPauseTask *work = ExTaskGetWorkCurrent(exPauseTask);

    if (work->buttonSelected[EXPAUSEMENU_BUTTON_CONTINUE])
    {
        if (work->buttonLerpPercent[EXPAUSEMENU_BUTTON_BACK] >= FLOAT_TO_FX32(1.0))
        {
            SetCurrentExTaskMainEvent(ExPauseMenu_Main_Exit);
            ExPauseMenu_Main_Exit();
            return;
        }

        work->buttonLerpPercent[EXPAUSEMENU_BUTTON_BACK] += FLOAT_TO_FX32(0.125);
        work->aniBackButton[work->buttonSelected[EXPAUSEMENU_BUTTON_BACK]].sprite.pos.x =
            (MultiplyFX(FLOAT_TO_FX32(160.0), work->buttonLerpPercent[EXPAUSEMENU_BUTTON_BACK]) + FLOAT_TO_FX32(HW_LCD_CENTER_X)) / (float)FLOAT_TO_FX32(1.0);
    }
    else if (work->buttonSelected[EXPAUSEMENU_BUTTON_BACK])
    {
        if (work->buttonLerpPercent[EXPAUSEMENU_BUTTON_CONTINUE] >= FLOAT_TO_FX32(1.0))
        {
            SetCurrentExTaskMainEvent(ExPauseMenu_Main_Exit);
            ExPauseMenu_Main_Exit();
            return;
        }

        work->buttonLerpPercent[EXPAUSEMENU_BUTTON_CONTINUE] += FLOAT_TO_FX32(0.125);
        work->aniContinueButton[work->buttonSelected[EXPAUSEMENU_BUTTON_CONTINUE]].sprite.pos.x =
            (MultiplyFX(FLOAT_TO_FX32(160.0), work->buttonLerpPercent[EXPAUSEMENU_BUTTON_CONTINUE]) + FLOAT_TO_FX32(HW_LCD_CENTER_X)) / (float)FLOAT_TO_FX32(1.0);
    }

    ExPauseMenu_Draw();

    RunCurrentExTaskOnCheckStageFinishedEvent();
}

void ExPauseMenu_Main_Exit(void)
{
    exPauseTask *work = ExTaskGetWorkCurrent(exPauseTask);

    if (work->timer <= 0)
    {
        work->timer--;
    }
    else
    {
        if (work->madeSelection)
        {
            if (work->buttonSelected[EXPAUSEMENU_BUTTON_CONTINUE])
            {
                exPauseMenuSelectedAction = EXPAUSEMENU_ACTION_CONTINUE;
            }
            else if (work->buttonSelected[EXPAUSEMENU_BUTTON_BACK])
            {
                exPauseMenuSelectedAction = EXPAUSEMENU_ACTION_BACK;
            }
        }
        else
        {
            exPauseMenuSelectedAction = EXPAUSEMENU_ACTION_CONTINUE;
        }
    }

    ExPauseMenu_Draw();

    DestroyCurrentExTask();
}

void ExPauseMenu_Draw(void)
{
    exPauseTask *work = ExTaskGetWorkCurrent(exPauseTask);

    AnimateExDrawRequestSprite2D(&work->aniPauseText);
    AnimateExDrawRequestSprite2D(&work->aniContinueButton[work->buttonSelected[EXPAUSEMENU_BUTTON_CONTINUE]]);
    AnimateExDrawRequestSprite2D(&work->aniBackButton[work->buttonSelected[EXPAUSEMENU_BUTTON_BACK]]);

    work->aniPauseText.sprite.animator.pos.x = work->aniPauseText.sprite.pos.x;
    work->aniPauseText.sprite.animator.pos.y = work->aniPauseText.sprite.pos.y;

    work->aniContinueButton[work->buttonSelected[EXPAUSEMENU_BUTTON_CONTINUE]].sprite.animator.pos.x =
        work->aniContinueButton[work->buttonSelected[EXPAUSEMENU_BUTTON_CONTINUE]].sprite.pos.x;
    work->aniContinueButton[work->buttonSelected[EXPAUSEMENU_BUTTON_CONTINUE]].sprite.animator.pos.y =
        work->aniContinueButton[work->buttonSelected[EXPAUSEMENU_BUTTON_CONTINUE]].sprite.pos.y;

    work->aniBackButton[work->buttonSelected[EXPAUSEMENU_BUTTON_BACK]].sprite.animator.pos.x = work->aniBackButton[work->buttonSelected[EXPAUSEMENU_BUTTON_BACK]].sprite.pos.x;
    work->aniBackButton[work->buttonSelected[EXPAUSEMENU_BUTTON_BACK]].sprite.animator.pos.y = work->aniBackButton[work->buttonSelected[EXPAUSEMENU_BUTTON_BACK]].sprite.pos.y;

    if (Camera3D__UseEngineA())
    {
        AnimatorSprite__DrawFrame(&work->aniPauseText.sprite.animator);
        AnimatorSprite__DrawFrame(&work->aniContinueButton[work->buttonSelected[EXPAUSEMENU_BUTTON_CONTINUE]].sprite.animator);
        AnimatorSprite__DrawFrame(&work->aniBackButton[work->buttonSelected[EXPAUSEMENU_BUTTON_BACK]].sprite.animator);
    }
}

BOOL CreateExPauseMenu(void)
{
    Task *task = ExTaskCreate(ExPauseMenu_Main_Init, ExPauseMenu_Destructor, TASK_PRIORITY_UPDATE_LIST_END - 0, TASK_GROUP(3), 0, EXTASK_TYPE_ALWAYSUPDATE, exPauseTask);

    exPauseTask *work = ExTaskGetWork(task, exPauseTask);
    TaskInitWork8(work);

    SetExTaskOnCheckStageFinishedEvent(task, ExPauseMenu_OnCheckStageFinished);

    exPauseMenuSelectedAction = EXPAUSEMENU_ACTION_NONE;

    return TRUE;
}

ExPauseMenuAction GetExPauseMenuSelectedAction(void)
{
    return exPauseMenuSelectedAction;
}