#include <game/graphics/swapBuffer3D.h>
#include <game/graphics/vramSystem.h>
#include <game/graphics/oamSystem.h>
#include <game/graphics/pixelsQueue.h>
#include <game/graphics/mappingsQueue.h>
#include <game/graphics/paletteQueue.h>
#include <game/graphics/background.h>

// --------------------
// ENUMS
// --------------------

enum SwapBuffer3DInitMode_
{
    SWAPBUFFER3D_MODE_PAUSED  = -1,
    SWAPBUFFER3D_MODE_IDLE    = 0,
    SWAPBUFFER3D_MODE_REGULAR = 1,
};
typedef s32 SwapBuffer3DInitMode;

// --------------------
// STRUCTS
// --------------------

typedef struct DisableSwapBuffersTask_
{
    BOOL swapBuffersDisabled;
} DisableSwapBuffersTask;

// --------------------
// VARIABLES
// --------------------

static Task *sSysPauseTask;
static Task *sSwapBuffer3D;
static SwapBuffer3DPrimaryScreen sPrimary3DScreen;
static SwapBuffer3DInitMode sSwapBuffer3DMode;

// --------------------
// FUNCTION DECLS
// --------------------

// SysPause (Part 2)
static void SysPause_Main_Init(void);
static void SysPause_Main_Active(void);
static void SysPause_Func_207FC10(BOOL useEngineB);

// DisableSwapBuffersTask
static void CreateDisableSwapBuffersTask(BOOL swapBuffersDisabled);
static void DisableSwapBuffersTask_Main(void);

// Asset3DSetup
static void Asset3DSetup_Main(void);

// SwapBuffer3D (Part 2)
static void SwapBuffer3D_Main(void);
static void SwapBuffer3D_InitOAM(void);
static void SwapBuffer3D_VBlankCallback(void);
static void SwapBuffer3D_Use3DOnTopScreen(void);
static void SwapBuffer3D_Use3DOnBottomScreen(void);

// --------------------
// FUNCTIONS
// --------------------

// SysPause
void InitDrawReqSystem(void)
{
    sSysPauseTask = NULL;
    sSwapBuffer3D = NULL;
}

void GetVRAMPaletteConfig(BOOL useEngineB, u8 bgID, PaletteMode *paletteMode, void **palettePtr)
{
    u32 displayControl = *(u32 *)VRAMSystem__DisplayControllers[useEngineB];
    u32 mode           = 0;

    switch (displayControl & REG_GX_DISPCNT_BGMODE_MASK)
    {
        case GX_BGMODE_0:
            mode = 0;
            break;

        case GX_BGMODE_1:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                case BACKGROUND_2:
                    mode = 0;
                    break;

                case BACKGROUND_3:
                    mode = 2;
                    break;
            }
            break;

        case GX_BGMODE_2:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                    mode = 0;
                    break;

                case BACKGROUND_2:
                case BACKGROUND_3:
                    mode = 2;
                    break;
            }
            break;

        case GX_BGMODE_3:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                case BACKGROUND_2:
                    mode = 0;
                    break;

                case BACKGROUND_3:
                    mode = 1;
                    break;
            }
            break;

        case GX_BGMODE_4:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                    mode = 0;
                    break;

                case BACKGROUND_2:
                    mode = 2;
                    break;

                case BACKGROUND_3:
                    mode = 1;
                    break;
            }
            break;

        case GX_BGMODE_5:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                    mode = 0;
                    break;

                case BACKGROUND_2:
                case BACKGROUND_3:
                    mode = 1;
                    break;
            }
            break;
    }

    BOOL use256Colors = FALSE;
    u32 bgControl     = *(u16 *)VRAMSystem__BGControllers[useEngineB][bgID];

    switch (mode)
    {
        case 0:
            if ((bgControl & REG_G2_BG0CNT_COLORMODE_MASK) != 0 && (displayControl & REG_GX_DISPCNT_BG_MASK) != 0)
            {
                use256Colors = TRUE;
            }
            break;

        case 1:
            if ((displayControl & REG_GX_DISPCNT_BG_MASK) != 0 && (bgControl & REG_G2_BG0CNT_COLORMODE_MASK) == 0)
            {
                use256Colors = TRUE;
            }
            break;
    }

    if (use256Colors)
    {
        if (useEngineB == GRAPHICS_ENGINE_A)
            mode = PALETTE_MODE_BG;
        else
            mode = PALETTE_MODE_SUB_BG;

        *paletteMode = mode;
        *palettePtr  = NULL;
        if (bgID == BACKGROUND_0)
        {
            bgControl = *(u16 *)VRAMSystem__BGControllers[useEngineB][BACKGROUND_0];
            *palettePtr += (bgControl & REG_G2_BG0CNT_BGPLTTSLOT_MASK) != 0 ? 0x4000 : 0x0000;
        }
        else if (bgID == BACKGROUND_1)
        {
            bgControl = *(u16 *)VRAMSystem__BGControllers[useEngineB][BACKGROUND_1];
            *palettePtr += (bgControl & REG_G2_BG1CNT_BGPLTTSLOT_MASK) != 0 ? 0x6000 : 0x2000;
        }
        else
        {
            *palettePtr += bgID << 13;
        }
    }
    else
    {
        void *vramPalette = VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_BG[useEngineB]);

        *paletteMode = PALETTE_MODE_SPRITE;
        *palettePtr  = vramPalette;
    }
}

void GetVRAMCharacterConfig(BOOL useEngineB, u8 bgID, u16 *characterBaseA, u16 *characterBaseBlock)
{
    *characterBaseA = 0;
    if (!useEngineB)
        *characterBaseA = GX_GetBGCharOffset();

    *characterBaseBlock = (*(u16 *)VRAMSystem__BGControllers[useEngineB][bgID] & REG_G2_BG0CNT_CHARBASE_MASK) >> REG_G2_BG0CNT_CHARBASE_SHIFT;
}

