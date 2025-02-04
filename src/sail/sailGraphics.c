#include <sail/sailGraphics.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/vramSystem.h>
#include <game/object/objectManager.h>
#include <game/graphics/background.h>

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC void SailGraphics__SetupDisplay(void)
{
    // https://decomp.me/scratch/yaSmA -> 96.74%
#ifdef NON_MATCHING
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

    renderCoreSwapBuffer.sortMode   = GX_SORTMODE_MANUAL;
    renderCoreSwapBuffer.bufferMode = GX_BUFFERMODE_W;

    G3X_SetShading(GX_SHADING_TOON);
    G3X_AntiAlias(TRUE);
    G3X_AlphaTest(FALSE, 0);
    G3X_AlphaBlend(TRUE);
    G3X_EdgeMarking(FALSE);
    G3X_SetClearColor(GX_RGB_888(0x00, 0x00, 0xF8), GX_COLOR_FROM_888(0xF8), 0x7FFF, 0, TRUE);
    G3X_SetFog(FALSE, GX_FOGBLEND_COLOR_ALPHA, GX_FOGSLOPE_0x0200, 0);

    G3_SwapBuffers(renderCoreSwapBuffer.sortMode, renderCoreSwapBuffer.bufferMode);
    G3_ViewPort(0, 0, HW_LCD_WIDTH - 1, HW_LCD_HEIGHT - 1);

    G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x00000, GX_BG_EXTPLTT_01);
    G2_SetBG0Priority(1);
    G2_SetBG1Priority(0);

    GX_SetMasterBrightness(renderCoreGFXControlA.brightness = RENDERCORE_BRIGHTNESS_WHITE);
    GX_SetVisiblePlane(GX_PLANEMASK_BG0 | GX_PLANEMASK_BG1 | GX_PLANEMASK_OBJ);

    renderCoreGFXControlA.blendManager.blendControl.effect = BLENDTYPE_NONE;

    u16 vram1BaseA;
    u16 vram1BaseBlock;
    GetVRAMCharacterConfig(FALSE, BACKGROUND_1, &vram1BaseA, &vram1BaseBlock);
    
    void *vramOffsetA = VRAMSystem__VRAM_BG[GRAPHICS_ENGINE_A];
    MI_CpuClear16(vramOffsetA + ((vram1BaseA << 16) + (vram1BaseBlock << 14)), 0x4000);

    MappingsMode mappingsModeA;
    GetVRAMTileConfig(FALSE, BACKGROUND_1, &mappingsModeA, &vram1BaseA, &vram1BaseBlock);
    MI_CpuFill16(vramOffsetA + ((vram1BaseA << 16) + (vram1BaseBlock << 11)), 0x40, 0x800);

    VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_128_C);
    VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_16_I, GX_OBJVRAMMODE_CHAR_1D_64K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x100);

    GXS_SetGraphicsMode(GX_BGMODE_0);

    G2S_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x512, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0800, GX_BG_CHARBASE_0x10000, GX_BG_EXTPLTT_01);
    G2S_SetBG1Priority(0);
    G2S_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x1800, GX_BG_CHARBASE_0x18000);
    G2S_SetBG2Priority(1);
    G2S_SetBG3ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x08000);
    G2S_SetBG3Priority(2);

    GXS_SetVisiblePlane(GX_PLANEMASK_BG1 | GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3 | GX_PLANEMASK_OBJ);
    GXS_SetMasterBrightness(renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_WHITE);

    renderCoreGFXControlB.blendManager.blendControl.effect = BLENDTYPE_NONE;

    u16 vram2BaseA;
    u16 vram2BaseBlock;
    GetVRAMCharacterConfig(TRUE, BACKGROUND_1, &vram2BaseA, &vram2BaseBlock);
    
    void *vramOffsetB = VRAMSystem__VRAM_BG[GRAPHICS_ENGINE_B];
    MI_CpuClear16(vramOffsetB + ((vram2BaseA << 16) + (vram2BaseBlock << 14)), 0x820);

    MappingsMode mappingsModeB;
    GetVRAMTileConfig(TRUE, BACKGROUND_1, &mappingsModeB, &vram2BaseA, &vram2BaseBlock);
    MI_CpuFill16(vramOffsetB + ((vram2BaseA << 16) + (vram2BaseBlock << 11)), 0x40, 0x1000);

    GetVRAMCharacterConfig(TRUE, BACKGROUND_2, &vram2BaseA, &vram2BaseBlock);
    MI_CpuClear16(vramOffsetB + ((vram2BaseA << 16) + (vram2BaseBlock << 14)), 0x8000);

    GetVRAMTileConfig(TRUE, BACKGROUND_2, &mappingsModeB, &vram2BaseA, &vram2BaseBlock);
    MI_CpuFill16(vramOffsetB + ((vram2BaseA << 16) + (vram2BaseBlock << 11)), 0x4, 0x800);

    GetVRAMCharacterConfig(TRUE, BACKGROUND_3, &vram2BaseA, &vram2BaseBlock);
    MI_CpuClear16(vramOffsetB + ((vram2BaseA << 16) + (vram2BaseBlock << 14)), 0x8000);

    GetVRAMTileConfig(TRUE, BACKGROUND_3, &mappingsModeB, &vram2BaseA, &vram2BaseBlock);
    MI_CpuClear16(vramOffsetB + ((vram2BaseA << 16) + (vram2BaseBlock << 11)), 0x800);

    renderCoreGFXControlB.bgPosition[BACKGROUND_0].x = renderCoreGFXControlA.bgPosition[BACKGROUND_0].x = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_0].y = renderCoreGFXControlA.bgPosition[BACKGROUND_0].y = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_1].x = renderCoreGFXControlA.bgPosition[BACKGROUND_1].x = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_1].y = renderCoreGFXControlA.bgPosition[BACKGROUND_1].y = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_2].x = renderCoreGFXControlA.bgPosition[BACKGROUND_2].x = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_2].y = renderCoreGFXControlA.bgPosition[BACKGROUND_2].y = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_3].x = renderCoreGFXControlA.bgPosition[BACKGROUND_3].x = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_3].y = renderCoreGFXControlA.bgPosition[BACKGROUND_3].y = 0;
