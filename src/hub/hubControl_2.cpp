#include <hub/hubControl.hpp>
#include <hub/cviHubAreaPreview.hpp>
#include <hub/cviMap.hpp>
#include <hub/dockCommon.h>
#include <hub/cviDockNpcGroup.hpp>
#include <hub/hubHUD.hpp>
#include <hub/hubAudio.h>
#include <game/audio/sysSound.h>
#include <hub/hubConfig.h>
#include <hub/missionConfig.h>
#include <hub/talkHelpers.h>
#include <game/game/gameState.h>
#include <game/save/saveGame.h>
#include <game/file/fileUnknown.h>
#include <game/file/fsRequest.h>
#include <game/file/binaryBundle.h>
#include <game/system/sysEvent.h>
#include <game/graphics/oamSystem.h>
#include <menu/credits.h>
#include <game/cutscene/script.h>
#include <hub/cviTalkPurchase.hpp>

// resources
#include <resources/narc/vi_act_lz7.h>
#include <resources/bb/vi_act_loc.h>
#include <resources/bb/vi_act_loc/vi_act_loc_eng.h>
#include <resources/narc/vi_bg_lz7.h>
#include <resources/bb/vi_bg_up.h>
#include <resources/bb/vi_bg_up/vi_bg_up_eng.h>
#include <resources/bb/vi_msg.h>
#include <resources/narc/vi_msg_ctrl_lz7.h>
#include <resources/bb/tkdm_name.h>
#include <resources/bb/tkdm_down.h>

// --------------------
// VARIABLES
// --------------------

extern HubControlSaveUnknown const *_0217362C[];

// --------------------
// FUNCTIONS
// --------------------

