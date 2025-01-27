#include <ex/core/exTitleCard.h>
#include <ex/core/exTutorialMessage.h>
#include <ex/core/exHUD.h>
#include <ex/system/exSystem.h>
#include <game/audio/audioSystem.h>
#include <game/input/padInput.h>

// --------------------
// VARIABLES
// --------------------

static Task *exTitleCardTaskSingleton;
static Task *exTutorialMessageTaskSingleton;

static EX_ACTION_BAC2D_WORK exTitleCardAniZoneIcon;
static EX_ACTION_BAC2D_WORK exTitleCardAniBackdrop;
static EX_ACTION_BAC2D_WORK exTitleCardAniZoneLetter_E;
static EX_ACTION_BAC2D_WORK exTitleCardAniZoneLetter_X;
static EX_ACTION_BAC2D_WORK exTitleCardAniZoneLetter_T;
static EX_ACTION_BAC2D_WORK exTitleCardAniZoneNameTextJP;
static EX_ACTION_BAC2D_WORK exTitleCardAniActBanner;
static EX_ACTION_BAC2D_WORK exTitleCardAniReadyText;
static EX_ACTION_BAC2D_WORK exTitleCardAniGoText;
static EX_ACTION_BAC2D_WORK exTitleCardAniZoneLetter_A;
static EX_ACTION_BAC2D_WORK exTitleCardAniZoneLetter_R;

static u16 exTutorialMessageTextAnims[EXPLAYER_CHARACTER_COUNT][OS_LANGUAGE_CODE_MAX] = {
    [EXPLAYER_CHARACTER_SONIC] = { [OS_LANGUAGE_JAPANESE] = EX_ACTCOM_ANI_TUTORIAL_TEXT_SONIC_JPN,
                                   [OS_LANGUAGE_ENGLISH]  = EX_ACTCOM_ANI_TUTORIAL_TEXT_SONIC_ENG,
                                   [OS_LANGUAGE_FRENCH]   = EX_ACTCOM_ANI_TUTORIAL_TEXT_SONIC_FRA,
                                   [OS_LANGUAGE_GERMAN]   = EX_ACTCOM_ANI_TUTORIAL_TEXT_SONIC_DEU,
                                   [OS_LANGUAGE_ITALIAN]  = EX_ACTCOM_ANI_TUTORIAL_TEXT_SONIC_ITA,
                                   [OS_LANGUAGE_SPANISH]  = EX_ACTCOM_ANI_TUTORIAL_TEXT_SONIC_SPA },

    [EXPLAYER_CHARACTER_BLAZE] = { [OS_LANGUAGE_JAPANESE] = EX_ACTCOM_ANI_TUTORIAL_TEXT_BLAZE_JPN,
                                   [OS_LANGUAGE_ENGLISH]  = EX_ACTCOM_ANI_TUTORIAL_TEXT_BLAZE_ENG,
                                   [OS_LANGUAGE_FRENCH]   = EX_ACTCOM_ANI_TUTORIAL_TEXT_BLAZE_FRA,
                                   [OS_LANGUAGE_GERMAN]   = EX_ACTCOM_ANI_TUTORIAL_TEXT_BLAZE_DEU,
                                   [OS_LANGUAGE_ITALIAN]  = EX_ACTCOM_ANI_TUTORIAL_TEXT_BLAZE_ITA,
                                   [OS_LANGUAGE_SPANISH]  = EX_ACTCOM_ANI_TUTORIAL_TEXT_BLAZE_SPA },
};

static u16 exTutorialMessageTextScrollLimit[EXPLAYER_CHARACTER_COUNT][OS_LANGUAGE_CODE_MAX] = {
    [EXPLAYER_CHARACTER_SONIC] = { [OS_LANGUAGE_JAPANESE] = 392,
                                   [OS_LANGUAGE_ENGLISH]  = 488,
                                   [OS_LANGUAGE_FRENCH]   = 472,
                                   [OS_LANGUAGE_GERMAN]   = 496,
                                   [OS_LANGUAGE_ITALIAN]  = 432,
                                   [OS_LANGUAGE_SPANISH]  = 432 },

    [EXPLAYER_CHARACTER_BLAZE] = { [OS_LANGUAGE_JAPANESE] = 376,
                                   [OS_LANGUAGE_ENGLISH]  = 368,
                                   [OS_LANGUAGE_FRENCH]   = 392,
                                   [OS_LANGUAGE_GERMAN]   = 352,
                                   [OS_LANGUAGE_ITALIAN]  = 400,
                                   [OS_LANGUAGE_SPANISH]  = 384 },
};

// --------------------
// FUNCTION DECLS
// --------------------

// ExTutorialMessage
static u16 GetExTutorialMessageLanguage(void);
static void ExTutorialMessage_Main_Init(void);
static void ExTutorialMessage_TaskUnknown(void);
static void ExTutorialMessage_Destructor(void);
static void ExTutorialMessage_Main_Active(void);

