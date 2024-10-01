#include <menu/emeraldCollectedScreen.h>
#include <menu/stageClearEx.h>
#include <game/system/sysEvent.h>
#include <game/audio/audioSystem.h>
#include <game/audio/sysSound.h>
#include <game/graphics/spriteUnknown.h>
#include <game/graphics/drawFadeTask.h>
#include <game/graphics/drawReqTask.h>
#include <game/graphics/drawState.h>
#include <game/graphics/background.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/save/saveGame.h>
#include <game/stage/gameSystem.h>
#include <game/file/archiveFile.h>
#include <game/file/fileUnknown.h>
#include <game/util/unknown204BE48.h>

// files
#include <resources/narc/emdm_lz7.h>
#include <resources/narc/act_com_b_lz7.h>

#include <nitro/code16.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void _ull_mul(void);

// --------------------
// ENUMS
// --------------------

enum AnimResources
{
    EMERALDCOLLECTED_RESOURCE_HUD,
    EMERALDCOLLECTED_RESOURCE_EMERALDS,
};

enum HUDAnimID
{
    EMERALDCOLLECTED_HUD_ANI_CHAOSEMERALD_CONTAINER,
    EMERALDCOLLECTED_HUD_ANI_CHAOSEMERALD_CONTAINER_ACTIVE,
    EMERALDCOLLECTED_HUD_ANI_SOLEMERALD_CONTAINER,
    EMERALDCOLLECTED_HUD_ANI_SOLEMERALD_CONTAINER_ACTIVE,
    EMERALDCOLLECTED_HUD_ANI_EMERALDJEWEL_1,
    EMERALDCOLLECTED_HUD_ANI_EMERALDJEWEL_2,
    EMERALDCOLLECTED_HUD_ANI_EMERALDJEWEL_3,
    EMERALDCOLLECTED_HUD_ANI_EMERALDJEWEL_4,
    EMERALDCOLLECTED_HUD_ANI_EMERALDJEWEL_5,
    EMERALDCOLLECTED_HUD_ANI_EMERALDJEWEL_6,
    EMERALDCOLLECTED_HUD_ANI_EMERALDJEWEL_7,
    EMERALDCOLLECTED_HUD_ANI_SPARKLE_1,
    EMERALDCOLLECTED_HUD_ANI_SPARKLE_2,
    EMERALDCOLLECTED_HUD_ANI_SPARKLE_3,
    EMERALDCOLLECTED_HUD_ANI_SPARKLE_4,
    EMERALDCOLLECTED_HUD_ANI_SPARKLE_5,
    EMERALDCOLLECTED_HUD_ANI_SPARKLE_6,
    EMERALDCOLLECTED_HUD_ANI_SPARKLE_7,
    EMERALDCOLLECTED_HUD_ANI_SPARKLE_8,
    EMERALDCOLLECTED_HUD_ANI_SPARKLE_9,
    EMERALDCOLLECTED_HUD_ANI_SPARKLE_10,
};

enum EmeraldAnimID
{
    EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_1,
    EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_2,
    EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_3,
    EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_4,
    EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_5,
    EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_6,
    EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_7,
    EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_1,
    EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_2,
    EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_3,
    EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_4,
    EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_5,
    EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_6,
    EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_7,
    EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_SHINE_1,
    EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_SHINE_2,
    EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_SHINE_3,
    EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_SHINE_4,
    EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_SHINE_5,
    EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_SHINE_6,
    EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_SHINE_7,
    EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_SHINE_1,
    EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_SHINE_2,
    EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_SHINE_3,
    EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_SHINE_4,
    EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_SHINE_5,
    EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_SHINE_6,
    EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_SHINE_7,
};

// --------------------
// STRUCTS
// --------------------

typedef struct EmeraldCollectedScreenAnimConfig_
{
    u16 resource;
    u16 animID;
    PixelMode pixelMode;
    Vec2Fx16 pos;
    u8 paletteRow;
    u8 oamPriority;
    u8 oamOrder;
} EmeraldCollectedScreenAnimConfig;

// --------------------
// VARIABLES
// --------------------

// TODO: split this into individual declarations
// 'sVars.unknown' is never referenced, and thus is being stripped from the final rom atm
static struct EmeraldCollectedScreenStaticVars
{
    void *unknown;
    void *singleton;
} sVars;

static const EmeraldCollectedScreenAnimConfig decorationConfig[7] = {
    { .resource    = EMERALDCOLLECTED_RESOURCE_HUD,
      .animID      = EMERALDCOLLECTED_HUD_ANI_EMERALDJEWEL_1,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 32, 64 },
      .paletteRow  = PALETTE_ROW_10,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_30 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_HUD,
      .animID      = EMERALDCOLLECTED_HUD_ANI_EMERALDJEWEL_2,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 64, 128 },
      .paletteRow  = PALETTE_ROW_10,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_30 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_HUD,
      .animID      = EMERALDCOLLECTED_HUD_ANI_EMERALDJEWEL_3,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 96, 64 },
      .paletteRow  = PALETTE_ROW_10,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_30 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_HUD,
      .animID      = EMERALDCOLLECTED_HUD_ANI_EMERALDJEWEL_4,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 128, 128 },
      .paletteRow  = PALETTE_ROW_10,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_30 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_HUD,
      .animID      = EMERALDCOLLECTED_HUD_ANI_EMERALDJEWEL_5,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 160, 64 },
      .paletteRow  = PALETTE_ROW_11,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_30 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_HUD,
      .animID      = EMERALDCOLLECTED_HUD_ANI_EMERALDJEWEL_6,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 192, 128 },
      .paletteRow  = PALETTE_ROW_11,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_30 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_HUD,
      .animID      = EMERALDCOLLECTED_HUD_ANI_EMERALDJEWEL_7,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 224, 64 },
      .paletteRow  = PALETTE_ROW_11,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_30 },
};

static const EmeraldCollectedScreenAnimConfig chaosEmeraldConfig[9] = {
    { .resource    = EMERALDCOLLECTED_RESOURCE_EMERALDS,
      .animID      = EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_1,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 16, 48 },
      .paletteRow  = PALETTE_ROW_1,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_15 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_EMERALDS,
      .animID      = EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_2,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 48, 112 },
      .paletteRow  = PALETTE_ROW_2,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_15 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_EMERALDS,
      .animID      = EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_3,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 80, 48 },
      .paletteRow  = PALETTE_ROW_3,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_15 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_EMERALDS,
      .animID      = EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_4,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 112, 112 },
      .paletteRow  = PALETTE_ROW_4,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_15 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_EMERALDS,
      .animID      = EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_5,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 144, 48 },
      .paletteRow  = PALETTE_ROW_5,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_15 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_EMERALDS,
      .animID      = EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_6,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 176, 112 },
      .paletteRow  = PALETTE_ROW_6,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_15 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_EMERALDS,
      .animID      = EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_7,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 208, 48 },
      .paletteRow  = PALETTE_ROW_7,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_15 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_HUD,
      .animID      = EMERALDCOLLECTED_HUD_ANI_CHAOSEMERALD_CONTAINER,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 0, 0 },
      .paletteRow  = PALETTE_ROW_8,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_31 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_HUD,
      .animID      = EMERALDCOLLECTED_HUD_ANI_CHAOSEMERALD_CONTAINER_ACTIVE,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 0, 0 },
      .paletteRow  = PALETTE_ROW_9,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_31 },
};

