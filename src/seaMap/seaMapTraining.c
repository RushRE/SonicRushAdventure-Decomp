#include <seaMap/seaMapTraining.h>
#include <seaMap/seaMapView.h>
#include <seaMap/navTails.h>
#include <seaMap/seaMapChartCourseView.h>
#include <game/graphics/renderCore.h>
#include <game/audio/audioSystem.h>
#include <game/system/sysEvent.h>
#include <game/file/binaryBundle.h>
#include <game/game/gameState.h>
#include <game/save/saveGame.h>
#include <hub/dockCommon.h>

// resources
#include <resources/bb/ch.h>
#include <resources/bb/ch/ch_training.h>

// --------------------
// STRUCTS
// --------------------

struct SeaMapTrainingConfig
{
    u8 anim[8];
    u8 palette[3];
    u16 unknown[6];
};

// --------------------
// VARIABLES
// --------------------

static const struct SeaMapTrainingConfig seaMapTrainingSpriteButtonConfig = {
    .anim    = { 0, 2, 4, 6, 8, 10, 0, 0 },
    .palette = { PALETTE_ROW_0, PALETTE_ROW_0, PALETTE_ROW_0 },
    .unknown = { 12, 24, 24, 12, 3, 3 },
};

// --------------------
// FUNCTION DECLS
// --------------------

static void SeaMapTraining_Main(void);
static void SeaMapTraining_Destructor(Task *task);
static void DestroySeaMapTraining(SeaMapTraining *work);
static void SeaMapTraining_DrawText(SeaMapTraining *work);
static void LoadSeaMapTrainingAssets(SeaMapTrainingAssets *work);
static void ReleaseSeaMapTrainingAssets(SeaMapTrainingAssets *work);
static void InitDisplayForSeaMapTraining(void);
static void InitSeaMapTrainingUnknown(SeaMapTraining *work);
static void ReleaseSeaMapTrainingUnknown(SeaMapTraining *work);
static void InitSeaMapTrainingBackground(SeaMapTraining *work);
static void InitSeaMapTrainingSprites(SeaMapTraining *work);
static void ReleaseSeaMapTrainingSprites(SeaMapTraining *work);
static u32 GetSeaMapTrainingSpriteButtonSpriteSize(SeaMapTraining *work);
static void SeaMapTraining_TouchAreaCallback(TouchAreaResponse *response, TouchArea *area, void *userData);
static void SeaMapTraining_State_InitNavTails(SeaMapTraining *work);
static void SeaMapTraining_State_FadeIn(SeaMapTraining *work);
static void SeaMapTraining_State_WaitingForButtonPress(SeaMapTraining *work);
static void SeaMapTraining_State_FadeOutForChartCourseTutorial(SeaMapTraining *work);
static void SeaMapTraining_State_HideButton(SeaMapTraining *work);
static void SeaMapTraining_State_InitChartCourseViewTutorial(SeaMapTraining *work);
static void SeaMapTraining_State_WaitForChartCourseViewTutorialFinished(SeaMapTraining *work);
static void SeaMapTraining_State_FadeOut(SeaMapTraining *work);

// --------------------
// FUNCTIONS
// --------------------

void CreateSeaMapTraining(void)
{
    LoadSpriteButtonCursorSprite();
    LoadSpriteButtonTouchpadSprite();

    Task *task = TaskCreate(SeaMapTraining_Main, SeaMapTraining_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(0), SeaMapTraining);

    SeaMapTraining *work = TaskGetWork(task, SeaMapTraining);
    TaskInitWork16(work);

    work->state = SeaMapTraining_State_InitNavTails;

    TouchField__Init(&work->touchField);

    LoadSeaMapTrainingAssets(&work->assets);
    InitDisplayForSeaMapTraining();
    InitSeaMapTrainingUnknown(work);
    InitSeaMapTrainingBackground(work);
    InitSeaMapTrainingSprites(work);

    CreateNavTails(TRUE, SHIP_JET, NULL);

    ReleaseAudioSystem();
    LoadAudioSndArc("snd/sys/sound_data.sdat");
    NNS_SndArcLoadGroup(SND_SYS_GROUP_CHART, audioManagerSndHeap);

    PlayTrack(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_SYS_SEQ_SEQ_CHART);

    ResetTouchInput();
}

