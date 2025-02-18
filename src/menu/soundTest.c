#include <menu/soundTest.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/graphics/drawState.h>
#include <game/file/binaryBundle.h>
#include <game/file/fsRequest.h>
#include <game/file/fileUnknown.h>
#include <game/file/bundleFileUnknown.h>
#include <game/audio/sysSound.h>
#include <game/system/sysEvent.h>
#include <game/save/saveGame.h>
#include <game/text/fontAnimator.h>
#include <hub/dockCommon.h>

// resources
#include <resources/narc/dmsou_lz7.h>
#include <resources/bb/vi_npc.h>
#include <resources/narc/vi_bg_lz7.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void BackgroundUnknown__CopyPixels(void *pixels, s32 unitWidth, s32 pivotX, s32 pivotY, u16 xAdvance, u16 lineSize, void *pixels2, u16 pixelWidth, u16 x, u16 y,
                                                  s16 a11);

// --------------------
// ENUMS
// --------------------

enum SoundTestAnimID
{
    SOUNDTEST_ANI_PLAY_BTN_UP,
    SOUNDTEST_ANI_PLAY_BTN_DOWN,
    SOUNDTEST_ANI_STOP_BTN_UP,
    SOUNDTEST_ANI_STOP_BTN_DOWN,
    SOUNDTEST_ANI_RIGHT_BTN_UP,
    SOUNDTEST_ANI_RIGHT_BTN_DOWN,
    SOUNDTEST_ANI_LEFT_BTN_UP,
    SOUNDTEST_ANI_LEFT_BTN_DOWN,
    SOUNDTEST_ANI_BACK_BTN_UP,
    SOUNDTEST_ANI_BACK_BTN_DOWN,
    SOUNDTEST_ANI_TITLE_EDGE_R,
    SOUNDTEST_ANI_TITLE_EDGE_L,
    SOUNDTEST_ANI_TRACK_NUM_BG,
    SOUNDTEST_ANI_PENDULIM_BG,
    SOUNDTEST_ANI_PENDULIM_FG,
    SOUNDTEST_ANI_PENDULIM,
};

enum SoundTestLocAnimID
{
    SOUNDTEST_LOC_ANI_LABEL_PLAYING,
    SOUNDTEST_LOC_ANI_LABEL_STOPPED,
};

enum SoundTestKoalaAnimID
{
    SOUNDTEST_KOALA_ANI_PLAYING,
    SOUNDTEST_KOALA_ANI_IDLE,
};

enum SoundTestSpriteResource
{
    SOUNDTEST_SPRITE_RESOURCE_COMMON,
    SOUNDTEST_SPRITE_RESOURCE_LOCALIZED,
};

// --------------------
// STRUCTS
// --------------------

struct SoundTestAnimConfig
{
    u16 resource;
    u16 anim;
    u16 paletteRow;
    u8 priority;
    u8 order;
};

// --------------------
// VARIABLES
// --------------------

// force correct string order when compiling a matching func
#ifndef NON_MATCHING
static const char *aExtra  = "extra/";
static const char *aSndZ42 = "snd/z42/";
static const char *aSndZ22 = "snd/z22/";
static const char *aSndSb2 = "snd/sb2/";
static const char *aSndSb3 = "snd/sb3/";
static const char *aSndSb4 = "snd/sb4/";
static const char *aSndZ11 = "snd/z11/";
static const char *aSndZ12 = "snd/z12/";
static const char *aSndZ1b = "snd/z1b/";
static const char *aSndZ1t = "snd/z1t/";
static const char *aSndSb1 = "snd/sb1/";
static const char *aSndZ62 = "snd/z62/";
static const char *aSndZ2b = "snd/z2b/";
static const char *aSndZ31 = "snd/z31/";
static const char *aSndZ32 = "snd/z32/";
static const char *aSndZfb = "snd/zfb/";
static const char *aSndZ71 = "snd/z71/";
static const char *aSndZ41 = "snd/z41/";
static const char *aSndZ3b = "snd/z3b/";
static const char *aSndZ4b = "snd/z4b/";
static const char *aSndZ52 = "snd/z52/";
static const char *aSndZ5b = "snd/z5b/";
static const char *aSndZ21 = "snd/z21/";
static const char *aSndZ7b = "snd/z7b/";
static const char *aSndZ6b = "snd/z6b/";
static const char *aSndZ51 = "snd/z51/";
static const char *aSndZ72 = "snd/z72/";
static const char *aSndSys = "snd/sys/";
static const char *aSndZ61 = "snd/z61/";
static const char *aSndZ91 = "snd/z91/";
#endif

static const char *sndArcFolderTable[] = {
    "snd/sys/", "extra/",   "snd/sb1/", "snd/sb2/", "snd/sb3/", "snd/sb4/", "snd/z11/", "snd/z12/", "snd/z1b/", "snd/z1t/",
    "snd/z21/", "snd/z22/", "snd/z2b/", "snd/z31/", "snd/z32/", "snd/z3b/", "snd/z41/", "snd/z42/", "snd/z4b/", "snd/z51/",
    "snd/z52/", "snd/z5b/", "snd/z61/", "snd/z62/", "snd/z6b/", "snd/z71/", "snd/z72/", "snd/z7b/", "snd/z91/", "snd/zfb/",
};

NOT_DECOMPILED const u16 SoundTest__touchAreaTable[5];
NOT_DECOMPILED const u16 _02161912[24];
NOT_DECOMPILED const struct SoundTestAnimConfig _02161942[12];

/*
static const u16 SoundTest__touchAreaTable[5] = { 1, 2, 3, 4, 11 };

static const u16 _02161912[24] = { 5, 3, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 5 };

static const struct SoundTestAnimConfig _02161942[12] = {
    { .resource = SOUNDTEST_SPRITE_RESOURCE_COMMON, .anim = SOUNDTEST_ANI_TRACK_NUM_BG, .paletteRow = PALETTE_ROW_0, .priority = SPRITE_PRIORITY_3, .order = SPRITE_ORDER_0 },
    { .resource = SOUNDTEST_SPRITE_RESOURCE_COMMON, .anim = SOUNDTEST_ANI_PLAY_BTN_UP, .paletteRow = PALETTE_ROW_1, .priority = SPRITE_PRIORITY_0, .order = SPRITE_ORDER_0 },
    { .resource = SOUNDTEST_SPRITE_RESOURCE_COMMON, .anim = SOUNDTEST_ANI_STOP_BTN_UP, .paletteRow = PALETTE_ROW_2, .priority = SPRITE_PRIORITY_0, .order = SPRITE_ORDER_0 },
    { .resource = SOUNDTEST_SPRITE_RESOURCE_COMMON, .anim = SOUNDTEST_ANI_RIGHT_BTN_UP, .paletteRow = PALETTE_ROW_3, .priority = SPRITE_PRIORITY_0, .order = SPRITE_ORDER_0 },
    { .resource = SOUNDTEST_SPRITE_RESOURCE_COMMON, .anim = SOUNDTEST_ANI_LEFT_BTN_UP, .paletteRow = PALETTE_ROW_4, .priority = SPRITE_PRIORITY_0, .order = SPRITE_ORDER_0 },
    { .resource = SOUNDTEST_SPRITE_RESOURCE_COMMON, .anim = SOUNDTEST_ANI_TITLE_EDGE_R, .paletteRow = PALETTE_ROW_5, .priority = SPRITE_PRIORITY_0, .order = SPRITE_ORDER_0 },
    { .resource = SOUNDTEST_SPRITE_RESOURCE_COMMON, .anim = SOUNDTEST_ANI_TITLE_EDGE_L, .paletteRow = PALETTE_ROW_5, .priority = SPRITE_PRIORITY_0, .order = SPRITE_ORDER_0 },
    { .resource = SOUNDTEST_SPRITE_RESOURCE_COMMON, .anim = SOUNDTEST_ANI_PENDULIM_BG, .paletteRow = PALETTE_ROW_6, .priority = SPRITE_PRIORITY_3, .order = SPRITE_ORDER_8 },
    { .resource = SOUNDTEST_SPRITE_RESOURCE_COMMON, .anim = SOUNDTEST_ANI_PENDULIM_FG, .paletteRow = PALETTE_ROW_6, .priority = SPRITE_PRIORITY_0, .order = SPRITE_ORDER_0 },
    { .resource = SOUNDTEST_SPRITE_RESOURCE_COMMON, .anim = SOUNDTEST_ANI_PENDULIM, .paletteRow = PALETTE_ROW_7, .priority = SPRITE_PRIORITY_3, .order = SPRITE_ORDER_4 },
    { .resource = SOUNDTEST_SPRITE_RESOURCE_LOCALIZED, .anim = SOUNDTEST_LOC_ANI_LABEL_PLAYING, .paletteRow = PALETTE_ROW_8, .priority = SPRITE_PRIORITY_0, .order = SPRITE_ORDER_0
}, { .resource = SOUNDTEST_SPRITE_RESOURCE_COMMON, .anim = SOUNDTEST_ANI_BACK_BTN_UP, .paletteRow = PALETTE_ROW_9, .priority = SPRITE_PRIORITY_0, .order = SPRITE_ORDER_0 },
};

FORCE_INCLUDE_ARRAY(const u16, _21619A2, 32,
                    {
                        0, 0x2D8, 4, 0x1C71, 8, 0x1C, 0, 4, 0, 0x10, 0, 0x10, 0, 8, 0, 0x10, 0, 8, 0, 0x30, 0, 0x400, 0, 0x30, 0, 0, 0, 0x20, 0, 7, 0, 0x15,
                    })
*/

// --------------------
// FUNCTION DECLS
// --------------------