void GetVRAMTileConfig(BOOL useEngineB, u8 bgID, s32 *mappingsMode, u16 *screenBaseA, u16 *screenBaseBlock)
{
    u16 bgControl = *(u16 *)VRAMSystem__BGControllers[useEngineB][bgID];

    *screenBaseA = GX_BGSCROFFSET_0x00000;
    if (!useEngineB)
        *screenBaseA = (reg_GX_DISPCNT & REG_GX_DISPCNT_BGSCREENOFFSET_MASK) >> REG_GX_DISPCNT_BGSCREENOFFSET_SHIFT; // GX_GetBGScrOffset

    *screenBaseBlock = (bgControl & REG_G2_BG0CNT_SCREENBASE_MASK) >> REG_G2_BG0CNT_SCREENBASE_SHIFT; // G2_GetBG0ScrPtr

    switch (*((u32 *)(size_t)VRAMSystem__DisplayControllers[useEngineB]) & REG_GX_DISPCNT_BGMODE_MASK)
    {
        case GX_BGMODE_0:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                case BACKGROUND_2:
                case BACKGROUND_3:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_TEXT_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x256_A : MAPPINGS_MODE_TEXT_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x256_A : MAPPINGS_MODE_TEXT_512x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_256x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x512_A : MAPPINGS_MODE_TEXT_256x512_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x512_A : MAPPINGS_MODE_TEXT_512x512_B;
                            break;
                    }
                    break;
            }
            break;

        case GX_BGMODE_1:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                case BACKGROUND_2:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_TEXT_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x256_A : MAPPINGS_MODE_TEXT_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x256_A : MAPPINGS_MODE_TEXT_512x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_256x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x512_A : MAPPINGS_MODE_TEXT_256x512_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x512_A : MAPPINGS_MODE_TEXT_512x512_B;
                            break;
                    }
                    break;

                case BACKGROUND_3:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_AFFINE_128x128:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_128x128_A : MAPPINGS_MODE_AFFINE_128x128_B;
                            break;

                        case GX_BG_SCRSIZE_AFFINE_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_256x256_A : MAPPINGS_MODE_AFFINE_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_AFFINE_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_512x512_A : MAPPINGS_MODE_AFFINE_512x512_B;
                            break;

                        case GX_BG_SCRSIZE_AFFINE_1024x1024:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_1024x1024_A : MAPPINGS_MODE_AFFINE_1024x1024_B;
                            break;
                    }
                    break;
            }
            break;

        case GX_BGMODE_2:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_TEXT_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x256_A : MAPPINGS_MODE_TEXT_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x256_A : MAPPINGS_MODE_TEXT_512x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_256x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x512_A : MAPPINGS_MODE_TEXT_256x512_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x512_A : MAPPINGS_MODE_TEXT_512x512_B;
                            break;
                    }
                    break;

                case BACKGROUND_2:
                case BACKGROUND_3:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_AFFINE_128x128:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_128x128_A : MAPPINGS_MODE_AFFINE_128x128_B;
                            break;

                        case GX_BG_SCRSIZE_AFFINE_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_256x256_A : MAPPINGS_MODE_AFFINE_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_AFFINE_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_512x512_A : MAPPINGS_MODE_AFFINE_512x512_B;
                            break;

                        case GX_BG_SCRSIZE_AFFINE_1024x1024:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_1024x1024_A : MAPPINGS_MODE_AFFINE_1024x1024_B;
                            break;
                    }
                    break;
            }
            break;

        case GX_BGMODE_3:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                case BACKGROUND_2:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_TEXT_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x256_A : MAPPINGS_MODE_TEXT_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x256_A : MAPPINGS_MODE_TEXT_512x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_256x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x512_A : MAPPINGS_MODE_TEXT_256x512_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x512_A : MAPPINGS_MODE_TEXT_512x512_B;
                            break;
                    }
                    break;

                case BACKGROUND_3:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_256x16PLTT_128x128:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_128x128_A : MAPPINGS_MODE_256x16PLTT_128x128_B;
                            break;

                        case GX_BG_SCRSIZE_256x16PLTT_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_256x256_A : MAPPINGS_MODE_256x16PLTT_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_256x16PLTT_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_512x512_A : MAPPINGS_MODE_256x16PLTT_512x512_B;
                            break;

                        case GX_BG_SCRSIZE_256x16PLTT_1024x1024:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_1024x1024_A : MAPPINGS_MODE_256x16PLTT_1024x1024_B;
                            break;
                    }
                    break;
            }
            break;

        case GX_BGMODE_4:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_TEXT_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x256_A : MAPPINGS_MODE_TEXT_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x256_A : MAPPINGS_MODE_TEXT_512x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_256x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x512_A : MAPPINGS_MODE_TEXT_256x512_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x512_A : MAPPINGS_MODE_TEXT_512x512_B;
                            break;
                    }
                    break;

                case BACKGROUND_2:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_AFFINE_128x128:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_128x128_A : MAPPINGS_MODE_AFFINE_128x128_B;
                            break;

                        case GX_BG_SCRSIZE_AFFINE_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_256x256_A : MAPPINGS_MODE_AFFINE_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_AFFINE_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_512x512_A : MAPPINGS_MODE_AFFINE_512x512_B;
                            break;

                        case GX_BG_SCRSIZE_AFFINE_1024x1024:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_1024x1024_A : MAPPINGS_MODE_AFFINE_1024x1024_B;
                            break;
                    }
                    break;

                case BACKGROUND_3:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_256x16PLTT_128x128:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_128x128_A : MAPPINGS_MODE_256x16PLTT_128x128_B;
                            break;

                        case GX_BG_SCRSIZE_256x16PLTT_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_256x256_A : MAPPINGS_MODE_256x16PLTT_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_256x16PLTT_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_512x512_A : MAPPINGS_MODE_256x16PLTT_512x512_B;
                            break;

                        case GX_BG_SCRSIZE_256x16PLTT_1024x1024:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_1024x1024_A : MAPPINGS_MODE_256x16PLTT_1024x1024_B;
                            break;
                    }
                    break;
            }
            break;

        case GX_BGMODE_5:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_TEXT_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x256_A : MAPPINGS_MODE_TEXT_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x256_A : MAPPINGS_MODE_TEXT_512x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_256x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x512_A : MAPPINGS_MODE_TEXT_256x512_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x512_A : MAPPINGS_MODE_TEXT_512x512_B;
                            break;
                    }
                    break;

                case BACKGROUND_2:
                case BACKGROUND_3:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_256x16PLTT_128x128:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_128x128_A : MAPPINGS_MODE_256x16PLTT_128x128_B;
                            break;

                        case GX_BG_SCRSIZE_256x16PLTT_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_256x256_A : MAPPINGS_MODE_256x16PLTT_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_256x16PLTT_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_512x512_A : MAPPINGS_MODE_256x16PLTT_512x512_B;
                            break;

                        case GX_BG_SCRSIZE_256x16PLTT_1024x1024:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_1024x1024_A : MAPPINGS_MODE_256x16PLTT_1024x1024_B;
                            break;
                    }
                    break;
            }
            break;
    }
}