void SeaMapTraining_Main(void)
{
    SeaMapTraining *work = TaskGetWorkCurrent(SeaMapTraining);

    work->state(work);

    if (!work->destroyQueued)
        SeaMapTraining_DrawText(work);
    else
        DestroySeaMapTraining(work);
}

void SeaMapTraining_Destructor(Task *task)
{
    SeaMapTraining *work = TaskGetWork(task, SeaMapTraining);

    ReleaseSeaMapTrainingUnknown(work);
    ReleaseSeaMapTrainingSprites(work);
    ReleaseSeaMapTrainingAssets(&work->assets);

    ReleaseAudioSystem();
}

void DestroySeaMapTraining(SeaMapTraining *work)
{
    SeaMapChartCourseView__Destroy();

    ReleaseSpriteButtonCursorSprite();
    ReleaseSpriteButtonTouchpadSprite();
    DestroyCurrentTask();

    if (GetSysEventList()->prevEventID == SYSEVENT_RETURN_TO_HUB)
    {
        gameState.talk.state.hubStartAction = HUB_STARTACTION_RESUME_HUB;
        RequestSysEventChange(1); // SYSEVENT_RETURN_TO_HUB
    }
    else
    {
        SaveGame__SetProgressType(SAVE_PROGRESSTYPE_2);
        RequestSysEventChange(0); // SYSEVENT_UPDATE_PROGRESS
    }

    NextSysEvent();
}

void SeaMapTraining_DrawText(SeaMapTraining *work)
{
    if (work->textVisible)
    {
        AnimatorSprite__ProcessAnimationFast(&work->trainingTextButton.animator);
        AnimatorSprite__DrawFrame(&work->trainingTextButton.animator);
    }
}

void LoadSeaMapTrainingAssets(SeaMapTrainingAssets *work)
{
    MI_CpuClear16(work, sizeof(*work));

    GetCompressedFileFromBundle("/bb/ch.bb", BUNDLE_CH_FILE_RESOURCES_BB_CH_CH_TRAINING_NARC, &work->archive, TRUE, FALSE);

    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "ch", work->archive);
    work->sprTrainingText = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_CH_TRAINING_FILE_CH_COM_BAC);
    work->bgTraining      = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_CH_TRAINING_FILE_CH_UI_TRE_BASE_BBG);
    NNS_FndUnmountArchive(&arc);
}

void ReleaseSeaMapTrainingAssets(SeaMapTrainingAssets *work)
{
    HeapFree(HEAP_USER, work->archive);

    MI_CpuClear16(work, sizeof(*work));
}

void InitDisplayForSeaMapTraining(void)
{
    VRAMSystem__Reset();
    VRAMSystem__SetupBGBank(GX_VRAM_BG_128_D);
    VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_32_FG, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x400);
    VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_128_C);
    VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_16_I, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x200);

    RenderCoreGFXControl *control = VRAMSystem__GFXControl[GRAPHICS_ENGINE_A];

    GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_0, GX_BG0_AS_2D);
    G2_SetBG3ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x08000);

    MI_CpuClear32(control->bgPosition, sizeof(control->bgPosition));
    MI_CpuClear32(control->bgPosition, sizeof(control->bgPosition));
    MI_CpuClear16(&control->windowManager, sizeof(control->windowManager));
    MI_CpuClear16(&control->blendManager, sizeof(control->blendManager));
    MI_CpuClear16(&control->mosaicSize, sizeof(control->mosaicSize));

    GX_SetVisiblePlane(GX_PLANEMASK_BG3 | GX_PLANEMASK_OBJ);

    renderCurrentDisplay = GX_DISP_SELECT_SUB_MAIN;
}