// ExTitleCard
static void ExTitleCard_Main_Init(void);
static void ExTitleCard_Main_TaskUnknown(void);
static void ExTitleCard_Destructor(void);
static void ExTitleCard_Main_IntroDelay(void);
static void ExTitleCard_Action_InitZoneIcon(void);
static void ExTitleCard_Main_EnterZoneIcon(void);
static void ExTitleCard_Action_InitZoneActText(void);
static void ExTitleCard_Main_ShowZoneActText(void);
static void ExTitleCard_Action_ExitNameplate(void);
static void ExTitleCard_Main_ExitNameplate(void);
static void ExTitleCard_Action_ShowReadyText(void);
static void ExTitleCard_Main_ShowReadyText(void);
static void ExTitleCard_Action_StartShowingGoText(void);
static void ExTitleCard_Main_StartShowingGoText(void);
static void ExTitleCard_Action_ShowGoText(void);
static void ExTitleCard_Main_ShowGoText(void);
static void ExTitleCard_Action_StartOutro(void);
static void ExTitleCard_Main_OutroDelay(void);

// --------------------
// FUNCTIONS
// --------------------

// ExTutorialMessage
u16 GetExTutorialMessageLanguage(void)
{
    s32 id;
    switch (*RenderCore_GetLanguagePtr())
    {
        case OS_LANGUAGE_JAPANESE:
            id = OS_LANGUAGE_JAPANESE;
            break;

        case OS_LANGUAGE_ENGLISH:
            id = OS_LANGUAGE_ENGLISH;
            break;

        case OS_LANGUAGE_FRENCH:
            id = OS_LANGUAGE_FRENCH;
            break;

        case OS_LANGUAGE_GERMAN:
            id = OS_LANGUAGE_GERMAN;
            break;

        case OS_LANGUAGE_ITALIAN:
            id = OS_LANGUAGE_ITALIAN;
            break;

        case OS_LANGUAGE_SPANISH:
            id = OS_LANGUAGE_SPANISH;
            break;

        default:
            id = OS_LANGUAGE_ENGLISH;
            break;
    }

    return id;
}

void ExTutorialMessage_Main_Init(void)
{
    exMsgTutorialTask *work = ExTaskGetWorkCurrent(exMsgTutorialTask);

    exTutorialMessageTaskSingleton = GetCurrentTask();

    work->language     = GetExTutorialMessageLanguage();
    work->playerWorker = exPlayerAdminTask__GetUnknown2();

    for (u16 i = 0; i < EXPLAYER_CHARACTER_COUNT; i++)
    {
        work->aniMessage[i].sprite.anim       = exTutorialMessageTextAnims[i][work->language];
        work->aniMessage[i].sprite.paletteRow = PALETTE_ROW_3;
        SetupExHUDSprite(&work->aniMessage[i]);
        exDrawReqTask__SetConfigPriority(&work->aniMessage[i].config, 0xE002);
        work->aniMessage[i].sprite.pos.x            = 0;
        work->aniMessage[i].sprite.pos.y            = 0;
        work->aniMessage[i].config.field_2.value_20 = TRUE;
        exDrawReqTask__Sprite2D__Func_2161B80(&work->aniMessage[i]);
        exDrawReqTask__Func_21641F0(&work->aniMessage[i].config);
    }

    work->aniBorder.sprite.anim       = EX_ACTCOM_ANI_TUTORIAL_TEXT_BACKDROP;
    work->aniBorder.sprite.paletteRow = PALETTE_ROW_3;
    SetupExHUDSprite(&work->aniBorder);
    exDrawReqTask__SetConfigPriority(&work->aniBorder.config, 0xE001);
    work->aniBorder.sprite.pos.x            = 0;
    work->aniBorder.sprite.pos.y            = 0;
    work->aniBorder.config.field_2.value_20 = TRUE;
    exDrawReqTask__Sprite2D__Func_2161B80(&work->aniBorder);
    exDrawReqTask__Func_21641F0(&work->aniBorder.config);
    work->aniBorder.sprite.field_78 = 5;

    work->scrollPos = HW_LCD_CENTER_X;

    SetCurrentExTaskMainEvent(ExTutorialMessage_Main_Active);
}

void ExTutorialMessage_TaskUnknown(void)
{
    exMsgTutorialTask *work = ExTaskGetWorkCurrent(exMsgTutorialTask);
    UNUSED(work);

    if (GetExSystemFlag_2178650())
        DestroyCurrentExTask();
}

void ExTutorialMessage_Destructor(void)
{
    exMsgTutorialTask *work = ExTaskGetWorkCurrent(exMsgTutorialTask);

    ReleaseExHUDSprite(&work->aniMessage[EXPLAYER_CHARACTER_SONIC]);
    ReleaseExHUDSprite(&work->aniMessage[EXPLAYER_CHARACTER_BLAZE]);
    ReleaseExHUDSprite(&work->aniBorder);

    exTutorialMessageTaskSingleton = NULL;
}

void ExTutorialMessage_Main_Active(void)
{
    exMsgTutorialTask *work = ExTaskGetWorkCurrent(exMsgTutorialTask);

    u8 character = EXPLAYER_CHARACTER_SONIC;
    if (work->playerWorker->activeCharacter.value_1)
        character = EXPLAYER_CHARACTER_BLAZE;

    exDrawReqTask__Sprite2D__Animate(&work->aniMessage[character]);
    exDrawReqTask__Sprite2D__Animate(&work->aniBorder);

    s32 scrollLimit = exTutorialMessageTextScrollLimit[character][work->language];

    if (work->scrollPos <= -(scrollLimit - HW_LCD_CENTER_X))
        work->scrollPos = HW_LCD_CENTER_X;
    else
        work->scrollPos--;

    work->aniMessage[character].sprite.pos.x = work->scrollPos;
    exDrawReqTask__AddRequest(&work->aniMessage[character], &work->aniMessage[character].config);

    work->aniMessage[character].sprite.pos.x -= scrollLimit;
    exDrawReqTask__AddRequest(&work->aniMessage[character], &work->aniMessage[character].config);
    work->aniMessage[character].sprite.pos.x += scrollLimit;

    work->aniMessage[character].sprite.pos.x += scrollLimit;
    exDrawReqTask__AddRequest(&work->aniMessage[character], &work->aniMessage[character].config);
    work->aniMessage[character].sprite.pos.x -= scrollLimit;

    exDrawReqTask__AddRequest(&work->aniBorder, &work->aniBorder.config);

    RunCurrentExTaskUnknownEvent();
}

