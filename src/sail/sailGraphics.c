#include <sail/sailGraphics.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/vramSystem.h>
#include <game/object/objectManager.h>

// --------------------
// FUNCTIONS
// --------------------

void SailGraphics__SetupDisplay(void)
{
    GX_SetPower(GX_POWER_ALL);
    renderCurrentDisplay = GX_DISP_SELECT_SUB_MAIN;

    GX_DisableBankForBG();
    GX_DisableBankForOBJ();
    GX_DisableBankForBGExtPltt();
    GX_DisableBankForOBJExtPltt();
    GX_DisableBankForTex();
    GX_DisableBankForTexPltt();
    GX_DisableBankForClearImage();
    GX_DisableBankForSubBG();
    GX_DisableBankForSubOBJ();
    GX_DisableBankForSubBGExtPltt();
    GX_DisableBankForSubOBJExtPltt();
    GX_DisableBankForARM7();
    GX_DisableBankForLCDC();

    VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_64_E, GX_OBJVRAMMODE_CHAR_1D_64K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 1024);
    VRAMSystem__InitSpriteBuffer(FALSE);
    VRAMSystem__SetupBGBank(GX_VRAM_BG_16_G);
    VRAMSystem__SetupTextureBank(GX_VRAM_TEX_012_ABD);
    VRAMSystem__SetupTexturePalBank(GX_VRAM_TEXPLTT_0_F);
    VRAMSystem__InitTextureBuffer();
    VRAMSystem__InitPaletteBuffer();

    GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_0, GX_BG0_AS_3D);
    GX_SetBGScrOffset(GX_BGSCROFFSET_0x00000);
    GX_SetBGCharOffset(GX_BGCHAROFFSET_0x00000);

    renderCoreSwapBuffer.sortMode = GX_SORTMODE_MANUAL;
    renderCoreSwapBuffer.bufferMode = GX_BUFFERMODE_W;

    G3X_SetShading(GX_SHADING_TOON);
    G3X_AntiAlias(TRUE);
    G3X_AlphaTest(FALSE, 0);
    G3X_AlphaBlend(TRUE);
    G3X_EdgeMarking(TRUE);
    G3X_SetClearColor(GX_RGB_888(0x00, 0x00, 0xF8), GX_COLOR_FROM_888(0xF8), 0x7FFF, 0, TRUE);
    G3X_SetFog(TRUE, GX_FOGBLEND_COLOR_ALPHA, GX_FOGSLOPE_0x0200, 0);

    G3_SwapBuffers(renderCoreSwapBuffer.sortMode, renderCoreSwapBuffer.bufferMode);
    G3_ViewPort(0, 0, HW_LCD_WIDTH - 1, HW_LCD_HEIGHT - 1);

    G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x00000, GX_BG_EXTPLTT_01);
    G2_SetBG0Priority(1);
    G2_SetBG1Priority(0);

    GX_SetMasterBrightness(renderCoreGFXControlA.brightness = RENDERCORE_BRIGHTNESS_WHITE);
    GX_SetVisiblePlane(GX_PLANEMASK_BG0 | GX_PLANEMASK_BG1 | GX_PLANEMASK_OBJ);

    renderCoreGFXControlA.blendManager.blendControl.effect &= ~BLENDTYPE_FADEOUT;

    u16 vram1BaseA;
    u16 vram1BaseBlock;
    GetVRAMCharacterConfig(FALSE, BACKGROUND_1, &vram1BaseA, &vram1BaseBlock);
    MI_CpuClear16(VRAMSystem__VRAM_BG[GRAPHICS_ENGINE_A] + ((vram1BaseBlock << 14) + (vram1BaseA << 16)), 0x4000);

    MappingsMode mappingsModeA; 
    GetVRAMTileConfig(FALSE, BACKGROUND_1, &mappingsModeA, &vram1BaseA, &vram1BaseBlock);
    MI_CpuFill16(VRAMSystem__VRAM_BG[GRAPHICS_ENGINE_A] + ((vram1BaseBlock << 11) + (vram1BaseA << 16)), 0x40, 0x800);

    VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_128_C);
    VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_16_I, GX_OBJVRAMMODE_CHAR_1D_64K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x100);

    GXS_SetGraphicsMode(GX_BGMODE_0);

    G2S_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x512, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0800, GX_BG_CHARBASE_0x10000, GX_BG_EXTPLTT_01);
    G2S_SetBG1Priority(0);
    G2S_SetBG2Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x1800, GX_BG_CHARBASE_0x18000, GX_BG_EXTPLTT_01);
    G2S_SetBG2Priority(1);
    G2S_SetBG3Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x08000, GX_BG_EXTPLTT_01);
    G2S_SetBG3Priority(2);

    GXS_SetMasterBrightness(renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_WHITE);
    GXS_SetVisiblePlane(GX_PLANEMASK_BG1 | GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3 | GX_PLANEMASK_OBJ);

    renderCoreGFXControlB.blendManager.blendControl.effect &= ~BLENDTYPE_FADEOUT;

    u16 vram2BaseBlock;
    u16 vram2BaseA;
    GetVRAMCharacterConfig(TRUE, BACKGROUND_1, &vram2BaseA, &vram2BaseBlock);
    MI_CpuClear16(VRAMSystem__VRAM_BG[GRAPHICS_ENGINE_B] + ((vram2BaseBlock << 14) + (vram2BaseA << 16)), 0x820);

    MappingsMode mappingsModeB; 
    GetVRAMTileConfig(TRUE, BACKGROUND_1, &mappingsModeB, &vram2BaseA, &vram2BaseBlock);
    MI_CpuFill16(VRAMSystem__VRAM_BG[GRAPHICS_ENGINE_B] + ((vram2BaseBlock << 11) + (vram2BaseA << 16)), 0x40, 0x1000);

    GetVRAMCharacterConfig(TRUE, BACKGROUND_2, &vram2BaseA, &vram2BaseBlock);
    MI_CpuClear16(VRAMSystem__VRAM_BG[GRAPHICS_ENGINE_B] + ((vram2BaseBlock << 14) + (vram2BaseA << 16)), 0x8000);

    GetVRAMTileConfig(TRUE, BACKGROUND_2, &mappingsModeB, &vram2BaseA, &vram2BaseBlock);
    MI_CpuFill16(VRAMSystem__VRAM_BG[GRAPHICS_ENGINE_B] + ((vram2BaseBlock << 11) + (vram2BaseA << 16)), 0x40, 0x800);

    GetVRAMCharacterConfig(TRUE, BACKGROUND_3, &vram2BaseA, &vram2BaseBlock);
    MI_CpuClear16(VRAMSystem__VRAM_BG[GRAPHICS_ENGINE_B] + ((vram2BaseBlock << 14) + (vram2BaseA << 16)), 0x8000);

    GetVRAMTileConfig(TRUE, BACKGROUND_3, &mappingsModeB, &vram2BaseA, &vram2BaseBlock);
    MI_CpuFill16(VRAMSystem__VRAM_BG[GRAPHICS_ENGINE_B] + ((vram2BaseBlock << 11) + (vram2BaseA << 16)), 0x40, 0x800);

    renderCoreGFXControlA.bgPosition[0].x = renderCoreGFXControlA.bgPosition[1].x = renderCoreGFXControlA.bgPosition[2].x = renderCoreGFXControlA.bgPosition[3].x = 0;
    renderCoreGFXControlB.bgPosition[0].y = renderCoreGFXControlB.bgPosition[1].y = renderCoreGFXControlB.bgPosition[2].y = renderCoreGFXControlB.bgPosition[3].y = 0;
}