void GetVRAMPixelConfig(BOOL useEngineB, u8 bgID, PixelMode *pixelMode, u16 *screenBaseBlock)
{
#define bg3_256ColorChar04000 ((GX_BG_COLORMODE_256 << REG_G2_BG3CNT_COLORMODE_SHIFT) | (GX_BG_CHARBASE_0x04000 << REG_G2_BG3CNT_CHARBASE_SHIFT))

    s32 bgControl = *(u16 *)VRAMSystem__BGControllers[useEngineB][bgID];
    u32 *disp     = (u32 *)VRAMSystem__DisplayControllers[useEngineB];

    *screenBaseBlock = (bgControl & REG_G2_BG0CNT_SCREENBASE_MASK) >> REG_G2_BG0CNT_SCREENBASE_SHIFT; // G2_GetBG0ScrPtr

    switch (*disp & REG_GX_DISPCNT_BGMODE_MASK)
    {
        case GX_BGMODE_3:
        case GX_BGMODE_4:
            switch (bgID)
            {
                case BACKGROUND_3:
                    if ((bgControl & bg3_256ColorChar04000) == bg3_256ColorChar04000)
                    {
                        switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                        {
                            case GX_BG_SCRSIZE_AFFINE_128x128:
                                *pixelMode = PIXEL_MODE_BG_DCBMP_128x128;
                                break;

                            case GX_BG_SCRSIZE_AFFINE_256x256:
                                *pixelMode = PIXEL_MODE_BG_DCBMP_256x256;
                                break;

                            case GX_BG_SCRSIZE_AFFINE_512x512:
                                *pixelMode = PIXEL_MODE_BG_DCBMP_512x256;
                                break;

                            case GX_BG_SCRSIZE_AFFINE_1024x1024:
                                *pixelMode = PIXEL_MODE_BG_DCBMP_512x512;
                                break;

                            default:
                                break;
                        }
                    }
                    else
                    {
                        switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                        {
                            case GX_BG_SCRSIZE_TEXT_256x256:
                                *pixelMode = PIXEL_MODE_BG_TEXT_256x256;
                                break;

                            case GX_BG_SCRSIZE_TEXT_512x256:
                                *pixelMode = PIXEL_MODE_BG_TEXT_512x256;
                                break;

                            case GX_BG_SCRSIZE_TEXT_256x512:
                                *pixelMode = PIXEL_MODE_BG_TEXT_256x512;
                                break;

                            case GX_BG_SCRSIZE_TEXT_512x512:
                                *pixelMode = PIXEL_MODE_BG_TEXT_512x512;
                                break;

                            default:
                                break;
                        }
                    }
                    break;
            }
            break;

        case GX_BGMODE_5:
            switch (bgID)
            {
                case BACKGROUND_2:
                case BACKGROUND_3:
                    if ((bgControl & bg3_256ColorChar04000) == bg3_256ColorChar04000)
                    {
                        switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                        {
                            case GX_BG_SCRSIZE_DCBMP_128x128:
                                *pixelMode = PIXEL_MODE_BG_DCBMP_128x128;
                                break;

                            case GX_BG_SCRSIZE_DCBMP_256x256:
                                *pixelMode = PIXEL_MODE_BG_DCBMP_256x256;
                                break;

                            case GX_BG_SCRSIZE_DCBMP_512x256:
                                *pixelMode = PIXEL_MODE_BG_DCBMP_512x256;
                                break;

                            case GX_BG_SCRSIZE_DCBMP_512x512:
                                *pixelMode = PIXEL_MODE_BG_DCBMP_512x512;
                                break;
                        }
                    }
                    else
                    {
                        switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                        {
                            case GX_BG_SCRSIZE_TEXT_256x256:
                                *pixelMode = PIXEL_MODE_BG_TEXT_256x256;
                                break;

                            case GX_BG_SCRSIZE_TEXT_512x256:
                                *pixelMode = PIXEL_MODE_BG_TEXT_512x256;
                                break;

                            case GX_BG_SCRSIZE_TEXT_256x512:
                                *pixelMode = PIXEL_MODE_BG_TEXT_256x512;
                                break;

                            case GX_BG_SCRSIZE_TEXT_512x512:
                                *pixelMode = PIXEL_MODE_BG_TEXT_512x512;
                                break;
                        }
                    }
                    break;
            }
            break;

        case GX_BGMODE_6:
            switch (bgID)
            {
                case BACKGROUND_2:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_LARGEBMP_512x1024:
                            *pixelMode = PIXEL_MODE_BG_LARGEBMP_512x1024;
                            break;

                        case GX_BG_SCRSIZE_LARGEBMP_1024x512:
                            *pixelMode = PIXEL_MODE_BG_LARGEBMP_1024x512;
                            break;
                    }
                    break;
            }
            break;
    }

#undef bg3_256ColorChar04000
}

void BeginSysPause(u8 pauseLevel, BOOL engineActiveA, BOOL engineActiveB, BOOL disableSwapBuffers)
{
    Task *task    = TaskCreate(SysPause_Main_Init, NULL, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, TASK_PAUSELEVEL_0, TASK_PRIORITY_UPDATE_LIST_END - 0,
                               TASK_GROUP_HIGHEST - 1, SysPause);
    sSysPauseTask = task;

    SysPause *work = TaskGetWork(task, SysPause);
    TaskInitWork16(work);

    work->engineActive[GRAPHICS_ENGINE_A] = engineActiveA;
    work->engineActive[GRAPHICS_ENGINE_B] = engineActiveB;
    StartTaskPause(pauseLevel);

    if (GetSwapBuffer3DTask() == NULL)
    {
        if (disableSwapBuffers)
            CreateDisableSwapBuffersTask(TRUE);
    }
}

void EndSysPause(void)
{
    SysPause *work   = TaskGetWork(sSysPauseTask, SysPause);
    work->isFinished = TRUE;

    if (GetSwapBuffer3DTask() == NULL)
        CreateDisableSwapBuffersTask(FALSE);

    EndTaskPause();
}

BOOL SysPause_IsActive(void)
{
    if (sSysPauseTask == NULL)
        return FALSE;

    SysPause *work = TaskGetWork(sSysPauseTask, SysPause);
    return work->isActive;
}

// SwapBuffer3D
void CreateSwapBuffer3D(void)
{
    sPrimary3DScreen  = SWAPBUFFER3D_PRIMARY_TOP;
    sSwapBuffer3DMode = SWAPBUFFER3D_MODE_IDLE;

    Task *task    = TaskCreate(SwapBuffer3D_Main, NULL, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, TASK_PAUSELEVEL_0, TASK_PRIORITY_UPDATE_LIST_END - 0,
                               TASK_GROUP_HIGHEST - 1, SwapBuffer3D);
    sSwapBuffer3D = task;

    SwapBuffer3D *work = TaskGetWork(task, SwapBuffer3D);
    TaskInitWork16(work);

    RenderCore_DisableSwapBuffers(TRUE);
    RenderCore_DisableOAMReset(TRUE);
    RenderCore_SetVBlankCallback(SwapBuffer3D_VBlankCallback);

    MTX_Identity22(&renderCoreGFXControlB.affineBG2.matrix);
    renderCoreGFXControlB.affineBG2.centerX = renderCoreGFXControlB.affineBG2.centerY = 0;
    renderCoreGFXControlB.affineBG2.x = renderCoreGFXControlB.affineBG2.y = 0;

    SwapBuffer3D_InitOAM();
}

