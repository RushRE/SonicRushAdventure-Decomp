#include <menu/credits.h>
#include <game/game/gameState.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/drawState.h>
#include <game/system/sysEvent.h>
#include <game/file/fsRequest.h>
#include <game/file/fileUnknown.h>
#include <game/input/padInput.h>
#include <game/graphics/vramSystem.h>
#include <game/graphics/drawFadeTask.h>
#include <game/save/saveGame.h>
#include <game/audio/sysSound.h>
#include <hub/missionConfig.h>

// resources
#include <resources/narc/dmsr_lz7.h>
#include <resources/narc/tkdm_lz7.h>

// --------------------
// ENUMS
// --------------------

enum CreditsFlags
{
    CREDITS_FLAG_NONE = 0x00,

    CREDITS_FLAG_UNKNOWN                   = 1 << 0,
    CREDITS_FLAG_SHOW_STINGER              = 1 << 1,
    CREDITS_FLAG_TEXT_SCROLL_PAGE_FINISHED = 1 << 2,
    CREDITS_FLAG_TEXT_SCROLL_FINISHED      = 1 << 3,
    CREDITS_FLAG_FADING_DONE               = 1 << 4,
    CREDITS_FLAG_THANKS_FINISHED           = 1 << 5,
    CREDITS_FLAG_NOTIFICATION_FINISHED     = 1 << 6,
};

enum CreditsMsgSequences
{
    CREDITS_MSGSEQ_COLLECT_ALL_EMERALDS,
    CREDITS_MSGSEQ_YOU_GOT_A_NEW_MISSION,
    CREDITS_MSGSEQ_YOU_CAN_NOW_PLAY_DEEP_CORE,
};

enum CreditsNotificationType_
{
    CREDITSNOTIF_EMERALD_STINGER,
    CREDITSNOTIF_MISSION_UNLOCK,
    CREDITSNOTIF_DEEP_CORE_UNLOCK,
};
typedef u32 CreditsNotificationType;

enum CreditsAssetType_
{
    CREDITS_ASSET_CREDITS,
    CREDITS_ASSET_CREDITS_EX,
    CREDITS_ASSET_FAKE_CREDITS,
    CREDITS_ASSET_EXSTAGE_NOTIF,
    CREDITS_ASSET_MISSION_NOTIF,
};
typedef u32 CreditsAssetType;

enum CreditsDisplayType_
{
    CREDITS_DISPLAY_CREDITS,
    CREDITS_DISPLAY_CREDITS_EX,
    CREDITS_DISPLAY_FAKE_CREDITS,
};
typedef u32 CreditsDisplayType;

// --------------------
// FUNCTION DECLS
// --------------------

// Credits Helpers
static void SetupDisplayForCredits(CreditsDisplayType type, BOOL isNotification);
static void LoadCreditsArchives(CreditsAssets *work, CreditsAssetType type);
static void ReleaseCreditsArchives(CreditsAssets *work);
static void LoadWandRoomAssets(WandRoom *work);
static void ReleaseWandRoomAssets(WandRoom *work);
static void LoadCreditsBackgrounds(Credits *work, CreditsAssetType type);
static void InitCreditsAnimator(AnimatorSpriteDS *animator, void *file, u16 anim, u16 palette);
static void InitCreditsSprites(Credits *work);
static void ReleaseCreditsSprites(Credits *work);
static void ReleaseCredits(void);
static void ClearCreditsChildTasks(void); // destroy any notifs & wandroom tasks
static void GoToNextCreditsEvent(s32 id);
static void SetCreditsLogoAlpha(fx32 alpha);
static BOOL DrawCreditsScrollText(Credits *work, s32 screenID);
static void DrawCreditsScreen(Credits *work, s32 id);
static void DrawCreditsLogo(Credits *work, s32 logoID, s32 screenID, s16 x, s16 y);
static BOOL DrawCreditsThanksText(Credits *work);
static void ProcessCreditsScroll(Credits *work, s32 id);
static void InitCreditsWindowPlanes(void);
static void DisableCreditsWinOutPlane(BOOL useEngineB, u8 plane);
static void EnableCreditsWinOutPlane(BOOL useEngineB, u8 plane);
static void Credits__Scroll_Screen1(Credits *work);
static void Credits__Scroll_Screen1Into2(Credits *work);
static void Credits__Scroll_Screen2(Credits *work);
static void Credits__Scroll_Screen2Into3(Credits *work);
static void Credits__Scroll_Screen3(Credits *work);
static void Credits__Scroll_Screen3Into4(Credits *work);
static void Credits__Scroll_Screen4(Credits *work);
static void Credits__Scroll_Thanks(Credits *work);

// Credits (beating Big Swell via the sea map)
static void CreateCredits(void);
static void Credits_Destructor(Task *task);
static void Credits_Main_Init(void);
static void Credits_Main_FadeToBlack(void);
static void Credits_Main_SetupBlending(void);
static void Credits_Main_DimWandRoom(void);
static void Credits_Main_DimDelay(void);
static void Credits_Main_ScrollText(void);
static void Credits_Main_EnterSegaLogo(void);
static void Credits_Main_ShowSegaLogo(void);
static void Credits_Main_UndimWandRoom(void);
static void Credits_Main_InitEmeraldStingerNotif(void);
static void Credits_Main_ShowEmeraldStingerNotif(void);
static void Credits_Main_InitMissionUnlockNotif(void);
static void Credits_Main_ShowMissionUnlockNotif(void);
static void Credits_Main_InitExit(void);
static void Credits_Main_Exit(void);

// CreditsEx (beating Deep Core via the hub icon)
static void CreateCreditsEx(void);
static void CreditsEx_Destructor(Task *task);
static void CreditsEx_Main_Init(void);
static void CreditsEx_Main_FadeToBlack(void);
static void CreditsEx_Main_SetupBlending(void);
static void CreditsEx_Main_DimBackground(void);
static void CreditsEx_Main_DimDelay(void);
static void CreditsEx_Main_ScrollText(void);
static void CreditsEx_Main_UndimBackground(void);
static void CreditsEx_Main_InitExit(void);
static void CreditsEx_Main_Exit(void);

// FakeCredits (beating Deep Core via stage select)
static void CreateFakeCredits(void);
static void FakeCredits_Destructor(Task *task);
static void FakeCredits_Main_Init(void);
static void FakeCredits_Main_FadeToBlack(void);
static void FakeCredits_Main_ScrollText(void);
static void FakeCredits_Main_UndimBackground(void);
static void FakeCredits_Main_InitExit(void);
static void FakeCredits_Main_Exit(void);

// ExStageCreditsNotification
static void CreateExStageCreditsNotification(void);
static void ExStageCreditsNotification_Destructor(Task *task);
static void ExStageCreditsNotification_Main_Init(void);
static void ExStageCreditsNotification_Main_ShowNotif(void);
static void ExStageCreditsNotification_Main_InitExit(void);
static void ExStageCreditsNotification_Main_Exit(void);

// PostGameMissionCreditsNotification
static void CreatePostGameMissionCreditsNotification(void);
static void PostGameMissionCreditsNotification__Destructor(Task *task);
static void PostGameMissionCreditsNotification_Main_Init(void);
static void PostGameMissionCreditsNotification_Main_ShowNotif(void);
static void PostGameMissionCreditsNotification_Main_InitExit(void);
static void PostGameMissionCreditsNotification_Main_Exit(void);

// WandRoom
static void CreateWandRoom(Credits *parent);
static void WandRoom_Destructor(Task *task);
static void WandRoom_Main_Init(void);
static void WandRoom_Main_Idle(void);
static void WandRoom_Main_ShowStinger(void);

// CreditsNotification
static void CreateCreditsNotification(Credits *parent, CreditsNotificationType type);
static void CreditsNotification_Destructor(Task *task);
static void CreditsNotification_Main_InitWindowOpen(void);
static void CreditsNotification_Main_ProcessWindowOpen(void);
static void CreditsNotification_Main_ShowText(void);
static void CreditsNotification_Main_InitWindowClose(void);
static void CreditsNotification_Main_ProcessWindowClose(void);
static void CreditsNotification_Main_Exit(void);
static void InitCreditsNotificationWindow(CreditsNotification *work);
static void ReleaseCreditsNotificationWindow(CreditsNotification *work);
static void InitCreditsNotificationWindowOpen(CreditsNotification *work);
static BOOL ProcessCreditsNotificationWindowAnimation(CreditsNotification *work);
static BOOL ProcessCreditsNotificationWindowAnimationAndClose(CreditsNotification *work);
static void SetCreditsNotificationWindowOpen(CreditsNotification *work);
static void InitCreditsNotificationWindowClose(CreditsNotification *work);
static void SetCreditsNotificationWindowNextButtonState(CreditsNotification *work, s32 state);

// --------------------
// FUNCTIONS
// --------------------

void InitCreditsEvent(void)
{
    switch (gameState.creditsMode)
    {
        case CREDITS_MODE_FINAL_BOSS:
            CreateCredits();
            break;

        case CREDITS_MODE_EXTRA_BOSS:
            CreateCreditsEx();
            break;

        case CREDITS_MODE_EXTRA_BOSS_STAGE_SELECT:
            CreateFakeCredits();
            break;

        case CREDITS_MODE_EXTRA_STAGE_NOTIF:
            CreateExStageCreditsNotification();
            break;

        case CREDITS_MODE_MISSION_NOTIF:
            CreatePostGameMissionCreditsNotification();
            break;
    }
}