void SailGraphics__SetupLights(void)
{
    NNS_G3dGlbLightColor(GX_LIGHTID_0, GX_RGB_888(0xF8, 0xF8, 0xF8));
    NNS_G3dGlbLightColor(GX_LIGHTID_1, GX_RGB_888(0x88, 0x88, 0x88));
    NNS_G3dGlbLightColor(GX_LIGHTID_2, GX_RGB_888(0x40, 0x40, 0x40));

    NNS_G3dGlbLightVector(GX_LIGHTID_0, -0xF6C3, -0xF6C3, -0xF6C3);
    NNS_G3dGlbLightVector(GX_LIGHTID_1, 0x93D, 0x93D, 0x93D);
    NNS_G3dGlbLightVector(GX_LIGHTID_2, 0, -0x1000, 0);

    g_obj.lightCount = 3;

    g_obj.lightDirs[0].x = g_obj.lightDirs[0].y = g_obj.lightDirs[0].z = -0x93D;
    g_obj.lightDirs[1].x = g_obj.lightDirs[1].y = g_obj.lightDirs[1].z = 0x93D;
    g_obj.lightDirs[2].x = 0;
    g_obj.lightDirs[2].y = -0x1000;
    g_obj.lightDirs[2].z = 0;
    g_obj.lightDirs[3].x = 0xFFF;
    g_obj.lightDirs[3].y = g_obj.lightDirs[3].z = 0;
}