static void InitSoundTest(SoundTest *work);
static void SetupDisplayForSoundTest(SoundTest *work);
static void LoadSoundTestAssets(SoundTest *work);
static void SetupSoundTestAssets(SoundTest *work);
static void SetupSoundTestBackgrounds(SoundTest *work);
static void ReleaseSoundTest(SoundTest *work);
static void ReleaseSoundTestUnknown(SoundTest *work);
static void ReleaseSoundTestAssets(SoundTest *work);
static void ReleaseSoundTestModels(SoundTest *work);
static void ReleaseSoundTestSprites(SoundTest *work);
static void SoundTest_Main_Init(void);
static void SoundTest_Main_Active(void);
static void SoundTest_Destructor(Task *task);
static void DisableSoundTestDraw3D(SoundTest *work);
static void SetSoundTestKoalaAnim(SoundTest *work, s32 anim);
static void SoundTest_StateDraw3D_DrawStage(SoundTest *work);
static void InitSoundTestDrumBG(SoundTest *work);
static void DrawSoundTestDrumBG(SoundTest *work, u16 id, u16 a3, s16 a4);
static void SetSoundTestTrackNumber(SoundTest *work, s32 selection, BOOL instantChange);
static void AnimateSoundTestTrackNumber(SoundTest *work);
static BOOL CheckSoundTestDigitsIdle(SoundTest *work);
static void ProcessSoundTestAnimations(SoundTest *work, BOOL flag);
static void SoundTest_Draw(SoundTest *work);
static void SetSoundTestSelectedSongName(SoundTest *work);
static void InitSoundTestTouchAreas(SoundTest *work, BOOL disableInteractions);
static void ProcessSoundTestBtnRepeatTimers(SoundTest *work);
static BOOL CheckSoundTestRightBtnDown(SoundTest *work);
static BOOL CheckSoundTestLeftBtnDown(SoundTest *work);
static void SoundTest_State_FadeIn(SoundTest *work);
static void SoundTest_State_FadeOut(SoundTest *work);
static void SoundTest_State_TrackStopped(SoundTest *work);
static void SoundTest_State_TrackPlaying(SoundTest *work);
static void InitSoundTestAudio(SoundTest *work);
static void ReleaseSoundTestAudio(SoundTest *work);
static void PlaySoundTestSong(SoundTest *work, u16 trackID);
static BOOL CheckSoundTestIsPlayingTrack(SoundTest *work);
static void ReleaseSoundTestSoundPlayers(SoundTest *work, BOOL releasePlayers);
static BOOL CheckSoundTestSongStopped(SoundTest *work);
static void SoundTest_CaptureCallback(void *bufferL, void *bufferR, u32 len, NNSSndCaptureFormat format, void *arg);
static void ProcessSoundTestPendulumAngle(SoundTest *work);
static fx32 GetSoundTestPendulumAngle(SoundTest *work);
static void ApplySoundTestSongName(SoundTest *work, Unknown2056570 *unknown, const char *name, size_t nameLength, s16 flag);
static void SetSoundTestSpriteAnimation(AnimatorSprite *animator, void *sprFile, u16 anim, u8 oamPriority, u8 oamOrder, u16 paletteRow);
static BOOL CheckSoundTestTouchAreaHold(TouchArea *area);
static BOOL CheckSoundTestTouchAreaRelease(TouchArea *area);
static BOOL CheckSoundTestTouchAreaPress(TouchArea *area);
static u16 MoveSoundTestSelectionRight(SoundTest *work, u16 selection);
static u16 MoveSoundTestSelectionLeft(SoundTest *work, u16 selection);
static void DisableSoundTestSleepOnFold(void);
static void EnableSoundTestSleepOnFold(void);
static BOOL CheckSoundTestSongUnlocked(u8 flags);
static u16 GetSoundTestSongCount(SoundTestHeader *config);
static u8 GetSoundTestSongSndArcID(SoundTestHeader *config, u16 id);
static u8 CheckSoundTestSongIsStageArc(SoundTestHeader *config, u16 id);
static SoundTestSongType GetSoundTestSongType(SoundTestHeader *config, u16 id);
static u16 GetSoundTestSongGroup(SoundTestHeader *config, u16 id);
static u16 GetSoundTestSongSeqArcNo(SoundTestHeader *config, u16 id);
static u16 GetSoundTestSongSeqNo(SoundTestHeader *config, u16 id);
static u8 GetSoundTestSongUnlockFlags(SoundTestHeader *config, u16 id);
static const char *GetSoundTestSongTitle(SoundTestHeader *config, u16 id);
static u16 GetSoundTestSongTitleLength(SoundTestHeader *config, u16 id);
static SoundTestSound *GetSoundTestSong(SoundTestHeader *config, u16 id);

// --------------------
// FUNCTIONS
// --------------------

void CreateSoundTest(void)
{
    ResetTouchInput();

    TaskCreate(SoundTest_Main_Init, SoundTest_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 10, 10, SoundTest);
}

void InitSoundTest(SoundTest *work)
{
    TaskInitWork32(work);

    work->miProcessor = MI_GetMainMemoryPriority();
    MI_SetMainMemoryPriority(MI_PROCESSOR_ARM7);

    work->selection = 0;

    SetupDisplayForSoundTest(work);
    LoadSoundTestAssets(work);

    work->songCount      = GetSoundTestSongCount(work->soundTest);
    work->isSongUnlocked = HeapAllocHead(HEAP_SYSTEM, sizeof(BOOL) * work->songCount);
    MI_CpuClear32(work->isSongUnlocked, sizeof(BOOL) * work->songCount);

    FontFile__Init(&work->fontFile);
    FontFile__InitFromHeader(&work->fontFile, work->assets.fntIpl);

    SetupSoundTestAssets(work);
    SetupSoundTestBackgrounds(work);
    InitSoundTestAudio(work);

    for (s32 s = 0; s < work->songCount; s++)
    {
        if (CheckSoundTestSongUnlocked(GetSoundTestSongUnlockFlags(work->soundTest, s)))
            work->isSongUnlocked[s] = TRUE;
    }
}

void SetupDisplayForSoundTest(SoundTest *work)
{
    renderCoreGFXControlA.brightness = RENDERCORE_BRIGHTNESS_BLACK;
    renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_BLACK;
    GX_SetMasterBrightness(renderCoreGFXControlA.brightness);
    GXS_SetMasterBrightness(renderCoreGFXControlB.brightness);

    GX_SetPower(GX_POWER_ALL);
    GX_Power3D(TRUE);

    VRAMSystem__Reset();

    VRAMSystem__SetupTextureBank(GX_VRAM_TEX_0_A);
    VRAMSystem__SetupTexturePalBank(GX_VRAM_TEXPLTT_0_F);

    VRAMSystem__SetupBGBank(GX_VRAM_BG_128_B);
    VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_64_E, GX_OBJVRAMMODE_CHAR_1D_128K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x200);
    VRAMSystem__SetupBGExtPalBank(GX_VRAM_BGEXTPLTT_23_G);
    VRAMSystem__SetupOBJExtPalBank(GX_VRAM_OBJEXTPLTT_NONE);
    VRAMSystem__InitSpriteBuffer(GRAPHICS_ENGINE_A);

    VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_128_C);
    VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_128_D, GX_OBJVRAMMODE_CHAR_1D_128K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x400);
    VRAMSystem__SetupSubBGExtPalBank(GX_VRAM_SUB_BGEXTPLTT_0123_H);
    VRAMSystem__SetupSubOBJExtPalBank(GX_VRAM_SUB_OBJEXTPLTT_0_I);
    VRAMSystem__InitSpriteBuffer(GRAPHICS_ENGINE_B);

    GX_SetBGScrOffset(GX_BGSCROFFSET_0x00000);
    GX_SetBGCharOffset(GX_BGCHAROFFSET_0x00000);
    GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_0, GX_BG0_AS_3D);

    G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_01);
    G2_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0800, GX_BG_CHARBASE_0x08000);
    G2_SetBG3ControlText(GX_BG_SCRSIZE_TEXT_512x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x1000, GX_BG_CHARBASE_0x0c000);

    G2_SetBG2Priority(0);
    G2_SetBG1Priority(1);
    G2_SetBG0Priority(2);
    G2_SetBG3Priority(3);
    GX_SetVisiblePlane(GX_PLANEMASK_ALL & ~GX_PLANEMASK_OBJ);
    MI_CpuClearFast(VRAM_BG, 0x80000);

    GXS_SetGraphicsMode(GX_BGMODE_0);

    G2S_SetBG0Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_01);
    G2S_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0800, GX_BG_CHARBASE_0x08000, GX_BG_EXTPLTT_01);
    G2S_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x1000, GX_BG_CHARBASE_0x0c000);
    G2S_SetBG3ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x1800, GX_BG_CHARBASE_0x10000);

    MI_CpuClear32(&renderCoreGFXControlB.bgPosition, sizeof(renderCoreGFXControlB.bgPosition));

    G2S_SetBG3Priority(0);
    G2S_SetBG2Priority(1);
    G2S_SetBG1Priority(2);
    G2S_SetBG0Priority(3);
    GXS_SetVisiblePlane(GX_PLANEMASK_ALL);

    MI_CpuClearFast(VRAM_DB_BG, 0x20000);

    MI_CpuClear16(&renderCoreGFXControlA.bgPosition, sizeof(renderCoreGFXControlA.bgPosition));
    MI_CpuClear16(&renderCoreGFXControlB.bgPosition, sizeof(renderCoreGFXControlB.bgPosition));

    renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;

    RenderCore_DisableBlending(&renderCoreGFXControlA.blendManager);
    RenderCore_DisableBlending(&renderCoreGFXControlB.blendManager);

    renderCoreGFXControlA.windowManager.visible = GX_WNDMASK_NONE;
    renderCoreGFXControlB.windowManager.visible = GX_WNDMASK_NONE;
}