void SetupDisplayForCredits(CreditsDisplayType type, BOOL isNotification)
{
    VRAMSystem__Reset();

    if (type == CREDITS_DISPLAY_CREDITS_EX)
    {
        GX_SetPower(GX_POWER_2D);

        VRAMSystem__SetupBGBank(GX_VRAM_BG_256_AB);
        VRAMSystem__SetupBGExtPalBank(GX_VRAM_BGEXTPLTT_23_G);
    }
    else
    {
        GX_SetPower(GX_POWER_ALL);

        VRAMSystem__SetupTextureBank(GX_VRAM_TEX_0_B);
        VRAMSystem__SetupTexturePalBank(GX_VRAM_TEXPLTT_0_G);
        VRAMSystem__SetupBGBank(GX_VRAM_BG_128_A);
    }

    VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_64_E, GX_OBJVRAMMODE_CHAR_1D_64K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x400);
    VRAMSystem__SetupOBJExtPalBank(GX_VRAM_OBJEXTPLTT_0_F);
    VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_128_C);
    VRAMSystem__SetupSubBGExtPalBank(GX_VRAM_SUB_BGEXTPLTT_0123_H);
    VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_128_D, GX_OBJVRAMMODE_CHAR_1D_64K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x400);
    VRAMSystem__SetupSubOBJExtPalBank(GX_VRAM_SUB_OBJEXTPLTT_0_I);

    GX_SetDispSelect(GX_DISP_SELECT_MAIN_SUB);
    renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;

    ((GXRgb *)VRAM_BG_PLTT)[0]    = GX_RGB_888(0x00, 0x00, 0x00);
    ((GXRgb *)VRAM_DB_BG_PLTT)[0] = GX_RGB_888(0x00, 0x00, 0x00);

    renderCoreGFXControlA.windowManager.visible = 0;

    renderCoreGFXControlA.blendManager.blendControl.effect = BLENDTYPE_NONE;

    renderCoreGFXControlA.brightness = RENDERCORE_BRIGHTNESS_BLACK;
    renderCoreGFXControlA.mosaicSize = 0;
    GX_SetMasterBrightness(renderCoreGFXControlA.brightness);

    GX_SetBGScrOffset(GX_BGSCROFFSET_0x00000);
    GX_SetBGCharOffset(GX_BGCHAROFFSET_0x00000);

    if (type == CREDITS_DISPLAY_CREDITS_EX)
    {
        GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_0, GX_BG0_AS_2D);
        G2_SetBG0Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x2800, GX_BG_CHARBASE_0x20000, GX_BG_EXTPLTT_23);
    }
    else
    {
        GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_0, GX_BG0_AS_3D);
    }

    G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_01);
    G2_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0800, GX_BG_CHARBASE_0x10000);
    G2_SetBG3ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x1800, GX_BG_CHARBASE_0x18000);

    renderCoreGFXControlA.bgPosition[BACKGROUND_0].x = renderCoreGFXControlA.bgPosition[BACKGROUND_0].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_1].x = renderCoreGFXControlA.bgPosition[BACKGROUND_1].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_2].x = renderCoreGFXControlA.bgPosition[BACKGROUND_2].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_3].x = renderCoreGFXControlA.bgPosition[BACKGROUND_3].y = 0;

    G2_SetBG0Priority(3);
    G2_SetBG1Priority(2);
    G2_SetBG2Priority(1);
    G2_SetBG3Priority(0);

    if (isNotification)
        GX_SetVisiblePlane(GX_PLANEMASK_ALL & ~(GX_PLANEMASK_BG0 | GX_PLANEMASK_BG1));
    else
        GX_SetVisiblePlane(GX_PLANEMASK_ALL);

    if (type == CREDITS_DISPLAY_CREDITS_EX)
        MI_CpuClear16(VRAMSystem__VRAM_BG[0], 0x40000);
    else
        MI_CpuClear16(VRAMSystem__VRAM_BG[0], 0x20000);

    renderCoreGFXControlB.windowManager.visible = 0;

    renderCoreGFXControlB.blendManager.blendControl.effect = BLENDTYPE_NONE;

    renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_BLACK;
    renderCoreGFXControlB.mosaicSize = 0;
    GXS_SetMasterBrightness(renderCoreGFXControlB.brightness);

    GXS_SetGraphicsMode(GX_BGMODE_0);

    G2S_SetBG0Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_01);
    G2S_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x0800, GX_BG_CHARBASE_0x08000, GX_BG_EXTPLTT_01);
    G2S_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x1000, GX_BG_CHARBASE_0x10000);
    G2S_SetBG3ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x2000, GX_BG_CHARBASE_0x18000);

    renderCoreGFXControlB.bgPosition[BACKGROUND_0].x = renderCoreGFXControlB.bgPosition[BACKGROUND_0].y = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_1].x = renderCoreGFXControlB.bgPosition[BACKGROUND_1].y = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_2].x = renderCoreGFXControlB.bgPosition[BACKGROUND_2].y = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_3].x = renderCoreGFXControlB.bgPosition[BACKGROUND_3].y = 0;

    G2S_SetBG0Priority(3);
    G2S_SetBG1Priority(2);
    G2S_SetBG2Priority(1);
    G2S_SetBG3Priority(0);

    if (isNotification)
        GXS_SetVisiblePlane(GX_PLANEMASK_NONE);
    else
        GXS_SetVisiblePlane(GX_PLANEMASK_ALL);

    MI_CpuClear16(VRAMSystem__VRAM_BG[1], 0x20000);
}

void LoadCreditsArchives(CreditsAssets *work, CreditsAssetType type)
{
    FSRequestArchive("/narc/dmsr_lz7.narc", &work->dmsrArchive, FALSE);

    switch (type)
    {
        case CREDITS_ASSET_CREDITS_EX:
        case CREDITS_ASSET_FAKE_CREDITS:
            break;

        case CREDITS_ASSET_CREDITS:
        case CREDITS_ASSET_EXSTAGE_NOTIF:
        case CREDITS_ASSET_MISSION_NOTIF:
            FSRequestArchive("/narc/tkdm_lz7.narc", &work->tkdmArchive, FALSE);

            work->font = FSRequestFileSync("fnt/font_all.fnt", FSREQ_AUTO_ALLOC_HEAD);
            break;
    }
}

void ReleaseCreditsArchives(CreditsAssets *work)
{
    HeapFree(HEAP_USER, work->dmsrArchive);

    switch (work->type)
    {
        case CREDITS_ASSET_CREDITS_EX:
        case CREDITS_ASSET_FAKE_CREDITS:
            break;

        case CREDITS_ASSET_CREDITS:
        case CREDITS_ASSET_EXSTAGE_NOTIF:
        case CREDITS_ASSET_MISSION_NOTIF:
            HeapFree(HEAP_USER, work->tkdmArchive);
            HeapFree(HEAP_USER, work->font);
            break;
    }
}