static const EmeraldCollectedScreenAnimConfig solEmeraldConfig[9] = {
    { .resource    = EMERALDCOLLECTED_RESOURCE_EMERALDS,
      .animID      = EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_1,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 16, 48 },
      .paletteRow  = PALETTE_ROW_1,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_15 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_EMERALDS,
      .animID      = EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_2,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 48, 112 },
      .paletteRow  = PALETTE_ROW_2,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_15 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_EMERALDS,
      .animID      = EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_3,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 80, 48 },
      .paletteRow  = PALETTE_ROW_3,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_15 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_EMERALDS,
      .animID      = EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_4,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 112, 112 },
      .paletteRow  = PALETTE_ROW_4,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_15 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_EMERALDS,
      .animID      = EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_5,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 144, 48 },
      .paletteRow  = PALETTE_ROW_5,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_15 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_EMERALDS,
      .animID      = EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_6,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 176, 112 },
      .paletteRow  = PALETTE_ROW_6,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_15 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_EMERALDS,
      .animID      = EMERALDCOLLECTED_EME_ANI_SOL_EMERALD_7,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 208, 48 },
      .paletteRow  = PALETTE_ROW_7,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_15 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_HUD,
      .animID      = EMERALDCOLLECTED_HUD_ANI_SOLEMERALD_CONTAINER,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 0, 0 },
      .paletteRow  = PALETTE_ROW_8,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_31 },

    { .resource    = EMERALDCOLLECTED_RESOURCE_HUD,
      .animID      = EMERALDCOLLECTED_HUD_ANI_SOLEMERALD_CONTAINER_ACTIVE,
      .pixelMode   = PIXEL_MODE_SPRITE,
      .pos         = { 0, 0 },
      .paletteRow  = PALETTE_ROW_9,
      .oamPriority = SPRITE_PRIORITY_2,
      .oamOrder    = SPRITE_ORDER_31 },
};

// --------------------
// FUNCTION DECLS
// --------------------

static void EmeraldCollectedScreen_Destructor(Task *task);
static void SetEmeraldCollectedScreenState(EmeraldCollectedScreen *work, void (*state)(EmeraldCollectedScreen *work));
static void SetupDisplayForEmeraldCollectedScreen(void);
static void InitEmeraldCollectedScreen(EmeraldCollectedScreen *work);
static void ReleaseEmeraldCollectedScreen(EmeraldCollectedScreen *work);
static void InitEmeraldCollectedScreenAssets(EmeraldCollectedScreenAssets *work);
static void ReleaseEmeraldCollectedScreenAssets(EmeraldCollectedScreenAssets *work);
static void InitEmeraldCollectedScreenGraphics(EmeraldCollectedScreenWorker *work, EmeraldCollectedScreenAssets *archives);
static void ReleaseEmeraldCollectedScreenGraphics(EmeraldCollectedScreenWorker *work);
static void HandleEmeraldCollectedScreenUpdating(EmeraldCollectedScreen *work);
static void HandleEmeraldCollectedScreenDrawing(EmeraldCollectedScreen *work);

// States
static void EmeraldCollectedScreen_State_Init(EmeraldCollectedScreen *work);
static void EmeraldCollectedScreen_State_FadeIn(EmeraldCollectedScreen *work);
static void EmeraldCollectedScreen_State_IntroDelay(EmeraldCollectedScreen *work);
static void EmeraldCollectedScreen_State_InitEnterEmerald(EmeraldCollectedScreen *work);
static void EmeraldCollectedScreen_State_EnterEmerald(EmeraldCollectedScreen *work);
static void EmeraldCollectedScreen_State_InitMoveEmeraldIntoPlace(EmeraldCollectedScreen *work);
static void EmeraldCollectedScreen_State_MoveEmeraldIntoPlace(EmeraldCollectedScreen *work);
static void EmeraldCollectedScreen_State_InitEmeraldInPlace(EmeraldCollectedScreen *work);
static void EmeraldCollectedScreen_State_EmeraldPlaceFlash(EmeraldCollectedScreen *work);
static void EmeraldCollectedScreen_State_EmeraldPlaceWait(EmeraldCollectedScreen *work);
static void EmeraldCollectedScreen_State_EmeraldSparkle(EmeraldCollectedScreen *work);
static void EmeraldCollectedScreen_State_EmeraldSparkleWait(EmeraldCollectedScreen *work);
static void EmeraldCollectedScreen_State_InitFadeOut(EmeraldCollectedScreen *work);
static void EmeraldCollectedScreen_State_FadeOut(EmeraldCollectedScreen *work);
static void EmeraldCollectedScreen_State_ChangeEvent(EmeraldCollectedScreen *work);

static s32 GetEmeraldCollectedScreenEmeraldAnimatorID(u32 id);
static BOOL IsEmeraldCollectedScreenUsingChaosEmeralds(void);
static void InitEmeraldCollectedScreenEmeraldConfig(EmeraldCollectedScreenWorker *work);
static void EmeraldCollectedScreen_RenderCallback(NNSG3dRS *rs);
static void InitEmeraldCollectedScreenSparkles(EmeraldCollectedScreenSparkles *work, void *spriteFile);
static void ReleaseEmeraldCollectedScreenSparkles(EmeraldCollectedScreenSparkles *work);
static void EnableSparklesForEmeraldCollectedScreen(EmeraldCollectedScreenSparkles *work);
static void DisableSparklesForEmeraldCollectedScreen(EmeraldCollectedScreenSparkles *work);
static void ProcessSparklesForEmeraldCollectedScreen(EmeraldCollectedScreenSparkles *work);
static void DrawSparklesForEmeraldCollectedScreen(EmeraldCollectedScreenSparkles *work);

static void EmeraldCollectedScreen_Main_Core(void);
static void EmeraldCollectedScreen_Main_UpdateManager(void);
static void EmeraldCollectedScreen_Main_DrawManager(void);

// --------------------
// FUNCTIONS
// --------------------

void CreateEmeraldCollectedScreen(void)
{
    sVars.singleton = TaskCreate(EmeraldCollectedScreen_Main_Core, EmeraldCollectedScreen_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x41, TASK_SCOPE_0,
                                 EmeraldCollectedScreen);

    EmeraldCollectedScreen *work = TaskGetWork(sVars.singleton, EmeraldCollectedScreen);
    InitEmeraldCollectedScreen(work);

    work->taskUpdateManager = TaskCreateNoWork(EmeraldCollectedScreen_Main_UpdateManager, NULL, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x21, TASK_SCOPE_0,
                                               "EmeraldCollectedScreenUpdateManager");
    work->taskDrawManager   = TaskCreateNoWork(EmeraldCollectedScreen_Main_DrawManager, NULL, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x81, TASK_SCOPE_0,
                                               "EmeraldCollectedScreenDrawManager");
}

void EmeraldCollectedScreen_Destructor(Task *task)
{
    sVars.singleton = NULL;
}

void SetEmeraldCollectedScreenState(EmeraldCollectedScreen *work, void (*state)(EmeraldCollectedScreen *work))
{
    work->timer = 0;
    work->state = state;
}

void SetupDisplayForEmeraldCollectedScreen(void)
{
    GX_SetVisiblePlane(GX_PLANEMASK_NONE);
    GXS_SetVisiblePlane(GX_PLANEMASK_NONE);

    GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_0, GX_BG0_AS_3D);
    GXS_SetGraphicsMode(GX_BGMODE_0);

    renderCurrentDisplay = GX_DISP_SELECT_SUB_MAIN;

    VRAMSystem__Reset();
    VRAMSystem__SetupTextureBank(GX_VRAM_TEX_0_D);
    VRAMSystem__SetupTexturePalBank(GX_VRAM_TEXPLTT_0_G);
    VRAMSystem__SetupBGBank(GX_VRAM_BG_128_A);
    VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_128_B, GX_OBJVRAMMODE_CHAR_1D_128K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x400);
    VRAMSystem__SetupBGExtPalBank(GX_VRAM_BGEXTPLTT_0123_E);
    VRAMSystem__SetupOBJExtPalBank(GX_VRAM_OBJEXTPLTT_0_F);
    VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_128_C);
    VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_16_I, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x200);
    VRAMSystem__SetupSubBGExtPalBank(GX_VRAM_SUB_BGEXTPLTT_0123_H);
    VRAMSystem__SetupSubOBJExtPalBank(GX_VRAM_SUB_OBJEXTPLTT_NONE);

    G2_SetBG0Priority(0);
    G2_SetBG1Priority(1);
    G2_SetBG2Priority(2);
    G2_SetBG3Priority(3);

    G2S_SetBG0Priority(0);
    G2S_SetBG1Priority(1);
    G2S_SetBG2Priority(2);
    G2S_SetBG3Priority(3);

    // clang-format off
    renderCoreGFXControlA.bgPosition[0].x = renderCoreGFXControlA.bgPosition[0].y = renderCoreGFXControlA.bgPosition[1].x = renderCoreGFXControlA.bgPosition[1].y =
    renderCoreGFXControlA.bgPosition[2].x = renderCoreGFXControlA.bgPosition[2].y = renderCoreGFXControlA.bgPosition[3].x = renderCoreGFXControlA.bgPosition[3].y =
    renderCoreGFXControlB.bgPosition[0].x = renderCoreGFXControlB.bgPosition[0].y = renderCoreGFXControlB.bgPosition[1].x = renderCoreGFXControlB.bgPosition[1].y =
    renderCoreGFXControlB.bgPosition[2].x = renderCoreGFXControlB.bgPosition[2].y = renderCoreGFXControlB.bgPosition[3].x = renderCoreGFXControlB.bgPosition[3].y = 0;
    // clang-format on

    G2_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x3800, GX_BG_CHARBASE_0x04000);
    G2_SetBG3ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x3000, GX_BG_CHARBASE_0x08000);

    G2S_SetBG3ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x3800, GX_BG_CHARBASE_0x04000);

    GX_SetVisiblePlane(GX_GetVisiblePlane() | GX_PLANEMASK_BG0 | GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3 | GX_PLANEMASK_OBJ);
    GXS_SetVisiblePlane(GXS_GetVisiblePlane() | GX_PLANEMASK_BG3 | GX_PLANEMASK_OBJ);
}