BOOL CreateExTutorialMessage(void)
{
    Task *task =
        ExTaskCreate(ExTutorialMessage_Main_Init, ExTutorialMessage_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(3), 0, EXTASK_TYPE_REGULAR, exMsgTutorialTask);

    exMsgTutorialTask *work = ExTaskGetWork(task, exMsgTutorialTask);
    TaskInitWork8(work);

    SetExTaskUnknownEvent(task, ExTutorialMessage_TaskUnknown);

    return TRUE;
}

void DestroyExTutorialMessage(void)
{
    if (exTutorialMessageTaskSingleton != NULL)
        DestroyExTask(exTutorialMessageTaskSingleton);
}

// ExTitleCard
void ExTitleCard_Main_Init(void)
{
    exMsgTitleTask *work = ExTaskGetWorkCurrent(exMsgTitleTask);

    exTitleCardTaskSingleton = GetCurrentTask();

    work->aniBackdrop                             = &exTitleCardAniBackdrop;
    work->aniZoneNameTextJP                       = &exTitleCardAniZoneNameTextJP;
    work->aniZoneIcon                             = &exTitleCardAniZoneIcon;
    work->aniActBanner                            = &exTitleCardAniActBanner;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_E] = &exTitleCardAniZoneLetter_E;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_X] = &exTitleCardAniZoneLetter_X;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_T] = &exTitleCardAniZoneLetter_T;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_R] = &exTitleCardAniZoneLetter_R;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_A] = &exTitleCardAniZoneLetter_A;
    work->aniReadyText                            = &exTitleCardAniReadyText;
    work->aniGoText                               = &exTitleCardAniGoText;

    work->aniBackdrop->sprite.anim       = EX_ACTCOM_ANI_TITLECARD_BACKDROP;
    work->aniBackdrop->sprite.paletteRow = PALETTE_ROW_4;
    SetupExHUDSprite(work->aniBackdrop);
    exDrawReqTask__SetConfigPriority(&work->aniBackdrop->config, 0xE000);
    work->aniBackdrop->sprite.pos.x = 0;
    work->aniBackdrop->sprite.pos.y = 0;
    exDrawReqTask__Sprite2D__Func_2161B80(work->aniBackdrop);
    exDrawReqTask__Func_21641F0(&work->aniBackdrop->config);

    work->aniZoneNameTextJP->sprite.anim       = EX_ACTCOM_ANI_TITLECARD_ZONE_NAME_TEXT_JP;
    work->aniZoneNameTextJP->sprite.paletteRow = PALETTE_ROW_6;
    SetupExHUDSprite(work->aniZoneNameTextJP);
    exDrawReqTask__SetConfigPriority(&work->aniZoneNameTextJP->config, 0xE000);
    work->aniZoneNameTextJP->sprite.pos.x = 0;
    work->aniZoneNameTextJP->sprite.pos.y = 0;
    exDrawReqTask__Sprite2D__Func_2161B80(work->aniZoneNameTextJP);
    exDrawReqTask__Func_21641F0(&work->aniZoneNameTextJP->config);

    work->aniZoneIcon->sprite.anim       = EX_ACTCOM_ANI_TITLECARD_ICON;
    work->aniZoneIcon->sprite.paletteRow = PALETTE_ROW_5;
    SetupExHUDSprite(work->aniZoneIcon);
    exDrawReqTask__SetConfigPriority(&work->aniZoneIcon->config, 0xE001);
    work->aniZoneIcon->sprite.pos.x = HW_LCD_CENTER_X;
    work->aniZoneIcon->sprite.pos.y = 96;

    exDrawReqTask__Sprite2D__Func_2161B80(work->aniZoneIcon);
    exDrawReqTask__Func_21641F0(&work->aniZoneIcon->config);
    work->aniActBanner->sprite.anim       = EX_ACTCOM_ANI_TITLECARD_ACT_BANNER;
    work->aniActBanner->sprite.paletteRow = PALETTE_ROW_6;
    SetupExHUDSprite(work->aniActBanner);
    exDrawReqTask__SetConfigPriority(&work->aniActBanner->config, 0xE000);
    work->aniActBanner->sprite.pos.x = 0;
    work->aniActBanner->sprite.pos.y = 0;

    exDrawReqTask__Sprite2D__Func_2161B80(work->aniActBanner);
    exDrawReqTask__Func_21641F0(&work->aniActBanner->config);
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_E]->sprite.anim       = EX_ACTCOM_ANI_TITLECARD_LETTER_E;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_E]->sprite.paletteRow = PALETTE_ROW_6;
    SetupExHUDSprite(work->aniZoneLetter[EXTITLECARD_ZONELETTER_E]);
    exDrawReqTask__SetConfigPriority(&work->aniZoneLetter[EXTITLECARD_ZONELETTER_E]->config, 0xE000);
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_E]->sprite.pos.x = 0;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_E]->sprite.pos.y = 0;
    exDrawReqTask__Sprite2D__Func_2161B80(work->aniZoneLetter[EXTITLECARD_ZONELETTER_E]);
    exDrawReqTask__Func_21641F0(&work->aniZoneLetter[EXTITLECARD_ZONELETTER_E]->config);

    work->aniZoneLetter[EXTITLECARD_ZONELETTER_X]->sprite.anim       = EX_ACTCOM_ANI_TITLECARD_LETTER_X;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_X]->sprite.paletteRow = PALETTE_ROW_6;
    SetupExHUDSprite(work->aniZoneLetter[EXTITLECARD_ZONELETTER_X]);
    exDrawReqTask__SetConfigPriority(&work->aniZoneLetter[EXTITLECARD_ZONELETTER_X]->config, 0xE000);
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_X]->sprite.pos.x = 0;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_X]->sprite.pos.y = 0;
    exDrawReqTask__Sprite2D__Func_2161B80(work->aniZoneLetter[EXTITLECARD_ZONELETTER_X]);
    exDrawReqTask__Func_21641F0(&work->aniZoneLetter[EXTITLECARD_ZONELETTER_X]->config);

    work->aniZoneLetter[EXTITLECARD_ZONELETTER_T]->sprite.anim       = EX_ACTCOM_ANI_TITLECARD_LETTER_T;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_T]->sprite.paletteRow = PALETTE_ROW_6;
    SetupExHUDSprite(work->aniZoneLetter[EXTITLECARD_ZONELETTER_T]);
    exDrawReqTask__SetConfigPriority(&work->aniZoneLetter[EXTITLECARD_ZONELETTER_T]->config, 0xE000);
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_T]->sprite.pos.x = 0;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_T]->sprite.pos.y = 0;
    exDrawReqTask__Sprite2D__Func_2161B80(work->aniZoneLetter[EXTITLECARD_ZONELETTER_T]);
    exDrawReqTask__Func_21641F0(&work->aniZoneLetter[EXTITLECARD_ZONELETTER_T]->config);

    work->aniZoneLetter[EXTITLECARD_ZONELETTER_R]->sprite.anim       = EX_ACTCOM_ANI_TITLECARD_LETTER_R;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_R]->sprite.paletteRow = PALETTE_ROW_6;
    SetupExHUDSprite(work->aniZoneLetter[EXTITLECARD_ZONELETTER_R]);
    exDrawReqTask__SetConfigPriority(&work->aniZoneLetter[EXTITLECARD_ZONELETTER_R]->config, 0xE000);
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_R]->sprite.pos.x = 0;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_R]->sprite.pos.y = 0;
    exDrawReqTask__Sprite2D__Func_2161B80(work->aniZoneLetter[EXTITLECARD_ZONELETTER_R]);
    exDrawReqTask__Func_21641F0(&work->aniZoneLetter[EXTITLECARD_ZONELETTER_R]->config);

    work->aniZoneLetter[EXTITLECARD_ZONELETTER_A]->sprite.anim       = EX_ACTCOM_ANI_TITLECARD_LETTER_A;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_A]->sprite.paletteRow = PALETTE_ROW_6;
    SetupExHUDSprite(work->aniZoneLetter[EXTITLECARD_ZONELETTER_A]);
    exDrawReqTask__SetConfigPriority(&work->aniZoneLetter[EXTITLECARD_ZONELETTER_A]->config, 0xE000);
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_A]->sprite.pos.x = 0;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_A]->sprite.pos.y = 0;
    exDrawReqTask__Sprite2D__Func_2161B80(work->aniZoneLetter[EXTITLECARD_ZONELETTER_A]);
    exDrawReqTask__Func_21641F0(&work->aniZoneLetter[EXTITLECARD_ZONELETTER_A]->config);

    work->timer = 30;

    SetCurrentExTaskMainEvent(ExTitleCard_Main_IntroDelay);
}