void InitSeaMapTrainingUnknown(SeaMapTraining *work)
{
    work->unknownFlag = TRUE;
}

void ReleaseSeaMapTrainingUnknown(SeaMapTraining *work)
{
    if (work->unknownFlag)
        work->unknownFlag = FALSE;
}

void InitSeaMapTrainingBackground(SeaMapTraining *work)
{
    void *bgTraining = work->assets.bgTraining;

    Background background;
    InitBackground(&background, bgTraining, BACKGROUND_FLAG_LOAD_ALL, GRAPHICS_ENGINE_A, BACKGROUND_3, GetBackgroundWidth(bgTraining), GetBackgroundHeight(bgTraining));
    DrawBackground(&background);
}

void InitSeaMapTrainingSprites(SeaMapTraining *work)
{
    const struct SeaMapTrainingConfig *config;
    SpriteButtonAnimator *trainingTextButton = &work->trainingTextButton;

    config = &seaMapTrainingSpriteButtonConfig;

    trainingTextButton->animID = config->anim[GetGameLanguage()];
    for (s32 i = 0; i < 3; i++)
    {
        trainingTextButton->paletteRow[i] = config->palette[i];
    }

    AnimatorSprite__Init(&trainingTextButton->animator, work->assets.sprTrainingText, trainingTextButton->animID, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_A, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_A, GetSeaMapTrainingSpriteButtonSpriteSize(work)), PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[GRAPHICS_ENGINE_A]), SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    trainingTextButton->animator.cParam.palette = trainingTextButton->paletteRow[0];
    trainingTextButton->animator.pos.x          = HW_LCD_CENTER_X;
    trainingTextButton->animator.pos.y          = HW_LCD_CENTER_Y;

    HitboxRect rect;
    AnimatorSprite__GetBlockData(&trainingTextButton->animator, 0, &rect);
    TouchField__InitAreaShape(&trainingTextButton->touchArea, &trainingTextButton->animator.pos, TouchField__PointInRect, (TouchRectUnknown *)&rect,
                              SeaMapTraining_TouchAreaCallback, work);
    TouchField__AddArea(&work->touchField, &trainingTextButton->touchArea, 16);

    SetSpriteButtonState(trainingTextButton, SPRITE_BUTTON_STATE_IDLE);

    work->textVisible = TRUE;
}

void ReleaseSeaMapTrainingSprites(SeaMapTraining *work)
{
    if (work->textVisible)
    {
        AnimatorSprite__Release(&work->trainingTextButton.animator);
        TouchField__RemoveArea(&work->touchField, &work->trainingTextButton.touchArea);

        work->textVisible = FALSE;
    }
}

u32 GetSeaMapTrainingSpriteButtonSpriteSize(SeaMapTraining *work)
{
    const struct SeaMapTrainingConfig *config;
    void *sprTrainingText;
    size_t size;
    s32 i;
    s32 a;

    config = &seaMapTrainingSpriteButtonConfig;

    size = 0;

    sprTrainingText = work->assets.sprTrainingText;
    for (i = 0; i < 8; i++)
    {
        for (a = 0; a < 2; a++)
        {
            size_t animSize = Sprite__GetSpriteSize1FromAnim(sprTrainingText, a + config->anim[i]);
            if (size < animSize)
                size = animSize;
        }
    }

    return size;
}