void DestroySwapBuffer3D(void)
{
    if (sSwapBuffer3D == NULL)
        return;

    RenderCore_SetVBlankCallback(NULL);

    sSwapBuffer3D->usrFlags &= ~TASKLIST_FLAG_PRIORITY_ACTIVE;
    DestroyTask(sSwapBuffer3D);
    sSwapBuffer3D = NULL;

    RenderCore_DisableSwapBuffers(FALSE);
    RenderCore_DisableOAMReset(FALSE);

    MI_CpuFill16(OAMSystem__GetList2(GRAPHICS_ENGINE_B), 0x200, HW_OAM_SIZE);
}

Task *GetSwapBuffer3DTask(void)
{
    return sSwapBuffer3D;
}

SwapBuffer3DPrimaryScreen SwapBuffer3D_GetPrimaryScreen(void)
{
    return sPrimary3DScreen;
}

SwapBuffer3D *GetSwapBuffer3DWork(void)
{
    return TaskGetWork(sSwapBuffer3D, SwapBuffer3D);
}

void SwapBuffer3D_ApplyCameraState(Camera3D *camera)
{
    FXMatrix43 *matView;
    FXMatrix44 matTranslate;

    NNS_G3dGlbLookAt(&camera->view.camPos, &camera->view.camUp, &camera->view.camTarget);

    matView = (FXMatrix43 *)NNS_G3dGlbGetCameraMtx();
    matView->row[3].x += camera->view.position.x;
    matView->row[3].y += camera->view.position.y;
    matView->row[3].z += camera->view.position.z;

    NNS_G3dGlbPerspectiveW(SinFX(camera->projection.fov), CosFX(camera->projection.fov), camera->projection.aspectRatio, camera->projection.nearPlane, camera->projection.farPlane,
                           camera->projection.scaleW);

    FXMatrix44 *matProj = (FXMatrix44 *)NNS_G3dGlbGetProjectionMtx();

    MTX_Identity44(matTranslate.nnMtx);
    matTranslate.row[3].vec = camera->projection.position;
    MTX_Concat44(matProj->nnMtx, matTranslate.nnMtx, matProj->nnMtx);
}

void SwapBuffer3D_SetLight(GXLightId lightID, DirLight *light)
{
    fx32 z = MTM_MATH_CLIP(light->dir.z, -FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0) - 1);
    fx32 y = MTM_MATH_CLIP(light->dir.y, -FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0) - 1);
    fx32 x = MTM_MATH_CLIP(light->dir.x, -FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0) - 1);

    NNS_G3dGlbLightVector(lightID, x, y, z);
    NNS_G3dGlbLightColor(lightID, light->color);
}

void SwapBuffer3D_Op_Init(void)
{
    // clang-format off
	static const u32 sz = (sizeof(NNS_G3dGlb.cmd1) +
                           sizeof(NNS_G3dGlb.lightVec[0]) * 4 +
                           sizeof(NNS_G3dGlb.cmd2) +
                           sizeof(NNS_G3dGlb.prmMatColor0) +
                           sizeof(NNS_G3dGlb.prmMatColor1) +
                           sizeof(NNS_G3dGlb.prmPolygonAttr) +
                           sizeof(NNS_G3dGlb.prmViewPort) +
                           sizeof(NNS_G3dGlb.cmd3) +
                           sizeof(NNS_G3dGlb.lightColor[0]) * 4) / sizeof(u32);
    // clang-format on

    NNS_G3dGeBufferData_N((u32 *)&NNS_G3dGlb.cmd1, sz);
    NNS_G3dGeBufferOP_N(G3OP_TEXIMAGE_PARAM, &NNS_G3dGlb.prmTexImageParam, 1);
    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION_VECTOR);
}

void SwapBuffer3D_Op_FlushP(void)
{
    // clang-format off
	static const u32 sz = (sizeof(NNS_G3dGlb.cmd0) +
                           sizeof(NNS_G3dGlb.mtxmode_proj) +
                           sizeof(NNS_G3dGlb.projMtx) +
                           sizeof(NNS_G3dGlb.mtxmode_posvec) +
                           sizeof(NNS_G3dGlb.cameraMtx)) / sizeof(u32);
    // clang-format on

    NNS_G3dGeBufferData_N((u32 *)&NNS_G3dGlb, sz);
    NNS_G3dGeBufferOP_N(GX_PACK_OP(G3OP_MTX_MULT_4x3, G3OP_MTX_SCALE, G3OP_NOP, G3OP_NOP), (u32 *)NNS_G3dGlbGetBaseRot(), (sizeof(MtxFx44) / sizeof(u32)) - 1);

    NNS_G3dGlb.flag &= ~NNS_G3D_GLB_FLAG_FLUSH_WVP;
    NNS_G3dGlb.flag &= ~NNS_G3D_GLB_FLAG_FLUSH_VP;
}

void SwapBuffer3D_Op_FlushVP(void)
{
    static const u32 sz = (sizeof(NNS_G3dGlb.mtxmode_proj) + sizeof(NNS_G3dGlb.projMtx)) / sizeof(u32);

    NNS_G3dGeBufferOP_N(GX_PACK_OP(G3OP_MTX_MODE, G3OP_MTX_LOAD_4x4, G3OP_NOP, G3OP_NOP), (u32 *)&NNS_G3dGlb.mtxmode_proj, sz);
    NNS_G3dGeBufferOP_N(G3OP_MTX_MULT_4x3, (u32 *)NNS_G3dGlbGetCameraMtx(), (sizeof(MtxFx43) / sizeof(u32)));

    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION_VECTOR);
    NNS_G3dGeBufferOP_N(GX_PACK_OP(G3OP_MTX_LOAD_4x3, G3OP_MTX_SCALE, G3OP_NOP, G3OP_NOP), (u32 *)NNS_G3dGlbGetBaseRot(), (sizeof(MtxFx44) / sizeof(u32)) - 1);

    NNS_G3dGlb.flag &= ~NNS_G3D_GLB_FLAG_FLUSH_WVP;
    NNS_G3dGlb.flag |= NNS_G3D_GLB_FLAG_FLUSH_VP;
}