void HubControl::InitDisplay()
{
    if (renderCoreGFXControlA.brightness > RENDERCORE_BRIGHTNESS_DEFAULT)
    {
        renderCoreGFXControlA.brightness = RENDERCORE_BRIGHTNESS_WHITE;
        renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_WHITE;
    }
    else
    {
        renderCoreGFXControlA.brightness = RENDERCORE_BRIGHTNESS_BLACK;
        renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_BLACK;
    }

    GX_SetMasterBrightness(renderCoreGFXControlA.brightness);
    GXS_SetMasterBrightness(renderCoreGFXControlB.brightness);

    GX_SetPower(GX_POWER_ALL);
    reg_GX_POWCNT |= GX_POWER_3D; // not sure why this line is here, maybe it's a leftover?

    HubControl::InitVRAMSystem();

    GX_SetBGScrOffset(GX_BGSCROFFSET_0x00000);
    GX_SetBGCharOffset(GX_BGCHAROFFSET_0x00000);
    GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_0, GX_BG0_AS_3D);
    renderCoreSwapBuffer.sortMode   = GX_SORTMODE_AUTO;
    renderCoreSwapBuffer.bufferMode = GX_BUFFERMODE_W;

    G3X_SetShading(GX_SHADING_TOON);
    G3X_AntiAlias(TRUE);
    G3X_AlphaTest(FALSE, 0);
    G3X_AlphaBlend(TRUE);
    G3X_EdgeMarking(TRUE);

    G3X_SetFog(FALSE, GX_FOGBLEND_COLOR_ALPHA, GX_FOGSLOPE_0x8000, 0);
    G3X_SetClearColor(GX_RGB_888(0x00, 0x00, 0x00), GX_COLOR_FROM_888(0x00), 0x7FFF, 0, FALSE);

    G3_SwapBuffers(renderCoreSwapBuffer.sortMode, renderCoreSwapBuffer.bufferMode);
    G3_ViewPort(0, 0, HW_LCD_WIDTH - 1, HW_LCD_HEIGHT - 1);

    G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x8000, GX_BG_CHARBASE_0x08000, GX_BG_EXTPLTT_01);

    renderCoreGFXControlA.bgPosition[BACKGROUND_0].x = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_0].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_1].x = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_1].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_2].x = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_2].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_3].x = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_3].y = 0;

    G2_SetBG0Priority(3);
    G2_SetBG1Priority(1);
    G2_SetBG2Priority(2);
    G2_SetBG3Priority(0);

    GX_SetVisiblePlane(GX_PLANEMASK_BG0 | GX_PLANEMASK_OBJ);

    GXS_SetGraphicsMode(GX_BGMODE_0);

    G2S_SetBG0Control(GX_BG_SCRSIZE_TEXT_512x256, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0xa000, GX_BG_CHARBASE_0x0c000, GX_BG_EXTPLTT_01);
    G2S_SetBG1Control(GX_BG_SCRSIZE_TEXT_512x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0xb000, GX_BG_CHARBASE_0x1c000, GX_BG_EXTPLTT_01);

    renderCoreGFXControlB.bgPosition[BACKGROUND_0].x = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_0].y = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_1].x = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_1].y = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_2].x = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_2].y = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_3].x = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_3].y = 0;

    G2S_SetBG2Priority(0);
    G2S_SetBG3Priority(1);
    G2S_SetBG0Priority(2);
    G2S_SetBG1Priority(3);

    GXS_SetVisiblePlane(GX_PLANEMASK_BG0 | GX_PLANEMASK_BG1 | GX_PLANEMASK_OBJ);

    MI_CpuClearFast(VRAM_BG, HW_BG_VRAM_SIZE);
    MI_CpuClearFast(VRAM_DB_BG, HW_DB_BG_VRAM_SIZE);

    MI_CpuClear16(&renderCoreGFXControlA.blendManager, sizeof(renderCoreGFXControlA.blendManager));
    MI_CpuClear16(&renderCoreGFXControlB.blendManager, sizeof(renderCoreGFXControlB.blendManager));

    renderCoreGFXControlB.blendManager.blendControl.plane2_BG0 = TRUE;
    renderCoreGFXControlB.blendManager.blendControl.plane2_BG1 = TRUE;

    renderCoreGFXControlB.blendManager.blendAlpha.ev1 = 0x10;
    renderCoreGFXControlB.blendManager.blendAlpha.ev2 = 0x10;

    renderCoreGFXControlB.windowManager.visible = 0;

    renderCoreGFXControlA.windowManager.visible = 0;
}

void HubControl::InitEngineAForTalk()
{
    renderCoreGFXControlA.bgPosition[BACKGROUND_2].x = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_2].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_3].x = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_3].y = 0;

    G2_SetBG0Priority(3);
    G2_SetBG1Priority(1);
    G2_SetBG2Priority(2);
    G2_SetBG3Priority(0);

    GX_SetVisiblePlane(GX_GetVisiblePlane() & ~(GX_PLANEMASK_BG1 | GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3));

    G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x8000, GX_BG_CHARBASE_0x08000, GX_BG_EXTPLTT_01);
    G2_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0800, GX_BG_CHARBASE_0x00000);
    G2_SetBG3ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x00000);

    MI_CpuFill32(VRAM_BG, VRAM_SCRFMT_TEXT_x2(VRAM_SCRFMT_TEXT(1023, FALSE, FALSE, PALETTE_ROW_0), VRAM_SCRFMT_TEXT(1023, FALSE, FALSE, PALETTE_ROW_0)),
                 2 * sizeof(GXScrText32x32));
    MI_CpuClearFast((u8 *)VRAM_BG + (0x8000 - sizeof(GXCharFmt16)), sizeof(GXCharFmt16));
}

void HubControl::InitEngineAFor3DHub()
{
    G2_SetBG0Priority(3);
    G2_SetBG1Priority(1);
    G2_SetBG2Priority(2);
    G2_SetBG3Priority(0);

    GX_SetVisiblePlane(GX_GetVisiblePlane() & ~(GX_PLANEMASK_BG1 | GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3));
}