void ExTitleCard_Main_TaskUnknown(void)
{
    exMsgTitleTask *work = ExTaskGetWorkCurrent(exMsgTitleTask);
    UNUSED(work);
}

void ExTitleCard_Destructor(void)
{
    exMsgTitleTask *work = ExTaskGetWorkCurrent(exMsgTitleTask);

    ReleaseExHUDSprite(work->aniGoText);

    exTitleCardTaskSingleton = NULL;
}

void ExTitleCard_Main_IntroDelay(void)
{
    exMsgTitleTask *work = ExTaskGetWorkCurrent(exMsgTitleTask);

    if (work->timer-- <= 0)
    {
        ExTitleCard_Action_InitZoneIcon();
    }
    else
    {
        RunCurrentExTaskUnknownEvent();
    }
}

void ExTitleCard_Action_InitZoneIcon(void)
{
    exMsgTitleTask *work = ExTaskGetWorkCurrent(exMsgTitleTask);

    work->aniBackdrop->sprite.pos.x   = HW_LCD_CENTER_X;
    work->aniBackdrop->sprite.pos.y   = -96;
    work->aniBackdrop->sprite.scale.x = FLOAT_TO_FX32(1.80005); // NOTE: this value is a single (FX32) unit above the clean value of '1.8' used below. So this might be a typo?
    work->aniBackdrop->sprite.scale.y = FLOAT_TO_FX32(1.80005); // NOTE: this value is a single (FX32) unit above the clean value of '1.8' used below. So this might be a typo?

    work->aniZoneIcon->sprite.pos.x   = HW_LCD_CENTER_X;
    work->aniZoneIcon->sprite.pos.y   = -96;
    work->aniZoneIcon->sprite.scale.x = FLOAT_TO_FX32(1.80005); // NOTE: this value is a single (FX32) unit above the clean value of '1.8' used below. So this might be a typo?
    work->aniZoneIcon->sprite.scale.y = FLOAT_TO_FX32(1.80005); // NOTE: this value is a single (FX32) unit above the clean value of '1.8' used below. So this might be a typo?

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TITLE);

    work->nameplaceEnterPercent = FLOAT_TO_FX32(0.0);

    SetCurrentExTaskMainEvent(ExTitleCard_Main_EnterZoneIcon);
    ExTitleCard_Main_EnterZoneIcon();
}