void SwapBuffer3D_Op_FlushWVP(void)
{
    static const u32 sz = (sizeof(NNS_G3dGlb.mtxmode_proj) + sizeof(NNS_G3dGlb.projMtx)) / sizeof(u32);

    NNS_G3dGeBufferOP_N(GX_PACK_OP(G3OP_MTX_MODE, G3OP_MTX_LOAD_4x4, G3OP_NOP, G3OP_NOP), (u32 *)&NNS_G3dGlb.mtxmode_proj, sz);
    NNS_G3dGeBufferOP_N(G3OP_MTX_MULT_4x3, (u32 *)NNS_G3dGlbGetCameraMtx(), (sizeof(MtxFx43) / sizeof(u32)));
    NNS_G3dGeBufferOP_N(GX_PACK_OP(G3OP_MTX_MULT_4x3, G3OP_MTX_SCALE, G3OP_NOP, G3OP_NOP), (u32 *)NNS_G3dGlbGetBaseRot(), (sizeof(MtxFx44) / sizeof(u32)) - 1);

    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION_VECTOR);
    NNS_G3dGeIdentity();

    NNS_G3dGlb.flag |= NNS_G3D_GLB_FLAG_FLUSH_WVP;
    NNS_G3dGlb.flag &= ~NNS_G3D_GLB_FLAG_FLUSH_VP;
}

void SwapBuffer3D_CopyMatrix_Standard(const FXMatrix43 *src, FXMatrix33 *dst)
{
    dst->m[0][0] = src->m[0][0];
    dst->m[0][1] = src->m[1][0];
    dst->m[0][2] = src->m[2][0];
    dst->m[1][0] = src->m[0][1];
    dst->m[1][1] = src->m[1][1];
    dst->m[1][2] = src->m[2][1];
    dst->m[2][0] = src->m[0][2];
    dst->m[2][1] = src->m[1][2];
    dst->m[2][2] = src->m[2][2];
}

void SwapBuffer3D_CopyMatrix_Billboard(const FXMatrix43 *src, FXMatrix33 *dst)
{
    dst->m[0][0] = src->m[0][0];
    dst->m[0][1] = src->m[1][0];
    dst->m[0][2] = src->m[2][0];
    dst->m[1][0] = FLOAT_TO_FX32(0.0);
    dst->m[1][1] = FLOAT_TO_FX32(1.0);
    dst->m[1][2] = FLOAT_TO_FX32(0.0);
    dst->m[2][0] = src->m[0][2];
    dst->m[2][1] = src->m[1][2];
    dst->m[2][2] = src->m[2][2];
}

// Asset3DSetup
u32 Asset3DSetup_GetResourceSize(void *resource)
{
    NNSG3dResTex *tex = NNS_G3dGetTex(resource);
    if (tex != NULL)
        return NNS_G3dGetTexData(tex) - resource;

    return ((NNSG3dResFileHeader *)resource)->fileSize;
}

void Asset3DSetup_CopyResourceData(void *resource, void *dest)
{
    u32 size = Asset3DSetup_GetResourceSize(resource);
    MI_CpuCopy32(resource, dest, size);
    DC_StoreRange(dest, size);
}

void CreateAsset3DSetup(void *resource)
{
    Task *task = TaskCreate(Asset3DSetup_Main, NULL, TASK_FLAG_NONE, 0, TASK_PRIORITY_RENDER_LIST_START + 0x0001, TASK_GROUP_HIGHEST - 1, AssetSetupTask);

    AssetSetupTask *work = TaskGetWork(task, AssetSetupTask);
    work->resource       = resource;
}

u32 Asset3DSetup_GetPaletteFromIndex(const NNSG3dResTex *texture, u32 id)
{
    return ((NNS_G3dGetPlttDataByIdx(texture, id)->offset + (u16)((NNSG3dResTex *)texture)->plttInfo.vramKey) << NNS_GFD_PLTTKEY_ADDR_SHIFT) | VRAMSYSTEM_FLAG_ALLOCATED;
}

u32 Asset3DSetup_GetPaletteFromName(const NNSG3dResTex *texture, const char *name)
{
    NNSG3dResName resName;

    u32 length = STD_GetStringLength(name);
    if (length > sizeof(NNSG3dResName))
        length = sizeof(NNSG3dResName);

    MI_CpuClear32(&resName, sizeof(resName));
    MI_CpuCopy8(name, &resName.name, length);

    return ((NNS_G3dGetPlttDataByName(texture, &resName)->offset + (u16)((NNSG3dResTex *)texture)->plttInfo.vramKey) << NNS_GFD_PLTTKEY_ADDR_SHIFT) | VRAMSYSTEM_FLAG_ALLOCATED;
}

// SysPause (Part 2)
void SysPause_Main_Init(void)
{
    SwapBuffer3D *camera3D;
    SysPause *work;

    s32 i;
    GXOamAttr *oamSrc;
    GXOamAttr *oamList2;
    u16 oamAffineOffset;
    u16 oamCount;

    work = TaskGetWorkCurrent(SysPause);

    if (GetSwapBuffer3DTask() != NULL)
    {
        camera3D = TaskGetWork(sSwapBuffer3D, SwapBuffer3D);

        oamList2 = OAMSystem__GetList2(GRAPHICS_ENGINE_A);
        MI_CpuCopyFast(oamList2, work->oam[GRAPHICS_ENGINE_A], sizeof(work->oam[GRAPHICS_ENGINE_A]));

        if (SwapBuffer3D_GetPrimaryScreen() == SWAPBUFFER3D_PRIMARY_BOTTOM)
        {
            oamSrc          = camera3D->oam[GRAPHICS_ENGINE_B];
            oamAffineOffset = camera3D->oamAffineOffset[GRAPHICS_ENGINE_B];
            oamCount        = camera3D->oamCount[GRAPHICS_ENGINE_B];
        }
        else
        {
            oamAffineOffset = camera3D->oamAffineOffset[GRAPHICS_ENGINE_A];
            oamCount        = camera3D->oamCount[GRAPHICS_ENGINE_A];
            oamSrc          = camera3D->oam[GRAPHICS_ENGINE_A];
        }

        MI_CpuCopyFast(oamSrc, oamList2, sizeof(work->oam[GRAPHICS_ENGINE_A]));

        for (i = 0; i < oamCount; i++)
            MI_CpuCopy16(&oamList2[oamCount - 1 - i], &oamList2[OAMSYSTEM_OAM_LIST_SIZE - 1 - i], sizeof(GXOamAttr) - sizeof(u16));

        for (; i < OAMSYSTEM_OAM_LIST_SIZE; i++)
        {
            oamList2[i - oamCount].attr01 = 0x200;
        }
        work->oamAffineOffset[0] = oamAffineOffset;

        MI_CpuCopyFast(OAMSystem__GetList2(GRAPHICS_ENGINE_B), work->oam[GRAPHICS_ENGINE_B], sizeof(work->oam[GRAPHICS_ENGINE_B]));
        work->oamAffineOffset[GRAPHICS_ENGINE_B] = OAMSystem__GetOAMAffineOffset(GRAPHICS_ENGINE_B);
        SysPause_Func_207FC10(GRAPHICS_ENGINE_B);
    }
    else
    {
        for (i = 0; i < GRAPHICS_ENGINE_COUNT; i++)
        {
            if (work->engineActive[i])
            {
                MI_CpuCopyFast(OAMSystem__GetList2(i), work->oam[i], sizeof(work->oam[i]));
                work->oamAffineOffset[i] = OAMSystem__GetOAMAffineOffset(i);
                SysPause_Func_207FC10(i);
            }
        }
    }

    work->isActive = TRUE;
    SetCurrentTaskMainEvent(SysPause_Main_Active);
    SysPause_Main_Active();
}