void HubControl::InitEngineBForMissionList()
{
    renderCoreGFXControlB.bgPosition[BACKGROUND_2].x = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_2].y = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_3].x = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_3].y = 0;

    G2S_SetBG3Priority(0);
    G2S_SetBG2Priority(1);
    G2S_SetBG0Priority(2);
    G2S_SetBG1Priority(3);

    GXS_SetVisiblePlane(GXS_GetVisiblePlane() & ~(GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3));

    G2S_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0800, GX_BG_CHARBASE_0x00000);
    G2S_SetBG3ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x00000);

    MI_CpuFill32(VRAM_DB_BG, VRAM_SCRFMT_TEXT_x2(VRAM_SCRFMT_TEXT(1023, FALSE, FALSE, PALETTE_ROW_0), VRAM_SCRFMT_TEXT(1023, FALSE, FALSE, PALETTE_ROW_0)),
                 2 * sizeof(GXScrText32x32));
    MI_CpuClearFast((u8 *)VRAM_DB_BG + (0x8000 - sizeof(GXCharFmt16)), sizeof(GXCharFmt16));
}

void HubControl::InitEngineBForTalkPurchase()
{
    renderCoreGFXControlB.bgPosition[BACKGROUND_2].x = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_2].y = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_3].x = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_3].y = 0;

    G2S_SetBG3Priority(0);
    G2S_SetBG2Priority(1);
    G2S_SetBG0Priority(2);
    G2S_SetBG1Priority(3);

    GXS_SetVisiblePlane(GXS_GetVisiblePlane() & ~(GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3));

    G2S_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0800, GX_BG_CHARBASE_0x00000);

    MI_CpuFill32(VRAM_DB_BG, VRAM_SCRFMT_TEXT_x2(VRAM_SCRFMT_TEXT(1023, FALSE, FALSE, PALETTE_ROW_0), VRAM_SCRFMT_TEXT(1023, FALSE, FALSE, PALETTE_ROW_0)),
                 2 * sizeof(GXScrText32x32));
    MI_CpuClearFast((u8 *)VRAM_DB_BG + (0x8000 - sizeof(GXCharFmt16)), sizeof(GXCharFmt16));
}

void HubControl::InitEngineBFor3DHub()
{
    G2S_SetBG2Priority(0);
    G2S_SetBG3Priority(1);
    G2S_SetBG0Priority(2);
    G2S_SetBG1Priority(3);

    GXS_SetVisiblePlane(GXS_GetVisiblePlane() & ~(GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3));
}

void HubControl::InitEngineAForAreaSelect()
{
    renderCoreGFXControlA.bgPosition[BACKGROUND_1].x = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_1].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_3].x = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_3].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_2].x = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_2].y = 0;

    G2_SetBG2Priority(0);
    G2_SetBG1Priority(1);
    G2_SetBG3Priority(2);
    G2_SetBG0Priority(3);

    GX_SetVisiblePlane(GX_PLANEMASK_BG0 | GX_PLANEMASK_BG2 | GX_PLANEMASK_OBJ);

    G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x2800, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_01);
    G2_SetBG3ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x3000, GX_BG_CHARBASE_0x0c000);
    G2_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x2000, GX_BG_CHARBASE_0x00000);

    MI_CpuClearFast((u8 *)VRAM_BG + 0x1800, 0x800);
    MI_CpuClearFast((u8 *)VRAM_BG + 0x2000, 0x800);
    MI_CpuClearFast((u8 *)VRAM_BG + 0x4000, 0x40);
    MI_CpuClearFast((u8 *)VRAM_BG + 0xC000, 0x40);
    MI_CpuClearFast((u8 *)VRAM_BG + 0x1000, 0x800);
    MI_CpuClearFast((u8 *)VRAM_BG + 0x0000, 0x20);
}