void ExTitleCard_Main_EnterZoneIcon(void)
{
    exMsgTitleTask *work = ExTaskGetWorkCurrent(exMsgTitleTask);

    exDrawReqTask__Sprite2D__Animate(work->aniBackdrop);
    exDrawReqTask__Sprite2D__Animate(work->aniZoneIcon);

    if ((padInput.btnPress & PAD_BUTTON_A) != 0 || (padInput.btnPress & PAD_BUTTON_B) != 0 || (padInput.btnPress & PAD_BUTTON_X) != 0 || (padInput.btnPress & PAD_BUTTON_Y) != 0
        || (padInput.btnPress & PAD_BUTTON_START) != 0)
    {
        ExTitleCard_Action_ShowReadyText();
    }
    else
    {
        work->aniBackdrop->sprite.rotation += FLOAT_DEG_TO_IDX(24.0);
        work->aniZoneIcon->sprite.rotation += FLOAT_DEG_TO_IDX(24.0);

        if (work->aniBackdrop->sprite.pos.y < 80)
        {
            work->aniBackdrop->sprite.pos.y += 4;
            work->aniZoneIcon->sprite.pos.y += 4;
        }

        work->nameplaceEnterPercent += FLOAT_TO_FX32(1.0 / 45.0);

        work->aniBackdrop->sprite.scale.x = MultiplyFX(-FLOAT_TO_FX32(0.8), work->nameplaceEnterPercent) + FLOAT_TO_FX32(1.8);
        work->aniBackdrop->sprite.scale.y = MultiplyFX(-FLOAT_TO_FX32(0.8), work->nameplaceEnterPercent) + FLOAT_TO_FX32(1.8);
        work->aniZoneIcon->sprite.scale.x = MultiplyFX(-FLOAT_TO_FX32(0.8), work->nameplaceEnterPercent) + FLOAT_TO_FX32(1.8);
        work->aniZoneIcon->sprite.scale.y = MultiplyFX(-FLOAT_TO_FX32(0.8), work->nameplaceEnterPercent) + FLOAT_TO_FX32(1.8);

        if (work->nameplaceEnterPercent >= FLOAT_TO_FX32(1.0))
        {
            ExTitleCard_Action_InitZoneActText();
        }
        else
        {
            exDrawReqTask__AddRequest(work->aniBackdrop, &work->aniBackdrop->config);
            exDrawReqTask__AddRequest(work->aniZoneIcon, &work->aniZoneIcon->config);

            RunCurrentExTaskUnknownEvent();
        }
    }
}

void ExTitleCard_Action_InitZoneActText(void)
{
    exMsgTitleTask *work = ExTaskGetWorkCurrent(exMsgTitleTask);

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SONIC);

    work->aniBackdrop->sprite.pos.x            = HW_LCD_CENTER_X;
    work->aniBackdrop->sprite.pos.y            = 80;
    work->aniBackdrop->sprite.scale.x          = FLOAT_TO_FX32(1.0);
    work->aniBackdrop->sprite.scale.y          = FLOAT_TO_FX32(1.0);
    work->aniBackdrop->config.field_2.value_20 = TRUE;

    work->aniZoneIcon->sprite.pos.x            = HW_LCD_CENTER_X;
    work->aniZoneIcon->sprite.pos.y            = 80;
    work->aniZoneIcon->sprite.scale.x          = FLOAT_TO_FX32(1.0);
    work->aniZoneIcon->sprite.scale.y          = FLOAT_TO_FX32(1.0);
    work->aniZoneIcon->config.field_2.value_20 = TRUE;

    work->aniZoneNameTextJP->sprite.pos.x            = work->aniBackdrop->sprite.pos.x;
    work->aniZoneNameTextJP->sprite.pos.y            = work->aniBackdrop->sprite.pos.y - 48;
    work->aniZoneNameTextJP->config.field_2.value_20 = TRUE;

    work->aniActBanner->sprite.pos.x            = work->aniBackdrop->sprite.pos.x + 32;
    work->aniActBanner->sprite.pos.y            = work->aniBackdrop->sprite.pos.y + 28;
    work->aniActBanner->config.field_2.value_20 = TRUE;

    work->aniZoneLetter[EXTITLECARD_ZONELETTER_E]->sprite.pos.x            = work->aniBackdrop->sprite.pos.x - 76;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_E]->sprite.pos.y            = work->aniBackdrop->sprite.pos.y + 51;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_E]->config.field_2.value_20 = TRUE;

    work->aniZoneLetter[EXTITLECARD_ZONELETTER_X]->sprite.pos.x            = work->aniBackdrop->sprite.pos.x - 52;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_X]->sprite.pos.y            = work->aniBackdrop->sprite.pos.y + 51;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_X]->config.field_2.value_20 = TRUE;

    work->aniZoneLetter[EXTITLECARD_ZONELETTER_T]->sprite.pos.x            = work->aniBackdrop->sprite.pos.x - 28;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_T]->sprite.pos.y            = work->aniBackdrop->sprite.pos.y + 51;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_T]->config.field_2.value_20 = TRUE;

    work->aniZoneLetter[EXTITLECARD_ZONELETTER_R]->sprite.pos.x            = work->aniBackdrop->sprite.pos.x - 4;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_R]->sprite.pos.y            = work->aniBackdrop->sprite.pos.y + 51;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_R]->config.field_2.value_20 = TRUE;

    work->aniZoneLetter[EXTITLECARD_ZONELETTER_A]->sprite.pos.x            = work->aniBackdrop->sprite.pos.x + 20;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_A]->sprite.pos.y            = work->aniBackdrop->sprite.pos.y + 51;
    work->aniZoneLetter[EXTITLECARD_ZONELETTER_A]->config.field_2.value_20 = TRUE;

    SetCurrentExTaskMainEvent(ExTitleCard_Main_ShowZoneActText);
    ExTitleCard_Main_ShowZoneActText();
}