void InitEmeraldCollectedScreen(EmeraldCollectedScreen *work)
{
    TaskInitWork32(work);

    InitEmeraldCollectedScreenEmeraldConfig(&work->process);
    SetupDisplayForEmeraldCollectedScreen();

    EmeraldCollectedScreenAssets *assets = &work->assets;
    InitEmeraldCollectedScreenAssets(assets);

    ReleaseAudioSystem();
    work->seqPlayer = AllocSndHandle();
    LoadSysSound(SYSSOUND_GROUP_EMERALD);

    InitEmeraldCollectedScreenGraphics(&work->process, assets);
    ResetTouchInput();

    SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_Init);
}

void ReleaseEmeraldCollectedScreen(EmeraldCollectedScreen *work)
{
    ReleaseTouchInput();

    DestroyTask(work->taskUpdateManager);
    DestroyTask(work->taskDrawManager);

    ReleaseEmeraldCollectedScreenGraphics(&work->process);

    StopStageSfx(work->seqPlayer);
    NNS_SndHandleReleaseSeq(work->seqPlayer);
    ReleaseSysSound();

    ReleaseEmeraldCollectedScreenAssets(&work->assets);
    DestroyCurrentTask();
}

void InitEmeraldCollectedScreenAssets(EmeraldCollectedScreenAssets *work)
{
    work->archiveEmeraldCollected = ArchiveFile__Load("/narc/emdm_lz7.narc", ARCHIVEFILE_ID_NONE, ARCHIVEFILE_AUTO_ALLOC_HEAD_USER, ARCHIVEFILE_FLAG_IS_COMPRESSED, NULL);
    work->sprGoalJewelEffect = ArchiveFileUnknown__LoadFileFromArchive("/narc/act_com_b_lz7.narc", ARCHIVE_ACT_COM_B_LZ7_FILE_AC_EFF_GOAL_JEWEL_BAC, FILEUNKNOWN_AUTO_ALLOC_HEAD);
}

void ReleaseEmeraldCollectedScreenAssets(EmeraldCollectedScreenAssets *work)
{
    HeapFree(HEAP_USER, work->sprGoalJewelEffect);
    HeapFree(HEAP_USER, work->archiveEmeraldCollected);

    MI_CpuClear32(work, sizeof(*work));
}