void HubControl::InitEngineAForExitHub()
{
    G2_SetBG0Priority(3);
    G2_SetBG1Priority(1);
    G2_SetBG2Priority(2);
    G2_SetBG3Priority(0);

    GX_SetVisiblePlane(GX_GetVisiblePlane() & ~(GX_PLANEMASK_BG1 | GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3));
}

void HubControl::InitEngineAForCutscene()
{
    renderCoreGFXControlA.bgPosition[BACKGROUND_1].x = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_1].y = 0;

    G2_SetBG1Priority(0);
    G2_SetBG2Priority(1);
    G2_SetBG3Priority(2);
    G2_SetBG0Priority(3);

    GX_SetVisiblePlane(GX_PLANEMASK_BG1);

    G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x2800, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_01);

    Background background;
    void *backgroundFile = ReadFileFromBundle("bb/tkdm_down.bb", BUNDLE_TKDM_DOWN_FILE_RESOURCES_BB_TKDM_DOWN_DOWN_BG_BBG, BINARYBUNDLE_AUTO_ALLOC_HEAD);
    InitBackground(&background, backgroundFile, BACKGROUND_FLAG_LOAD_ALL, GRAPHICS_ENGINE_A, BACKGROUND_1, BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
    DrawBackground(&background);
    HeapFree(HEAP_USER, backgroundFile);
}

void HubControl::InitEngineAForUnknown()
{
    G2_SetBG0Priority(3);
    G2_SetBG1Priority(1);
    G2_SetBG2Priority(2);
    G2_SetBG3Priority(0);

    GX_SetVisiblePlane(GX_PLANEMASK_BG0 | GX_PLANEMASK_OBJ);
}

s32 HubControl::HandleFade(s16 targetA, s16 targetB, s16 fadeSpeed)
{
    s32 differenceA = HubControl::HandleFadeA(targetA, fadeSpeed);
    s32 differenceB = HubControl::HandleFadeB(targetB, fadeSpeed);

    return MT_MATH_MAX(differenceA, differenceB);
}

s32 HubControl::HandleFadeA(s16 target, s16 fadeSpeed)
{
    s32 difference;

    if (renderCoreGFXControlA.brightness > target)
    {
        renderCoreGFXControlA.brightness -= fadeSpeed;
        if (renderCoreGFXControlA.brightness < target)
            renderCoreGFXControlA.brightness = target;

        difference = renderCoreGFXControlA.brightness - target;
    }
    else if (renderCoreGFXControlA.brightness < target)
    {
        renderCoreGFXControlA.brightness += fadeSpeed;
        if (renderCoreGFXControlA.brightness > target)
            renderCoreGFXControlA.brightness = target;

        difference = target - renderCoreGFXControlA.brightness;
    }
    else
    {
        difference = 0;
    }

    if (MATH_ABS(renderCoreGFXControlA.brightness) >= RENDERCORE_BRIGHTNESS_WHITE)
        GX_SetMasterBrightness(renderCoreGFXControlA.brightness);

    return difference;
}

s32 HubControl::HandleFadeB(s16 target, s16 fadeSpeed)
{
    s32 difference;

    if (renderCoreGFXControlB.brightness > target)
    {
        renderCoreGFXControlB.brightness -= fadeSpeed;
        if (renderCoreGFXControlB.brightness < target)
            renderCoreGFXControlB.brightness = target;

        difference = renderCoreGFXControlB.brightness - target;
    }
    else if (renderCoreGFXControlB.brightness < target)
    {
        renderCoreGFXControlB.brightness += fadeSpeed;
        if (renderCoreGFXControlB.brightness > target)
            renderCoreGFXControlB.brightness = target;

        difference = target - renderCoreGFXControlB.brightness;
    }
    else
    {
        difference = 0;
    }

    if (MATH_ABS(renderCoreGFXControlB.brightness) >= RENDERCORE_BRIGHTNESS_WHITE)
        GXS_SetMasterBrightness(renderCoreGFXControlB.brightness);

    return difference;
}