void SysPause_Main_Active(void)
{
    SysPause *work = TaskGetWorkCurrent(SysPause);

    if (work->isFinished)
    {
        for (s32 i = 0; i < GRAPHICS_ENGINE_COUNT; i++)
        {
            if (work->engineActive[i])
            {
                MI_CpuCopyFast(&work->oam[i], OAMSystem__GetList2(i), sizeof(work->oam[i]));
                OAMSystem__SetOAMAffineOffset(i, work->oamAffineOffset[i]);
            }
        }

        DestroyCurrentTask();
        sSysPauseTask = NULL;
    }
}

NONMATCH_FUNC void SysPause_Func_207FC10(BOOL useEngineB)
{
    // https://decomp.me/scratch/iIxdp -> 90.77%
#ifdef NON_MATCHING
    GXOamAttr *oamList3 = OAMSystem__GetList3(useEngineB);
    GXOamAttr *oamList2 = OAMSystem__GetList2(useEngineB);

    GXOamAttr *oamPtr = &oamList2[OAMSYSTEM_OAM_LIST_SIZE - 1 - OAMSystem__GetOAMCount(useEngineB)];
    for (u16 i = 0; i < OAMSYSTEM_OAM_COUNT; i++)
    {
        for (u32 index = OAMSystem__GetListMap(useEngineB, i); index != 0xFFFF; oamPtr++)
        {
            MI_CpuCopy16(&oamList3[index], oamPtr, sizeof(GXOamAttr) - sizeof(u16));
            index = oamList3[index]._3;
        }
    }

    GXOamAttr *oamList2_2 = (GXOamAttr *)OAMSystem__GetList2(useEngineB);
    GXOamAttr *oamList1   = (GXOamAttr *)OAMSystem__GetList1(useEngineB);
    for (u16 i = 0; i < OAMSystem__GetOAMAffineCount(useEngineB); i++)
    {
        oamList2_2[0]._3 = oamList1[0]._3;
        oamList2_2[1]._3 = oamList1[1]._3;
        oamList2_2[2]._3 = oamList1[2]._3;
        oamList2_2[3]._3 = oamList1[3]._3;

        oamList1 += 4;
        oamList2_2 += 4;
    }

    OAMSystem__SetOAMAffineOffset(useEngineB, OAMSystem__GetOAMAffineCount(useEngineB));
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r7, r0
	bl OAMSystem__GetList3
	mov r5, r0
	mov r0, r7
	bl OAMSystem__GetList2
	mov r4, r0
	mov r0, r7
	bl OAMSystem__GetOAMCount
	rsb r0, r0, #0x7f
	add r6, r4, r0, lsl #3
	ldr r8, =0x0000FFFF
	mov r9, #0
	mov r4, #6
_0207FC48:
	mov r0, r7
	mov r1, r9
	bl OAMSystem__GetListMap
	mov r10, r0
	cmp r10, r8
	beq _0207FC84
_0207FC60:
	mov r1, r6
	mov r2, r4
	add r0, r5, r10, lsl #3
	bl MIi_CpuCopy16
	add r0, r5, r10, lsl #3
	ldrh r10, [r0, #6]
	add r6, r6, #8
	cmp r10, r8
	bne _0207FC60
_0207FC84:
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #0x20
	blo _0207FC48
	mov r0, r7
	bl OAMSystem__GetList2
	mov r5, r0
	mov r0, r7
	bl OAMSystem__GetList1
	mov r4, r0
	mov r0, r7
	mov r6, #0
	bl OAMSystem__GetOAMAffineCount
	cmp r0, #0
	bls _0207FD10
_0207FCC4:
	ldrh r1, [r4, #6]
	add r0, r6, #1
	mov r8, r0, lsl #0x10
	strh r1, [r5, #6]
	ldrh r2, [r4, #0xe]
	add r1, r4, #0x18
	mov r0, r7
	strh r2, [r5, #0xe]
	ldrh r3, [r4, #0x16]
	add r2, r5, #0x18
	add r4, r4, #0x20
	strh r3, [r5, #0x16]
	ldrh r1, [r1, #6]
	add r5, r5, #0x20
	mov r6, r8, lsr #0x10
	strh r1, [r2, #6]
	bl OAMSystem__GetOAMAffineCount
	cmp r0, r8, lsr #16
	bhi _0207FCC4
_0207FD10:
	mov r0, r7
	bl OAMSystem__GetOAMAffineCount
	mov r1, r0
	mov r0, r7
	bl OAMSystem__SetOAMAffineOffset
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

// DisableSwapBuffersTask
void CreateDisableSwapBuffersTask(BOOL swapBuffersDisabled)
{
    Task *task = TaskCreate(DisableSwapBuffersTask_Main, NULL, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, TASK_PAUSELEVEL_0,
                            TASK_PRIORITY_RENDER_LIST_END - 0, TASK_GROUP_HIGHEST - 1, DisableSwapBuffersTask);

    DisableSwapBuffersTask *work = TaskGetWork(task, DisableSwapBuffersTask);
    work->swapBuffersDisabled    = swapBuffersDisabled;
}

void DisableSwapBuffersTask_Main(void)
{
    DisableSwapBuffersTask *work = TaskGetWorkCurrent(DisableSwapBuffersTask);

    RenderCore_DisableSwapBuffers(work->swapBuffersDisabled);
    DestroyCurrentTask();
}

// Asset3DSetup
void Asset3DSetup_Main(void)
{
    AssetSetupTask *work = TaskGetWorkCurrent(AssetSetupTask);

    NNS_G3dResDefaultSetup(work->resource);
    DestroyCurrentTask();
}

// SwapBuffer3D (Part 2)
void SwapBuffer3D_Main(void)
{
    SwapBuffer3D *work = TaskGetWorkCurrent(SwapBuffer3D);

    UNUSED(SwapBuffer3D_GetPrimaryScreen());

    s32 id;
    if (SysPause_IsActive())
        id = SwapBuffer3D_GetPrimaryScreen() == SWAPBUFFER3D_PRIMARY_BOTTOM ? GRAPHICS_ENGINE_A : GRAPHICS_ENGINE_B;
    else
        id = SwapBuffer3D_GetPrimaryScreen() != SWAPBUFFER3D_PRIMARY_BOTTOM ? GRAPHICS_ENGINE_A : GRAPHICS_ENGINE_B;

    MI_CpuCopy32(&work->gfxControl[id], &renderCoreGFXControlA, sizeof(renderCoreGFXControlA));
    work->oamAffineOffset[id] = OAMSystem__GetOAMAffineOffset(GRAPHICS_ENGINE_A);
    work->oamCount[id]        = OAMSystem__GetOAMCount(GRAPHICS_ENGINE_A);
    OAMSystem__PrepareNewFrame(GRAPHICS_ENGINE_A);
    OAMSystem__PrepareNewFrame(GRAPHICS_ENGINE_B);

    if ((GX_GetPower() & GX_POWER_3D) != 0)
    {
        if (SysPause_IsActive() == FALSE)
            G3_SwapBuffers(renderCoreSwapBuffer.sortMode, renderCoreSwapBuffer.bufferMode);

        OSIntrMode enabled = OS_DisableInterrupts();
        sSwapBuffer3DMode  = SysPause_IsActive() == FALSE ? SWAPBUFFER3D_MODE_REGULAR : SWAPBUFFER3D_MODE_PAUSED;
        OS_RestoreInterrupts(enabled);
    }
}

NONMATCH_FUNC void SwapBuffer3D_InitOAM(void)
{
    // https://decomp.me/scratch/pQdeO -> 99.17%
#ifdef NON_MATCHING
    s32 x;
    s32 y;
    GXOamAttr *attr = OAMSystem__GetList2(GRAPHICS_ENGINE_B);

    for (y = 0; y < BG_DISPLAY_SINGLE_HEIGHT; y += TILE_SIZE)
    {
        for (x = 0; x < BG_DISPLAY_FULL_WIDTH; x += TILE_SIZE)
        {
            attr->attr01 = (((y * TILE_SIZE) & GX_OAM_ATTR01_Y_MASK) << GX_OAM_ATTR01_Y_SHIFT) | GX_OAM_SHAPE_64x64 | (GX_OAM_MODE_BITMAPOBJ << GX_OAM_ATTR01_MODE_SHIFT)
                           | (((x * TILE_SIZE) & (GX_OAM_ATTR01_X_MASK >> GX_OAM_ATTR01_X_SHIFT)) << GX_OAM_ATTR01_X_SHIFT);

            attr->attr2 = ((y * BG_DISPLAY_FULL_WIDTH) + x) | (PALETTE_ROW_15 << GX_OAM_ATTR2_CPARAM_SHIFT);

            attr++;
        }
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r0, #1
	bl OAMSystem__GetList2
	mov r4, #0
	ldr r1, =0xC0000C00
	mov r5, r4
	mov r6, r4
	mov ip, r4
_0207FED4:
	and r2, r6, #0xff
	mov lr, ip
	mov r7, ip
	orr r8, r2, r1
_0207FEE4:
	mov r3, r7, lsl #0x17
	add r2, r5, lr
	orr r3, r8, r3, lsr #7
	add lr, lr, #8
	str r3, [r0]
	orr r2, r2, #0xf000
	strh r2, [r0, #4]
	cmp lr, #0x20
	add r0, r0, #8
	add r7, r7, #0x40
	blt _0207FEE4
	add r4, r4, #8
	cmp r4, #0x18
	add r5, r5, #0x100
	add r6, r6, #0x40
	blt _0207FED4
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

void SwapBuffer3D_VBlankCallback(void)
{
    SwapBuffer3D *work = TaskGetWork(sSwapBuffer3D, SwapBuffer3D);

    if (sSwapBuffer3DMode > SWAPBUFFER3D_MODE_IDLE)
    {
        // SWAPBUFFER3D_MODE_REGULAR

        // Wait for one vertical line to be processed (784 cycles) if the scanline is on screen
        // This is to confirm the swap buffer operation has completed successfully
        if (GX_GetVCount() <= HW_LCD_HEIGHT + 1)
            OS_SpinWait(784);

        DC_StoreRange(&renderCoreGFXControlA, sizeof(renderCoreGFXControlA));
        DC_StoreRange(&renderCoreGFXControlB, sizeof(renderCoreGFXControlB));
        DC_WaitWriteBufferEmpty();

        if (SwapBuffer3D_GetPrimaryScreen() != SWAPBUFFER3D_PRIMARY_BOTTOM)
        {
            renderCoreGFXControlA.brightness = work->gfxControl[GRAPHICS_ENGINE_A].brightness;
            renderCoreGFXControlB.brightness = work->gfxControl[GRAPHICS_ENGINE_B].brightness;
        }
        else
        {
            renderCoreGFXControlA.brightness = work->gfxControl[GRAPHICS_ENGINE_B].brightness;
            renderCoreGFXControlB.brightness = work->gfxControl[GRAPHICS_ENGINE_A].brightness;
        }

        if (G3X_IsGeometryBusy() == FALSE)
        {
            MI_DmaCopy32(renderDmaNo, renderCoreGFXControlA.bgPosition, &reg_G2_BG0OFS, sizeof(renderCoreGFXControlA.bgPosition));

            {
                MI_DmaCopy32(renderDmaNo, &renderCoreGFXControlA.windowManager.registers, &reg_G2_WIN0H, sizeof(renderCoreGFXControlA.windowManager.registers));
                GX_SetVisibleWnd(renderCoreGFXControlA.windowManager.visible);
            }

            MI_DmaCopy16(renderDmaNo, &renderCoreGFXControlA.blendManager, &reg_G2_BLDCNT, sizeof(renderCoreGFXControlA.blendManager));

            reg_G2_MOSAIC = renderCoreGFXControlA.mosaicSize;

            G2_SetBG2Affine(&renderCoreGFXControlA.affineBG2.matrix, renderCoreGFXControlA.affineBG2.centerX, renderCoreGFXControlA.affineBG2.centerY,
                            renderCoreGFXControlA.affineBG2.x, renderCoreGFXControlA.affineBG2.y);
            G2_SetBG3Affine(&renderCoreGFXControlA.affineBG3.matrix, renderCoreGFXControlA.affineBG3.centerX, renderCoreGFXControlA.affineBG3.centerY,
                            renderCoreGFXControlA.affineBG3.x, renderCoreGFXControlA.affineBG3.y);

            OAMSystem__CopyToVRAM(GRAPHICS_ENGINE_A);
            if (SwapBuffer3D_GetPrimaryScreen() != SWAPBUFFER3D_PRIMARY_BOTTOM)
                MI_CpuCopyFast(RAW_ADDRESS(HW_OAM), work->oam[GRAPHICS_ENGINE_A], sizeof(work->oam[GRAPHICS_ENGINE_A]));
            else
                MI_CpuCopyFast(RAW_ADDRESS(HW_OAM), work->oam[GRAPHICS_ENGINE_B], sizeof(work->oam[GRAPHICS_ENGINE_B]));
            OAMSystem__CopyToVRAM(GRAPHICS_ENGINE_B);

            ProcessTexturePaletteQueue();
            ProcessTexturePixelQueue();
            ProcessBackgroundPaletteQueue();
            ProcessSpritePaletteQueue();
            Mappings__ReadList();
            ProcessSpritePixelQueue();

            if (sPrimary3DScreen != SWAPBUFFER3D_PRIMARY_BOTTOM)
                SwapBuffer3D_Use3DOnTopScreen();
            else
                SwapBuffer3D_Use3DOnBottomScreen();

            sSwapBuffer3DMode = SWAPBUFFER3D_MODE_IDLE;
            sPrimary3DScreen  = sPrimary3DScreen == SWAPBUFFER3D_PRIMARY_BOTTOM ? SWAPBUFFER3D_PRIMARY_TOP : SWAPBUFFER3D_PRIMARY_BOTTOM;
        }
    }
    else if (sSwapBuffer3DMode < SWAPBUFFER3D_MODE_IDLE)
    {
        // SWAPBUFFER3D_MODE_PAUSED

        // Wait for one vertical line to be processed (784 cycles) if the scanline is on screen
        // This is to confirm the swap buffer operation has completed successfully
        if (GX_GetVCount() <= HW_LCD_HEIGHT + 1)
            OS_SpinWait(784);

        if (SwapBuffer3D_GetPrimaryScreen() == SWAPBUFFER3D_PRIMARY_BOTTOM)
        {
            renderCoreGFXControlA.brightness = work->gfxControl[GRAPHICS_ENGINE_A].brightness;
            renderCoreGFXControlB.brightness = work->gfxControl[GRAPHICS_ENGINE_B].brightness;
        }
        else
        {
            renderCoreGFXControlA.brightness = work->gfxControl[GRAPHICS_ENGINE_B].brightness;
            renderCoreGFXControlB.brightness = work->gfxControl[GRAPHICS_ENGINE_A].brightness;
        }

        if (G3X_IsGeometryBusy() == FALSE)
        {
            MI_DmaCopy32(renderDmaNo, renderCoreGFXControlA.bgPosition, &reg_G2_BG0OFS, sizeof(renderCoreGFXControlA.bgPosition));

            {
                MI_DmaCopy32(renderDmaNo, &renderCoreGFXControlA.windowManager.registers, &reg_G2_WIN0H, sizeof(renderCoreGFXControlA.windowManager.registers));
                GX_SetVisibleWnd(renderCoreGFXControlA.windowManager.visible);
            }

            MI_DmaCopy16(renderDmaNo, &renderCoreGFXControlA.blendManager, &reg_G2_BLDCNT, sizeof(renderCoreGFXControlA.blendManager));

            reg_G2_MOSAIC = renderCoreGFXControlA.mosaicSize;

            G2_SetBG2Affine(&renderCoreGFXControlA.affineBG2.matrix, renderCoreGFXControlA.affineBG2.centerX, renderCoreGFXControlA.affineBG2.centerY,
                            renderCoreGFXControlA.affineBG2.x, renderCoreGFXControlA.affineBG2.y);
            G2_SetBG3Affine(&renderCoreGFXControlA.affineBG3.matrix, renderCoreGFXControlA.affineBG3.centerX, renderCoreGFXControlA.affineBG3.centerY,
                            renderCoreGFXControlA.affineBG3.x, renderCoreGFXControlA.affineBG3.y);

            OAMSystem__CopyToVRAM(GRAPHICS_ENGINE_A);
            OAMSystem__CopyToVRAM(GRAPHICS_ENGINE_B);
        }

        sSwapBuffer3DMode = SWAPBUFFER3D_MODE_IDLE;
    }
}

void SwapBuffer3D_Use3DOnTopScreen(void)
{
    renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;
    GX_SetDispSelect(renderCurrentDisplay);

    VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_NONE, GX_OBJVRAMMODE_CHAR_1D_128K, GX_OBJVRAMMODE_BMP_2D_W256, 0, 0);
    VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_128_C);
    GX_SetBankForLCDC(8);

    GX_SetCapture(GX_CAPTURE_SIZE_256x192, GX_CAPTURE_MODE_A, GX_CAPTURE_SRCA_2D3D, GX_CAPTURE_SRCB_VRAM_0x00000, GX_CAPTURE_DEST_VRAM_D_0x00000, 0x10, 0x00);

    GXS_SetGraphicsMode(GX_BGMODE_5);
    GXS_SetVisiblePlane(GX_PLANEMASK_BG2);

    G2S_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_512x256, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x04000);
    G2S_SetBG2Priority(0);
}

void SwapBuffer3D_Use3DOnBottomScreen(void)
{
    renderCurrentDisplay = GX_DISP_SELECT_SUB_MAIN;
    GX_SetDispSelect(renderCurrentDisplay);

    VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_NONE);
    VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_128_D, GX_OBJVRAMMODE_CHAR_1D_128K, GX_OBJVRAMMODE_BMP_2D_W256, 0, 0);
    GX_SetBankForLCDC(4);

    GX_SetCapture(GX_CAPTURE_SIZE_256x192, GX_CAPTURE_MODE_A, GX_CAPTURE_SRCA_2D3D, GX_CAPTURE_SRCB_VRAM_0x00000, GX_CAPTURE_DEST_VRAM_C_0x00000, 0x10, 0x00);

    GXS_SetGraphicsMode(GX_BGMODE_5);
    GXS_SetVisiblePlane(GX_PLANEMASK_OBJ);
}