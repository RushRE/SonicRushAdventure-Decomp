
#include <menu/splashScreen.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/file/fileUnknown.h>
#include <game/file/fsRequest.h>
#include <game/system/sysEvent.h>
#include <game/graphics/drawFadeTask.h>
#include <game/graphics/renderCore.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void SetupDisplayForSplashScreen(void);
static void LoadSplashScreenArchive(SplashScreen *work);
static void FreeSplashScreenArchive(SplashScreen *work);
static void LoadSplashScreenBackgrounds(SplashScreen *work);
static void ChangeEventForSplashScreen(void);
static BOOL CheckSplashScreenSkip(SplashScreen *work);
static void SplashScreen_Destructor(Task *task);
static void SplashScreen_Main_StartFadeIn(void);
static void SplashScreen_Main_FadeIn(void);
static void SplashScreen_Main_StartShowLogos(void);
static void SplashScreen_Main_ShowLogos(void);
static void SplashScreen_Main_StartFadeOut(void);
static void SplashScreen_Main_FadeOut(void);
static void SplashScreen_Main_StartOpening(void);

// --------------------
// FUNCTIONS
// --------------------

void CreateSplashScreen(void)
{
    SetupDisplayForSplashScreen();
    Task *task = TaskCreate(SplashScreen_Main_StartFadeIn, SplashScreen_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x0000, TASK_SCOPE_0, SplashScreen);

    SplashScreen *work = TaskGetWork(task, SplashScreen);
    TaskInitWork16(work);

    LoadSplashScreenArchive(work);
    LoadSplashScreenBackgrounds(work);
    StartSamplingTouchInput(4);
}

void SetupDisplayForSplashScreen(void)
{
    VRAMSystem__Init(VRAM_MODE_0);
    GX_SetPower(GX_POWER_2D);
    GX_SetDispSelect(GX_DISP_SELECT_MAIN_SUB);
    renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;

    renderCoreGFXControlA.windowManager.visible = GX_PLANEMASK_NONE;
    renderCoreGFXControlA.blendManager.blendControl.effect = BLENDTYPE_NONE;
    renderCoreGFXControlA.brightness = RENDERCORE_BRIGHTNESS_BLACK;
    renderCoreGFXControlA.mosaicSize = 0;
    GX_SetMasterBrightness(renderCoreGFXControlA.brightness);
    GX_SetBGScrOffset(GX_BGSCROFFSET_0x00000);
    GX_SetBGCharOffset(GX_BGCHAROFFSET_0x00000);
    GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_0, GX_BG0_AS_2D);
    G2_SetBG0Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_01);
    renderCoreGFXControlA.bgPosition[0].x = renderCoreGFXControlA.bgPosition[0].y = 0;
    renderCoreGFXControlA.bgPosition[1].x = renderCoreGFXControlA.bgPosition[1].y = 0;
    renderCoreGFXControlA.bgPosition[2].x = renderCoreGFXControlA.bgPosition[2].y = 0;
    renderCoreGFXControlA.bgPosition[3].x = renderCoreGFXControlA.bgPosition[3].y = 0;

    G2_SetBG0Priority(3);
    G2_SetBG1Priority(2);
    G2_SetBG2Priority(1);
    G2_SetBG3Priority(0);
    GX_SetVisiblePlane(GX_PLANEMASK_BG0);
    MI_CpuClear16(VRAMSystem__VRAM_BG[0], 0x20000);

    renderCoreGFXControlB.windowManager.visible = GX_PLANEMASK_NONE;
    renderCoreGFXControlB.blendManager.blendControl.effect = BLENDTYPE_NONE;
    renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_BLACK;
    renderCoreGFXControlB.mosaicSize = 0;
    GXS_SetMasterBrightness(renderCoreGFXControlB.brightness);
    GXS_SetGraphicsMode(GX_BGMODE_0);
    G2S_SetBG0Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_01);
    renderCoreGFXControlB.bgPosition[0].x = renderCoreGFXControlB.bgPosition[0].y = 0;
    renderCoreGFXControlB.bgPosition[1].x = renderCoreGFXControlB.bgPosition[1].y = 0;
    renderCoreGFXControlB.bgPosition[2].x = renderCoreGFXControlB.bgPosition[2].y = 0;
    renderCoreGFXControlB.bgPosition[3].x = renderCoreGFXControlB.bgPosition[3].y = 0;

    G2S_SetBG0Priority(3);
    G2S_SetBG1Priority(2);
    G2S_SetBG2Priority(1);
    G2S_SetBG3Priority(0);
    GXS_SetVisiblePlane(GX_PLANEMASK_BG0);
    MI_CpuClear16(VRAMSystem__VRAM_BG[1], 0x20000);
}