void HubControl::Func_215B03C()
{
    renderCoreGFXControlB.bgPosition[BACKGROUND_2].x = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_2].y = 0;

    G2S_SetBG2Priority(0);
    G2S_SetBG3Priority(1);
    G2S_SetBG0Priority(2);
    G2S_SetBG1Priority(3);

    GXS_SetVisiblePlane(GXS_GetVisiblePlane() & ~(GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3));

    GXS_SetGraphicsMode(GX_BGMODE_5);

    G2S_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_512x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x04000);

    MI_CpuClear16(&renderCoreGFXControlA.blendManager, sizeof(renderCoreGFXControlA.blendManager));
    MI_CpuClear16(&renderCoreGFXControlB.blendManager, sizeof(renderCoreGFXControlA.blendManager));

    renderCoreGFXControlB.blendManager.blendControl.effect     = 1;
    renderCoreGFXControlB.blendManager.blendControl.plane1_BG2 = TRUE;
    renderCoreGFXControlB.blendManager.blendControl.plane2_BG0 = TRUE;
    renderCoreGFXControlB.blendManager.blendControl.plane2_BG1 = TRUE;
    renderCoreGFXControlB.blendManager.blendControl.plane2_OBJ = TRUE;

    renderCoreGFXControlB.blendManager.blendAlpha.ev1 = 0x10;
    renderCoreGFXControlB.blendManager.blendAlpha.ev2 = 0x10;
}

void HubControl::Func_215B168()
{
    G2S_SetBG2Priority(0);
    G2S_SetBG3Priority(1);
    G2S_SetBG0Priority(2);
    G2S_SetBG1Priority(3);

    GXS_SetVisiblePlane(GXS_GetVisiblePlane() & ~(GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3));

    GXS_SetGraphicsMode(GX_BGMODE_0);

    MI_CpuClear16(&renderCoreGFXControlA.blendManager, sizeof(renderCoreGFXControlA.blendManager));
    MI_CpuClear16(&renderCoreGFXControlB.blendManager, sizeof(renderCoreGFXControlA.blendManager));

    renderCoreGFXControlB.blendManager.blendControl.plane2_BG0 = TRUE;
    renderCoreGFXControlB.blendManager.blendControl.plane2_BG1 = TRUE;

    renderCoreGFXControlB.blendManager.blendAlpha.ev1 = 0x10;
    renderCoreGFXControlB.blendManager.blendAlpha.ev2 = 0x10;
}

void HubControl::Func_215B250()
{
    renderCoreGFXControlB.bgPosition[BACKGROUND_2].x = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_2].y = 0;

    G2S_SetBG2Priority(0);
    G2S_SetBG3Priority(1);
    G2S_SetBG0Priority(2);
    G2S_SetBG1Priority(3);

    GXS_SetVisiblePlane(GXS_GetVisiblePlane() & ~(GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3));

    G2S_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x04000);

    MI_CpuClear16(&renderCoreGFXControlA.blendManager, sizeof(renderCoreGFXControlA.blendManager));
    MI_CpuClear16(&renderCoreGFXControlB.blendManager, sizeof(renderCoreGFXControlA.blendManager));

    renderCoreGFXControlB.blendManager.blendControl.effect     = 1;
    renderCoreGFXControlB.blendManager.blendControl.plane1_BG2 = TRUE;
    renderCoreGFXControlB.blendManager.blendControl.plane2_BG0 = TRUE;
    renderCoreGFXControlB.blendManager.blendControl.plane2_BG1 = TRUE;
    renderCoreGFXControlB.blendManager.blendControl.plane2_OBJ = TRUE;

    renderCoreGFXControlB.blendManager.blendAlpha.ev1 = 0x10;
    renderCoreGFXControlB.blendManager.blendAlpha.ev2 = 0x10;

    renderCoreGFXControlB.windowManager.visible = 4;

    renderCoreGFXControlB.windowManager.registers.winOutPlane.plane_BG0 = TRUE;
    renderCoreGFXControlB.windowManager.registers.winOutPlane.plane_BG1 = TRUE;
    renderCoreGFXControlB.windowManager.registers.winOutPlane.plane_BG2 = FALSE;
    renderCoreGFXControlB.windowManager.registers.winOutPlane.plane_BG3 = TRUE;
    renderCoreGFXControlB.windowManager.registers.winOutPlane.plane_OBJ = TRUE;
    renderCoreGFXControlB.windowManager.registers.winOutPlane.effect    = TRUE;

    renderCoreGFXControlB.windowManager.registers.winOBJOutPlane.plane_BG0 = TRUE;
    renderCoreGFXControlB.windowManager.registers.winOBJOutPlane.plane_BG1 = TRUE;
    renderCoreGFXControlB.windowManager.registers.winOBJOutPlane.plane_BG2 = TRUE;
    renderCoreGFXControlB.windowManager.registers.winOBJOutPlane.plane_BG3 = TRUE;
    renderCoreGFXControlB.windowManager.registers.winOBJOutPlane.plane_OBJ = TRUE;
    renderCoreGFXControlB.windowManager.registers.winOBJOutPlane.effect    = TRUE;
}