void SeaMapTraining_TouchAreaCallback(TouchAreaResponse *response, TouchArea *area, void *userData)
{
    SeaMapTraining *work = (SeaMapTraining *)userData;

    TouchAreaResponseFlags flags = area->responseFlags;

    switch (response->flags)
    {
        case TOUCHAREA_RESPONSE_40000:
            work->selectedButton = 1;
            break;

        case TOUCHAREA_RESPONSE_ENTERED_AREA_ALT:
        case TOUCHAREA_RESPONSE_ENTERED_AREA:
            if ((flags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
                SetSpriteButtonState(&work->trainingTextButton, SPRITE_BUTTON_STATE_HOVERED);
            break;

        case TOUCHAREA_RESPONSE_EXITED_AREA_ALT:
        case TOUCHAREA_RESPONSE_EXITED_AREA:
            if ((flags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0)
                SetSpriteButtonState(&work->trainingTextButton, SPRITE_BUTTON_STATE_IDLE);
            break;
    }
}

void SeaMapTraining_State_InitNavTails(SeaMapTraining *work)
{
    NavTailsSpeak(NAVTAILS_MSGSEQ_TUTORIAL_TOUCH_WHEN_READY, SECONDS_TO_FRAMES(0.0));

    work->state = SeaMapTraining_State_FadeIn;
}

void SeaMapTraining_State_FadeIn(SeaMapTraining *work)
{
    BOOL done = TRUE;
    for (s32 i = 0; i < GRAPHICS_ENGINE_COUNT; i++)
    {
        RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[i];

        if (gfxControl->brightness > 0)
        {
            gfxControl->brightness--;
        }
        else if (gfxControl->brightness < 0)
        {
            gfxControl->brightness++;
        }

        if (gfxControl->brightness != RENDERCORE_BRIGHTNESS_DEFAULT)
            done = FALSE;
    }

    if (done)
        work->state = SeaMapTraining_State_WaitingForButtonPress;
}

void SeaMapTraining_State_WaitingForButtonPress(SeaMapTraining *work)
{
    TouchField__Process(&work->touchField);

    if (work->selectedButton != 0)
    {
        // BUG: this is trying to call a sequence from the "ARC_VILLAGE" seqArchive, which is not currently loaded.
        // the fix would probably to be to use the equivalent sfx id (which happens to be the same sfx) in the "ARC_CHART" seqArchive, which has been loaded.
        PlaySystemSfx(SND_SYS_SEQARC_ARC_VILLAGE, SND_SYS_SEQARC_ARC_VILLAGE_SEQ_SE_PAUSE);
        // PlaySystemSfx(SND_SYS_SEQARC_ARC_CHART, SND_SYS_SEQARC_ARC_CHART_SEQ_SE_PAUSE);

        work->state = SeaMapTraining_State_FadeOutForChartCourseTutorial;
    }
}

void SeaMapTraining_State_FadeOutForChartCourseTutorial(SeaMapTraining *work)
{
    if (VRAMSystem__GFXControl[GRAPHICS_ENGINE_A]->brightness > RENDERCORE_BRIGHTNESS_BLACK)
        VRAMSystem__GFXControl[GRAPHICS_ENGINE_A]->brightness--;
    else
        work->state = SeaMapTraining_State_HideButton;
}

void SeaMapTraining_State_HideButton(SeaMapTraining *work)
{
    ReleaseSeaMapTrainingUnknown(work);
    ReleaseSeaMapTrainingSprites(work);

    work->state = SeaMapTraining_State_InitChartCourseViewTutorial;
}

void SeaMapTraining_State_InitChartCourseViewTutorial(SeaMapTraining *work)
{
    SeaMapChartCourseView__Create(FALSE, SHIP_JET, 2);

    work->state = SeaMapTraining_State_WaitForChartCourseViewTutorialFinished;
}

void SeaMapTraining_State_WaitForChartCourseViewTutorialFinished(SeaMapTraining *work)
{
    if (SeaMapChartCourseView__Func_2040978() == FALSE)
    {
        NNS_SndPlayerStopSeqAll(60);

        work->state = SeaMapTraining_State_FadeOut;
    }
}

void SeaMapTraining_State_FadeOut(SeaMapTraining *work)
{
    BOOL done = TRUE;
    for (s32 i = 0; i < GRAPHICS_ENGINE_COUNT; i++)
    {
        RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[i];

        if (gfxControl->brightness > RENDERCORE_BRIGHTNESS_BLACK)
        {
            gfxControl->brightness--;
            done = FALSE;
        }
    }

    if (done)
        work->destroyQueued = TRUE;
}