void LoadSplashScreenArchive(SplashScreen *work)
{
    FSRequestArchive("/narc/dmlg_lz7.narc", &work->archiveLogos, FALSE);
}

void FreeSplashScreenArchive(SplashScreen *work)
{
    HeapFree(HEAP_USER, work->archiveLogos);
}

void LoadSplashScreenBackgrounds(SplashScreen *work)
{
    InitBackground(&work->bgSega, FileUnknown__GetAOUFile(work->archiveLogos, ARC_DMLG_FILE_CORP_BBG), BACKGROUND_FLAG_LOAD_MAPPINGS | BACKGROUND_FLAG_LOAD_PALETTE, FALSE,
                   BACKGROUND_0, 32, 24);
    DrawBackground(&work->bgSega);

    InitBackground(&work->bgSonicTeam, FileUnknown__GetAOUFile(work->archiveLogos, ARC_DMLG_FILE_TEAM_BBG), BACKGROUND_FLAG_LOAD_MAPPINGS | BACKGROUND_FLAG_LOAD_PALETTE, TRUE,
                   BACKGROUND_0, 32, 24);
    DrawBackground(&work->bgSonicTeam);
}

void ChangeEventForSplashScreen(void)
{
    RequestSysEventChange(0); // SYSEVENT_OPENING
    NextSysEvent();
}

BOOL CheckSplashScreenSkip(SplashScreen *work)
{
    if ((padInput.btnPress & (PAD_BUTTON_START | PAD_BUTTON_A)) != 0)
        return TRUE;

    if (work->touchSkipDelay != 0)
    {
        work->touchSkipDelay--;
    }
    else if (IsTouchInputEnabled() && TouchInput__IsTouchPush(&touchInput))
    {
        return TRUE;
    }

    return FALSE;
}

void SplashScreen_Destructor(Task *task)
{
    SplashScreen *work = TaskGetWork(task, SplashScreen);

    StopSamplingTouchInput();
    FreeSplashScreenArchive(work);
}

void SplashScreen_Main_StartFadeIn(void)
{
    SplashScreen *work = TaskGetWorkCurrent(SplashScreen);
    UNUSED(work);

    CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_FADE_TO_BLACK, FLOAT_TO_FX32(0.5));
    SetCurrentTaskMainEvent(SplashScreen_Main_FadeIn);
}

void SplashScreen_Main_FadeIn(void)
{
    if (IsDrawFadeTaskFinished())
        SetCurrentTaskMainEvent(SplashScreen_Main_StartShowLogos);
}

void SplashScreen_Main_StartShowLogos(void)
{
    SplashScreen *work   = TaskGetWorkCurrent(SplashScreen);
    work->timer          = SECONDS_TO_FRAMES(3.0);
    work->touchSkipDelay = 5;
    SetCurrentTaskMainEvent(SplashScreen_Main_ShowLogos);
}

void SplashScreen_Main_ShowLogos(void)
{
    SplashScreen *work = TaskGetWorkCurrent(SplashScreen);

    if (work->timer != 0)
    {
        work->timer--;

        if (CheckSplashScreenSkip(work) == FALSE)
            return;
    }

    SetCurrentTaskMainEvent(SplashScreen_Main_StartFadeOut);
}

void SplashScreen_Main_StartFadeOut(void)
{
    CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED | DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS, FLOAT_TO_FX32(0.5));
    SetCurrentTaskMainEvent(SplashScreen_Main_FadeOut);
}

void SplashScreen_Main_FadeOut(void)
{
    if (IsDrawFadeTaskFinished())
    {
        DestroyDrawFadeTask();
        SetCurrentTaskMainEvent(SplashScreen_Main_StartOpening);
    }
}

void SplashScreen_Main_StartOpening(void)
{
    SplashScreen *work = TaskGetWorkCurrent(SplashScreen);
    UNUSED(work);

    ChangeEventForSplashScreen();
    DestroyCurrentTask();
}