void ExTitleCard_Main_ShowZoneActText(void)
{
    exMsgTitleTask *work = ExTaskGetWorkCurrent(exMsgTitleTask);

    exDrawReqTask__Sprite2D__Animate(work->aniBackdrop);
    exDrawReqTask__Sprite2D__Animate(work->aniZoneIcon);
    exDrawReqTask__Sprite2D__Animate(work->aniZoneNameTextJP);
    exDrawReqTask__Sprite2D__Animate(work->aniActBanner);
    exDrawReqTask__Sprite2D__Animate(work->aniZoneLetter[EXTITLECARD_ZONELETTER_E]);
    exDrawReqTask__Sprite2D__Animate(work->aniZoneLetter[EXTITLECARD_ZONELETTER_X]);
    exDrawReqTask__Sprite2D__Animate(work->aniZoneLetter[EXTITLECARD_ZONELETTER_T]);
    exDrawReqTask__Sprite2D__Animate(work->aniZoneLetter[EXTITLECARD_ZONELETTER_R]);
    exDrawReqTask__Sprite2D__Animate(work->aniZoneLetter[EXTITLECARD_ZONELETTER_A]);

    if ((padInput.btnPress & PAD_BUTTON_A) != 0 || (padInput.btnPress & PAD_BUTTON_B) != 0 || (padInput.btnPress & PAD_BUTTON_X) != 0 || (padInput.btnPress & PAD_BUTTON_Y) != 0
        || (padInput.btnPress & PAD_BUTTON_START) != 0)
    {
        ExTitleCard_Action_ShowReadyText();
    }
    else if (exDrawReqTask__Sprite2D__IsAnimFinished(work->aniZoneLetter[EXTITLECARD_ZONELETTER_COUNT - 1]))
    {
        ExTitleCard_Action_ExitNameplate();
    }
    else
    {
        if (GetExTutorialMessageLanguage() == OS_LANGUAGE_JAPANESE)
            exDrawReqTask__AddRequest(work->aniZoneNameTextJP, &work->aniZoneNameTextJP->config);

        exDrawReqTask__AddRequest(work->aniActBanner, &work->aniActBanner->config);
        exDrawReqTask__AddRequest(work->aniZoneLetter[EXTITLECARD_ZONELETTER_E], &work->aniZoneLetter[EXTITLECARD_ZONELETTER_E]->config);
        exDrawReqTask__AddRequest(work->aniZoneLetter[EXTITLECARD_ZONELETTER_X], &work->aniZoneLetter[EXTITLECARD_ZONELETTER_X]->config);
        exDrawReqTask__AddRequest(work->aniZoneLetter[EXTITLECARD_ZONELETTER_T], &work->aniZoneLetter[EXTITLECARD_ZONELETTER_T]->config);
        exDrawReqTask__AddRequest(work->aniZoneLetter[EXTITLECARD_ZONELETTER_R], &work->aniZoneLetter[EXTITLECARD_ZONELETTER_R]->config);
        exDrawReqTask__AddRequest(work->aniZoneLetter[EXTITLECARD_ZONELETTER_A], &work->aniZoneLetter[EXTITLECARD_ZONELETTER_A]->config);
        exDrawReqTask__AddRequest(work->aniBackdrop, &work->aniBackdrop->config);
        exDrawReqTask__AddRequest(work->aniZoneIcon, &work->aniZoneIcon->config);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExTitleCard_Action_ExitNameplate(void)
{
    exMsgTitleTask *work = ExTaskGetWorkCurrent(exMsgTitleTask);

    work->nameplaceExitPercent = FLOAT_TO_FX32(0.0);

    SetCurrentExTaskMainEvent(ExTitleCard_Main_ExitNameplate);
    ExTitleCard_Main_ExitNameplate();
}

void ExTitleCard_Main_ExitNameplate(void)
{
    exMsgTitleTask *work = ExTaskGetWorkCurrent(exMsgTitleTask);

    if ((padInput.btnPress & PAD_BUTTON_A) != 0 || (padInput.btnPress & PAD_BUTTON_B) != 0 || (padInput.btnPress & PAD_BUTTON_X) != 0 || (padInput.btnPress & PAD_BUTTON_Y) != 0
        || (padInput.btnPress & PAD_BUTTON_START) != 0)
    {
        ExTitleCard_Action_ShowReadyText();
    }
    else
    {
        exDrawReqTask__Sprite2D__Animate(work->aniBackdrop);
        exDrawReqTask__Sprite2D__Animate(work->aniZoneIcon);
        exDrawReqTask__Sprite2D__Animate(work->aniZoneNameTextJP);
        exDrawReqTask__Sprite2D__Animate(work->aniActBanner);
        exDrawReqTask__Sprite2D__Animate(work->aniZoneLetter[EXTITLECARD_ZONELETTER_E]);
        exDrawReqTask__Sprite2D__Animate(work->aniZoneLetter[EXTITLECARD_ZONELETTER_X]);
        exDrawReqTask__Sprite2D__Animate(work->aniZoneLetter[EXTITLECARD_ZONELETTER_T]);
        exDrawReqTask__Sprite2D__Animate(work->aniZoneLetter[EXTITLECARD_ZONELETTER_R]);
        exDrawReqTask__Sprite2D__Animate(work->aniZoneLetter[EXTITLECARD_ZONELETTER_A]);

        work->nameplaceExitPercent += FLOAT_TO_FX32(1.0 / 40.0);

        work->aniBackdrop->sprite.pos.x       = mtLerpEx2(work->nameplaceExitPercent, FLOAT_TO_FX32(HW_LCD_CENTER_X), -FLOAT_TO_FX32(HW_LCD_WIDTH), 2) / (float)FLOAT_TO_FX32(1.0);
        work->aniZoneIcon->sprite.pos.x       = work->aniBackdrop->sprite.pos.x;
        work->aniZoneNameTextJP->sprite.pos.x = work->aniBackdrop->sprite.pos.x;
        work->aniActBanner->sprite.pos.x      = work->aniBackdrop->sprite.pos.x + 32;
        work->aniZoneLetter[EXTITLECARD_ZONELETTER_E]->sprite.pos.x = work->aniBackdrop->sprite.pos.x - 76;
        work->aniZoneLetter[EXTITLECARD_ZONELETTER_X]->sprite.pos.x = work->aniBackdrop->sprite.pos.x - 52;
        work->aniZoneLetter[EXTITLECARD_ZONELETTER_T]->sprite.pos.x = work->aniBackdrop->sprite.pos.x - 28;
        work->aniZoneLetter[EXTITLECARD_ZONELETTER_R]->sprite.pos.x = work->aniBackdrop->sprite.pos.x - 4;
        work->aniZoneLetter[EXTITLECARD_ZONELETTER_A]->sprite.pos.x = work->aniBackdrop->sprite.pos.x + 20;

        if (work->nameplaceExitPercent >= FLOAT_TO_FX32(1.0))
        {
            ExTitleCard_Action_ShowReadyText();
        }
        else
        {
            if (GetExTutorialMessageLanguage() == OS_LANGUAGE_JAPANESE)
                exDrawReqTask__AddRequest(work->aniZoneNameTextJP, &work->aniZoneNameTextJP->config);

            exDrawReqTask__AddRequest(work->aniActBanner, &work->aniActBanner->config);
            exDrawReqTask__AddRequest(work->aniZoneLetter[EXTITLECARD_ZONELETTER_E], &work->aniZoneLetter[EXTITLECARD_ZONELETTER_E]->config);
            exDrawReqTask__AddRequest(work->aniZoneLetter[EXTITLECARD_ZONELETTER_X], &work->aniZoneLetter[EXTITLECARD_ZONELETTER_X]->config);
            exDrawReqTask__AddRequest(work->aniZoneLetter[EXTITLECARD_ZONELETTER_T], &work->aniZoneLetter[EXTITLECARD_ZONELETTER_T]->config);
            exDrawReqTask__AddRequest(work->aniZoneLetter[EXTITLECARD_ZONELETTER_R], &work->aniZoneLetter[EXTITLECARD_ZONELETTER_R]->config);
            exDrawReqTask__AddRequest(work->aniZoneLetter[EXTITLECARD_ZONELETTER_A], &work->aniZoneLetter[EXTITLECARD_ZONELETTER_A]->config);
            exDrawReqTask__AddRequest(work->aniBackdrop, &work->aniBackdrop->config);
            exDrawReqTask__AddRequest(work->aniZoneIcon, &work->aniZoneIcon->config);

            RunCurrentExTaskUnknownEvent();
        }
    }
}

void ExTitleCard_Action_ShowReadyText(void)
{
    exMsgTitleTask *work = ExTaskGetWorkCurrent(exMsgTitleTask);

    ReleaseExHUDSprite(work->aniBackdrop);
    ReleaseExHUDSprite(work->aniZoneIcon);
    ReleaseExHUDSprite(work->aniZoneNameTextJP);
    ReleaseExHUDSprite(work->aniActBanner);
    ReleaseExHUDSprite(work->aniZoneLetter[EXTITLECARD_ZONELETTER_E]);
    ReleaseExHUDSprite(work->aniZoneLetter[EXTITLECARD_ZONELETTER_X]);
    ReleaseExHUDSprite(work->aniZoneLetter[EXTITLECARD_ZONELETTER_T]);
    ReleaseExHUDSprite(work->aniZoneLetter[EXTITLECARD_ZONELETTER_R]);
    ReleaseExHUDSprite(work->aniZoneLetter[EXTITLECARD_ZONELETTER_A]);

    work->aniReadyText->sprite.anim       = EX_ACTCOM_ANI_TITLECARD_READY_TEXT;
    work->aniReadyText->sprite.paletteRow = PALETTE_ROW_7;
    SetupExHUDSprite(work->aniReadyText);
    exDrawReqTask__SetConfigPriority(&work->aniReadyText->config, 0xE000);
    work->aniReadyText->sprite.pos.x = HW_LCD_CENTER_X;
    work->aniReadyText->sprite.pos.y = 96;
    exDrawReqTask__Sprite2D__Func_2161B80(work->aniReadyText);
    work->aniReadyText->config.field_2.value_20 = TRUE;
    exDrawReqTask__Func_21641F0(&work->aniReadyText->config);

    work->aniGoText->sprite.anim       = EX_ACTCOM_ANI_TITLECARD_GO_TEXT;
    work->aniGoText->sprite.paletteRow = PALETTE_ROW_7;
    SetupExHUDSprite(work->aniGoText);
    exDrawReqTask__SetConfigPriority(&work->aniGoText->config, 0xE000);
    work->aniGoText->sprite.pos.x = HW_LCD_CENTER_X;
    work->aniGoText->sprite.pos.y = 96;
    exDrawReqTask__Sprite2D__Func_2161B80(work->aniGoText);
    work->aniGoText->config.field_2.value_20 = TRUE;
    exDrawReqTask__Func_21641F0(&work->aniGoText->config);

    work->timer = 45;

    SetCurrentExTaskMainEvent(ExTitleCard_Main_ShowReadyText);
    ExTitleCard_Main_ShowReadyText();
}

void ExTitleCard_Main_ShowReadyText(void)
{
    exMsgTitleTask *work = ExTaskGetWorkCurrent(exMsgTitleTask);

    exDrawReqTask__Sprite2D__Animate(work->aniReadyText);

    if (exDrawReqTask__Sprite2D__IsAnimFinished(work->aniReadyText))
    {
        ExTitleCard_Action_StartShowingGoText();
    }
    else
    {
        exDrawReqTask__AddRequest(work->aniReadyText, &work->aniReadyText->config);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExTitleCard_Action_StartShowingGoText(void)
{
    exMsgTitleTask *work = ExTaskGetWorkCurrent(exMsgTitleTask);

    work->timer = 0;

    SetCurrentExTaskMainEvent(ExTitleCard_Main_StartShowingGoText);
    ExTitleCard_Main_StartShowingGoText();
}

void ExTitleCard_Main_StartShowingGoText(void)
{
    exMsgTitleTask *work = ExTaskGetWorkCurrent(exMsgTitleTask);

    if (work->timer-- <= 0)
    {
        ExTitleCard_Action_ShowGoText();
    }
    else
    {
        exDrawReqTask__AddRequest(work->aniReadyText, &work->aniReadyText->config);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExTitleCard_Action_ShowGoText(void)
{
    exMsgTitleTask *work = ExTaskGetWorkCurrent(exMsgTitleTask);

    ReleaseExHUDSprite(work->aniReadyText);

    GetExSystemStatus()->state = EXSYSTASK_STATE_TITLECARD_DONE;

    SetCurrentExTaskMainEvent(ExTitleCard_Main_ShowGoText);
    ExTitleCard_Main_ShowGoText();
}

void ExTitleCard_Main_ShowGoText(void)
{
    exMsgTitleTask *work = ExTaskGetWorkCurrent(exMsgTitleTask);

    exDrawReqTask__Sprite2D__Animate(work->aniGoText);
    if (exDrawReqTask__Sprite2D__IsAnimFinished(work->aniGoText))
    {
        ExTitleCard_Action_StartOutro();
    }
    else
    {
        exDrawReqTask__AddRequest(work->aniGoText, &work->aniGoText->config);
        RunCurrentExTaskUnknownEvent();
    }
}

void ExTitleCard_Action_StartOutro(void)
{
    exMsgTitleTask *work = ExTaskGetWorkCurrent(exMsgTitleTask);

    work->timer = 120;

    SetCurrentExTaskMainEvent(ExTitleCard_Main_OutroDelay);
    ExTitleCard_Main_OutroDelay();
}

void ExTitleCard_Main_OutroDelay(void)
{
    exMsgTitleTask *work = ExTaskGetWorkCurrent(exMsgTitleTask);

    if (work->timer-- <= 0)
    {
        GetExTaskCurrent()->main = ExTask_State_Destroy;
    }
    else
    {
        exDrawReqTask__AddRequest(work->aniGoText, &work->aniGoText->config);

        RunCurrentExTaskUnknownEvent();
    }
}

BOOL CreateExTitleCard(void)
{
    Task *task = ExTaskCreate(ExTitleCard_Main_Init, ExTitleCard_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(3), 0, EXTASK_TYPE_REGULAR, exMsgTitleTask);

    exMsgTitleTask *work = ExTaskGetWork(task, exMsgTitleTask);
    TaskInitWork8(work);

    SetExTaskUnknownEvent(task, ExTitleCard_Main_TaskUnknown);

    return TRUE;
}

Task *GetExTitleCardTaskSingleton(void)
{
    return exTitleCardTaskSingleton;
}