NONMATCH_FUNC void InitEmeraldCollectedScreenGraphics(EmeraldCollectedScreenWorker *work, EmeraldCollectedScreenAssets *archives)
{
    // https://decomp.me/scratch/nTG0V -> 93.87%
#ifdef NON_MATCHING
    u32 i;
    void *sprHUD[2];
    void *bgUp;
    void *bgDown00;
    void *bgDown01;
    void *mdlEmerald;
    void *jntAniEmerald;
    void *matAniEmerald;
    void *drawState;

    LoadAssetsForStageClearEx(archives->archiveEmeraldCollected, sprHUD, ARCHIVE_EMDM_LZ7_FILE_EMDM_FIX_BAC, &sprHUD[1], ARCHIVE_EMDM_LZ7_FILE_EMDM_EME_BAC, &mdlEmerald,
                              ARCHIVE_EMDM_LZ7_FILE_EMDM_NSBMD, &jntAniEmerald, ARCHIVE_EMDM_LZ7_FILE_EMDM_NSBCA, &matAniEmerald, ARCHIVE_EMDM_LZ7_FILE_EMDM_NSBMA, &drawState,
                              ARCHIVE_EMDM_LZ7_FILE_EMDM_BSD, NULL);

    if (IsEmeraldCollectedScreenUsingChaosEmeralds())
    {
        LoadAssetsForStageClearEx(archives->archiveEmeraldCollected, &bgUp, ARCHIVE_EMDM_LZ7_FILE_EMDM_BASE_SON_UP_BBG, &bgDown00, ARCHIVE_EMDM_LZ7_FILE_EMDM_BASE_SON_DOWN00_BBG,
                                  &bgDown01, ARCHIVE_EMDM_LZ7_FILE_EMDM_BASE_SON_DOWN01_BBG, NULL);
    }
    else
    {
        LoadAssetsForStageClearEx(archives->archiveEmeraldCollected, &bgUp, ARCHIVE_EMDM_LZ7_FILE_EMDM_BASE_BLZ_UP_BBG, &bgDown00, ARCHIVE_EMDM_LZ7_FILE_EMDM_BASE_BLZ_DOWN00_BBG,
                                  &bgDown01, ARCHIVE_EMDM_LZ7_FILE_EMDM_BASE_BLZ_DOWN01_BBG, NULL);
    }

    Background background;
    InitBackground(&background, bgUp, BACKGROUND_FLAG_LOAD_PALETTE | BACKGROUND_FLAG_LOAD_PIXELS | BACKGROUND_FLAG_LOAD_MAPPINGS, TRUE, BACKGROUND_3, 32, 24);
    DrawBackground(&background);

    InitBackground(&background, bgDown00, BACKGROUND_FLAG_LOAD_PALETTE | BACKGROUND_FLAG_LOAD_PIXELS | BACKGROUND_FLAG_LOAD_MAPPINGS, FALSE, BACKGROUND_2, 32, 24);
    DrawBackground(&background);

    InitBackground(&background, bgDown01, BACKGROUND_FLAG_LOAD_PALETTE | BACKGROUND_FLAG_LOAD_PIXELS | BACKGROUND_FLAG_LOAD_MAPPINGS, FALSE, BACKGROUND_3, 32, 24);
    DrawBackground(&background);

    const EmeraldCollectedScreenAnimConfig *animConfig = decorationConfig;
    i                                                  = 0;
    AnimatorSprite *aniJewel                           = work->animators;
    for (; i < 7; i++)
    {
        void *spriteFile = sprHUD[animConfig->resource];

        SpriteUnknown__Func_204C90C(aniJewel, spriteFile, animConfig->animID, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK, animConfig->pixelMode,
                                    SpriteUnknown__Func_204C3CC(spriteFile, animConfig->pixelMode, animConfig->animID), animConfig->paletteRow, animConfig->oamPriority,
                                    animConfig->oamOrder);

        aniJewel->pos32 = *(u32 *)&animConfig->pos;
        AnimatorSprite__ProcessAnimationFast(aniJewel);

        aniJewel++;
        animConfig++;
    }

    const EmeraldCollectedScreenAnimConfig *emeraldConfig;
    if (IsEmeraldCollectedScreenUsingChaosEmeralds())
        emeraldConfig = chaosEmeraldConfig;
    else
        emeraldConfig = solEmeraldConfig;

    u32 e                      = 7;
    AnimatorSprite *aniEmerald = &work->animators[7];
    for (; e < 16; e++)
    {
        EmeraldCollectedScreenAnimConfig *config = &emeraldConfig[e - 7];
        void *spriteFile                         = sprHUD[config->resource];

        SpriteUnknown__Func_204C90C(aniEmerald, spriteFile, config->animID, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK, config->pixelMode,
                                    SpriteUnknown__Func_204C3CC(spriteFile, config->pixelMode, config->animID), config->paletteRow, config->oamPriority, config->oamOrder);
        aniEmerald->pos32 = *(u32 *)&config->pos;
        AnimatorSprite__ProcessAnimationFast(aniEmerald);

        aniEmerald++;
    }

    u32 id = 0;
    i      = 0;
    for (; i < 7; i++)
    {
        if (((1 << i) & work->emeraldFlags) == 0)
        {
            work->animators[id + 7].flags |= ANIMATOR_FLAG_DISABLE_DRAW;
        }

        id++;
    }

    LoadDrawState(drawState, DRAWSTATE_CLEARCOLOR | DRAWSTATE_DISPLAY1DOTDEPTH | DRAWSTATE_ANTIALIASING | DRAWSTATE_EDGECOLORTABLE | DRAWSTATE_EDGEMARKING | DRAWSTATE_FOGTABLE
                                 | DRAWSTATE_FOGCOLOR | DRAWSTATE_FOGOFFSET | DRAWSTATE_SWAPSORTMODE | DRAWSTATE_ALPHABLEND | DRAWSTATE_ALPHATEST | DRAWSTATE_TOONTABLE
                                 | DRAWSTATE_SHADING_STYLE | DRAWSTATE_SHININESS | DRAWSTATE_LIGHT3 | DRAWSTATE_LIGHT2 | DRAWSTATE_LIGHT1 | DRAWSTATE_LIGHT0
                                 | DRAWSTATE_SWAPBUFFERMODE | DRAWSTATE_PROJECTION | DRAWSTATE_LOOKAT);

    Camera3D camera;
    MI_CpuClear16(&camera, sizeof(camera));
    GetDrawStateCameraView(drawState, &camera);
    GetDrawStateCameraProjection(drawState, &camera);
    if (IsEmeraldCollectedScreenUsingChaosEmeralds())
        camera.config.matProjPosition.y = MultiplyFX(camera.config.projScaleW, -106);
    else
        camera.config.matProjPosition.y = MultiplyFX(camera.config.projScaleW, -213);
    camera.config.matProjPosition.x = 0;
    Camera3D__LoadState(&camera);

    work->mdlEmerald = mdlEmerald;
    NNS_G3dResDefaultSetup(work->mdlEmerald);

    AnimatorMDL *aniEmerald3D = &work->aniEmerald3D[0];
    AnimatorMDL__Init(aniEmerald3D, ANIMATOR_FLAG_NONE);

    s16 emeraldID = work->currentEmerald;
    if (IsEmeraldCollectedScreenUsingChaosEmeralds())
        AnimatorMDL__SetResource(aniEmerald3D, mdlEmerald, emeraldID, FALSE, FALSE);
    else
        AnimatorMDL__SetResource(aniEmerald3D, mdlEmerald, emeraldID + 7, FALSE, FALSE);
    aniEmerald3D->work.scale.z = FLOAT_TO_FX32(1.0);
    aniEmerald3D->work.scale.y = FLOAT_TO_FX32(1.0);
    aniEmerald3D->work.scale.x = FLOAT_TO_FX32(1.0);
    AnimatorMDL__SetAnimation(aniEmerald3D, B3D_ANIM_JOINT_ANIM, jntAniEmerald, 0, NULL);
    AnimatorMDL__SetAnimation(aniEmerald3D, B3D_ANIM_MAT_ANIM, matAniEmerald, emeraldID, NULL);
    aniEmerald3D->animFlags[0] |= ANIMATORMDL_FLAG_STOPPED;
    aniEmerald3D->animFlags[1] |= ANIMATORMDL_FLAG_STOPPED;
    aniEmerald3D->work.translation.x = FLOAT_TO_FX32(0.0);
    aniEmerald3D->work.translation.y = FLOAT_TO_FX32(0.0);
    aniEmerald3D->work.translation.z = FLOAT_TO_FX32(0.0);
    aniEmerald3D->work.flags |= ANIMATORMDL_FLAG_STOPPED;
    AnimatorMDL__ProcessAnimation(aniEmerald3D);
    aniEmerald3D->work.matrixOpIDs[0] = MATRIX_OP_FLUSH_VP;
    NNS_G3dRenderObjSetCallBack(&aniEmerald3D->renderObj, EmeraldCollectedScreen_RenderCallback, NULL, NNS_G3D_SBC_NODEDESC, NNS_G3D_SBC_CALLBACK_TIMING_C);

    InitEmeraldCollectedScreenSparkles(&work->sparkleManager, sprHUD[0]);
#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0xec
	str r0, [sp, #0x28]
	mov r0, #1
	str r0, [sp]
	add r0, sp, #0x44
	str r0, [sp, #4]
	mov r0, #8
	str r0, [sp, #8]
	add r0, sp, #0x48
	str r0, [sp, #0xc]
	mov r0, #9
	str r0, [sp, #0x10]
	add r0, sp, #0x4c
	str r0, [sp, #0x14]
	mov r0, #0xa
	str r0, [sp, #0x18]
	add r0, sp, #0x50
	str r0, [sp, #0x1c]
	mov r0, #0xb
	mov r4, r1
	str r0, [sp, #0x20]
	mov r2, #0
	str r2, [sp, #0x24]
	ldr r0, [r4, #0]
	add r1, sp, #0x30
	add r3, sp, #0x34
	bl LoadAssetsForStageClearEx
	bl IsEmeraldCollectedScreenUsingChaosEmeralds
	cmp r0, #0
	add r1, sp, #0x38
	beq _02155224
	mov r0, #3
	str r0, [sp]
	add r0, sp, #0x40
	str r0, [sp, #4]
	mov r0, #4
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	ldr r0, [r4, #0]
	mov r2, #2
	add r3, sp, #0x3c
	bl LoadAssetsForStageClearEx
	b _0215523E
_02155224:
	mov r0, #6
	str r0, [sp]
	add r0, sp, #0x40
	str r0, [sp, #4]
	mov r0, #7
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	ldr r0, [r4, #0]
	mov r2, #5
	add r3, sp, #0x3c
	bl LoadAssetsForStageClearEx
_0215523E:
	ldr r1, [sp, #0x38]
	mov r0, #3
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	add r0, sp, #0xa4
	mov r2, #0x38
	mov r3, #1
	bl InitBackground
	add r0, sp, #0xa4
	bl DrawBackground
	ldr r1, [sp, #0x3c]
	mov r0, #2
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	add r0, sp, #0xa4
	mov r2, #0x38
	mov r3, #0
	bl InitBackground
	add r0, sp, #0xa4
	bl DrawBackground
	mov r0, #3
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	ldr r1, [sp, #0x40]
	add r0, sp, #0xa4
	mov r2, #0x38
	mov r3, #0
	bl InitBackground
	add r0, sp, #0xa4
	bl DrawBackground
	ldr r4, [sp, #0x28]
	ldr r5, =decorationConfig
	mov r6, #0
	add r4, #8
_021552A0:
	ldrh r0, [r5, #0]
	ldrh r2, [r5, #2]
	lsl r1, r0, #2
	add r0, sp, #0x30
	ldr r7, [r0, r1]
	ldr r1, [r5, #4]
	mov r0, r7
	bl SpriteUnknown__Func_204C3CC
	ldr r1, [r5, #4]
	mov r3, #2
	str r1, [sp]
	str r0, [sp, #4]
	ldrb r0, [r5, #0xc]
	mov r1, r7
	lsl r3, r3, #0xa
	str r0, [sp, #8]
	ldrb r0, [r5, #0xd]
	str r0, [sp, #0xc]
	ldrb r0, [r5, #0xe]
	str r0, [sp, #0x10]
	ldrh r2, [r5, #2]
	mov r0, r4
	bl SpriteUnknown__Func_204C90C
	ldr r0, [r5, #8]
	mov r1, #0
	str r0, [r4, #8]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r6, r6, #1
	add r4, #0x64
	add r5, #0x10
	cmp r6, #7
	blo _021552A0
	bl IsEmeraldCollectedScreenUsingChaosEmeralds
	cmp r0, #0
	beq _021552F8
	ldr r0, =chaosEmeraldConfig
	str r0, [sp, #0x2c]
	b _021552FC
_021552F8:
	ldr r0, =solEmeraldConfig
	str r0, [sp, #0x2c]
_021552FC:
	mov r1, #0xb1
	ldr r0, [sp, #0x28]
	lsl r1, r1, #2
	mov r6, #7
	add r5, r0, r1
_02155306:
	sub r0, r6, #7
	lsl r1, r0, #4
	ldr r0, [sp, #0x2c]
	add r4, r0, r1
	ldrh r0, [r0, r1]
	ldrh r2, [r4, #2]
	lsl r1, r0, #2
	add r0, sp, #0x30
	ldr r7, [r0, r1]
	ldr r1, [r4, #4]
	mov r0, r7
	bl SpriteUnknown__Func_204C3CC
	ldr r1, [r4, #4]
	mov r3, #2
	str r1, [sp]
	str r0, [sp, #4]
	ldrb r0, [r4, #0xc]
	mov r1, r7
	lsl r3, r3, #0xa
	str r0, [sp, #8]
	ldrb r0, [r4, #0xd]
	str r0, [sp, #0xc]
	ldrb r0, [r4, #0xe]
	str r0, [sp, #0x10]
	ldrh r2, [r4, #2]
	mov r0, r5
	bl SpriteUnknown__Func_204C90C
	ldr r0, [r4, #8]
	mov r1, #0
	str r0, [r5, #8]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r6, r6, #1
	add r5, #0x64
	cmp r6, #0x10
	blo _02155306
	ldr r1, [sp, #0x28]
	mov r5, #0
	mov r3, #1
	mov r7, #0xaf
	mov r4, r5
	add r1, #8
	lsl r7, r7, #2
	mov r0, r3
_02155366:
	ldr r6, [sp, #0x28]
	mov r2, r3
	ldrh r6, [r6, #4]
	lsl r2, r5
	tst r2, r6
	bne _0215537C
	add r2, r4, r7
	add r2, r1, r2
	ldr r6, [r2, #0x3c]
	orr r6, r0
	str r6, [r2, #0x3c]
_0215537C:
	add r5, r5, #1
	add r4, #0x64
	cmp r5, #7
	blo _02155366
	ldr r0, [sp, #0x50]
	ldr r1, =0x001FFFFF
	bl LoadDrawState
	mov r0, #0
	add r1, sp, #0x54
	mov r2, #0x50
	bl MIi_CpuClear16
	ldr r0, [sp, #0x50]
	add r1, sp, #0x54
	bl GetDrawStateCameraView
	ldr r0, [sp, #0x50]
	add r1, sp, #0x54
	bl GetDrawStateCameraProjection
	bl IsEmeraldCollectedScreenUsingChaosEmeralds
	cmp r0, #0
	beq _021553D2
	mov r2, #0x69
	ldr r0, [sp, #0x64]
	mvn r2, r2
	mov r3, r2
	asr r1, r0, #0x1f
	add r3, #0x69
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	str r1, [sp, #0x6c]
	b _021553F4
_021553D2:
	mov r2, #0xd4
	ldr r0, [sp, #0x64]
	mvn r2, r2
	mov r3, r2
	asr r1, r0, #0x1f
	add r3, #0xd4
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	str r1, [sp, #0x6c]
_021553F4:
	mov r0, #0
	str r0, [sp, #0x68]
	add r0, sp, #0x54
	bl Camera3D__LoadState
	ldr r2, [sp, #0x44]
	ldr r1, =0x0000078C
	ldr r0, [sp, #0x28]
	str r2, [r0, r1]
	ldr r0, [r0, r1]
	bl NNS_G3dResDefaultSetup
	ldr r1, =0x00000648
	ldr r0, [sp, #0x28]
	add r4, r0, r1
	mov r0, r4
	mov r1, #0
	bl AnimatorMDL__Init
	ldr r0, [sp, #0x28]
	mov r1, #6
	ldrsh r5, [r0, r1]
	bl IsEmeraldCollectedScreenUsingChaosEmeralds
	cmp r0, #0
	beq _02155438
	mov r3, #0
	str r3, [sp]
	ldr r1, [sp, #0x44]
	mov r0, r4
	mov r2, r5
	bl AnimatorMDL__SetResource
	b _02155446
_02155438:
	mov r3, #0
	str r3, [sp]
	ldr r1, [sp, #0x44]
	mov r0, r4
	add r2, r5, #7
	bl AnimatorMDL__SetResource
_02155446:
	mov r0, #1
	lsl r0, r0, #0xc
	str r0, [r4, #0x20]
	str r0, [r4, #0x1c]
	str r0, [r4, #0x18]
	mov r1, #0
	str r1, [sp]
	ldr r2, [sp, #0x48]
	mov r0, r4
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	mov r0, #0
	str r0, [sp]
	ldr r2, [sp, #0x4c]
	mov r0, r4
	mov r1, #1
	mov r3, r5
	bl AnimatorMDL__SetAnimation
	mov r0, #0x43
	lsl r0, r0, #2
	ldrh r1, [r4, r0]
	mov r2, #1
	orr r1, r2
	strh r1, [r4, r0]
	add r1, r0, #2
	ldrh r1, [r4, r1]
	add r0, r0, #2
	orr r1, r2
	strh r1, [r4, r0]
	mov r0, #0
	str r0, [r4, #0x48]
	str r0, [r4, #0x4c]
	str r0, [r4, #0x50]
	ldr r0, [r4, #4]
	orr r0, r2
	str r0, [r4, #4]
	mov r0, r4
	bl AnimatorMDL__ProcessAnimation
	mov r0, #4
	strb r0, [r4, #0xa]
	mov r0, #3
	add r4, #0x90
	str r0, [sp]
	ldr r1, =EmeraldCollectedScreen_RenderCallback
	mov r0, r4
	mov r2, #0
	mov r3, #6
	bl NNS_G3dRenderObjSetCallBack
	ldr r1, =0x000007A8
	ldr r0, [sp, #0x28]
	add r0, r0, r1
	ldr r1, [sp, #0x30]
	bl InitEmeraldCollectedScreenSparkles
	add sp, #0xec
	pop {r4, r5, r6, r7, pc}
	nop

// clang-format on
#endif
}

NONMATCH_FUNC void ReleaseEmeraldCollectedScreenGraphics(EmeraldCollectedScreenWorker *work)
{
    // https://decomp.me/scratch/XOCqq -> 90.44%
#ifdef NON_MATCHING
    ReleaseEmeraldCollectedScreenSparkles(&work->sparkleManager);

    for (AnimatorSprite *ani = &work->animators[0]; ani != &work->animators[16]; ani++)
    {
        AnimatorSprite__Release(ani);
    }

    NNS_G3dRenderObjResetCallBack(&work->aniEmerald3D[0].renderObj);

    for (AnimatorMDL *ani = &work->aniEmerald3D[0]; ani != &work->aniEmerald3D[1]; ani++)
    {
        AnimatorMDL__ProcessAnimation(ani);
    }

    NNS_G3dResDefaultRelease(work->mdlEmerald);
#else
    // clang-format off
	push {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, =0x000007A8
	add r0, r6, r0
	bl ReleaseEmeraldCollectedScreenSparkles
	ldr r0, =0x00000648
	mov r5, r6
	add r5, #8
	add r4, r6, r0
	cmp r5, r4
	beq _02155504
_021554F8:
	mov r0, r5
	bl AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _021554F8
_02155504:
	ldr r0, =0x00000648
	add r0, r6, r0
	add r0, #0x90
	bl NNS_G3dRenderObjResetCallBack
	ldr r0, =0x00000648
	ldr r1, =0x0000078C
	add r0, r6, r0
	add r1, r6, r1
	cmp r0, r1
	beq _0215551E
	bl AnimatorMDL__Release
_0215551E:
	ldr r0, =0x0000078C
	ldr r0, [r6, r0]
	bl NNS_G3dResDefaultRelease
	pop {r4, r5, r6, pc}

// clang-format on
#endif
}

void HandleEmeraldCollectedScreenUpdating(EmeraldCollectedScreen *work)
{
    EmeraldCollectedScreenWorker *process       = &work->process;
    EmeraldCollectedScreenSparkles *sparkleWork = &process->sparkleManager;

    renderCoreGFXControlA.bgPosition[2].x -= 2;
    renderCoreGFXControlA.bgPosition[3].x += 2;

    for (AnimatorSprite *ani = &process->animators[0]; ani != &process->animators[16]; ani++)
    {
        AnimatorSprite__ProcessAnimationFast(ani);
    }

    for (AnimatorMDL *ani = &process->aniEmerald3D[0]; ani != &process->aniEmerald3D[1]; ani++)
    {
        AnimatorMDL__ProcessAnimation(ani);
    }

    sparkleWork->originPos.x = FX32_FROM_WHOLE(process->emeraldPos.x);
    sparkleWork->originPos.y = FX32_FROM_WHOLE(process->emeraldPos.y);

    sparkleWork->spawnMoveSpeed = FLOAT_TO_FX32(0.5);

    if (process->emeraldPos.z > FLOAT_TO_FX32(355.0))
    {
        sparkleWork->scale          = FLOAT_TO_FX32(2.0);
        sparkleWork->spawnMoveSpeed = FLOAT_TO_FX32(1.0);
        sparkleWork->spawnRange     = FLOAT_TO_FX32(60.0);
    }
    else if (process->emeraldPos.z < FLOAT_TO_FX32(340.0))
    {
        sparkleWork->scale          = FLOAT_TO_FX32(1.0);
        sparkleWork->spawnMoveSpeed = FLOAT_TO_FX32(0.5);
        sparkleWork->spawnRange     = FLOAT_TO_FX32(2.0);
    }
    else
    {
        fx32 scale = MTM_MATH_CLIP((process->emeraldPos.z - FLOAT_TO_FX32(340.0)) / 15, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(1.0));

        sparkleWork->scale          = scale + FLOAT_TO_FX32(1.0);
        sparkleWork->spawnMoveSpeed = MultiplyFX(scale + FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.5)) + FLOAT_TO_FX32(0.5);
        sparkleWork->spawnRange     = MultiplyFX(scale + FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(58.0)) + FLOAT_TO_FX32(2.0);
    }

    ProcessSparklesForEmeraldCollectedScreen(sparkleWork);
}

void HandleEmeraldCollectedScreenDrawing(EmeraldCollectedScreen *work)
{
    u32 e;

    EmeraldCollectedScreenWorker *process = &work->process;

    for (AnimatorSprite *ani = &process->animators[0]; ani != &process->animators[14]; ani++)
    {
        AnimatorSprite__DrawFrame(ani);
    }

    const EmeraldCollectedScreenAnimConfig *config = &decorationConfig[0];
    for (e = 0; e < 7; e++)
    {
        AnimatorSprite *aniEmerald;
        if (((1 << e) & process->emeraldFlags) != 0)
            aniEmerald = &process->aniActiveCase;
        else
            aniEmerald = &process->aniCase;

        aniEmerald->pos32 = *(u32 *)&config->pos;
        AnimatorSprite__DrawFrame(aniEmerald);

        config++;
    }

    for (AnimatorMDL *ani = &process->aniEmerald3D[0]; ani != &process->aniEmerald3D[1]; ani++)
    {
        AnimatorMDL__Draw(ani);
    }

    DrawSparklesForEmeraldCollectedScreen(&process->sparkleManager);
}

void EmeraldCollectedScreen_State_Init(EmeraldCollectedScreen *work)
{
    u32 flags = DRAW_FADE_TASK_FLAG_FADE_TO_BLACK | DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS;

    work->flags |= (EMERALDCOLLECTEDSCREEN_FLAG_CAN_UPDATE | EMERALDCOLLECTEDSCREEN_FLAG_CAN_DRAW);

    if (renderCoreGFXControlA.brightness != 0)
    {
        if (renderCoreGFXControlA.brightness < 0)
            flags = DRAW_FADE_TASK_FLAG_FADE_TO_BLACK;

        CreateDrawFadeTask(flags, FLOAT_TO_FX32(1.0));
    }
    else
    {
        CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_FADE_TO_BLACK, FLOAT_TO_FX32(1.0));
    }

    SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_FadeIn);
}

void EmeraldCollectedScreen_State_FadeIn(EmeraldCollectedScreen *work)
{
    if (IsDrawFadeTaskFinished())
    {
        PlaySysTrack(SND_SYS_SEQ_SEQ_EMERALD, FALSE);
        PlayHandleSystemSfx(work->seqPlayer, SND_SYS_SEQARC_ARC_EMERALD, SND_SYS_SEQARC_ARC_EMERALD_SEQ_SE_EMERALD_FLIGHT);
        SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_IntroDelay);
    }
}

void EmeraldCollectedScreen_State_IntroDelay(EmeraldCollectedScreen *work)
{
    if (work->timer > 16)
    {
        EmeraldCollectedScreenWorker *process = &work->process;
        AnimatorMDL *aniEmerald3D             = &process->aniEmerald3D[0];

        aniEmerald3D->work.flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;
        aniEmerald3D->animFlags[1] &= ~ANIMATORMDL_FLAG_STOPPED;
        aniEmerald3D->animFlags[0] &= ~ANIMATORMDL_FLAG_STOPPED;

        EnableSparklesForEmeraldCollectedScreen(&process->sparkleManager);
        SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_InitEnterEmerald);
    }
}

void EmeraldCollectedScreen_State_InitEnterEmerald(EmeraldCollectedScreen *work)
{
    EmeraldCollectedScreenWorker *process = &work->process;
    AnimatorMDL *aniEmerald3D             = &process->aniEmerald3D[0];

    if ((padInput.btnPress & PAD_BUTTON_A) != 0 || TOUCH_HAS_PUSH(touchInput.flags) != 0)
    {
        SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_InitEmeraldInPlace);
        return;
    }

    aniEmerald3D->work.flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;
    aniEmerald3D->animFlags[1] &= ~ANIMATORMDL_FLAG_STOPPED;
    aniEmerald3D->animFlags[0] &= ~ANIMATORMDL_FLAG_STOPPED;
    SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_EnterEmerald);
}

void EmeraldCollectedScreen_State_EnterEmerald(EmeraldCollectedScreen *work)
{
    if ((padInput.btnPress & PAD_BUTTON_A) != 0 || TOUCH_HAS_PUSH(touchInput.flags) != 0)
    {
        SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_InitEmeraldInPlace);
        return;
    }

    if (work->timer > 150)
    {
        SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_InitMoveEmeraldIntoPlace);
    }
}

void EmeraldCollectedScreen_State_InitMoveEmeraldIntoPlace(EmeraldCollectedScreen *work)
{
    EmeraldCollectedScreenWorker *process = &work->process;

    // load asset.... and then don't use it?
    void *jntAniEmerald;
    LoadAssetsForStageClearEx(work->assets.archiveEmeraldCollected, &jntAniEmerald, ARCHIVE_EMDM_LZ7_FILE_EMDM_NSBCA, NULL);

    if ((padInput.btnPress & PAD_BUTTON_A) != 0 || TOUCH_HAS_PUSH(touchInput.flags) != 0)
    {
        SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_InitEmeraldInPlace);
        return;
    }

    const EmeraldCollectedScreenAnimConfig *config = &decorationConfig[process->currentEmerald];

    VecFx32 *targetPos = &process->emeraldTargetPos;
    targetPos->x       = 128 + (392 * (config->pos.x - 128));
    targetPos->y       = 96 + (392 * -(config->pos.y - 96));
    targetPos->z       = -FLOAT_TO_FX32(5.0);

    SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_MoveEmeraldIntoPlace);
}

void EmeraldCollectedScreen_State_MoveEmeraldIntoPlace(EmeraldCollectedScreen *work)
{
    EmeraldCollectedScreenWorker *process = &work->process;
    AnimatorMDL *aniEmerald3D             = &process->aniEmerald3D[0];

    VecFx32 startPos;
    startPos.x = FLOAT_TO_FX32(0.0);
    startPos.y = FLOAT_TO_FX32(0.0);
    startPos.z = FLOAT_TO_FX32(0.0);

    s16 lerpPercent = FX32_FROM_WHOLE(work->timer) / 190;
    if (lerpPercent > FLOAT_TO_FX32(1.0))
        lerpPercent = FLOAT_TO_FX32(1.0);

    Task__Unknown204BE48__LerpVec3(&aniEmerald3D->work.translation, &startPos, &process->emeraldTargetPos, lerpPercent, -FLOAT_TO_FX32(0.5));

    if ((padInput.btnPress & PAD_BUTTON_A) != 0 || TOUCH_HAS_PUSH(touchInput.flags) != 0)
    {
        SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_InitEmeraldInPlace);
        return;
    }

    if ((aniEmerald3D->animFlags[B3D_ANIM_JOINT_ANIM] & ANIMATORMDL_FLAG_FINISHED) != 0)
    {
        SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_InitEmeraldInPlace);
        return;
    }
}

void EmeraldCollectedScreen_State_InitEmeraldInPlace(EmeraldCollectedScreen *work)
{
    EmeraldCollectedScreenWorker *process = &work->process;
    AnimatorMDL *aniEmerald3D             = &process->aniEmerald3D[0];

    aniEmerald3D->work.flags |= ANIMATORMDL_FLAG_STOPPED;

    AnimatorSprite *aniEmerald = &process->animators[7 + process->currentEmerald];
    aniEmerald->flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;

    AnimatorSprite *aniEmeraldJewel = &process->animators[process->currentEmerald];
    aniEmeraldJewel->flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;

    process->emeraldFlags |= 1 << process->currentEmerald;
    DisableSparklesForEmeraldCollectedScreen(&process->sparkleManager);

    CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_FADE_TO_BLACK | DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS, FLOAT_TO_FX32(0.25));

    StopStageSfx(work->seqPlayer);
    PlaySystemSfx(SND_SYS_SEQARC_ARC_EMERALD, SND_SYS_SEQARC_ARC_EMERALD_SEQ_SE_EMERALD_FIX);

    SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_EmeraldPlaceFlash);
}

void EmeraldCollectedScreen_State_EmeraldPlaceFlash(EmeraldCollectedScreen *work)
{
    if (IsDrawFadeTaskFinished())
    {
        SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_EmeraldPlaceWait);
    }
}

void EmeraldCollectedScreen_State_EmeraldPlaceWait(EmeraldCollectedScreen *work)
{
    if ((padInput.btnPress & PAD_BUTTON_A) != 0 || TOUCH_HAS_PUSH(touchInput.flags) != 0)
    {
        SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_InitFadeOut);
        return;
    }

    if (work->timer > 32)
    {
        PlaySystemSfx(SND_SYS_SEQARC_ARC_EMERALD, SND_SYS_SEQARC_ARC_EMERALD_SEQ_SE_EMERALD_SHINE);
        SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_EmeraldSparkle);
    }
}

void EmeraldCollectedScreen_State_EmeraldSparkle(EmeraldCollectedScreen *work)
{
    EmeraldCollectedScreenWorker *process = &work->process;

    const EmeraldCollectedScreenAnimConfig *config;
    if (IsEmeraldCollectedScreenUsingChaosEmeralds())
        config = chaosEmeraldConfig;
    else
        config = solEmeraldConfig;

    u32 i            = 0;
    s32 shineAniTime = 1;
    s32 idleAniTime  = 33;
    for (; i < 7; i++)
    {
        if (work->timer == shineAniTime)
        {
            u32 id = GetEmeraldCollectedScreenEmeraldAnimatorID(i);

            u32 aniID = id + 7;
            AnimatorSprite__SetAnimation(&process->animators[aniID], config[id].animID + EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_SHINE_1);
            AnimatorSprite__ProcessAnimationFast(&process->animators[aniID]);
        }

        if (work->timer == idleAniTime)
        {
            u32 id = GetEmeraldCollectedScreenEmeraldAnimatorID(i);

            u32 aniID = id + 7;
            AnimatorSprite__SetAnimation(&process->animators[aniID], config[id].animID + EMERALDCOLLECTED_EME_ANI_CHAOS_EMERALD_1);
            AnimatorSprite__ProcessAnimationFast(&process->animators[aniID]);
        }

        shineAniTime += 4;
        idleAniTime += 4;
    }

    if (work->timer > 61)
    {
        SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_EmeraldSparkleWait);
    }
}

void EmeraldCollectedScreen_State_EmeraldSparkleWait(EmeraldCollectedScreen *work)
{
    if ((padInput.btnPress & PAD_BUTTON_A) != 0 || TOUCH_HAS_PUSH(touchInput.flags) != 0)
    {
        SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_InitFadeOut);
        return;
    }

    if (work->timer > 120)
    {
        SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_InitFadeOut);
    }
}

void EmeraldCollectedScreen_State_InitFadeOut(EmeraldCollectedScreen *work)
{
    CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(1.0));
    FadeSysTrack(12);
    SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_FadeOut);
}

void EmeraldCollectedScreen_State_FadeOut(EmeraldCollectedScreen *work)
{
    if (IsDrawFadeTaskFinished())
    {
        DestroyDrawFadeTask();
        work->flags &= ~(EMERALDCOLLECTEDSCREEN_FLAG_CAN_UPDATE | EMERALDCOLLECTEDSCREEN_FLAG_CAN_DRAW);
        SetEmeraldCollectedScreenState(work, EmeraldCollectedScreen_State_ChangeEvent);
    }
}

void EmeraldCollectedScreen_State_ChangeEvent(EmeraldCollectedScreen *work)
{
    RequestNewSysEventChange(SYSEVENT_UPDATE_PROGRESS);
    NextSysEvent();
    ReleaseEmeraldCollectedScreen(work);
}

s32 GetEmeraldCollectedScreenEmeraldAnimatorID(u32 id)
{
    switch (id)
    {
        case 0:
            return 0;

        case 1:
            return 2;

        case 2:
            return 4;

        case 3:
            return 6;

        case 4:
            return 1;

        case 5:
            return 3;

        case 6:
            return 5;
    }

    return 0;
}

BOOL IsEmeraldCollectedScreenUsingChaosEmeralds(void)
{
    EmeraldCollectedScreen *work = TaskGetWork(sVars.singleton, EmeraldCollectedScreen);
    return work->process.isChaosEmeralds;
}

NONMATCH_FUNC void InitEmeraldCollectedScreenEmeraldConfig(EmeraldCollectedScreenWorker *work)
{
    // https://decomp.me/scratch/p581P -> 81.37%
#ifdef NON_MATCHING
    u32 e = 0;

    work->emeraldFlags   = 0x00;
    work->currentEmerald = -1;

    SaveBlockStage *stageSaveGame = &saveGame.stage;
    SaveBlockChart *chartSaveGame = &saveGame.chart;
    if (gameState.saveFile.field_50 != 0xFF)
    {
        work->isChaosEmeralds = TRUE;

        while (e < 7)
        {
            if (SaveGame__HasChaosEmerald(chartSaveGame, e))
                work->emeraldFlags |= 1 << e;

            e++;
        }

        work->currentEmerald        = gameState.saveFile.field_50;
        gameState.saveFile.field_50 = 0xFF;

        work->emeraldFlags &= ~(1 << work->currentEmerald);
    }
    else if (gameState.saveFile.field_51 != 0xFF)
    {
        work->isChaosEmeralds = FALSE;

        while (e < 7)
        {
            if (SaveGame__HasSolEmerald(stageSaveGame, e))
                work->emeraldFlags |= 1 << e;

            e++;
        }

        work->currentEmerald        = gameState.saveFile.field_51;
        gameState.saveFile.field_51 = 0xFF;

        work->emeraldFlags &= ~(1 << work->currentEmerald);
    }
    else
    {
        gameState.saveFile.field_50 = 0xFF;
        gameState.saveFile.field_51 = 0xFF;
    }
#else
    // clang-format off
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	mov r4, #0
	strh r4, [r5, #4]
	sub r0, r4, #1
	strh r0, [r5, #6]
	ldr r0, =0x02139594
	ldr r7, =0x0213461C
	ldrb r0, [r0, #0x10]
	cmp r0, #0xff
	beq _02155C80
	mov r0, #1
	str r0, [r5]
	mov r6, r0
_02155C40:
	lsl r1, r4, #0x18
	mov r0, r7
	lsr r1, r1, #0x18
	bl SaveGame__HasChaosEmerald
	cmp r0, #0
	beq _02155C58
	mov r0, r6
	ldrh r1, [r5, #4]
	lsl r0, r4
	orr r0, r1
	strh r0, [r5, #4]
_02155C58:
	add r4, r4, #1
	cmp r4, #7
	blo _02155C40
	mov r1, #0x15
	ldr r0, =gameState
	lsl r1, r1, #4
	ldrb r0, [r0, r1]
	mov r2, #0xff
	strh r0, [r5, #6]
	ldr r0, =gameState
	strb r2, [r0, r1]
	mov r0, #6
	ldrsh r0, [r5, r0]
	mov r1, #1
	ldrh r2, [r5, #4]
	lsl r1, r0
	mvn r0, r1
	and r0, r2
	strh r0, [r5, #4]
	pop {r3, r4, r5, r6, r7, pc}
_02155C80:
	ldr r2, =0x00000151
	ldr r0, =gameState
	ldrb r0, [r0, r2]
	cmp r0, #0xff
	beq _02155CCC
	str r4, [r5]
	mov r6, #1
_02155C8E:
	lsl r1, r4, #0x18
	ldr r0, =0x02134474
	lsr r1, r1, #0x18
	bl SaveGame__HasSolEmerald
	cmp r0, #0
	beq _02155CA6
	mov r0, r6
	ldrh r1, [r5, #4]
	lsl r0, r4
	orr r0, r1
	strh r0, [r5, #4]
_02155CA6:
	add r4, r4, #1
	cmp r4, #7
	blo _02155C8E
	ldr r1, =0x00000151
	ldr r0, =gameState
	mov r2, #0xff
	ldrb r0, [r0, r1]
	strh r0, [r5, #6]
	ldr r0, =gameState
	strb r2, [r0, r1]
	mov r0, #6
	ldrsh r0, [r5, r0]
	mov r1, #1
	ldrh r2, [r5, #4]
	lsl r1, r0
	mvn r0, r1
	and r0, r2
	strh r0, [r5, #4]
	pop {r3, r4, r5, r6, r7, pc}
_02155CCC:
	mov r3, #0xff
	mov r1, r3
	ldr r0, =gameState
	add r1, #0x51
	strb r3, [r0, r1]
	strb r3, [r0, r2]
	pop {r3, r4, r5, r6, r7, pc}
	nop

// clang-format on
#endif
}

void EmeraldCollectedScreen_RenderCallback(NNSG3dRS *rs)
{
    MtxFx43 mtx;
    VecFx32 worldPos;
    fx32 sy;
    fx32 sx;

    EmeraldCollectedScreen *work          = TaskGetWork(sVars.singleton, EmeraldCollectedScreen);
    EmeraldCollectedScreenWorker *process = &work->process;

    NNS_G3dGetCurrentMtx(&mtx, 0);

    worldPos.x = mtx.m[3][0];
    worldPos.y = mtx.m[3][1];
    worldPos.z = mtx.m[3][2];
    NNS_G3dWorldPosToScrPos(&worldPos, &sx, &sy);

    process->emeraldPos.x = sx;
    process->emeraldPos.y = sy;
    process->emeraldPos.z = mtx.m[3][2];
}

void InitEmeraldCollectedScreenSparkles(EmeraldCollectedScreenSparkles *work, void *spriteFile)
{
    AnimatorSprite *aniSparkle = &work->animators[0];
    u32 i                      = 0;

    work->acceleration.x = FLOAT_TO_FX32(0.0);
    work->acceleration.y = FLOAT_TO_FX32(0.0);

    work->spawnMoveSpeed = FLOAT_TO_FX32(0.5);
    work->spawnRange     = FLOAT_TO_FX32(2.0);

    for (; i < 10; i++)
    {
        u16 anim = i + EMERALDCOLLECTED_HUD_ANI_SPARKLE_1;
        SpriteUnknown__Func_204C90C(aniSparkle, spriteFile, anim, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_ENABLE_SCALE | ANIMATOR_FLAG_DISABLE_LOOPING, 0,
                                    SpriteUnknown__Func_204C3CC(spriteFile, FALSE, anim), PALETTE_ROW_12, SPRITE_PRIORITY_0, SPRITE_ORDER_0);

        AnimatorSprite__AnimateManual(aniSparkle, mtMathRand(), NULL, NULL);

        aniSparkle++;
    }
}

void ReleaseEmeraldCollectedScreenSparkles(EmeraldCollectedScreenSparkles *work)
{
    for (AnimatorSprite *ani = &work->animators[0]; ani != &work->animators[10]; ani++)
    {
        AnimatorSprite__Release(ani);
    }

    work->enabled = FALSE;
}

void EnableSparklesForEmeraldCollectedScreen(EmeraldCollectedScreenSparkles *work)
{
    for (u32 i = 0; i < 50; i++)
    {
        EmeraldCollectedScreenSparkle *sparkle = &work->particleList[i];

        sparkle->type         = (mtMathRand() % 10);
        sparkle->inactiveTime = (mtMathRand() % 50) + 1;
        sparkle->activeTime   = mtMathRand() % 48;
    }

    work->enabled = TRUE;
}

void DisableSparklesForEmeraldCollectedScreen(EmeraldCollectedScreenSparkles *work)
{
    work->enabled = FALSE;
}

void ProcessSparklesForEmeraldCollectedScreen(EmeraldCollectedScreenSparkles *work)
{
    for (EmeraldCollectedScreenSparkle *particle = &work->particleList[0]; particle != &work->particleList[50]; particle++)
    {
        if (particle->inactiveTime == 0)
        {
            particle->pos.x += particle->velocity.x;
            particle->pos.y += particle->velocity.y;

            particle->velocity.x += work->acceleration.x;
            particle->velocity.y += work->acceleration.y;

            if (particle->activeTime-- == 0)
            {
                particle->inactiveTime = (mtMathRand() % 50) + 1;
            }
        }
        else
        {
            if (work->enabled)
            {
                particle->inactiveTime--;
                if (particle->inactiveTime == 0)
                {
                    u16 angle = mtMathRand();
                    (void)Task__Unknown204BE48__Rand();

                    particle->pos.x = work->originPos.x + FX32_TO_WHOLE((((s16)mtMathRand()) >> 4) * work->spawnRange);
                    particle->pos.y = work->originPos.y + FX32_TO_WHOLE((((s16)mtMathRand()) >> 4) * work->spawnRange);

                    particle->velocity.x = MultiplyFX(SinFX((s32)(u16)angle), work->spawnMoveSpeed);
                    particle->velocity.y = MultiplyFX(CosFX((s32)(u16)angle), work->spawnMoveSpeed);
                    particle->scale      = work->scale;

                    particle->type       = (mtMathRand() % 10);
                    particle->activeTime = (mtMathRand() % 48);
                }
            }
        }
    }

    for (AnimatorSprite *ani = &work->animators[0]; ani != &work->animators[10]; ani++)
    {
        AnimatorSprite__ProcessAnimationFast(ani);
    }
}

void DrawSparklesForEmeraldCollectedScreen(EmeraldCollectedScreenSparkles *work)
{
    u32 i                                  = 0;
    EmeraldCollectedScreenSparkle *sparkle = work->particleList;
    for (; i < 50; i++)
    {
        if (sparkle->inactiveTime == 0)
        {
            AnimatorSprite *aniSparkle = &work->animators[sparkle->type];
            aniSparkle->pos.x          = FX32_TO_WHOLE(sparkle->pos.x);
            aniSparkle->pos.y          = FX32_TO_WHOLE(sparkle->pos.y);

            if ((i & 1) != 0)
            {
                AnimatorSprite__DrawFrame(aniSparkle);
            }
            else
            {
                if (sparkle->scale <= FLOAT_TO_FX32(1.0))
                    AnimatorSprite__DrawFrame(aniSparkle);
                else
                    AnimatorSprite__DrawFrameRotoZoom(aniSparkle, work->scale, work->scale, FLOAT_DEG_TO_IDX(0.0));
            }
        }

        sparkle++;
    }
}

void EmeraldCollectedScreen_Main_Core(void)
{
    EmeraldCollectedScreen *work = TaskGetWorkCurrent(EmeraldCollectedScreen);

    work->timer++;

    if (work->state != NULL)
        work->state(work);
}

void EmeraldCollectedScreen_Main_UpdateManager(void)
{
    EmeraldCollectedScreen *work = TaskGetWork(sVars.singleton, EmeraldCollectedScreen);

    if ((work->flags & EMERALDCOLLECTEDSCREEN_FLAG_CAN_UPDATE) != 0)
        HandleEmeraldCollectedScreenUpdating(work);
}

void EmeraldCollectedScreen_Main_DrawManager(void)
{
    EmeraldCollectedScreen *work = TaskGetWork(sVars.singleton, EmeraldCollectedScreen);

    if ((work->flags & EMERALDCOLLECTEDSCREEN_FLAG_CAN_DRAW) != 0)
        HandleEmeraldCollectedScreenDrawing(work);
}

#include <nitro/codereset.h>