void HubControl::Func_215B3B4()
{
    HubControl::Func_215B168();
    renderCoreGFXControlB.windowManager.visible = 0;
}

void HubControl::InitVRAMSystem()
{
    VRAMSystem__Reset();
    VRAMSystem__SetupTextureBank(GX_VRAM_TEX_01_AB);
    VRAMSystem__SetupTexturePalBank(GX_VRAM_TEXPLTT_0_F);
    VRAMSystem__InitTextureBuffer();
    VRAMSystem__InitPaletteBuffer();

    VRAMSystem__SetupBGBank(GX_VRAM_BG_64_E);
    VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_16_G, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x200);
    VRAMSystem__SetupBGExtPalBank(GX_VRAM_BGEXTPLTT_NONE);
    VRAMSystem__SetupOBJExtPalBank(GX_VRAM_OBJEXTPLTT_NONE);
    VRAMSystem__InitSpriteBuffer(GRAPHICS_ENGINE_A);

    VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_128_C);
    VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_128_D, GX_OBJVRAMMODE_CHAR_1D_128K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x400);
    VRAMSystem__SetupSubBGExtPalBank(GX_VRAM_SUB_BGEXTPLTT_0123_H);
    VRAMSystem__SetupSubOBJExtPalBank(GX_VRAM_SUB_OBJEXTPLTT_0_I);
    VRAMSystem__InitSpriteBuffer(GRAPHICS_ENGINE_B);
}

RUSH_INLINE u8 GetProgressForShipConstructed(s32 shipType)
{
    static const u8 progressTable[] = {
        SAVE_PROGRESS_2,  // SHIP_JET
        SAVE_PROGRESS_9,  // SHIP_BOAT
        SAVE_PROGRESS_22, // SHIP_HOVER
        SAVE_PROGRESS_26, // SHIP_SUBMARINE
        SAVE_PROGRESS_38, // SHIP_DRILL
    };

    return progressTable[shipType];
}

void HubControl::UpdateSaveProgressForShipConstructed(s32 shipType, BOOL unknown)
{
    u8 progress = GetProgressForShipConstructed(shipType);

    if (shipType == SHIP_JET)
        SaveGame__IncrementUnknown2ForUnknown();
    else
        SaveGame__SetGameProgress(progress);
}

BOOL HubControl::CheckShipConstructed(s32 shipType)
{
    if (shipType == SHIP_JET && SaveGame__GetGameProgress() == SAVE_PROGRESS_1 && SaveGame__GetUnknown2() >= 1)
        return TRUE;
    else
        return SaveGame__GetGameProgress() >= GetProgressForShipConstructed(shipType);
}