#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	ldr r4, =0x04000304
	ldr r0, =0xFFFFFDF1
	ldrh r3, [r4, #0]
	ldr r1, =renderCurrentDisplay
	mov r2, #0
	and r0, r3, r0
	orr r0, r0, #0xe
	orr r0, r0, #0x200
	strh r0, [r4]
	str r2, [r1]
	bl GX_DisableBankForBG
	bl GX_DisableBankForOBJ
	bl GX_DisableBankForBGExtPltt
	bl GX_DisableBankForOBJExtPltt
	bl GX_DisableBankForTex
	bl GX_DisableBankForTexPltt
	bl GX_DisableBankForClearImage
	bl GX_DisableBankForSubBG
	bl GX_DisableBankForSubOBJ
	bl GX_DisableBankForSubBGExtPltt
	bl GX_DisableBankForSubOBJExtPltt
	bl GX_DisableBankForARM7
	bl GX_DisableBankForLCDC
	mov r0, #0x400
	str r0, [sp]
	mov r0, #0x10
	add r1, r0, #0x100000
	mov r2, #0x40
	mov r3, #0
	bl VRAMSystem__SetupOBJBank
	mov r0, #0
	bl VRAMSystem__InitSpriteBuffer
	mov r0, #0x40
	bl VRAMSystem__SetupBGBank
	mov r0, #0xb
	bl VRAMSystem__SetupTextureBank
	mov r0, #0x20
	bl VRAMSystem__SetupTexturePalBank
	bl VRAMSystem__InitTextureBuffer
	bl VRAMSystem__InitPaletteBuffer
	mov r0, #1
	mov r1, #0
	mov r2, r0
	bl GX_SetGraphicsMode
	mov lr, #0x4000000
	ldr r0, [lr]
	mov r3, #0
	bic r0, r0, #0x38000000
	str r0, [lr]
	ldr r1, [lr]
	ldr r0, =renderCoreSwapBuffer
	bic r1, r1, #0x7000000
	str r1, [lr]
	mov ip, #1
	str ip, [r0, #4]
	str ip, [r0, #8]
	ldrh r0, [lr, #0x60]
	ldr r1, =0xFFFFCFFD
	and r0, r0, r1
	strh r0, [lr, #0x60]
	ldrh r0, [lr, #0x60]
	bic r0, r0, #0x3000
	orr r0, r0, #0x10
	strh r0, [lr, #0x60]
	ldrh r4, [lr, #0x60]
	ldr r0, =0x0000CFFB
	mov r2, r1, lsr #0x11
	and r1, r4, r0
	strh r1, [lr, #0x60]
	ldrh r1, [lr, #0x60]
	sub r4, r0, #0x1c
	mov r0, #0x7c00
	bic r1, r1, #0x3000
	orr r1, r1, #8
	strh r1, [lr, #0x60]
	ldrh r5, [lr, #0x60]
	mov r1, #0x1f
	and r4, r5, r4
	strh r4, [lr, #0x60]
	str ip, [sp]
	bl G3X_SetClearColor
	mov r0, #0
	mov r1, r0
	mov r3, r0
	mov r2, #6
	bl G3X_SetFog
	ldr r0, =renderCoreSwapBuffer
	ldr r4, =0x0400000A
	ldr r2, [r0, #8]
	ldr r0, [r0, #4]
	ldr r1, =0x04000540
	orr r2, r0, r2, lsl #1
	str r2, [r1]
	ldr r0, =0xBFFF0000
	sub r3, r4, #2
	str r0, [r1, #0x40]
	ldrh r0, [r4, #0]
	ldr r2, =renderCoreGFXControlA
	mov r1, #0x10
	and r0, r0, #0x43
	strh r0, [r4]
	ldrh r0, [r3, #0]
	bic r0, r0, #3
	orr r0, r0, #1
	strh r0, [r3]
	ldrh r3, [r4, #0]
	add r0, r4, #0x62
	bic r3, r3, #3
	strh r3, [r4]
	strh r1, [r2, #0x58]
	bl GXx_SetMasterBrightness_
	mov r1, #0x4000000
	ldr r0, [r1, #0]
	ldr r2, =renderCoreGFXControlA
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1300
	str r0, [r1]
	ldrh r3, [r2, #0x20]
	mov r0, #0
	mov r1, #1
	bic r3, r3, #0xc0
	strh r3, [r2, #0x20]
	add r2, sp, #0xa
	add r3, sp, #8
	bl GetVRAMCharacterConfig
	ldr r1, =VRAMSystem__VRAM_BG
	ldrh r3, [sp, #0xa]
	ldr r4, [r1, #0]
	ldrh r1, [sp, #8]
	mov r0, #0
	mov r2, #0x4000
	mov r1, r1, lsl #0xe
	add r1, r1, r3, lsl #16
	add r1, r4, r1
	bl MIi_CpuClear16
	add r0, sp, #8
	str r0, [sp]
	add r2, sp, #0x10
	add r3, sp, #0xa
	mov r0, #0
	mov r1, #1
	bl GetVRAMTileConfig
	ldrh r1, [sp, #8]
	ldrh r2, [sp, #0xa]
	mov r0, #0x40
	mov r1, r1, lsl #0xb
	add r1, r1, r2, lsl #16
	add r1, r4, r1
	mov r2, #0x800
	bl MIi_CpuClear16
	mov r0, #4
	bl VRAMSystem__SetupSubBGBank
	mov r0, #0x100
	ldr r1, =0x00100010
	mov r2, #0x40
	mov r3, #0
	str r0, [sp]
	bl VRAMSystem__SetupSubOBJBank
	mov r0, #0
	bl GXS_SetGraphicsMode
	ldr r2, =0x0400100A
	ldr r3, =renderCoreGFXControlB
	ldrh r0, [r2, #0]
	sub r4, r2, #0xa
	mov r1, #0x10
	and r0, r0, #0x43
	orr r0, r0, #0x110
	orr r0, r0, #0x8000
	strh r0, [r2]
	ldrh ip, [r2]
	add r0, r2, #0x62
	bic ip, ip, #3
	strh ip, [r2]
	ldrh ip, [r2, #2]
	and ip, ip, #0x43
	orr ip, ip, #0x318
	strh ip, [r2, #2]
	ldrh ip, [r2, #2]
	bic ip, ip, #3
	orr ip, ip, #1
	strh ip, [r2, #2]
	ldrh ip, [r2, #4]
	and ip, ip, #0x43
	orr ip, ip, #8
	strh ip, [r2, #4]
	ldrh ip, [r2, #4]
	bic ip, ip, #3
	orr ip, ip, #2
	strh ip, [r2, #4]
	ldr r2, [r4, #0]
	bic r2, r2, #0x1f00
	orr r2, r2, #0x1e00
	str r2, [r4]
	strh r1, [r3, #0x58]
	bl GXx_SetMasterBrightness_
	ldr r3, =renderCoreGFXControlB
	mov r0, #1
	ldrh r4, [r3, #0x20]
	mov r1, r0
	add r2, sp, #6
	bic r4, r4, #0xc0
	strh r4, [r3, #0x20]
	add r3, sp, #4
	bl GetVRAMCharacterConfig
	ldrh r1, [sp, #4]
	ldr r0, =VRAMSystem__VRAM_BG
	ldrh r2, [sp, #6]
	mov r1, r1, lsl #0xe
	ldr r4, [r0, #4]
	add r0, r1, r2, lsl #16
	add r1, r4, r0
	mov r0, #0
	mov r2, #0x820
	bl MIi_CpuClear16
	add ip, sp, #4
	mov r0, #1
	add r2, sp, #0xc
	add r3, sp, #6
	mov r1, r0
	str ip, [sp]
	bl GetVRAMTileConfig
	ldrh r1, [sp, #4]
	ldrh r2, [sp, #6]
	mov r0, #0x40
	mov r1, r1, lsl #0xb
	add r1, r1, r2, lsl #16
	add r1, r4, r1
	mov r2, #0x1000
	bl MIi_CpuClear16
	add r2, sp, #6
	mov r0, #1
	mov r1, #2
	add r3, sp, #4
	bl GetVRAMCharacterConfig
	ldrh r1, [sp, #4]
	ldrh r3, [sp, #6]
	mov r0, #0
	mov r1, r1, lsl #0xe
	add r1, r1, r3, lsl #16
	mov r2, #0x8000
	add r1, r4, r1
	bl MIi_CpuClear16
	add r1, sp, #4
	str r1, [sp]
	mov r0, #1
	mov r1, #2
	add r2, sp, #0xc
	add r3, sp, #6
	bl GetVRAMTileConfig
	ldrh r1, [sp, #4]
	ldrh r3, [sp, #6]
	mov r0, #4
	mov r1, r1, lsl #0xb
	add r1, r1, r3, lsl #16
	mov r2, #0x800
	add r1, r4, r1
	bl MIi_CpuClear16
	mov r0, #1
	mov r1, #3
	add r2, sp, #6
	add r3, sp, #4
	bl GetVRAMCharacterConfig
	ldrh r1, [sp, #4]
	ldrh r3, [sp, #6]
	mov r0, #0
	mov r1, r1, lsl #0xe
	add r1, r1, r3, lsl #16
	mov r2, #0x8000
	add r1, r4, r1
	bl MIi_CpuClear16
	add r0, sp, #4
	str r0, [sp]
	add r2, sp, #0xc
	add r3, sp, #6
	mov r0, #1
	mov r1, #3
	bl GetVRAMTileConfig
	ldrh r1, [sp, #4]
	ldrh r2, [sp, #6]
	mov r0, #0
	mov r1, r1, lsl #0xb
	add r1, r1, r2, lsl #16
	add r1, r4, r1
	mov r2, #0x800
	bl MIi_CpuClear16
	ldr r1, =renderCoreGFXControlA
	mov r2, #0
	ldr r0, =renderCoreGFXControlB
	strh r2, [r1]
	strh r2, [r0]
	strh r2, [r1, #2]
	strh r2, [r0, #2]
	strh r2, [r1, #4]
	strh r2, [r0, #4]
	strh r2, [r1, #6]
	strh r2, [r0, #6]
	strh r2, [r1, #8]
	strh r2, [r0, #8]
	strh r2, [r1, #0xa]
	strh r2, [r0, #0xa]
	strh r2, [r1, #0xc]
	strh r2, [r0, #0xc]
	strh r2, [r1, #0xe]
	strh r2, [r0, #0xe]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

void SailGraphics__SetupLights(void)
{
    NNS_G3dGlbLightColor(GX_LIGHTID_0, GX_RGB_888(0xF8, 0xF8, 0xF8));
    NNS_G3dGlbLightColor(GX_LIGHTID_1, GX_RGB_888(0x88, 0x88, 0x88));
    NNS_G3dGlbLightColor(GX_LIGHTID_2, GX_RGB_888(0x40, 0x40, 0x40));

    NNS_G3dGlbLightVector(GX_LIGHTID_0, -FLOAT_TO_FX32(0.5774), -FLOAT_TO_FX32(0.5774), -FLOAT_TO_FX32(0.5774));
    NNS_G3dGlbLightVector(GX_LIGHTID_1, FLOAT_TO_FX32(0.5774), FLOAT_TO_FX32(0.5774), FLOAT_TO_FX32(0.5774));
    NNS_G3dGlbLightVector(GX_LIGHTID_2, FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0));

    g_obj.lightCount = 3;

    VEC_Fx16Set(&g_obj.lightDirs[0], -FLOAT_TO_FX32(0.5774), -FLOAT_TO_FX32(0.5774), -FLOAT_TO_FX32(0.5774));
    VEC_Fx16Set(&g_obj.lightDirs[1], FLOAT_TO_FX32(0.5774), FLOAT_TO_FX32(0.5774), FLOAT_TO_FX32(0.5774));
    VEC_Fx16Set(&g_obj.lightDirs[2], FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0));
    VEC_Fx16Set(&g_obj.lightDirs[3], FLOAT_TO_FX32(0.9999), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0));
}