void LoadSoundTestAssets(SoundTest *work)
{
    work->archive = ArchiveFileUnknown__LoadFile("narc/dmsou_lz7.narc", FILEUNKNOWN_AUTO_ALLOC_HEAD);

    work->assets.sprUI             = FileUnknown__GetAOUFile(work->archive, ARCHIVE_DMSOU_LZ7_FILE_DMSOU_BAC);
    work->assets.sprUILoc          = FileUnknown__GetAOUFile(work->archive, GetGameLanguage() + ARCHIVE_DMSOU_LZ7_FILE_DMSOU_JPN_BAC);
    work->assets.bgBase            = FileUnknown__GetAOUFile(work->archive, ARCHIVE_DMSOU_LZ7_FILE_DMSOU_BASE_BBG);
    work->assets.bgDrumValue       = FileUnknown__GetAOUFile(work->archive, ARCHIVE_DMSOU_LZ7_FILE_DMSOU_DRUM_VALUE_BBG);
    work->assets.bgSpeaker         = FileUnknown__GetAOUFile(work->archive, ARCHIVE_DMSOU_LZ7_FILE_DMSOU_SPEAKER_BBG);
    work->assets.bgUpWaku          = FileUnknown__GetAOUFile(work->archive, ARCHIVE_DMSOU_LZ7_FILE_DMSOU_UP_WAKU_BBG);
    work->assets.aniSpeakerPalette = FileUnknown__GetAOUFile(work->archive, ARCHIVE_DMSOU_LZ7_FILE_DMSOU_SPEAKER_BPA);
    work->assets.jntAniKoala       = FileUnknown__GetAOUFile(work->archive, ARCHIVE_DMSOU_LZ7_FILE_DMSOU_KOALA_00_NSBCA);
    work->assets.mdlLog            = FileUnknown__GetAOUFile(work->archive, ARCHIVE_DMSOU_LZ7_FILE_DMSOU_LOG_NSBMD);
    work->assets.drawState         = FileUnknown__GetAOUFile(work->archive, ARCHIVE_DMSOU_LZ7_FILE_DMSOU_BSD);
    work->assets.mdlSea            = FileUnknown__GetAOUFile(work->archive, ARCHIVE_DMSOU_LZ7_FILE_DMSOU_SEA_NSBMD);
    work->assets.jntAniSea         = FileUnknown__GetAOUFile(work->archive, ARCHIVE_DMSOU_LZ7_FILE_DMSOU_SEA_NSBCA);
    work->soundTest                = BundleFileUnknown__LoadFile("st/sound_test_lz7.st", BUNDLEFILEUNKNOWN_AUTO_ALLOC_HEAD);
    work->assets.mdlKoala          = BundleFileUnknown__LoadFileFromBundle("bb/vi_npc.bb", BUNDLE_VI_NPC_FILE_RESOURCES_BB_VI_NPC_MUZY_NSBMD, BUNDLEFILEUNKNOWN_AUTO_ALLOC_HEAD);
    work->assets.bgSea             = ArchiveFileUnknown__LoadFileFromArchive("narc/vi_bg_lz7.narc", ARCHIVE_VI_BG_LZ7_FILE_VI_MAP_SEA_BBG, FILEUNKNOWN_AUTO_ALLOC_HEAD);
    work->assets.fntIpl            = FSRequestFileSync("fnt/font_ipl.fnt", FSREQ_AUTO_ALLOC_HEAD);
}