s32 HubControl::GetNextShipToBuild()
{
    static const u8 progressTable[5] = {
        SAVE_PROGRESS_1,  // SHIP_JET
        SAVE_PROGRESS_8,  // SHIP_BOAT
        SAVE_PROGRESS_21, // SHIP_HOVER
        SAVE_PROGRESS_25, // SHIP_SUBMARINE
        0xFF              // SHIP_DRILL (unused, condition is never valid)
    };

    u16 progress = SaveGame__GetGameProgress();

    for (s32 i = 0; i < SHIP_COUNT_DRILL; i++)
    {
        if (progressTable[i] == progress)
        {
            return i;
        }
    }

    return CViTalkPurchase::CONSTRUCT_INVALID;
}

BOOL HubControl::Func_215B51C(s32 a1)
{
    static const u8 progressTable[8] = {
        SAVE_PROGRESS_0, SAVE_PROGRESS_2, SAVE_PROGRESS_9, SAVE_PROGRESS_22, SAVE_PROGRESS_26, SAVE_PROGRESS_0, SAVE_PROGRESS_38, SAVE_PROGRESS_0
    };

    if (a1 == 0 && SaveGame__GetGameProgress() == SAVE_PROGRESS_0 && SaveGame__GetUnknown2() <= 6)
        return FALSE;

    if (a1 == 1 && SaveGame__GetGameProgress() == SAVE_PROGRESS_1 && SaveGame__GetUnknown2() >= 1)
        return TRUE;

    return SaveGame__GetGameProgress() >= progressTable[a1];
}

void HubControl::Func_215B588(s32 a1, s32 a2)
{
    if (a1 == 7)
    {
        SaveGame__SetGameProgress(SAVE_PROGRESS_17);
    }
    else
    {
        switch (a1)
        {
            case 5:
                SaveGame__SetBoughtDecoration(0);
                break;

            case 8:
                SaveGame__SetBoughtDecoration(1);
                break;

            case 17:
                SaveGame__SetBoughtDecoration(2);
                break;

            case 1:
                MissionHelpers__CompleteMission(MISSION_83);
                break;

            case 2:
                MissionHelpers__CompleteMission(MISSION_39);
                break;

            case 4:
                MissionHelpers__CompleteMission(MISSION_91);
                break;

            case 6:
                MissionHelpers__CompleteMission(MISSION_99);
                break;

            case 10:
                MissionHelpers__CompleteMission(MISSION_79);
                break;

            case 11:
                MissionHelpers__CompleteMission(MISSION_89);
                break;

            case 12:
                MissionHelpers__CompleteMission(MISSION_93);
                break;

            case 13:
                MissionHelpers__CompleteMission(MISSION_59);
                break;

            case 16:
                MissionHelpers__CompleteMission(MISSION_9);
                break;

            case 18:
                MissionHelpers__CompleteMission(MISSION_88);
                break;

            case 19:
                MissionHelpers__CompleteMission(MISSION_49);
                break;

            case 20:
                MissionHelpers__CompleteMission(MISSION_84);
                break;

            case 21:
                MissionHelpers__CompleteMission(MISSION_85);
                break;
        }
    }
}