void LoadWandRoomAssets(WandRoom *work)
{
    void *wandroomMDL = FileUnknown__GetAOUFile(work->parent->assets.dmsrArchive, ARCHIVE_DMSR_LZ7_FILE_WANDROOM_NSBMD);
    void *wandroomTA  = FileUnknown__GetAOUFile(work->parent->assets.dmsrArchive, ARCHIVE_DMSR_LZ7_FILE_WANDROOM_NSBTA);

    Credits *parent       = work->parent;
    AnimatorMDL *animator = &work->aniWandroom;

    LoadDrawState(FileUnknown__GetAOUFile(parent->assets.dmsrArchive, ARCHIVE_DMSR_LZ7_FILE_WANDROOM_BSD), DRAWSTATE_ALL);
    NNS_G3dResDefaultSetup(wandroomMDL);

    AnimatorMDL__Init(animator, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(animator, wandroomMDL, 0, FALSE, FALSE);
    AnimatorMDL__SetAnimation(animator, B3D_ANIM_TEX_ANIM, wandroomTA, 0, NULL);

    for (u32 i = 0; i < B3D_ANIM_MAX; i++)
    {
        if (((1 << i) & B3D_ANIM_FLAG_TEX_ANIM) != 0)
            animator->animFlags[i] |= ANIMATORMDL_FLAG_STOPPED;
    }
}

void ReleaseWandRoomAssets(WandRoom *work)
{
    AnimatorMDL__Release(&work->aniWandroom);

    NNS_G3dResDefaultRelease(FileUnknown__GetAOUFile(work->parent->assets.dmsrArchive, ARCHIVE_DMSR_LZ7_FILE_WANDROOM_NSBMD));
}

void LoadCreditsBackgrounds(Credits *work, CreditsAssetType type)
{
    BackgroundDS *bgScreen1;
    s32 screen1Height;

    switch (type)
    {
        case CREDITS_ASSET_CREDITS:
            Background bgUpFrame1;
            InitBackground(&bgUpFrame1, FileUnknown__GetAOUFile(work->assets.dmsrArchive, ARCHIVE_DMSR_LZ7_FILE_UP_FLAME_BBG), BACKGROUND_FLAG_LOAD_ALL, FALSE, BACKGROUND_1,
                           BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
            DrawBackground(&bgUpFrame1);
            break;

        case CREDITS_ASSET_CREDITS_EX:
            Background bgExtraCap;
            InitBackground(&bgExtraCap, FileUnknown__GetAOUFile(work->assets.dmsrArchive, ARCHIVE_DMSR_LZ7_FILE_EXTRA_CAP_BBG), BACKGROUND_FLAG_LOAD_ALL, FALSE, BACKGROUND_0,
                           BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
            DrawBackground(&bgExtraCap);

            Background bgUpFrame2;
            InitBackground(&bgUpFrame2, FileUnknown__GetAOUFile(work->assets.dmsrArchive, ARCHIVE_DMSR_LZ7_FILE_UP_FLAME_BBG), BACKGROUND_FLAG_LOAD_ALL, FALSE, BACKGROUND_1,
                           BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
            DrawBackground(&bgUpFrame2);
            break;

        case CREDITS_ASSET_FAKE_CREDITS:
            Background bgExtraEnd;
            InitBackground(&bgExtraEnd, FileUnknown__GetAOUFile(work->assets.dmsrArchive, ARCHIVE_DMSR_LZ7_FILE_EXTRA_END_BBG), BACKGROUND_FLAG_LOAD_ALL, FALSE, BACKGROUND_1,
                           BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
            DrawBackground(&bgExtraEnd);
            break;
    }

    Background bgDownBase;
    InitBackground(&bgDownBase, FileUnknown__GetAOUFile(work->assets.dmsrArchive, ARCHIVE_DMSR_LZ7_FILE_DOWN_BASE_BBG), BACKGROUND_FLAG_LOAD_ALL, TRUE, BACKGROUND_0,
                   BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
    DrawBackground(&bgDownBase);

    Background bgSegaLogo;
    InitBackground(&bgSegaLogo, FileUnknown__GetAOUFile(work->assets.dmsrArchive, ARCHIVE_DMSR_LZ7_FILE_LOGO_SEGA_BBG), BACKGROUND_FLAG_LOAD_ALL, TRUE, BACKGROUND_1,
                   BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
    DrawBackground(&bgSegaLogo);

    bgScreen1 = &work->screens[1].background;
    switch (work->assets.type)
    {
        case CREDITS_ASSET_CREDITS:
            GXS_SetVisiblePlane(GXS_GetVisiblePlane() & ~GX_PLANEMASK_BG1);

            MI_CpuClear16(&renderCoreGFXControlB.blendManager, sizeof(renderCoreGFXControlB.blendManager));
            renderCoreGFXControlB.blendManager.blendControl.effect     = BLENDTYPE_ALPHA;
            renderCoreGFXControlB.blendManager.blendControl.plane2_BG0 = TRUE;
            renderCoreGFXControlB.blendManager.blendControl.plane1_BG1 = TRUE;
            renderCoreGFXControlB.blendManager.blendControl.plane2_OBJ = TRUE;

            renderCoreGFXControlB.blendManager.blendAlpha.ev1 = 0x00;
            renderCoreGFXControlB.blendManager.blendAlpha.ev2 = 0x10;
            break;

        case CREDITS_ASSET_CREDITS_EX:
            GXS_SetVisiblePlane(GXS_GetVisiblePlane() & ~GX_PLANEMASK_BG1);
            break;

        case CREDITS_ASSET_FAKE_CREDITS:
            GXS_SetVisiblePlane(GXS_GetVisiblePlane() | GX_PLANEMASK_BG1);
            break;
    }

    void *bgFile                = FileUnknown__GetAOUFile(work->assets.dmsrArchive, ARCHIVE_DMSR_LZ7_FILE_STUFF_00_BBG);
    work->screens[0].height     = 8 * GetBackgroundHeight(bgFile);
    work->screens[0].stopBottom = work->screens[0].height - HW_LCD_HEIGHT;
    work->screens[0].stopTop    = work->screens[0].height - (HW_LCD_HEIGHT + BOTTOM_SCREEN_CAMERA_OFFSET);
    InitBackgroundDS(&work->screens[0].background, bgFile, BACKGROUND_FLAG_ALIGN_EVEN_WIDTH | BACKGROUND_FLAG_ALIGN_EVEN_HEIGHT, BACKGROUND_2, BACKGROUND_2, BG_DISPLAY_FULL_WIDTH,
                     BG_DISPLAY_SINGLE_HEIGHT);
    DrawBackgroundDS(&work->screens[0].background);
    work->screens[0].background.work.flags |= BACKGROUND_FLAG_DISABLE_PALETTE | BACKGROUND_FLAG_DISABLE_PIXELS;

    u8 fileID;
#if defined(RUSH_EUROPE)
    fileID = ARCHIVE_DMSR_LZ7_FILE_STUFF_01_EU_BBG;
#elif defined(RUSH_USA)
    fileID = ARCHIVE_DMSR_LZ7_FILE_STUFF_01_ENG_BBG;
#elif defined(RUSH_JAPAN)
    fileID = ARCHIVE_DMSR_LZ7_FILE_STUFF_01_JPN_BBG;
#endif

    bgFile                      = FileUnknown__GetAOUFile(work->assets.dmsrArchive, fileID);
    work->screens[1].height     = 8 * GetBackgroundHeight(bgFile);
    screen1Height               = BACKGROUND_FLAG_ALIGN_EVEN_HEIGHT;
    work->screens[1].scrollPos  = -BOTTOM_SCREEN_CAMERA_OFFSET;
    work->screens[1].stopBottom = work->screens[1].height - HW_LCD_HEIGHT;
    work->screens[1].stopTop    = work->screens[1].height - (HW_LCD_HEIGHT + BOTTOM_SCREEN_CAMERA_OFFSET);
    InitBackgroundDS(bgScreen1, bgFile, BACKGROUND_FLAG_ALIGN_EVEN_WIDTH | screen1Height, BACKGROUND_3, BACKGROUND_3, 256 / 8, 192 / 8);
    DrawBackgroundDS(bgScreen1);
    work->screens[1].background.work.flags |= BACKGROUND_FLAG_DISABLE_PALETTE | BACKGROUND_FLAG_DISABLE_PIXELS;

#if defined(RUSH_EUROPE)
    fileID = ARCHIVE_DMSR_LZ7_FILE_STUFF_02_EU_BBG;
#elif defined(RUSH_USA)
    fileID = ARCHIVE_DMSR_LZ7_FILE_STUFF_02_ENG_BBG;
#elif defined(RUSH_JAPAN)
    fileID = ARCHIVE_DMSR_LZ7_FILE_STUFF_02_JPN_BBG;
#endif

    bgFile                      = FileUnknown__GetAOUFile(work->assets.dmsrArchive, fileID);
    work->screens[2].height     = 8 * GetBackgroundHeight(bgFile);
    work->screens[2].scrollPos  = -BOTTOM_SCREEN_CAMERA_OFFSET;
    work->screens[2].stopBottom = work->screens[2].height - HW_LCD_HEIGHT;
    work->screens[2].stopTop    = work->screens[2].height - (HW_LCD_HEIGHT + BOTTOM_SCREEN_CAMERA_OFFSET);
    InitBackgroundDS(&work->screens[2].background, bgFile, BACKGROUND_FLAG_ALIGN_EVEN_WIDTH | BACKGROUND_FLAG_ALIGN_EVEN_HEIGHT, BACKGROUND_2, BACKGROUND_2, BG_DISPLAY_FULL_WIDTH,
                     BG_DISPLAY_SINGLE_HEIGHT);

    bgFile                      = FileUnknown__GetAOUFile(work->assets.dmsrArchive, ARCHIVE_DMSR_LZ7_FILE_STUFF_03_BBG);
    work->screens[3].height     = 8 * GetBackgroundHeight(bgFile);
    work->screens[3].scrollPos  = -BOTTOM_SCREEN_CAMERA_OFFSET;
    work->screens[3].stopBottom = work->screens[3].height - HW_LCD_HEIGHT;
    work->screens[3].stopTop    = work->screens[3].height - (HW_LCD_HEIGHT + BOTTOM_SCREEN_CAMERA_OFFSET);
    InitBackgroundDS(&work->screens[3].background, bgFile, BACKGROUND_FLAG_ALIGN_EVEN_WIDTH | BACKGROUND_FLAG_ALIGN_EVEN_HEIGHT, BACKGROUND_3, BACKGROUND_3, BG_DISPLAY_FULL_WIDTH,
                     BG_DISPLAY_SINGLE_HEIGHT);

    work->scrollSpeed = 1;
}

void InitCreditsAnimator(AnimatorSpriteDS *animator, void *file, u16 anim, u16 palette)
{
    PaletteMode paletteMode0;
    PaletteMode paletteMode1;
    VRAMPaletteKey paletteBank0;
    VRAMPaletteKey paletteBank1;

    switch (Sprite__GetFormatFromAnim(file, anim))
    {
        case BAC_FORMAT_INDEXED4_2D:
            paletteBank0 = VRAM_OBJ_PLTT;
            paletteBank1 = VRAM_DB_OBJ_PLTT;
            paletteMode0 = PALETTE_MODE_SPRITE;
            paletteMode1 = PALETTE_MODE_SPRITE;
            break;

        case BAC_FORMAT_INDEXED8_2D:
            paletteBank0 = NULL;
            paletteBank1 = NULL;
            paletteMode0 = PALETTE_MODE_OBJ;
            paletteMode1 = PALETTE_MODE_SUB_OBJ;
            break;
    }

    VRAMPixelKey vramPixels0 = VRAMSystem__AllocSpriteVram(FALSE, Sprite__GetSpriteSize2(file));
    VRAMPixelKey vramPixels1 = VRAMSystem__AllocSpriteVram(TRUE, Sprite__GetSpriteSize2(file));
    AnimatorSpriteDS__Init(animator, file, anim, SCREEN_DRAW_NONE, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK, PIXEL_MODE_SPRITE, vramPixels0, paletteMode0, paletteBank0,
                           PIXEL_MODE_SPRITE, vramPixels1, paletteMode1, paletteBank1, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    animator->cParam[0].palette = palette;
    animator->cParam[1].palette = palette;
}

void InitCreditsSprites(Credits *work)
{
    s32 i;
    AnimatorSprite *aniThanks;

    void *sprLogos = FileUnknown__GetAOUFile(work->assets.dmsrArchive, ARCHIVE_DMSR_LZ7_FILE_OBJLOGO_BAC);
    InitCreditsAnimator(&work->aniLogos[0], sprLogos, 0, PALETTE_ROW_0);
    InitCreditsAnimator(&work->aniLogos[1], sprLogos, 1, PALETTE_ROW_1);
    InitCreditsAnimator(&work->aniCongratulations, FileUnknown__GetAOUFile(work->assets.dmsrArchive, ARCHIVE_DMSR_LZ7_FILE_STR_CONG_BAC), 0, PALETTE_ROW_0);

    void *sprThanks = FileUnknown__GetAOUFile(work->assets.dmsrArchive, ARCHIVE_DMSR_LZ7_FILE_STR_THANK_BAC);

    aniThanks = &work->aniThanksForPlaying[0];
    for (i = 0; i < 18; i++)
    {
        AnimatorSprite__Init(aniThanks, sprThanks, i, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_DRAW, FALSE, PIXEL_MODE_SPRITE,
                             VRAMSystem__AllocSpriteVram(FALSE, Sprite__GetSpriteSize2(sprThanks)), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
        work->aniThanksForPlaying[i].cParam.palette = PALETTE_ROW_1;

        aniThanks++;
    }
}

void ReleaseCreditsSprites(Credits *work)
{
    s32 i;

    for (i = 0; i < 3; i++)
    {
        AnimatorSpriteDS__Release(&work->aniLogos[i]);
    }

    for (i = 0; i < 18; i++)
    {
        AnimatorSprite__Release(&work->aniThanksForPlaying[i]);
    }
}

void ReleaseCredits(void)
{
    MI_CpuClear8(&renderCoreGFXControlA.windowManager, sizeof(renderCoreGFXControlA.windowManager));
    MI_CpuClear8(&renderCoreGFXControlB.windowManager, sizeof(renderCoreGFXControlB.windowManager));

    DestroyTaskGroup(TASK_GROUP(1));
    DestroyTaskGroup(TASK_GROUP(0));
}

void ClearCreditsChildTasks(void)
{
    DestroyTaskGroup(TASK_GROUP(1));
}

void GoToNextCreditsEvent(s32 id)
{
    RequestSysEventChange(id);
    NextSysEvent();
}

NONMATCH_FUNC void SetCreditsLogoAlpha(fx32 alpha)
{
    // https://decomp.me/scratch/h1HAK -> 76.74%
#ifdef NON_MATCHING
    alpha = MTM_MATH_CLIP(alpha, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(16.0));

    renderCoreGFXControlB.blendManager.blendAlpha.ev1 = FX32_TO_WHOLE(alpha);
    renderCoreGFXControlB.blendManager.blendAlpha.ev2 = FX32_TO_WHOLE(FLOAT_TO_FX32(16.0) - alpha);
#else
    // clang-format off
	cmp r0, #0
	ldr r1, =renderCoreGFXControlB
	movlt r0, #0
	blt _02155200
	cmp r0, #0x10000
	movgt r0, #0x10000
_02155200:
	ldrh r3, [r1, #0x22]
	mov r2, r0, lsl #4
	mov r2, r2, lsr #0x10
	bic r3, r3, #0x1f
	and r2, r2, #0x1f
	orr r2, r3, r2
	strh r2, [r1, #0x22]
	rsb r0, r0, #0x10000
	ldrh r2, [r1, #0x22]
	mov r0, r0, lsl #4
	mov r0, r0, lsr #0x10
	bic r2, r2, #0x1f00
	mov r0, r0, lsl #0x1b
	orr r0, r2, r0, lsr #19
	strh r0, [r1, #0x22]
	bx lr

// clang-format on
#endif
}

BOOL DrawCreditsScrollText(Credits *work, s32 screenID)
{
    BackgroundDS *background;

    BOOL doneBottom = FALSE;
    BOOL doneTop    = FALSE;

    u8 bgID;
    switch (screenID)
    {
        case 0:
        case 2:
            bgID = BACKGROUND_2;
            break;

        case 1:
        case 3:
            bgID = BACKGROUND_3;
            break;
    }

    background = &work->screens[screenID].background;
    if (work->screens[screenID].scrollPos <= work->screens[screenID].stopBottom)
    {
        if (work->screens[screenID].scrollPos > 0)
            EnableCreditsWinOutPlane(GRAPHICS_ENGINE_A, bgID);

        background->position[GRAPHICS_ENGINE_A].x = 0;
        background->position[GRAPHICS_ENGINE_A].y = work->screens[screenID].scrollPos;

        renderCoreGFXControlA.bgPosition[bgID].x = background->position[GRAPHICS_ENGINE_A].x & 7;
        renderCoreGFXControlA.bgPosition[bgID].y = background->position[GRAPHICS_ENGINE_A].y & 7;
    }
    else
    {
        doneBottom = TRUE;
        DisableCreditsWinOutPlane(GRAPHICS_ENGINE_A, bgID);
    }

    if (work->screens[screenID].scrollPos <= work->screens[screenID].stopTop)
    {
        background->position[GRAPHICS_ENGINE_B].x = 0;
        background->position[GRAPHICS_ENGINE_B].y = work->screens[screenID].scrollPos + BOTTOM_SCREEN_CAMERA_OFFSET;

        renderCoreGFXControlB.bgPosition[bgID].x = background->position[GRAPHICS_ENGINE_B].x & 7;
        renderCoreGFXControlB.bgPosition[bgID].y = background->position[GRAPHICS_ENGINE_B].y & 7;
    }
    else
    {
        doneTop = TRUE;
        DisableCreditsWinOutPlane(GRAPHICS_ENGINE_B, bgID);
    }

    DrawBackgroundDS(background);

    if (work->screens[screenID].scrollPos >= work->screens[screenID].stopTop - HW_LCD_HEIGHT)
        work->flags |= CREDITS_FLAG_TEXT_SCROLL_PAGE_FINISHED;

    return doneBottom && doneTop;
}

void DrawCreditsScreen(Credits *work, s32 id)
{
    work->screens[id].background.work.flags &= ~(BACKGROUND_FLAG_DISABLE_PALETTE | BACKGROUND_FLAG_DISABLE_PIXELS | BACKGROUND_FLAG_DISABLE_MAPPINGS);
    DrawBackgroundDS(&work->screens[id].background);
    work->screens[id].background.work.flags |= BACKGROUND_FLAG_DISABLE_PALETTE | BACKGROUND_FLAG_DISABLE_PIXELS;
}

NONMATCH_FUNC void DrawCreditsLogo(Credits *work, s32 logoID, s32 screenID, s16 x, s16 y)
{
    // https://decomp.me/scratch/khgpb -> 73.75%
#ifdef NON_MATCHING
    CreditsScreen *screen = &work->screens[screenID];
    s16 logoY             = y - (s16)screen->scrollPos;

    work->aniLogos[logoID].position[0].x = x;
    work->aniLogos[logoID].position[0].y = logoY;

    work->aniLogos[logoID].position[1].x = x;
    work->aniLogos[logoID].position[1].y = logoY - BOTTOM_SCREEN_CAMERA_OFFSET;

    AnimatorSpriteDS__ProcessAnimationFast(&work->aniLogos[logoID]);
    AnimatorSpriteDS__DrawFrame(&work->aniLogos[logoID]);
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov ip, #0xa4
	mla lr, r2, ip, r0
	mul r5, r1, ip
	add r2, r0, r5
	add r4, r0, #0x2c8
	mov r1, #0
	ldrsh r6, [sp, #0x10]
	ldr r0, [lr, #0x38]
	add ip, r2, #0x300
	sub r0, r6, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	strh r3, [ip, #0x30]
	strh r0, [ip, #0x32]
	mov r2, r1
	strh r3, [ip, #0x34]
	sub r3, r0, #0x110
	add r0, r4, r5
	strh r3, [ip, #0x36]
	bl AnimatorSpriteDS__ProcessAnimation
	add r0, r4, r5
	bl AnimatorSpriteDS__DrawFrame
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

BOOL DrawCreditsThanksText(Credits *work)
{
    BOOL done = FALSE;

    if (work->visibleLetterCount < 18)
    {
        if ((work->congratulationsTimer & 3) == 0)
        {
            work->aniThanksForPlaying[work->visibleLetterCount].flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;
            work->visibleLetterCount++;
        }

        work->congratulationsTimer++;
    }
    else
    {
        done = TRUE;
    }

    for (s32 i = 0; i < 18; i++)
    {
        AnimatorSprite__ProcessAnimationFast(&work->aniThanksForPlaying[i]);
        AnimatorSprite__DrawFrame(&work->aniThanksForPlaying[i]);
    }

    return done;
}

void ProcessCreditsScroll(Credits *work, s32 id)
{
    if ((padInput.btnDown & PAD_BUTTON_A) != 0)
        work->screens[id].scrollPos += 16 * work->scrollSpeed;
    else
        work->screens[id].scrollPos += work->scrollSpeed;
}

void InitCreditsWindowPlanes(void)
{
    RenderCoreGFXControl *control                      = VRAMSystem__GFXControl[0];
    control->windowManager.registers.win0X1            = 0;
    control->windowManager.registers.win0X2            = 0;
    control->windowManager.registers.win0Y1            = 0;
    control->windowManager.registers.win0Y2            = 0;
    control->windowManager.registers.win0InPlane.value = 0;
    control->windowManager.registers.winOutPlane.value = 0xFF;
    control->windowManager.visible                     = 1;

    control                                            = VRAMSystem__GFXControl[1];
    control->windowManager.registers.win0X1            = 0;
    control->windowManager.registers.win0X2            = 0;
    control->windowManager.registers.win0Y1            = 0;
    control->windowManager.registers.win0Y2            = 0;
    control->windowManager.registers.win0InPlane.value = 0;
    control->windowManager.registers.winOutPlane.value = 0xFF;
    control->windowManager.visible                     = 1;
}

void DisableCreditsWinOutPlane(BOOL useEngineB, u8 plane)
{
    RenderCoreGFXControl *control = VRAMSystem__GFXControl[useEngineB];

    control->windowManager.registers.win0X1            = 0;
    control->windowManager.registers.win0X2            = 0;
    control->windowManager.registers.win0Y1            = 0;
    control->windowManager.registers.win0Y2            = 0;
    control->windowManager.registers.win0InPlane.value = 0;
    control->windowManager.registers.winOutPlane.value &= ~(1 << plane) & 0xFF;
    control->windowManager.visible = 1;
}

void EnableCreditsWinOutPlane(BOOL useEngineB, u8 plane)
{
    RenderCoreGFXControl *control = VRAMSystem__GFXControl[useEngineB];

    control->windowManager.registers.win0X1            = 0;
    control->windowManager.registers.win0X2            = 0;
    control->windowManager.registers.win0Y1            = 0;
    control->windowManager.registers.win0Y2            = 0;
    control->windowManager.registers.win0InPlane.value = 0;
    control->windowManager.registers.winOutPlane.value |= (1 << plane) & 0xFF;
    control->windowManager.visible = 1;
}

void Credits__Scroll_Screen1(Credits *work)
{
    ProcessCreditsScroll(work, 0);

    DrawCreditsScrollText(work, 0);
    DrawCreditsLogo(work, 0, 0, 64, 504);
    DrawCreditsLogo(work, 1, 0, 64, 1592);

    if ((work->flags & CREDITS_FLAG_TEXT_SCROLL_PAGE_FINISHED) != 0)
    {
        work->flags &= ~CREDITS_FLAG_TEXT_SCROLL_PAGE_FINISHED;
        DisableCreditsWinOutPlane(GRAPHICS_ENGINE_A, BACKGROUND_3);
        EnableCreditsWinOutPlane(GRAPHICS_ENGINE_B, BACKGROUND_3);
        work->scrollState = Credits__Scroll_Screen1Into2;
    }
}

void Credits__Scroll_Screen1Into2(Credits *work)
{
    ProcessCreditsScroll(work, 0);
    ProcessCreditsScroll(work, 1);

    if (DrawCreditsScrollText(work, 0))
    {
        work->flags &= ~CREDITS_FLAG_TEXT_SCROLL_PAGE_FINISHED;

        DisableCreditsWinOutPlane(GRAPHICS_ENGINE_A, BACKGROUND_2);
        DisableCreditsWinOutPlane(GRAPHICS_ENGINE_B, BACKGROUND_2);
        work->scrollState = Credits__Scroll_Screen2;
    }

    DrawCreditsScrollText(work, 1);
}

void Credits__Scroll_Screen2(Credits *work)
{
    ProcessCreditsScroll(work, 1);

    DrawCreditsScrollText(work, 1);

    if ((work->flags & CREDITS_FLAG_TEXT_SCROLL_PAGE_FINISHED) != 0)
    {
        work->flags &= ~CREDITS_FLAG_TEXT_SCROLL_PAGE_FINISHED;

        DrawCreditsScreen(work, 2);
        DisableCreditsWinOutPlane(GRAPHICS_ENGINE_A, BACKGROUND_2);
        EnableCreditsWinOutPlane(GRAPHICS_ENGINE_B, BACKGROUND_2);

        work->scrollState = Credits__Scroll_Screen2Into3;
    }
}

void Credits__Scroll_Screen2Into3(Credits *work)
{
    ProcessCreditsScroll(work, 1);
    ProcessCreditsScroll(work, 2);

    if (DrawCreditsScrollText(work, 1))
    {
        work->flags &= ~CREDITS_FLAG_TEXT_SCROLL_PAGE_FINISHED;

        DisableCreditsWinOutPlane(GRAPHICS_ENGINE_A, BACKGROUND_3);
        DisableCreditsWinOutPlane(GRAPHICS_ENGINE_B, BACKGROUND_3);

        work->scrollState = Credits__Scroll_Screen3;
    }

    DrawCreditsScrollText(work, 2);
}

void Credits__Scroll_Screen3(Credits *work)
{
    ProcessCreditsScroll(work, 2);

    DrawCreditsScrollText(work, 2);

    if ((work->flags & CREDITS_FLAG_TEXT_SCROLL_PAGE_FINISHED) != 0)
    {
        work->flags &= ~CREDITS_FLAG_TEXT_SCROLL_PAGE_FINISHED;

        DrawCreditsScreen(work, 3);
        DisableCreditsWinOutPlane(GRAPHICS_ENGINE_A, BACKGROUND_3);
        EnableCreditsWinOutPlane(GRAPHICS_ENGINE_B, BACKGROUND_3);

        work->scrollState = Credits__Scroll_Screen3Into4;
    }
}

void Credits__Scroll_Screen3Into4(Credits *work)
{
    ProcessCreditsScroll(work, 2);
    ProcessCreditsScroll(work, 3);

    if (DrawCreditsScrollText(work, 2))
    {
        work->flags &= ~CREDITS_FLAG_TEXT_SCROLL_PAGE_FINISHED;

        DisableCreditsWinOutPlane(GRAPHICS_ENGINE_A, BACKGROUND_2);
        DisableCreditsWinOutPlane(GRAPHICS_ENGINE_B, BACKGROUND_2);

        work->scrollState = Credits__Scroll_Screen4;
    }

    DrawCreditsScrollText(work, 3);
}

void Credits__Scroll_Screen4(Credits *work)
{
    s16 pos = work->screens[3].height - 175;
    ProcessCreditsScroll(work, 3);

    DrawCreditsLogo(work, 2, 3, 128, pos);

    if (DrawCreditsScrollText(work, 3))
    {
        work->flags |= CREDITS_FLAG_TEXT_SCROLL_FINISHED;

        work->scrollState = Credits__Scroll_Thanks;
    }
}

void Credits__Scroll_Thanks(Credits *work)
{
    work->aniCongratulations.position[0].y = 17;

    AnimatorSpriteDS__ProcessAnimationFast(&work->aniCongratulations);
    AnimatorSpriteDS__DrawFrame(&work->aniCongratulations);

    if ((work->flags & CREDITS_FLAG_FADING_DONE) != 0)
    {
        if (DrawCreditsThanksText(work))
            work->flags |= CREDITS_FLAG_THANKS_FINISHED;
    }
}

void CreateCredits(void)
{
    SetupDisplayForCredits(CREDITS_DISPLAY_CREDITS, FALSE);

    Task *task = TaskCreate(Credits_Main_Init, Credits_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(0), Credits);

    Credits *work = TaskGetWork(task, Credits);
    TaskInitWork16(work);

    work->assets.type = CREDITS_ASSET_CREDITS;
    LoadCreditsArchives(&work->assets, work->assets.type);

    CreateWandRoom(work);
    LoadSysSound(SYSSOUND_GROUP_STAFF);
}

void Credits_Destructor(Task *task)
{
    Credits *work = TaskGetWork(task, Credits);

    ReleaseSysSound();
    ReleaseCreditsSprites(work);
    ReleaseCreditsArchives(&work->assets);
}

void Credits_Main_Init(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    LoadCreditsBackgrounds(work, work->assets.type);
    InitCreditsSprites(work);
    InitCreditsWindowPlanes();
    work->scrollState = Credits__Scroll_Screen1;

    CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_FADE_TO_BLACK, FLOAT_TO_FX32(0.5));
    PlaySysTrack(SND_SYS_SEQ_SEQ_STAFF, TRUE);

    SetCurrentTaskMainEvent(Credits_Main_FadeToBlack);
}

void Credits_Main_FadeToBlack(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if (IsDrawFadeTaskFinished())
    {
        work->delay = 60;
        SetCurrentTaskMainEvent(Credits_Main_SetupBlending);
    }
}

void Credits_Main_SetupBlending(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if (work->delay != 0)
    {
        work->delay--;
    }
    else
    {
        MI_CpuClear16(&renderCoreGFXControlA.blendManager, sizeof(renderCoreGFXControlA.blendManager));
        renderCoreGFXControlA.blendManager.blendControl.effect     = BLENDTYPE_FADEOUT;
        renderCoreGFXControlA.blendManager.blendControl.plane1_BG0 = TRUE;
        renderCoreGFXControlA.blendManager.blendControl.plane1_BG1 = FALSE;
        renderCoreGFXControlA.blendManager.blendControl.plane1_BG2 = FALSE;
        renderCoreGFXControlA.blendManager.blendControl.plane1_BG3 = FALSE;
        renderCoreGFXControlA.blendManager.blendControl.plane1_OBJ = FALSE;

        SetCurrentTaskMainEvent(Credits_Main_DimWandRoom);
    }
}

void Credits_Main_DimWandRoom(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    RenderCoreGFXControl *gfxControl = &renderCoreGFXControlA;

    work->bgBrightness += FLOAT_TO_FX32(0.2);

    if (work->bgBrightness >= FLOAT_TO_FX32(6.0))
    {
        work->bgBrightness                         = FLOAT_TO_FX32(6.0);
        gfxControl->blendManager.coefficient.value = FX32_TO_WHOLE(work->bgBrightness);
        work->delay                                = 90;
        SetCurrentTaskMainEvent(Credits_Main_DimDelay);
    }
    else
    {
        gfxControl->blendManager.coefficient.value = FX32_TO_WHOLE(work->bgBrightness);
    }
}

void Credits_Main_DimDelay(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if (work->delay != 0)
    {
        work->delay--;
    }
    else
    {
        work->delay     = 30;
        work->fadeDelay = 60;
        SetCurrentTaskMainEvent(Credits_Main_ScrollText);
    }
}

void Credits_Main_ScrollText(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if (work->scrollState != NULL)
        work->scrollState(work);

    if ((work->flags & CREDITS_FLAG_TEXT_SCROLL_FINISHED) != 0 && (work->flags & CREDITS_FLAG_FADING_DONE) == 0)
    {
        if (work->delay != 0)
        {
            work->delay--;
        }
        else
        {
            RenderCoreGFXControl *gfxControl = &renderCoreGFXControlA;

            work->bgBrightness -= FLOAT_TO_FX32(0.2);

            if (work->bgBrightness > 0)
            {
                gfxControl->blendManager.coefficient.value = FX32_TO_WHOLE(work->bgBrightness);
            }
            else
            {
                work->bgBrightness                         = FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_DEFAULT);
                gfxControl->blendManager.coefficient.value = FX32_TO_WHOLE(work->bgBrightness);

                if (work->fadeDelay != 0)
                    work->fadeDelay--;
                else
                    work->flags |= CREDITS_FLAG_FADING_DONE;
            }
        }
    }

    if ((work->flags & CREDITS_FLAG_THANKS_FINISHED) != 0)
    {
        GXS_SetVisiblePlane(GXS_GetVisiblePlane() | GX_PLANEMASK_BG1);
        work->logoAlpha = FLOAT_TO_FX32(0.0);

        SetCurrentTaskMainEvent(Credits_Main_EnterSegaLogo);
    }
}

void Credits_Main_EnterSegaLogo(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if (work->scrollState != NULL)
        work->scrollState(work);

    work->logoAlpha += FLOAT_TO_FX32(0.125);
    SetCreditsLogoAlpha(work->logoAlpha);

    if (work->logoAlpha >= FLOAT_TO_FX32(16.0))
    {
        work->timer = 360;
        SetCurrentTaskMainEvent(Credits_Main_ShowSegaLogo);
    }
}

void Credits_Main_ShowSegaLogo(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if (work->scrollState != NULL)
        work->scrollState(work);

    if (!SaveGame__CheckZoneBeaten(ZONE_DEEP_CORE) && work->timer < 330)
        work->flags |= CREDITS_FLAG_SHOW_STINGER;

    if (work->timer != 0)
    {
        work->timer--;
    }
    else
    {
        NNS_SndPlayerStopSeqAll(60);
        CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(0.5));
        SetCurrentTaskMainEvent(Credits_Main_UndimWandRoom);
    }
}

void Credits_Main_UndimWandRoom(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if (work->scrollState != NULL)
        work->scrollState(work);

    if (IsDrawFadeTaskFinished())
    {
        DestroyDrawFadeTask();

        if (SaveGame__CheckProgress37())
            SetCurrentTaskMainEvent(Credits_Main_InitExit);
        else
            SetCurrentTaskMainEvent(Credits_Main_InitEmeraldStingerNotif);
    }
}

void Credits_Main_InitEmeraldStingerNotif(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    ClearCreditsChildTasks();
    CreateCreditsNotification(work, CREDITSNOTIF_EMERALD_STINGER);

    SetCurrentTaskMainEvent(Credits_Main_ShowEmeraldStingerNotif);
}

void Credits_Main_ShowEmeraldStingerNotif(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if ((work->flags & CREDITS_FLAG_NOTIFICATION_FINISHED) != 0)
    {
        if (MissionHelpers__CheckPostGameMissionUnlock())
        {
            work->flags &= ~CREDITS_FLAG_NOTIFICATION_FINISHED;
            SetCurrentTaskMainEvent(Credits_Main_InitMissionUnlockNotif);
        }
        else
        {
            SetCurrentTaskMainEvent(Credits_Main_InitExit);
        }
    }
}

void Credits_Main_InitMissionUnlockNotif(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    CreateCreditsNotification(work, CREDITSNOTIF_MISSION_UNLOCK);
    LoadSysSoundVillage();
    PlaySysTrack(SND_SYS_SEQ_SEQ_J_ITEM, TRUE);

    SetCurrentTaskMainEvent(Credits_Main_ShowMissionUnlockNotif);
}

void Credits_Main_ShowMissionUnlockNotif(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if ((work->flags & CREDITS_FLAG_NOTIFICATION_FINISHED) != 0)
        SetCurrentTaskMainEvent(Credits_Main_InitExit);
}

void Credits_Main_InitExit(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    work->timer = 60;
    SetCurrentTaskMainEvent(Credits_Main_Exit);
}

void Credits_Main_Exit(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if (work->timer != 0)
    {
        work->timer--;
    }
    else
    {
        GoToNextCreditsEvent(0); // SYSEVENT_AUTOSAVE
        ReleaseCredits();
    }
}

void CreateCreditsEx(void)
{
    SetupDisplayForCredits(CREDITS_DISPLAY_CREDITS_EX, FALSE);

    Task *task = TaskCreate(CreditsEx_Main_Init, CreditsEx_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(0), Credits);

    Credits *work = TaskGetWork(task, Credits);
    TaskInitWork16(work);

    work->assets.type = CREDITS_ASSET_CREDITS_EX;
    LoadCreditsArchives(&work->assets, work->assets.type);

    LoadSysSound(SYSSOUND_GROUP_STAFF);
}

void CreditsEx_Destructor(Task *task)
{
    Credits *work = TaskGetWork(task, Credits);

    ReleaseSysSound();
    ReleaseCreditsSprites(work);
    ReleaseCreditsArchives(&work->assets);
}

void CreditsEx_Main_Init(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    LoadCreditsBackgrounds(work, work->assets.type);
    InitCreditsSprites(work);
    InitCreditsWindowPlanes();

    work->scrollState = Credits__Scroll_Screen1;

    CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_FADE_TO_BLACK, FLOAT_TO_FX32(0.5));
    PlaySysTrack(SND_SYS_SEQ_SEQ_STAFF, TRUE);

    SetCurrentTaskMainEvent(CreditsEx_Main_FadeToBlack);
}

void CreditsEx_Main_FadeToBlack(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if (IsDrawFadeTaskFinished())
    {
        work->timer = 240;
        work->delay = 60;
        SetCurrentTaskMainEvent(CreditsEx_Main_SetupBlending);
    }
}

void CreditsEx_Main_SetupBlending(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if (work->delay != 0)
    {
        work->delay--;
    }
    else
    {
        MI_CpuClear16(&renderCoreGFXControlA.blendManager, sizeof(renderCoreGFXControlA.blendManager));
        renderCoreGFXControlA.blendManager.blendControl.effect     = BLENDTYPE_FADEOUT;
        renderCoreGFXControlA.blendManager.blendControl.plane1_BG0 = TRUE;
        renderCoreGFXControlA.blendManager.blendControl.plane1_BG1 = FALSE;
        renderCoreGFXControlA.blendManager.blendControl.plane1_BG2 = FALSE;
        renderCoreGFXControlA.blendManager.blendControl.plane1_BG3 = FALSE;
        renderCoreGFXControlA.blendManager.blendControl.plane1_OBJ = FALSE;

        SetCurrentTaskMainEvent(CreditsEx_Main_DimBackground);
    }
}

void CreditsEx_Main_DimBackground(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    RenderCoreGFXControl *gfxControl = &renderCoreGFXControlA;

    work->bgBrightness += FLOAT_TO_FX32(0.2);

    if (work->bgBrightness >= FLOAT_TO_FX32(6.0))
    {
        work->bgBrightness                         = FLOAT_TO_FX32(6.0);
        gfxControl->blendManager.coefficient.value = FX32_TO_WHOLE(work->bgBrightness);
        work->delay                                = 90;
        SetCurrentTaskMainEvent(CreditsEx_Main_DimDelay);
    }
    else
    {
        gfxControl->blendManager.coefficient.value = FX32_TO_WHOLE(work->bgBrightness);
    }
}

void CreditsEx_Main_DimDelay(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if (work->delay != 0)
    {
        work->delay--;
    }
    else
    {
        work->delay     = 30;
        work->fadeDelay = 60;
        SetCurrentTaskMainEvent(CreditsEx_Main_ScrollText);
    }
}

void CreditsEx_Main_ScrollText(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if (work->scrollState != NULL)
        work->scrollState(work);

    if ((work->flags & CREDITS_FLAG_TEXT_SCROLL_FINISHED) != 0 && (work->flags & CREDITS_FLAG_FADING_DONE) == 0)
    {
        if (work->delay != 0)
        {
            work->delay--;
        }
        else
        {
            RenderCoreGFXControl *gfxControl = &renderCoreGFXControlA;

            work->bgBrightness -= FLOAT_TO_FX32(0.2);

            if (work->bgBrightness > 0)
            {
                gfxControl->blendManager.coefficient.value = FX32_TO_WHOLE(work->bgBrightness);
            }
            else
            {
                work->bgBrightness                         = FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_DEFAULT);
                gfxControl->blendManager.coefficient.value = FX32_TO_WHOLE(work->bgBrightness);

                if (work->fadeDelay != 0)
                    work->fadeDelay--;
                else
                    work->flags |= CREDITS_FLAG_FADING_DONE;
            }
        }
    }

    if ((work->flags & CREDITS_FLAG_THANKS_FINISHED) != 0)
    {
        if (work->timer != 0)
        {
            work->timer--;
        }
        else
        {
            NNS_SndPlayerStopSeqAll(60);
            CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(0.5));
            SetCurrentTaskMainEvent(CreditsEx_Main_UndimBackground);
        }
    }
}

void CreditsEx_Main_UndimBackground(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if (work->scrollState != NULL)
        work->scrollState(work);

    if (IsDrawFadeTaskFinished())
    {
        DestroyDrawFadeTask();
        SetCurrentTaskMainEvent(CreditsEx_Main_InitExit);
    }
}

void CreditsEx_Main_InitExit(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    work->timer = 60;
    SetCurrentTaskMainEvent(CreditsEx_Main_Exit);
}

void CreditsEx_Main_Exit(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if (work->timer != 0)
    {
        work->timer--;
    }
    else
    {
        GoToNextCreditsEvent(1); // SYSEVENT_UPDATE_PROGRESS
        ReleaseCredits();
    }
}

void CreateFakeCredits(void)
{
    SetupDisplayForCredits(CREDITS_DISPLAY_FAKE_CREDITS, FALSE);

    Task *task = TaskCreate(FakeCredits_Main_Init, FakeCredits_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(0), Credits);

    Credits *work = TaskGetWork(task, Credits);
    TaskInitWork16(work);

    work->assets.type = CREDITS_ASSET_FAKE_CREDITS;
    LoadCreditsArchives(&work->assets, work->assets.type);
}

void FakeCredits_Destructor(Task *task)
{
    Credits *work = TaskGetWork(task, Credits);

    ReleaseCreditsSprites(work);
    ReleaseCreditsArchives(&work->assets);
}

void FakeCredits_Main_Init(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    LoadCreditsBackgrounds(work, work->assets.type);
    InitCreditsSprites(work);
    CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_FADE_TO_BLACK, FLOAT_TO_FX32(0.5));

    SetCurrentTaskMainEvent(FakeCredits_Main_FadeToBlack);
}

void FakeCredits_Main_FadeToBlack(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if (IsDrawFadeTaskFinished())
    {
        work->timer = SECONDS_TO_FRAMES(6.0);
        SetCurrentTaskMainEvent(FakeCredits_Main_ScrollText);
    }
}

void FakeCredits_Main_ScrollText(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if (work->timer != 0)
    {
        work->timer--;
    }
    else
    {
        CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(0.5));
        SetCurrentTaskMainEvent(FakeCredits_Main_UndimBackground);
    }
}

void FakeCredits_Main_UndimBackground(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if (IsDrawFadeTaskFinished())
    {
        DestroyDrawFadeTask();
        SetCurrentTaskMainEvent(FakeCredits_Main_InitExit);
    }
}

void FakeCredits_Main_InitExit(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    work->timer = 60;

    SetCurrentTaskMainEvent(FakeCredits_Main_Exit);
}

void FakeCredits_Main_Exit(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if (work->timer != 0)
    {
        work->timer--;
    }
    else
    {
        GoToNextCreditsEvent(0); // SYSEVENT_AUTOSAVE
        ReleaseCredits();
    }
}

void CreateExStageCreditsNotification(void)
{
    SetupDisplayForCredits(CREDITS_DISPLAY_CREDITS, TRUE);

    Task *task = TaskCreate(ExStageCreditsNotification_Main_Init, ExStageCreditsNotification_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(0),
                            Credits);

    Credits *work = TaskGetWork(task, Credits);
    TaskInitWork16(work);

    work->assets.type = CREDITS_ASSET_EXSTAGE_NOTIF;
    LoadCreditsArchives(&work->assets, work->assets.type);

    LoadSysSound(SYSSOUND_GROUP_STAFF);
}

void ExStageCreditsNotification_Destructor(Task *task)
{
    Credits *work = TaskGetWork(task, Credits);

    ReleaseSysSound();
    ReleaseCreditsArchives(&work->assets);
}

void ExStageCreditsNotification_Main_Init(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    CreateCreditsNotification(work, CREDITSNOTIF_DEEP_CORE_UNLOCK);

    SetCurrentTaskMainEvent(ExStageCreditsNotification_Main_ShowNotif);
}

void ExStageCreditsNotification_Main_ShowNotif(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if ((work->flags & CREDITS_FLAG_NOTIFICATION_FINISHED) != 0)
        SetCurrentTaskMainEvent(ExStageCreditsNotification_Main_InitExit);
}

void ExStageCreditsNotification_Main_InitExit(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    work->timer = 20;
    SetCurrentTaskMainEvent(ExStageCreditsNotification_Main_Exit);
}

void ExStageCreditsNotification_Main_Exit(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if (work->timer != 0)
    {
        work->timer--;
    }
    else
    {
        GoToNextCreditsEvent(2); // SYSEVENT_RETURN_TO_HUB
        ReleaseCredits();
    }
}

void CreatePostGameMissionCreditsNotification(void)
{
    SetupDisplayForCredits(CREDITS_DISPLAY_CREDITS, TRUE);

    Task *task = TaskCreate(PostGameMissionCreditsNotification_Main_Init, PostGameMissionCreditsNotification__Destructor, TASK_FLAG_NONE, 0,
                            TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(0), Credits);

    Credits *work = TaskGetWork(task, Credits);
    TaskInitWork16(work);

    work->assets.type = CREDITS_ASSET_MISSION_NOTIF;
    LoadCreditsArchives(&work->assets, work->assets.type);

    LoadSysSoundVillage();
}

void PostGameMissionCreditsNotification__Destructor(Task *task)
{
    Credits *work = TaskGetWork(task, Credits);

    ReleaseSysSound();
    ReleaseCreditsArchives(&work->assets);
}

void PostGameMissionCreditsNotification_Main_Init(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    CreateCreditsNotification(work, CREDITSNOTIF_MISSION_UNLOCK);
    PlaySysTrack(SND_SYS_SEQ_SEQ_J_ITEM, TRUE);

    SetCurrentTaskMainEvent(PostGameMissionCreditsNotification_Main_ShowNotif);
}

void PostGameMissionCreditsNotification_Main_ShowNotif(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if ((work->flags & CREDITS_FLAG_NOTIFICATION_FINISHED) != 0)
        SetCurrentTaskMainEvent(PostGameMissionCreditsNotification_Main_InitExit);
}

void PostGameMissionCreditsNotification_Main_InitExit(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    work->timer = 20;

    SetCurrentTaskMainEvent(PostGameMissionCreditsNotification_Main_Exit);
}

void PostGameMissionCreditsNotification_Main_Exit(void)
{
    Credits *work = TaskGetWorkCurrent(Credits);

    if (work->timer != 0)
    {
        work->timer--;
    }
    else
    {
        GoToNextCreditsEvent(2); // SYSEVENT_RETURN_TO_HUB
        ReleaseCredits();
    }
}

void CreateWandRoom(Credits *parent)
{
    Task *task = TaskCreate(WandRoom_Main_Init, WandRoom_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x3000, TASK_GROUP(1), WandRoom);

    WandRoom *work = TaskGetWork(task, WandRoom);
    TaskInitWork16(work);

    work->parent = parent;
    LoadWandRoomAssets(work);
}

void WandRoom_Destructor(Task *task)
{
    WandRoom *work = TaskGetWork(task, WandRoom);

    ReleaseWandRoomAssets(work);
}

void WandRoom_Main_Init(void)
{
    SetCurrentTaskMainEvent(WandRoom_Main_Idle);
}

void WandRoom_Main_Idle(void)
{
    WandRoom *work = TaskGetWorkCurrent(WandRoom);

    AnimatorMDL__ProcessAnimation(&work->aniWandroom);
    AnimatorMDL__Draw(&work->aniWandroom);

    if ((work->parent->flags & CREDITS_FLAG_SHOW_STINGER) != 0)
    {
        for (u32 i = 0; i < B3D_ANIM_MAX; i++)
        {
            if (((1 << i) & B3D_ANIM_FLAG_TEX_ANIM) != 0)
                work->aniWandroom.animFlags[i] &= ~ANIMATORMDL_FLAG_STOPPED;
        }

        SetCurrentTaskMainEvent(WandRoom_Main_ShowStinger);
    }
}

void WandRoom_Main_ShowStinger(void)
{
    WandRoom *work = TaskGetWorkCurrent(WandRoom);

    AnimatorMDL__ProcessAnimation(&work->aniWandroom);
    AnimatorMDL__Draw(&work->aniWandroom);
}

void CreateCreditsNotification(Credits *parent, CreditsNotificationType type)
{
    SetupDisplayForCredits(CREDITS_DISPLAY_CREDITS, TRUE);

    Task *task = TaskCreate(CreditsNotification_Main_InitWindowOpen, CreditsNotification_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x3000, TASK_GROUP(1),
                            CreditsNotification);

    CreditsNotification *work = TaskGetWork(task, CreditsNotification);
    TaskInitWork16(work);
    work->parent = parent;
    work->type   = type;

    void *sprNext = FileUnknown__GetAOUFile(parent->assets.tkdmArchive, ARCHIVE_TKDM_LZ7_FILE_FIX_NEXT_BAC);
    AnimatorSprite__Init(&work->aniContinueButton, sprNext, 0, ANIMATOR_FLAG_DISABLE_LOOPING, FALSE, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(FALSE, Sprite__GetSpriteSize2(sprNext)), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    work->aniContinueButton.cParam.palette = PALETTE_ROW_0;
    work->aniContinueButton.pos.x          = 224;
    work->aniContinueButton.pos.y          = 96;
}

void CreditsNotification_Destructor(Task *task)
{
    CreditsNotification *work = TaskGetWork(task, CreditsNotification);

    AnimatorSprite__Release(&work->aniContinueButton);
}

void CreditsNotification_Main_InitWindowOpen(void)
{
    CreditsNotification *work = TaskGetWorkCurrent(CreditsNotification);

    renderCoreGFXControlA.brightness = RENDERCORE_BRIGHTNESS_DEFAULT;

    InitCreditsNotificationWindow(work);
    InitCreditsNotificationWindowOpen(work);
    SetCurrentTaskMainEvent(CreditsNotification_Main_ProcessWindowOpen);
}

void CreditsNotification_Main_ProcessWindowOpen(void)
{
    CreditsNotification *work = TaskGetWorkCurrent(CreditsNotification);

    if (ProcessCreditsNotificationWindowAnimation(work))
    {
        SetCreditsNotificationWindowOpen(work);
        work->autoCloseTimer = 360;
        work->timer          = 60;
        SetCurrentTaskMainEvent(CreditsNotification_Main_ShowText);
    }
}

void CreditsNotification_Main_ShowText(void)
{
    CreditsNotification *work = TaskGetWorkCurrent(CreditsNotification);

    s32 state = work->buttonState;

    if (work->timer != 0)
    {
        work->timer--;
        state = 0;
    }
    else
    {
        if (state == 0)
        {
            state = 1;
        }
        else
        {
            if ((padInput.btnPress & PAD_BUTTON_A) != 0)
            {
                PlaySysMenuNavSfx(SYSSOUND_MENUNAV_DECIDE);
                state = 2;
            }

            if ((padInput.btnRelease & PAD_BUTTON_A) != 0 && work->buttonState == 2)
            {
                work->autoCloseTimer = 0;
                state                = 1;
            }
        }
    }

    SetCreditsNotificationWindowNextButtonState(work, state);

    if (work->autoCloseTimer != 0)
        work->autoCloseTimer--;
    else
        SetCurrentTaskMainEvent(CreditsNotification_Main_InitWindowClose);
}

void CreditsNotification_Main_InitWindowClose(void)
{
    CreditsNotification *work = TaskGetWorkCurrent(CreditsNotification);

    InitCreditsNotificationWindowClose(work);
    SetCurrentTaskMainEvent(CreditsNotification_Main_ProcessWindowClose);
}

void CreditsNotification_Main_ProcessWindowClose(void)
{
    CreditsNotification *work = TaskGetWorkCurrent(CreditsNotification);

    if (ProcessCreditsNotificationWindowAnimationAndClose(work))
        SetCurrentTaskMainEvent(CreditsNotification_Main_Exit);
}

void CreditsNotification_Main_Exit(void)
{
    CreditsNotification *work = TaskGetWorkCurrent(CreditsNotification);

    SetCreditsNotificationWindowOpen(work);
    ReleaseCreditsNotificationWindow(work);
    work->parent->flags |= CREDITS_FLAG_NOTIFICATION_FINISHED;

    DestroyCurrentTask();
}

void InitCreditsNotificationWindow(CreditsNotification *work)
{
    FontWindow__Init(&work->fontWindow);
    FontWindow__LoadFromMemory(&work->fontWindow, work->parent->assets.font, 1);
    FontWindowAnimator__Init(&work->fontWindowAnimator);
    FontWindowAnimator__Load1(&work->fontWindowAnimator, &work->fontWindow, 0, FONTWINDOWANIMATOR_ARC_WIN_SIMPLE, ARCHIVE_WIN_SIMPLE_LZ7_FILE_WIN_SIMPLE_C_BBG, PIXEL_TO_TILE(0),
                              PIXEL_TO_TILE(64), PIXEL_TO_TILE(HW_LCD_WIDTH), PIXEL_TO_TILE(64), GRAPHICS_ENGINE_A, BACKGROUND_2, PALETTE_ROW_1, 1, 0);
    FontAnimator__Init(&work->fontAnimator);
    FontAnimator__LoadFont1(&work->fontAnimator, &work->fontWindow, 0, PIXEL_TO_TILE(16), PIXEL_TO_TILE(80), PIXEL_TO_TILE(216), PIXEL_TO_TILE(32), GRAPHICS_ENGINE_A, BACKGROUND_3,
                            PALETTE_ROW_2, 1);

    FontAnimator__LoadMPCFile(&work->fontAnimator, FileUnknown__GetAOUFile(work->parent->assets.dmsrArchive, GetGameLanguage() + ARCHIVE_DMSR_LZ7_FILE_MSG_JPN_MPC));
    switch (work->type)
    {
        case CREDITSNOTIF_EMERALD_STINGER:
            FontAnimator__SetMsgSequence(&work->fontAnimator, CREDITS_MSGSEQ_COLLECT_ALL_EMERALDS);
            break;

        case CREDITSNOTIF_MISSION_UNLOCK:
            FontAnimator__SetMsgSequence(&work->fontAnimator, CREDITS_MSGSEQ_YOU_GOT_A_NEW_MISSION);
            break;

        case CREDITSNOTIF_DEEP_CORE_UNLOCK:
            FontAnimator__SetMsgSequence(&work->fontAnimator, CREDITS_MSGSEQ_YOU_CAN_NOW_PLAY_DEEP_CORE);
            break;
    }

    FontAnimator__SetDialog(&work->fontAnimator, 0);
    FontAnimator__InitStartPos(&work->fontAnimator, 1, 0);
    FontAnimator__LoadMappingsFunc(&work->fontAnimator);
    FontAnimator__LoadPaletteFunc(&work->fontAnimator);
}

void ReleaseCreditsNotificationWindow(CreditsNotification *work)
{
    FontAnimator__Release(&work->fontAnimator);
    FontWindowAnimator__Release(&work->fontWindowAnimator);
    FontWindow__Release(&work->fontWindow);
}

void InitCreditsNotificationWindowOpen(CreditsNotification *work)
{
    FontWindowAnimator__InitAnimation(&work->fontWindowAnimator, 1, 15, 10, 0);
    FontWindowAnimator__StartAnimating(&work->fontWindowAnimator);
}

BOOL ProcessCreditsNotificationWindowAnimation(CreditsNotification *work)
{
    FontWindowAnimator__ProcessWindowAnim(&work->fontWindowAnimator);
    FontWindowAnimator__Draw(&work->fontWindowAnimator);
    FontWindow__PrepareSwapBuffer(&work->fontWindow);

    return FontWindowAnimator__IsFinishedAnimating(&work->fontWindowAnimator) != FALSE;
}

BOOL ProcessCreditsNotificationWindowAnimationAndClose(CreditsNotification *work)
{
    FontWindowAnimator__ProcessWindowAnim(&work->fontWindowAnimator);
    FontWindowAnimator__Draw(&work->fontWindowAnimator);
    FontWindow__PrepareSwapBuffer(&work->fontWindow);

    if (!FontWindowAnimator__IsFinishedAnimating(&work->fontWindowAnimator))
        return FALSE;

    FontWindowAnimator__SetWindowClosed(&work->fontWindowAnimator);
    return TRUE;
}

void SetCreditsNotificationWindowOpen(CreditsNotification *work)
{
    FontWindowAnimator__SetWindowOpen(&work->fontWindowAnimator);
}

void InitCreditsNotificationWindowClose(CreditsNotification *work)
{
    FontAnimator__ClearPixels(&work->fontAnimator);
    FontAnimator__Draw(&work->fontAnimator);

    FontWindowAnimator__InitAnimation(&work->fontWindowAnimator, 4, 15, 0, 0);
    FontWindowAnimator__StartAnimating(&work->fontWindowAnimator);
}

void SetCreditsNotificationWindowNextButtonState(CreditsNotification *work, s32 state)
{
    FontWindowAnimator__Draw(&work->fontWindowAnimator);
    FontAnimator__LoadCharacters(&work->fontAnimator, 0);
    FontAnimator__Draw(&work->fontAnimator);
    FontWindow__PrepareSwapBuffer(&work->fontWindow);

    if (state != work->buttonState)
    {
        work->buttonState = state;
        switch (work->buttonState)
        {
            case 0:
                AnimatorSprite__SetAnimation(&work->aniContinueButton, 0);
                break;

            case 1:
                AnimatorSprite__SetAnimation(&work->aniContinueButton, 2);
                break;

            case 2:
                AnimatorSprite__SetAnimation(&work->aniContinueButton, 1);
                break;
        }
    }

    AnimatorSprite__ProcessAnimationFast(&work->aniContinueButton);
    AnimatorSprite__DrawFrame(&work->aniContinueButton);
}