void SetupSoundTestAssets(SoundTest *work)
{
    Background background;
    InitBackground(&background, work->assets.bgUpWaku, BACKGROUND_FLAG_LOAD_ALL, GRAPHICS_ENGINE_A, BACKGROUND_1, BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
    DrawBackground(&background);

    InitBackground(&background, work->assets.bgSea, BACKGROUND_FLAG_LOAD_ALL, GRAPHICS_ENGINE_A, BACKGROUND_3, BG_DISPLAY_FULL_WIDTH * 2, BG_DISPLAY_SINGLE_HEIGHT_EX);
    DrawBackground(&background);

    work->koalaAnim = SOUNDTEST_KOALA_ANI_IDLE;
    AnimatorMDL__Init(&work->aniKoala, ANIMATOR_FLAG_NONE);
    NNS_G3dResDefaultSetup(work->assets.mdlKoala);
    AnimatorMDL__SetResource(&work->aniKoala, work->assets.mdlKoala, 0, FALSE, FALSE);
    AnimatorMDL__SetAnimation(&work->aniKoala, B3D_ANIM_JOINT_ANIM, work->assets.jntAniKoala, work->koalaAnim, NULL);
    for (u32 i = 0; i < B3D_ANIM_MAX; i++)
    {
        if (((1 << i) & B3D_ANIM_FLAG_JOINT_ANIM) != 0)
            work->aniKoala.animFlags[i] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    AnimatorMDL__Init(&work->aniLog, ANIMATOR_FLAG_NONE);
    NNS_G3dResDefaultSetup(work->assets.mdlLog);
    AnimatorMDL__SetResource(&work->aniLog, work->assets.mdlLog, 0, FALSE, FALSE);

    AnimatorMDL__Init(&work->aniSea, ANIMATOR_FLAG_NONE);
    NNS_G3dResDefaultSetup(work->assets.mdlSea);
    AnimatorMDL__SetResource(&work->aniSea, work->assets.mdlSea, 0, FALSE, FALSE);
    AnimatorMDL__SetAnimation(&work->aniSea, B3D_ANIM_JOINT_ANIM, work->assets.jntAniSea, 0, NULL);
    for (u32 i = 0; i < B3D_ANIM_MAX; i++)
    {
        if (((1 << i) & B3D_ANIM_FLAG_JOINT_ANIM) != 0)
            work->aniSea.animFlags[i] |= ANIMATORMDL_FLAG_CAN_LOOP;
    }

    work->activeTrackTextRenderer_data = HeapAllocHead(HEAP_USER, 2304);
    Unknown2056570__Init(&work->activeTrackTextRenderer, GRAPHICS_ENGINE_A, BACKGROUND_2, 0, 4, 20, 24, 3, work->activeTrackTextRenderer_data, 0, 32);
    Unknown2056570__Func_2056688(&work->activeTrackTextRenderer, 1);

    MI_CpuCopy16(FontAnimator__Palettes[1], &((GXRgb *)VRAM_BG_PLTT)[17], sizeof(FontAnimator__Palettes[1]));

    work->timer       = 0;
    work->stateDraw3D = SoundTest_StateDraw3D_DrawStage;
}

void SetupSoundTestBackgrounds(SoundTest *work)
{
    s32 i;
    Vec2Fx16 posShape2 = { 153, 127 };
    Vec2Fx16 posShape1 = { 103, 127 };
    u16 unknown[2]     = { 0x400, 0x000 };

    TouchRectUnknown touchRect;

#ifndef NON_MATCHING
    // dunno what this is, it's unreferenced and uncompiled but it's the only way I've gotten the static variables to match
    static u8 __UNKNOWN__[4];
#endif

    Background background;
    InitBackground(&background, work->assets.bgBase, BACKGROUND_FLAG_LOAD_ALL, GRAPHICS_ENGINE_B, BACKGROUND_0, BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
    DrawBackground(&background);

    InitBackground(&background, work->assets.bgSpeaker, BACKGROUND_FLAG_LOAD_ALL, GRAPHICS_ENGINE_B, BACKGROUND_2, BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
    DrawBackground(&background);

    InitSoundTestDrumBG(work);

    for (i = 0; i < 12; i++)
    {
        SetSoundTestSpriteAnimation(&work->animators[i], work->assets.uiSprites[_02161942[i].resource], _02161942[i].anim, _02161942[i].priority, _02161942[i].order,
                                    _02161942[i].paletteRow);
    }
    work->aniPendulum.pos.x = 128;
    work->aniPendulum.pos.y = 160;
    work->aniPendulum.flags |= ANIMATOR_FLAG_ENABLE_SCALE;

    work->targetPendulumDrawAngle = 0;

    InitPaletteAnimator(&work->aniPalette, work->assets.aniSpeakerPalette, 0, ANIMATORBPA_FLAG_CAN_LOOP, 0, &((GXRgb *)VRAM_DB_BG_PLTT)[32]);

    TouchField__Init(&work->touchField);
    for (i = 0; i < 5; i++)
    {
        if (SoundTest__touchAreaTable[i] == 1)
        {
            *(s32 *)&touchRect.box.left = FLOAT_TO_FX32(23.0); // TODO: document this better
            TouchField__InitAreaShape(&work->touchAreas[i], &posShape2, TouchField__PointInCircle, &touchRect, NULL, NULL);
        }
        else if (SoundTest__touchAreaTable[i] == 2)
        {
            *(s32 *)&touchRect.box.left = FLOAT_TO_FX32(23.0); // TODO: document this better
            TouchField__InitAreaShape(&work->touchAreas[i], &posShape1, TouchField__PointInCircle, &touchRect, NULL, NULL);
        }
        else
        {
            TouchField__InitAreaSprite(&work->touchAreas[i], &work->animators[SoundTest__touchAreaTable[i]], 0, 0x00, NULL, NULL);
        }

        TouchField__AddArea(&work->touchField, &work->touchAreas[i], TOUCHAREA_PRIORITY_FIRST);
    }

    work->selectedTrackTextRenderer_data = HeapAllocHead(HEAP_USER, 2304);
    Unknown2056570__Init(&work->selectedTrackTextRenderer, GRAPHICS_ENGINE_B, BACKGROUND_3, 0, 4, 0, 24, 3, work->selectedTrackTextRenderer_data, 0, 32);
    Unknown2056570__Func_2056688(&work->selectedTrackTextRenderer, 3);

    MI_CpuCopy16(FontAnimator__Palettes[1], &((GXRgb *)VRAM_DB_BG_PLTT)[49], sizeof(FontAnimator__Palettes[1]));

    SetSoundTestSelectedSongName(work);
    SetSoundTestTrackNumber(work, work->selection, 1);

    work->btnRightRepeatTimer = 24;
    work->btnLeftRepeatTimer  = 24;
    work->state               = SoundTest_State_FadeIn;
}

void ReleaseSoundTest(SoundTest *work)
{
    ReleaseSoundTestAudio(work);
    ReleaseSoundTestSprites(work);
    ReleaseSoundTestModels(work);
    FontFile__Release(&work->fontFile);
    ReleaseSoundTestAssets(work);
    ReleaseSoundTestUnknown(work);

    if (work->isSongUnlocked != NULL)
    {
        HeapFree(HEAP_SYSTEM, work->isSongUnlocked);
        work->isSongUnlocked = NULL;
    }

    if (work->miProcessor != MI_PROCESSOR_ARM7 && work->miProcessor != MI_PROCESSOR_ARM9)
        work->miProcessor = MI_PROCESSOR_ARM9;

    MI_SetMainMemoryPriority(work->miProcessor);

    EnableSoundTestSleepOnFold();
}

void ReleaseSoundTestUnknown(SoundTest *work)
{
    // do nothing
}

void ReleaseSoundTestAssets(SoundTest *work)
{
    if (work->archive != NULL)
    {
        HeapFree(HEAP_USER, work->archive);
        work->archive = NULL;
    }

    if (work->soundTest != NULL)
    {
        HeapFree(HEAP_USER, work->soundTest);
        work->soundTest = NULL;
    }

    if (work->assets.mdlKoala != NULL)
    {
        HeapFree(HEAP_USER, work->assets.mdlKoala);
    }

    if (work->assets.bgSea != NULL)
    {
        HeapFree(HEAP_USER, work->assets.bgSea);
    }

    if (work->assets.fntIpl != NULL)
    {
        HeapFree(HEAP_USER, work->assets.fntIpl);
    }

    MI_CpuClear32(&work->assets, sizeof(work->assets));
}

void ReleaseSoundTestModels(SoundTest *work)
{
    AnimatorMDL__Release(&work->aniKoala);
    MI_CpuClear16(&work->aniKoala, sizeof(work->aniKoala));
    NNS_G3dResDefaultRelease(work->assets.mdlKoala);

    AnimatorMDL__Release(&work->aniLog);
    MI_CpuClear16(&work->aniLog, sizeof(work->aniLog));
    NNS_G3dResDefaultRelease(work->assets.mdlLog);

    AnimatorMDL__Release(&work->aniSea);
    MI_CpuClear16(&work->aniSea, sizeof(work->aniSea));
    NNS_G3dResDefaultRelease(work->assets.mdlSea);

    Unknown2056570__Func_2056670(&work->activeTrackTextRenderer);

    if (work->activeTrackTextRenderer_data != NULL)
    {
        HeapFree(HEAP_USER, work->activeTrackTextRenderer_data);
        work->activeTrackTextRenderer_data = NULL;
    }
}

void ReleaseSoundTestSprites(SoundTest *work)
{
    ReleasePaletteAnimator(&work->aniPalette);

    for (s32 i = 0; i < 12; i++)
    {
        AnimatorSprite__Release(&work->animators[i]);
    }

    MI_CpuClear32(work->animators, sizeof(work->animators));

    if (work->drumPixels[0] != NULL)
    {
        HeapFree(HEAP_SYSTEM, work->drumPixels[0]);
        work->drumPixels[0] = NULL;
        work->drumPixels[1] = NULL;
        work->drumPixels[2] = NULL;
    }

    if (work->unknownPixels != NULL)
    {
        HeapFree(HEAP_SYSTEM, work->unknownPixels);
        work->unknownPixels = NULL;
    }

    Unknown2056570__Func_2056670(&work->selectedTrackTextRenderer);

    if (work->selectedTrackTextRenderer_data != NULL)
    {
        HeapFree(HEAP_USER, work->selectedTrackTextRenderer_data);
        work->selectedTrackTextRenderer_data = NULL;
    }
}

void SoundTest_Main_Init(void)
{
    SoundTest *work = TaskGetWorkCurrent(SoundTest);

    InitSoundTest(work);
    InitSoundTestTouchAreas(work, FALSE);

    SetCurrentTaskMainEvent(SoundTest_Main_Active);
}

void SoundTest_Main_Active(void)
{
    SoundTest *work = TaskGetWorkCurrent(SoundTest);

    if (work->stateDraw3D == NULL && work->state == NULL)
    {
        DestroyCurrentTask();
        gameState.talk.state.hubStartAction = HUB_STARTACTION_RESUME_HUB;
        RequestSysEventChange(0); // SYSEVENT_RETURN_TO_HUB
        NextSysEvent();
    }
    else
    {
        if (work->stateDraw3D != NULL)
            work->stateDraw3D(work);

        if (work->state != NULL)
            work->state(work);
    }

    renderCoreGFXControlB.brightness = renderCoreGFXControlA.brightness;
}

void SoundTest_Destructor(Task *task)
{
    SoundTest *work = TaskGetWork(task, SoundTest);

    ReleaseSoundTest(work);
}

void DisableSoundTestDraw3D(SoundTest *work)
{
    work->stateDraw3D = NULL;
}

void SetSoundTestKoalaAnim(SoundTest *work, s32 anim)
{
    if (work->koalaAnim != anim)
    {
        work->koalaAnim = anim;

        for (u32 i = 0; i < B3D_ANIM_MAX; i++)
        {
            if (((1 << i) & B3D_ANIM_FLAG_JOINT_ANIM) != 0)
                work->aniKoala.animFlags[i] |= ANIMATORMDL_FLAG_BLEND_ANIMATIONS;
        }

        work->aniKoala.ratio[B3D_ANIM_JOINT_ANIM] = FLOAT_TO_FX32(0.1);
        AnimatorMDL__SetAnimation(&work->aniKoala, B3D_ANIM_JOINT_ANIM, work->assets.jntAniKoala, work->koalaAnim, NULL);
    }
}

void SoundTest_StateDraw3D_DrawStage(SoundTest *work)
{
    NNS_G3dGlbSetViewPort(0, 0, HW_LCD_WIDTH - 1, HW_LCD_HEIGHT - 1);

    LoadDrawState(work->assets.drawState, DRAWSTATE_ALL);

    G3X_SetClearColor(GX_RGB_888(0x00, 0x00, 0x00), GX_COLOR_FROM_888(0x00), 0x7FFF, 0, FALSE);

    work->aniKoala.work.translation.x = FLOAT_TO_FX32(0.0);
    work->aniKoala.work.translation.y = FLOAT_TO_FX32(0.0);
    work->aniKoala.work.translation.z = FLOAT_TO_FX32(0.0);
    work->aniKoala.work.scale.x       = FLOAT_TO_FX32(1.0);
    work->aniKoala.work.scale.y       = FLOAT_TO_FX32(1.0);
    work->aniKoala.work.scale.z       = FLOAT_TO_FX32(1.0);
    MTX_Identity33(&work->aniKoala.work.matrix33);
    AnimatorMDL__ProcessAnimation(&work->aniKoala);
    AnimatorMDL__Draw(&work->aniKoala);

    work->aniLog.work.translation.x = FLOAT_TO_FX32(0.0);
    work->aniLog.work.translation.y = FLOAT_TO_FX32(0.0);
    work->aniLog.work.translation.z = FLOAT_TO_FX32(0.0);
    work->aniLog.work.scale.x       = FLOAT_TO_FX32(1.0);
    work->aniLog.work.scale.y       = FLOAT_TO_FX32(1.0);
    work->aniLog.work.scale.z       = FLOAT_TO_FX32(1.0);
    MTX_Identity33(&work->aniLog.work.matrix33);
    AnimatorMDL__ProcessAnimation(&work->aniLog);
    AnimatorMDL__Draw(&work->aniLog);

    work->aniSea.work.translation.x = FLOAT_TO_FX32(0.0);
    work->aniSea.work.translation.y = FLOAT_TO_FX32(0.0);
    work->aniSea.work.translation.z = FLOAT_TO_FX32(-30.0);
    work->aniSea.work.scale.x       = FLOAT_TO_FX32(1.0);
    work->aniSea.work.scale.y       = FLOAT_TO_FX32(1.0);
    work->aniSea.work.scale.z       = FLOAT_TO_FX32(1.0);
    MTX_Identity33(&work->aniSea.work.matrix33);
    AnimatorMDL__ProcessAnimation(&work->aniSea);
    AnimatorMDL__Draw(&work->aniSea);

    // sea parallax
    work->timer++;
    renderCoreGFXControlA.bgPosition[BACKGROUND_3].x = work->timer >> 6;
    renderCoreGFXControlA.bgPosition[BACKGROUND_3].y = 31;
}

NONMATCH_FUNC void InitSoundTestDrumBG(SoundTest *work)
{
    // https://decomp.me/scratch/IX4im -> 93.23%
#ifdef NON_MATCHING
    LoadUncompressedPalette(GetBackgroundPalette(work->assets.bgDrumValue)->data, 16, PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(&((GXRgb *)VRAM_DB_BG_PLTT)[16]));

    u16 *mappings = HeapAllocHead(HEAP_USER, BG_DISPLAY_FULL_WIDTH * BG_DISPLAY_SINGLE_HEIGHT * sizeof(GXScrFmtText));
    MI_CpuFill16(mappings, GX_SCRFMT_TEXT(1, 0, 0, 0x000), BG_DISPLAY_FULL_WIDTH * BG_DISPLAY_SINGLE_HEIGHT * sizeof(GXScrFmtText));

    u16 name = 1;
    s32 v6   = 13;
    for (s32 i = 0; i < 3; i++)
    {
        for (s32 x = 0; x < 3; x++)
        {
            for (s32 y = 0; y < 2; y++)
            {
                u32 v10 = (x + 9) << 5;
                u32 v9  = (y + v6);

                mappings[v10 + (v9 >> 1)] = GX_SCRFMT_TEXT(1, 0, 0, name);
                name++;
            }
        }

        v6 += 2;
    }
    DC_StoreRange(mappings, BG_DISPLAY_FULL_WIDTH * BG_DISPLAY_SINGLE_HEIGHT * sizeof(GXScrFmtText));
    Mappings__LoadUnknown(mappings, 0, 0, 32, FALSE, MAPPINGS_MODE_TEXT_256x256_B, 0, 1, 0, 0, BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
    HeapFree(HEAP_USER, mappings);

    work->unknownPixels = HeapAllocHead(HEAP_SYSTEM, 0x140);
    work->drumPixels[0] = HeapAllocHead(HEAP_SYSTEM, 0x240);
    work->drumPixels[1] = work->drumPixels[0] + HW_LCD_HEIGHT;
    work->drumPixels[2] = work->drumPixels[1] + HW_LCD_HEIGHT;

    DrawSoundTestDrumBG(work, 0, 0, 0);
    DrawSoundTestDrumBG(work, 1, 0, 0);
    DrawSoundTestDrumBG(work, 2, 0, 0);

    work->queueDrumPixels = TRUE;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x20
	mov r4, r0
	ldr r0, [r4, #0x14]
	bl GetBackgroundPalette
	ldr r3, =0x05000420
	add r0, r0, #4
	mov r1, #0x10
	mov r2, #0
	bl LoadUncompressedPalette
	mov r0, #0x600
	bl _AllocHeadHEAP_USER
	mov r5, r0
	mov r1, r5
	mov r0, #0x1000
	mov r2, #0x600
	bl MIi_CpuClear16
	mov r2, #0
	mov lr, #1
	mov r6, #0xd
	mov r0, r2
	mov r1, r2
_0215D71C:
	mov r3, r1
_0215D720:
	add r7, r3, #9
	mov r7, r7, lsl #0x10
	mov r7, r7, lsr #0xb
	mov ip, r0
	add r9, r5, r7, lsl #1
_0215D734:
	add r7, ip, r6
	mov r7, r7, lsl #0x10
	add r8, lr, #1
	add ip, ip, #1
	orr lr, lr, #0x1000
	mov r7, r7, lsr #0xf
	strh lr, [r7, r9]
	mov r7, r8, lsl #0x10
	cmp ip, #2
	mov lr, r7, lsr #0x10
	blt _0215D734
	add r3, r3, #1
	cmp r3, #3
	blt _0215D720
	add r2, r2, #1
	cmp r2, #3
	add r6, r6, #2
	blt _0215D71C
	mov r0, r5
	mov r1, #0x600
	bl DC_StoreRange
	mov r1, #0
	str r1, [sp]
	mov r0, #0xc
	stmib sp, {r0, r1}
	mov r0, #1
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r3, #0x20
	mov r0, r5
	mov r2, r1
	str r3, [sp, #0x18]
	mov r6, #0x18
	str r6, [sp, #0x1c]
	bl Mappings__LoadUnknown
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x140
	bl _AllocHeadHEAP_SYSTEM
	str r0, [r4, #0xb68]
	mov r0, #0x240
	bl _AllocHeadHEAP_SYSTEM
	mov r1, #0
	str r0, [r4, #0xb58]
	add r0, r0, #0xc0
	str r0, [r4, #0xb5c]
	add r0, r0, #0xc0
	str r0, [r4, #0xb60]
	mov r0, r4
	mov r2, r1
	mov r3, r1
	bl DrawSoundTestDrumBG
	mov r2, #0
	mov r0, r4
	mov r1, #1
	mov r3, r2
	bl DrawSoundTestDrumBG
	mov r2, #0
	mov r0, r4
	mov r1, #2
	mov r3, r2
	bl DrawSoundTestDrumBG
	mov r0, #1
	str r0, [r4, #0xb64]
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void DrawSoundTestDrumBG(SoundTest *work, u16 id, u16 a3, s16 a4)
{
    // TODO: decompile this
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x1c
	mov r4, r0
	ldr r0, [r4, #0x14]
	mov r5, r1
	mov r6, r2
	mov r7, r3
	bl GetBackgroundPixels
	mov r1, #0x12
	mul r2, r6, r1
	mov r6, #0x10
	smulbb r1, r7, r1
	rsb r2, r2, #0xb8
	sub r1, r2, r1, asr #12
	mov r3, r1, lsl #0x10
	str r6, [sp]
	mov r1, #0x28
	str r1, [sp, #4]
	ldr r2, [r4, #0xb68]
	mov r1, #2
	str r2, [sp, #8]
	str r1, [sp, #0xc]
	mov r2, #0
	str r2, [sp, #0x10]
	str r2, [sp, #0x14]
	add r0, r0, #4
	mov r3, r3, lsr #0x10
	str r2, [sp, #0x18]
	bl BackgroundUnknown__CopyPixels
	add r0, r4, r5, lsl #2
	mov lr, #0
	ldr r2, [r0, #0xb58]
	ldr r1, [r4, #0xb68]
	mov r0, lr
_0215D8CC:
	ldr r3, =_02161912
	mov r5, r0, lsl #1
	ldrh r9, [r3, r5]
	mov ip, #0
	mov r3, ip
	mov r8, ip
	cmp r9, #0
	ble _0215D924
_0215D8EC:
	and r5, lr, #7
	ldr r7, [r1, #0]
	ldr r6, [r1, #0x20]
	cmp r5, #7
	add r5, lr, #1
	add r1, r1, #4
	mov r5, r5, lsl #0x10
	add r8, r8, #1
	addeq r1, r1, #0x20
	orr r3, r3, r7
	orr ip, ip, r6
	cmp r8, r9
	mov lr, r5, lsr #0x10
	blt _0215D8EC
_0215D924:
	cmp r0, #0xc
	rsblt r9, r0, #0xb
	subge r9, r0, #0xc
	mov r8, #0
	mov r6, r8
	orr r5, r9, r9, lsl #4
	mov r7, #4
_0215D940:
	mov r10, r3, lsr r6
	and r10, r10, #0xff
	cmp r10, #0x10
	bhi _0215D970
	bhs _0215D97C
	cmp r10, #1
	bhi _0215D980
	cmp r10, #0
	beq _0215D980
	cmp r10, #1
	addeq r3, r3, r9, lsl r6
	b _0215D980
_0215D970:
	cmp r10, #0x11
	addeq r3, r3, r5, lsl r6
	b _0215D980
_0215D97C:
	add r3, r3, r9, lsl r7
_0215D980:
	mov r10, ip, lsr r6
	and r10, r10, #0xff
	cmp r10, #0x10
	bhi _0215D9B0
	bhs _0215D9BC
	cmp r10, #1
	bhi _0215D9C0
	cmp r10, #0
	beq _0215D9C0
	cmp r10, #1
	addeq ip, ip, r9, lsl r6
	b _0215D9C0
_0215D9B0:
	cmp r10, #0x11
	addeq ip, ip, r5, lsl r6
	b _0215D9C0
_0215D9BC:
	add ip, ip, r9, lsl r7
_0215D9C0:
	add r8, r8, #1
	cmp r8, #4
	add r6, r6, #8
	add r7, r7, #8
	blt _0215D940
	str r3, [r2]
	and r3, r0, #7
	str ip, [r2, #0x20]
	add r2, r2, #4
	cmp r3, #7
	add r0, r0, #1
	addeq r2, r2, #0x20
	cmp r0, #0x18
	blt _0215D8CC
	mov r0, #1
	str r0, [r4, #0xb64]
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SetSoundTestTrackNumber(SoundTest *work, s32 selection, BOOL instantChange)
{
    // https://decomp.me/scratch/o8dO6 -> 43.29%
#ifdef NON_MATCHING
    u16 digit1 = (selection + 1) / 100;
    u16 digit2 = ((selection + 1) - (digit1 * 100)) / 10;
    u16 digit3 = ((selection + 1) - (digit1 * 100) - (digit2 * 10));

    work->trackNumTarget[0] = digit1;
    work->trackNumTarget[1] = digit2;
    work->trackNumTarget[2] = digit3;

    if (instantChange)
    {
        work->trackNumPos[0] = FX32_FROM_WHOLE(work->trackNumTarget[0]);
        work->trackNumPos[1] = FX32_FROM_WHOLE(work->trackNumTarget[1]);
        work->trackNumPos[2] = FX32_FROM_WHOLE(work->trackNumTarget[2]);
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	add r1, r1, #1
	mov r3, r1, lsl #0x10
	mov r1, r3, lsr #0x10
	ldr r4, =0x51EB851F
	mov ip, r1, lsr #0x1f
	smull lr, r1, r4, r1
	add r1, ip, r1, asr #5
	mov r4, #0x64
	mul r4, r1, r4
	rsb r3, r4, r3, lsr #16
	mov r3, r3, lsl #0x10
	mov r6, r3, lsr #0x10
	add r5, r0, #0xb00
	ldr lr, =0x66666667
	mov r4, r6, lsr #0x1f
	smull ip, r6, lr, r6
	add r6, r4, r6, asr #2
	mov r4, #0xa
	strh r1, [r5, #0x6c]
	mul r4, r6, r4
	strh r6, [r5, #0x6e]
	rsb r1, r4, r3, lsr #16
	strh r1, [r5, #0x70]
	cmp r2, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldrh r1, [r5, #0x6c]
	mov r1, r1, lsl #0xc
	str r1, [r0, #0xb74]
	ldrh r1, [r5, #0x6e]
	mov r1, r1, lsl #0xc
	str r1, [r0, #0xb78]
	ldrh r1, [r5, #0x70]
	mov r1, r1, lsl #0xc
	str r1, [r0, #0xb7c]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void AnimateSoundTestTrackNumber(SoundTest *work)
{
    // https://decomp.me/scratch/JJ1Jd -> 89.07%
#ifdef NON_MATCHING
    for (s32 i = 0; i < 3; i++)
    {
        fx32 current = work->trackNumPos[i];
        fx32 target  = FX32_FROM_WHOLE(work->trackNumTarget[i]);
        if (current != target)
        {
            fx32 distance = MATH_ABS(current - target);
            if (distance <= FLOAT_TO_FX32(0.25))
            {
                work->trackNumPos[i] = target;
            }
            else
            {
                BOOL flag;
                if (current < target)
                    flag = distance >= FLOAT_TO_FX32(5.0);
                else
                    flag = distance < FLOAT_TO_FX32(5.0);

                if (flag)
                {
                    current -= FLOAT_TO_FX32(0.25);
                    if (current < FLOAT_TO_FX32(0.0))
                        current += FLOAT_TO_FX32(10.0);
                }
                else
                {
                    current += FLOAT_TO_FX32(0.25);
                    if (current >= FLOAT_TO_FX32(10.0))
                        current -= FLOAT_TO_FX32(10.0);
                }

                work->trackNumPos[i] = current;
            }
        }
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r1, #0
	mov r3, #1
	mov ip, r1
	mov lr, r1
	mov r4, r3
_0215DABC:
	add r2, r0, r1, lsl #1
	add r2, r2, #0xb00
	add r5, r0, r1, lsl #2
	ldrh r2, [r2, #0x6c]
	ldr r5, [r5, #0xb74]
	cmp r5, r2, lsl #12
	mov r6, r2, lsl #0xc
	beq _0215DB40
	subs r2, r5, r6
	rsbmi r2, r2, #0
	cmp r2, #0x400
	addle r2, r0, r1, lsl #2
	strle r6, [r2, #0xb74]
	ble _0215DB40
	cmp r5, r6
	bge _0215DB0C
	cmp r2, #0x5000
	movge r2, r4
	movlt r2, lr
	b _0215DB18
_0215DB0C:
	cmp r2, #0x5000
	movge r2, ip
	movlt r2, r3
_0215DB18:
	cmp r2, #0
	beq _0215DB2C
	subs r5, r5, #0x400
	addmi r5, r5, #0xa000
	b _0215DB38
_0215DB2C:
	add r5, r5, #0x400
	cmp r5, #0xa000
	subge r5, r5, #0xa000
_0215DB38:
	add r2, r0, r1, lsl #2
	str r5, [r2, #0xb74]
_0215DB40:
	add r1, r1, #1
	cmp r1, #3
	blt _0215DABC
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

BOOL CheckSoundTestDigitsIdle(SoundTest *work)
{
    for (s32 i = 0; i < 3; i++)
    {
        if (work->trackNumPos[i] != FX32_FROM_WHOLE(work->trackNumTarget[i]))
            return FALSE;
    }

    return TRUE;
}

void ProcessSoundTestAnimations(SoundTest *work, BOOL flag)
{
    u16 anim;

    {
        AnimatorSprite *aniPlayButton = &work->aniPlayButton;
        if (flag && ((padInput.btnDown & PAD_BUTTON_A) != 0 || CheckSoundTestTouchAreaHold(&work->touchAreaPlayButton)))
        {
            anim = SOUNDTEST_ANI_PLAY_BTN_DOWN;
        }
        else
        {
            anim = SOUNDTEST_ANI_PLAY_BTN_UP;
        }

        if (aniPlayButton->animID != anim)
            AnimatorSprite__SetAnimation(aniPlayButton, anim);
    }

    {
        AnimatorSprite *aniStopButton = &work->aniStopButton;
        if (flag && ((CheckSoundTestIsPlayingTrack(work) && (padInput.btnDown & PAD_BUTTON_B) != 0) || CheckSoundTestTouchAreaHold(&work->touchAreaStopButton)))
        {
            anim = SOUNDTEST_ANI_STOP_BTN_DOWN;
        }
        else
        {
            anim = SOUNDTEST_ANI_STOP_BTN_UP;
        }

        if (aniStopButton->animID != anim)
            AnimatorSprite__SetAnimation(aniStopButton, anim);
    }

    {
        AnimatorSprite *aniRightButton = &work->aniRightButton;
        if (flag && ((padInput.btnDown & PAD_KEY_RIGHT) != 0 || CheckSoundTestTouchAreaHold(&work->touchAreaRightButton)))
        {
            anim = SOUNDTEST_ANI_RIGHT_BTN_DOWN;
        }
        else
        {
            anim = SOUNDTEST_ANI_RIGHT_BTN_UP;
        }

        if (aniRightButton->animID != anim)
            AnimatorSprite__SetAnimation(aniRightButton, anim);
    }

    {
        AnimatorSprite *aniLeftButton = &work->aniLeftButton;
        if (flag && ((padInput.btnDown & PAD_KEY_LEFT) != 0 || CheckSoundTestTouchAreaHold(&work->touchAreaLeftButton)))
        {
            anim = SOUNDTEST_ANI_LEFT_BTN_DOWN;
        }
        else
        {
            anim = SOUNDTEST_ANI_LEFT_BTN_UP;
        }

        if (aniLeftButton->animID != anim)
            AnimatorSprite__SetAnimation(aniLeftButton, anim);
    }

    {
        AnimatorSprite *aniBackButton = &work->aniBackButton;
        if (flag && CheckSoundTestTouchAreaHold(&work->touchAreaBackButton))
        {
            anim = SOUNDTEST_ANI_BACK_BTN_DOWN;
        }
        else
        {
            anim = SOUNDTEST_ANI_BACK_BTN_UP;
        }

        if (aniBackButton->animID != anim)
            AnimatorSprite__SetAnimation(aniBackButton, anim);
    }

    {
        AnimatorSprite *aniControlsLabel = &work->aniControlsLabel;
        u16 anim                         = CheckSoundTestIsPlayingTrack(work) == 0 ? SOUNDTEST_LOC_ANI_LABEL_STOPPED : SOUNDTEST_LOC_ANI_LABEL_PLAYING;
        if (aniControlsLabel->animID != anim)
            AnimatorSprite__SetAnimation(aniControlsLabel, anim);
    }

    for (s32 i = 0; i < 12; i++)
    {
        AnimatorSprite__ProcessAnimationFast(&work->animators[i]);
    }

    AnimateSoundTestTrackNumber(work);
}

void SoundTest_Draw(SoundTest *work)
{
    AnimatorSprite__DrawFrame(&work->aniTrackNumDisplay);

    for (s32 i = 0; i < 3; i++)
    {
        DrawSoundTestDrumBG(work, i, work->trackNumPos[i] >> 12, work->trackNumPos[i] & 0xFFF);
    }

    if (work->queueDrumPixels)
    {
        DC_StoreRange(work->drumPixels[0], 0x240);
        QueueUncompressedPixels(work->drumPixels[0], 0x240, PIXEL_MODE_SPRITE, VRAM_DB_BG + 0x8020);
    }

    ProcessSoundTestPendulumAngle(work);
    work->targetPendulumDrawAngle = FX32_TO_WHOLE(0x16C1 * GetSoundTestPendulumAngle(work));
    AnimatorSprite__DrawFrame(&work->aniPlayButton);
    AnimatorSprite__DrawFrame(&work->aniStopButton);
    AnimatorSprite__DrawFrame(&work->aniRightButton);
    AnimatorSprite__DrawFrame(&work->aniLeftButton);
    AnimatorSprite__DrawFrame(&work->aniTitleEdgeL);
    AnimatorSprite__DrawFrame(&work->aniTitleEdgeR);
    AnimatorSprite__DrawFrame(&work->aniPendulumBG);
    AnimatorSprite__DrawFrame(&work->aniPendulumFG);
    AnimatorSprite__DrawFrameRotoZoom(&work->aniPendulum, FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0), (u16)(work->targetPendulumDrawAngle - FLOAT_DEG_TO_IDX(16.0)));
    AnimatorSprite__DrawFrame(&work->aniControlsLabel);
    AnimatorSprite__DrawFrame(&work->aniBackButton);
}

void SetSoundTestSelectedSongName(SoundTest *work)
{
    const char *title = GetSoundTestSongTitle(work->soundTest, work->selection);
    size_t length     = GetSoundTestSongTitleLength(work->soundTest, work->selection);

    ApplySoundTestSongName(work, &work->selectedTrackTextRenderer, title, length, 3);
    Unknown2056570__Func_2056B8C(&work->selectedTrackTextRenderer);
}

void InitSoundTestTouchAreas(SoundTest *work, BOOL disableInteractions)
{
    for (s32 i = 0; i < 5; i++)
    {
        TouchField__ResetArea(&work->touchAreas[i]);
    }

    if (disableInteractions)
    {
        for (s32 i = 0; i < 5; i++)
        {
            work->touchAreas[i].responseFlags |= TOUCHAREA_RESPONSE_DISABLED;
        }
    }
    else
    {
        for (s32 i = 0; i < 5; i++)
        {
            work->touchAreas[i].responseFlags &= ~TOUCHAREA_RESPONSE_DISABLED;
        }
    }
}

void ProcessSoundTestBtnRepeatTimers(SoundTest *work)
{
    if (((padInput.btnDown & PAD_KEY_RIGHT) != 0 || CheckSoundTestTouchAreaHold(&work->touchAreaRightButton)))
    {
        if (work->btnRightRepeatTimer != 0)
            work->btnRightRepeatTimer--;
    }
    else
    {
        work->btnRightRepeatTimer = 24;
    }

    if (((padInput.btnDown & PAD_KEY_LEFT) != 0 || CheckSoundTestTouchAreaHold(&work->touchAreaLeftButton)))
    {
        if (work->btnLeftRepeatTimer != 0)
            work->btnLeftRepeatTimer--;
    }
    else
    {
        work->btnLeftRepeatTimer = 24;
    }
}

BOOL CheckSoundTestRightBtnDown(SoundTest *work)
{
    if ((padInput.btnPress & PAD_KEY_RIGHT) != 0)
        return TRUE;

    if (CheckSoundTestTouchAreaPress(&work->touchAreaRightButton))
        return TRUE;

    return work->btnRightRepeatTimer == 0;
}

BOOL CheckSoundTestLeftBtnDown(SoundTest *work)
{
    if ((padInput.btnPress & PAD_KEY_LEFT) != 0)
        return TRUE;

    if (CheckSoundTestTouchAreaPress(&work->touchAreaLeftButton))
        return TRUE;

    return work->btnLeftRepeatTimer == 0;
}

void SoundTest_State_FadeIn(SoundTest *work)
{
    if (renderCoreGFXControlA.brightness > RENDERCORE_BRIGHTNESS_DEFAULT)
    {
        renderCoreGFXControlA.brightness--;
    }
    else if (renderCoreGFXControlA.brightness < RENDERCORE_BRIGHTNESS_DEFAULT)
    {
        renderCoreGFXControlA.brightness++;
    }
    else
    {
        InitSoundTestTouchAreas(work, FALSE);
        work->state = SoundTest_State_TrackStopped;
    }

    ProcessSoundTestAnimations(work, FALSE);
    SoundTest_Draw(work);
}

void SoundTest_State_FadeOut(SoundTest *work)
{
    if (renderCoreGFXControlA.brightness > RENDERCORE_BRIGHTNESS_BLACK)
    {
        renderCoreGFXControlA.brightness--;
    }
    else
    {
        DisableSoundTestDraw3D(work);
        work->state = NULL;
        return;
    }

    ProcessSoundTestAnimations(work, FALSE);
    SoundTest_Draw(work);
}

void SoundTest_State_TrackStopped(SoundTest *work)
{
    BOOL backPress        = FALSE;
    BOOL confirmPress     = FALSE;
    BOOL selectionChanged = FALSE;

    TouchField__Process(&work->touchField);
    ProcessSoundTestBtnRepeatTimers(work);

    if ((padInput.btnPress & PAD_BUTTON_B) != 0 || CheckSoundTestTouchAreaRelease(&work->touchAreaBackButton))
    {
        backPress = TRUE;
    }
    else if ((padInput.btnPress & PAD_BUTTON_A) != 0 || CheckSoundTestTouchAreaRelease(work->touchAreas))
    {
        confirmPress = TRUE;
    }
    else if (CheckSoundTestDigitsIdle(work) && CheckSoundTestRightBtnDown(work))
    {
        work->selection  = MoveSoundTestSelectionRight(work, work->selection);
        selectionChanged = TRUE;
    }
    else if (CheckSoundTestDigitsIdle(work) && CheckSoundTestLeftBtnDown(work))
    {
        work->selection  = MoveSoundTestSelectionLeft(work, work->selection);
        selectionChanged = TRUE;
    }

    work->targetPendulumAngle = 0;
    ProcessSoundTestAnimations(work, TRUE);
    SoundTest_Draw(work);

    if (backPress)
    {
        InitSoundTestTouchAreas(work, FALSE);
        work->state = SoundTest_State_FadeOut;
    }
    else if (confirmPress)
    {
        SetPaletteAnimation(&work->aniPalette, 0);
        SetSoundTestKoalaAnim(work, SOUNDTEST_KOALA_ANI_PLAYING);
        PlaySoundTestSong(work, work->selection);
        DisableSoundTestSleepOnFold();
        work->state = SoundTest_State_TrackPlaying;
    }
    else if (selectionChanged)
    {
        SetSoundTestTrackNumber(work, work->selection, 0);
        SetSoundTestSelectedSongName(work);
    }
}

void SoundTest_State_TrackPlaying(SoundTest *work)
{
    BOOL backPress        = FALSE;
    BOOL confirmPress     = FALSE;
    BOOL stopPress        = FALSE;
    BOOL selectionChanged = FALSE;

    TouchField__Process(&work->touchField);
    ProcessSoundTestBtnRepeatTimers(work);

    if (CheckSoundTestTouchAreaRelease(&work->touchAreaBackButton))
    {
        backPress = TRUE;
    }
    else if ((padInput.btnPress & PAD_BUTTON_A) != 0 || CheckSoundTestTouchAreaRelease(work->touchAreas))
    {
        confirmPress = TRUE;
    }
    else if ((padInput.btnPress & PAD_BUTTON_B) != 0 || CheckSoundTestTouchAreaRelease(&work->touchAreaStopButton) || !CheckSoundTestIsPlayingTrack(work))
    {
        stopPress = TRUE;
    }
    else if (CheckSoundTestDigitsIdle(work) && CheckSoundTestRightBtnDown(work))
    {
        work->selection  = MoveSoundTestSelectionRight(work, work->selection);
        selectionChanged = TRUE;
    }
    else if (CheckSoundTestDigitsIdle(work) && CheckSoundTestLeftBtnDown(work))
    {
        work->selection  = MoveSoundTestSelectionLeft(work, work->selection);
        selectionChanged = TRUE;
    }

    ProcessSoundTestAnimations(work, TRUE);
    SoundTest_Draw(work);

    if (!stopPress)
    {
        AnimatePalette(&work->aniPalette);
        DrawAnimatedPalette(&work->aniPalette);
    }

    if (backPress)
    {
        InitSoundTestTouchAreas(work, FALSE);
        ReleaseSoundTestSoundPlayers(work, FALSE);
        EnableSoundTestSleepOnFold();

        work->state = SoundTest_State_FadeOut;
    }
    else if (confirmPress)
    {
        PlaySoundTestSong(work, work->selection);
    }
    else if (stopPress)
    {
        LoadCompressedPalette(GetBackgroundPalette(work->assets.bgSpeaker), PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(&((GXRgb *)VRAM_DB_BG_PLTT)[32]));
        SetSoundTestKoalaAnim(work, SOUNDTEST_KOALA_ANI_IDLE);
        ReleaseSoundTestSoundPlayers(work, FALSE);
        EnableSoundTestSleepOnFold();
        work->state = SoundTest_State_TrackStopped;
    }
    else if (CheckSoundTestSongStopped(work))
    {
        LoadCompressedPalette(GetBackgroundPalette(work->assets.bgSpeaker), PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(&((GXRgb *)VRAM_DB_BG_PLTT)[32]));
        SetSoundTestKoalaAnim(work, SOUNDTEST_KOALA_ANI_IDLE);
        ReleaseSoundTestSoundPlayers(work, TRUE);
        EnableSoundTestSleepOnFold();
        work->state = SoundTest_State_TrackStopped;
    }
    else if (selectionChanged)
    {
        SetSoundTestTrackNumber(work, work->selection, 0);
        SetSoundTestSelectedSongName(work);
    }
}

void InitSoundTestAudio(SoundTest *work)
{
    work->curSongID           = -1;
    work->curSndArcID         = -1;
    work->curSndGroupID       = -1;
    work->isPlayingTrack      = FALSE;
    work->sndArcAsset         = 0;
    work->audioUnknown1       = 0;
    work->sndCaptureBuffer    = HeapAllocHead(HEAP_SYSTEM, 128);
    work->audioUnknown2       = 0;
    work->targetPendulumAngle = 0;
    work->pendulumAngle       = 0;
    MI_CpuClear32(work->volumeTracker, sizeof(work->volumeTracker));

    ReleaseAudioSystem();
    NNS_SndStrmHandleInit(&work->strmHandle);
}

void ReleaseSoundTestAudio(SoundTest *work)
{
    ReleaseSoundTestSoundPlayers(work, FALSE);

    if (work->sndCaptureBuffer != NULL)
    {
        HeapFree(HEAP_SYSTEM, work->sndCaptureBuffer);
        work->sndCaptureBuffer = NULL;
    }
}

void PlaySoundTestSong(SoundTest *work, u16 trackID)
{
    SoundTestHeader *config = work->soundTest;

    u8 sndArcID    = GetSoundTestSongSndArcID(config, trackID);
    u16 sndGroupID = GetSoundTestSongGroup(config, trackID);
    u16 seqArcNo   = GetSoundTestSongSeqArcNo(config, trackID);
    u16 id         = GetSoundTestSongSeqNo(config, trackID);

    if (sndArcID != work->curSndArcID || sndGroupID != work->curSndGroupID)
    {
        char sndArcName[32];
        ReleaseSoundTestSoundPlayers(work, 0);
        STD_CopyString(sndArcName, sndArcFolderTable[sndArcID]);
        STD_ConcatenateString(sndArcName, "sound_data.sdat");

        if (CheckSoundTestSongIsStageArc(config, trackID) == FALSE)
        {
            LoadAudioSndArc(sndArcName);
            NNS_SndArcLoadGroup(sndGroupID, audioManagerSndHeap);
        }
        else
        {
            work->sndArcAsset = FSRequestFileSync(sndArcName, FSREQ_AUTO_ALLOC_HEAD);
            InitAudioSystemForStage(work->sndArcAsset);
        }

        work->curSndArcID   = sndArcID;
        work->curSndGroupID = sndGroupID;
    }
    else
    {
        NNS_SndCaptureStopSampling();
        NNS_SndStopSoundAll();
    }

    switch (GetSoundTestSongType(config, trackID))
    {
        case SOUNDTESTSONG_TYPE_BGM:
            PlayTrack(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, id);
            break;

        case SOUNDTESTSONG_TYPE_SFX:
            PlaySfxEx(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, seqArcNo, id);
            break;

        case SOUNDTESTSONG_TYPE_VOICE_CLIP:
            PlayVoiceClipEx(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, seqArcNo, id);
            break;

        case SOUNDTESTSONG_TYPE_STREAM:
            NNS_SndArcStrmInit(10, audioManagerSndHeap);
            NNS_SndArcStrmStart(&work->strmHandle, id, 0);
            break;
    }

    NNS_SndCaptureStartSampling(work->sndCaptureBuffer, 128, NNS_SND_CAPTURE_FORMAT_PCM8, 8000, 2, SoundTest_CaptureCallback, work);

    if (trackID != work->curSongID)
    {
        ApplySoundTestSongName(work, &work->activeTrackTextRenderer, GetSoundTestSongTitle(config, trackID), GetSoundTestSongTitleLength(config, trackID), 1);
        Unknown2056570__Func_2056B8C(&work->activeTrackTextRenderer);
    }

    work->curSongID      = trackID;
    work->isPlayingTrack = TRUE;
}

BOOL CheckSoundTestIsPlayingTrack(SoundTest *work)
{
    return work->isPlayingTrack;
}

void ReleaseSoundTestSoundPlayers(SoundTest *work, BOOL releasePlayers)
{
    work->isPlayingTrack = FALSE;
    NNS_SndCaptureStopSampling();

    if (!releasePlayers)
    {
        NNS_SndStopSoundAll();

        if (work->strmHandle.player != NULL)
        {
            NNS_SndArcStrmStop(&work->strmHandle, 0);
            NNS_SndStrmHandleRelease(&work->strmHandle);
        }

        ReleaseAudioSystem();

        if (work->sndArcAsset != NULL)
        {
            HeapFree(HEAP_USER, work->sndArcAsset);
            work->sndArcAsset = NULL;
        }

        work->curSndArcID         = -1;
        work->curSndGroupID       = -1;
        work->audioUnknown2       = 0;
        work->targetPendulumAngle = 0;
        MI_CpuClear32(work->volumeTracker, sizeof(work->volumeTracker));
    }
}

BOOL CheckSoundTestSongStopped(SoundTest *work)
{
    if (work->curSongID >= GetSoundTestSongCount(work->soundTest))
        return TRUE;

    BOOL isValid;
    switch (GetSoundTestSongType(work->soundTest, work->curSongID))
    {
        case SOUNDTESTSONG_TYPE_BGM:
            isValid = defaultTrackPlayer.player != NULL;
            break;

        case SOUNDTESTSONG_TYPE_SFX:
            isValid = defaultSfxPlayer.player != NULL;
            break;

        case SOUNDTESTSONG_TYPE_VOICE_CLIP:
            isValid = defaultVoicePlayer.player != NULL;
            break;

        case SOUNDTESTSONG_TYPE_STREAM:
            isValid = work->strmHandle.player != NULL;
            break;
    }

    return !isValid;
}

void SoundTest_CaptureCallback(void *bufferL, void *bufferR, u32 len, NNSSndCaptureFormat format, void *arg)
{
    SoundTest *soundTest = (SoundTest *)arg;

    s32 volume;
    s32 i;

    s8 *bufferL_S8 = (s8 *)bufferL;
    s8 *bufferR_S8 = (s8 *)bufferR;

    volume = 0;
    for (i = 0; i < len; i++)
    {
        volume += MATH_ABS(bufferL_S8[i]);
        volume += MATH_ABS(bufferR_S8[i]);
    }

    soundTest->volumeTracker[3] = soundTest->volumeTracker[2];
    soundTest->volumeTracker[2] = soundTest->volumeTracker[1];
    soundTest->volumeTracker[1] = soundTest->volumeTracker[0];
    soundTest->volumeTracker[0] = volume;

    for (i = 0; i < 4; i++)
    {
        if (soundTest->volumeTracker[i] == 0)
        {
            volume = 0;
            break;
        }
    }

    soundTest->targetPendulumAngle = volume;
}

void ProcessSoundTestPendulumAngle(SoundTest *work)
{
    if (work->targetPendulumAngle > work->pendulumAngle)
    {
        if (work->targetPendulumAngle - work->pendulumAngle < 256)
        {
            work->pendulumAngle = work->targetPendulumAngle;
        }
        else
        {
            work->pendulumAngle += 256;
        }
    }
    else
    {
        if (work->pendulumAngle - work->targetPendulumAngle < 32)
        {
            work->pendulumAngle = work->targetPendulumAngle;
        }
        else
        {
            work->pendulumAngle -= 32;
        }
    }
}

fx32 GetSoundTestPendulumAngle(SoundTest *work)
{
    fx32 angle = FX_DivS32(FX32_FROM_WHOLE(work->pendulumAngle), FLOAT_TO_FX32(1.0));
    if (angle > FLOAT_TO_FX32(1.0))
        angle = FLOAT_TO_FX32(1.0);

    return angle;
}

void ApplySoundTestSongName(SoundTest *work, Unknown2056570 *unknown, const char *name, size_t nameLength, s16 flag)
{
    Unknown2056570__Func_205683C(unknown);

    if (nameLength != 0)
    {
        char *nameBuffer = HeapAllocHead(HEAP_DTCM, nameLength + 1);

        MI_CpuCopy8(name, nameBuffer, nameLength);
        nameBuffer[nameLength] = '\0';
        FontFile__Func_2053010(&work->fontFile, 0, 0, unknown, 96, flag, 0, 0, 8, 0, nameBuffer);

        HeapFree(HEAP_DTCM, nameBuffer);
    }
}

void SetSoundTestSpriteAnimation(AnimatorSprite *animator, void *sprFile, u16 anim, u8 oamPriority, u8 oamOrder, u16 paletteRow)
{
    AnimatorSprite__Init(animator, sprFile, anim, ANIMATOR_FLAG_NONE, GRAPHICS_ENGINE_B, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(GRAPHICS_ENGINE_B, Sprite__GetSpriteSize3FromAnim(sprFile, anim)), PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, oamPriority,
                         oamOrder);

    animator->cParam.palette = paletteRow;
}

BOOL CheckSoundTestTouchAreaHold(TouchArea *area)
{
    if ((area->responseFlags & TOUCHAREA_RESPONSE_CHECK_RECT2) == 0 && (area->responseFlags & TOUCHAREA_RESPONSE_IN_BOUNDS) != 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

BOOL CheckSoundTestTouchAreaRelease(TouchArea *area)
{
    return (area->responseFlags & TOUCHAREA_RESPONSE_40000) != 0;
}

BOOL CheckSoundTestTouchAreaPress(TouchArea *area)
{
    return (area->responseFlags & TOUCHAREA_RESPONSE_ENTERED_AREA_ALT) != 0;
}

u16 MoveSoundTestSelectionRight(SoundTest *work, u16 selection)
{
    s32 startSelection = selection;

    do
    {
        if (selection < work->songCount - 1)
            selection++;
        else
            selection = 0;
    } while (!work->isSongUnlocked[selection] && selection != startSelection);

    return selection;
}

u16 MoveSoundTestSelectionLeft(SoundTest *work, u16 selection)
{
    s32 startSelection = selection;

    do
    {
        if (selection > 0)
            selection--;
        else
            selection = work->songCount - 1;
    } while (!work->isSongUnlocked[selection] && selection != startSelection);

    return selection;
}

void DisableSoundTestSleepOnFold(void)
{
    RenderCore_SetNextFoldMode(FOLD_TOGGLE_POWER);
}

void EnableSoundTestSleepOnFold(void)
{
    RenderCore_SetNextFoldMode(FOLD_TOGGLE_SLEEP);
}

BOOL CheckSoundTestSongUnlocked(u8 flags)
{
    if (flags == 0xFF) // always unlocked
        return TRUE;

    if (flags == 0x80) // unlocked after deep core
        return SaveGame__GetGameProgress() >= SAVE_PROGRESS_39;

    return SaveGame__GetMissionStatus(flags) == MISSION_STATE_COMPLETED; // unlocked after mission
}

u16 GetSoundTestSongCount(SoundTestHeader *config)
{
    return config->songCount;
}

u8 GetSoundTestSongSndArcID(SoundTestHeader *config, u16 id)
{
    return GetSoundTestSong(config, id)->sndArcID;
}

u8 CheckSoundTestSongIsStageArc(SoundTestHeader *config, u16 id)
{
    return GetSoundTestSong(config, id)->isStageArc;
}

SoundTestSongType GetSoundTestSongType(SoundTestHeader *config, u16 id)
{
    return GetSoundTestSong(config, id)->type;
}

u16 GetSoundTestSongGroup(SoundTestHeader *config, u16 id)
{
    return GetSoundTestSong(config, id)->groupID;
}

u16 GetSoundTestSongSeqArcNo(SoundTestHeader *config, u16 id)
{
    return GetSoundTestSong(config, id)->seqArcNo;
}

u16 GetSoundTestSongSeqNo(SoundTestHeader *config, u16 id)
{
    return GetSoundTestSong(config, id)->seqID;
}

u8 GetSoundTestSongUnlockFlags(SoundTestHeader *config, u16 id)
{
    return GetSoundTestSong(config, id)->unlockFlags;
}

const char *GetSoundTestSongTitle(SoundTestHeader *config, u16 id)
{
    u8 *fileData = (u8 *)config;
    return &fileData[GetSoundTestSong(config, id)->titleOffset];
}

u16 GetSoundTestSongTitleLength(SoundTestHeader *config, u16 id)
{
    return GetSoundTestSong(config, id)->length;
}

SoundTestSound *GetSoundTestSong(SoundTestHeader *config, u16 id)
{
    return &config->sounds[id];
}