BOOL HubControl::Func_215B6C4(s32 a1)
{
    switch (a1)
    {
        case 0:
            return TRUE;

        case 7:
            return SaveGame__GetGameProgress() >= SAVE_PROGRESS_17;

        case 3:
        case 14:
            return SaveGame__GetGameProgress() >= SAVE_PROGRESS_25;

        case 5:
            return SaveGame__GetBoughtDecoration(0);

        case 8:
            return SaveGame__GetBoughtDecoration(1);

        case 17:
            return SaveGame__GetBoughtDecoration(2);

        case 1:
        case 9:
            return MissionHelpers__CheckMissionCompleted(MISSION_83);

        case 2:
            return MissionHelpers__CheckMissionCompleted(MISSION_39);

        case 4:
            return MissionHelpers__CheckMissionCompleted(MISSION_91);

        case 10:
            return MissionHelpers__CheckMissionCompleted(MISSION_79);

        case 11:
            return MissionHelpers__CheckMissionCompleted(MISSION_89);

        case 12:
            return MissionHelpers__CheckMissionCompleted(MISSION_93);

        case 13:
            return MissionHelpers__CheckMissionCompleted(MISSION_59);

        case 15:
            if (MissionHelpers__CheckMissionCompleted(MISSION_88))
                return FALSE;
            return TRUE;

        case 18:
            return MissionHelpers__CheckMissionCompleted(MISSION_88);

        case 16:
            return MissionHelpers__CheckMissionCompleted(MISSION_9);

        case 19:
            return MissionHelpers__CheckMissionCompleted(MISSION_49);

        case 20:
            if (MissionHelpers__CheckMissionCompleted(MISSION_85))
                return FALSE;

            return MissionHelpers__CheckMissionCompleted(MISSION_84);

        case 21:
            return MissionHelpers__CheckMissionCompleted(MISSION_85);

        case 6:
            return MissionHelpers__CheckMissionCompleted(MISSION_99);
    }

    return FALSE;
}

BOOL HubControl::Func_215B850(s32 a1)
{
    return TRUE;
}

BOOL HubControl::Func_215B858(s32 type)
{
    const HubControlSaveUnknown *table = _0217362C[type];

    s32 i;
    u16 gameProgress;
    u16 unknownProgress1;
    u16 unknownProgress2;
    BOOL flag;

    gameProgress     = SaveGame__GetGameProgress();
    unknownProgress1 = SaveGame__GetUnknownProgress1();
    unknownProgress2 = SaveGame__GetUnknownProgress2();

    flag = FALSE;

    i = 0;
    while (TRUE)
    {
        if (gameProgress < table[i].gameProgress)
            break;

        if (type == 15 && table[i].gameProgress == SAVE_PROGRESS_24)
        {
            if (unknownProgress1 < 4)
            {
                break;
            }
        }
        else
        {
            if ((type == 17 || type == 19) && table[i].gameProgress == SAVE_PROGRESS_24 && unknownProgress2 < 2)
            {
                break;
            }
        }

        flag = table[i].flag;

        i++;
    }

    return flag != FALSE;
}

void HubControl::Func_215B8FC(u16 id)
{
    struct GameCutsceneState *cutscene = &gameState.cutscene;
    cutscene->cutsceneID               = id;
    cutscene->nextSysEvent             = SYSEVENT_RETURN_TO_HUB;
    cutscene->canSkip                  = TRUE;

    gameState.talk.state.field_DC = 4;
}

void HubControl::Func_215B92C(u16 id)
{
    struct GameCutsceneState *cutscene = &gameState.cutscene;
    cutscene->cutsceneID               = id;
    cutscene->nextSysEvent             = SYSEVENT_RETURN_TO_HUB;
    cutscene->canSkip                  = TRUE;

    gameState.talk.state.field_DC = 1;
}

void HubControl::Func_215B958()
{
    gameState.characterID[0] = CHARACTER_SONIC;
    gameState.gameMode       = GAMEMODE_STORY;
    gameState.stageID        = STAGE_TUTORIAL;
}

s32 HubControl::Func_215B978()
{
    s32 selection;

    u16 ship;
    u16 level;
    SaveGame__GetNextShipUpgrade(&ship, &level);
    switch (ship)
    {
        case SHIP_JET:
            selection = 0;
            break;

        case SHIP_BOAT:
            selection = 2;
            break;

        case SHIP_HOVER:
            selection = 4;
            break;

        case SHIP_SUBMARINE:
            selection = 6;
            break;
    }

    if (level == SHIP_LEVEL_2)
        selection++;

    return selection;
}