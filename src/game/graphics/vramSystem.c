#include <game/graphics/vramSystem.h>
#include <game/graphics/renderCore.h>
#include <game/system/allocator.h>

// --------------------
// CONSTANTS
// --------------------

#define VRAM_SPRITE_BANK_SIZE  0x400
#define VRAM_TEXTURE_BANK_SIZE 0x100
#define VRAM_PALETTE_BANK_SIZE 0x200

// --------------------
// VARIABLES
// --------------------

static u8 paletteCount;
static u8 textureCount;

static u16 objBankSize[2];
static u16 objBankOffset[2];

static u16 objBankTileCount[2];
u16 objBankShift[2];
static u16 bgBankSize[2];
u16 objBmpUse256K[2];

static u32 textureUnknown[2];

struct VRAMOBJExtPalBankManager objExtPalBankManager[2];
struct VRAMOBJBankManager objBankManager[2];

struct VRAMBGBankManager bgBankManager[2];
struct VRAMBGExtPalBankManager bgExtPalBankManager[2];

struct VRAMTextureBankManager textureBankManager;
struct VRAMTexturePalBankManager texturePalBankManager;

static u16 vramTextureAllocTable[4 * VRAM_TEXTURE_BANK_SIZE];
static u16 vramSpriteAllocTable[2][VRAM_SPRITE_BANK_SIZE];
static u16 vramPaletteAllocTable[6 * VRAM_PALETTE_BANK_SIZE];

static const u8 vramTextureAllocBankID_4Pal_4x4Comp[] = { 0, 2 };
static const u8 vramTextureAllocBankID_4Pal[]  = { 3, 0, 2, 1 };

static const u8 vramPaletteAllocBankID_4Pal[]   = { 0, 1, 2, 3 };
static const u8 vramPaletteAllocBankID[] = { 4, 5, 1, 2, 3, 0 };

// --------------------
// FUNCTIONS
// --------------------

void InitVRAMSystem(void)
{
    // Init buffers
    VRAMSystem__InitSpriteBuffer(FALSE);
    VRAMSystem__InitSpriteBuffer(TRUE);
    VRAMSystem__InitTextureBuffer();
    VRAMSystem__InitPaletteBuffer();

    // Init HW VRAM
    VRAMSystem__SetupBGBank(GX_VRAM_BG_NONE);
    VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_NONE, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0);
    VRAMSystem__SetupBGExtPalBank(GX_VRAM_BGEXTPLTT_NONE);
    VRAMSystem__SetupOBJExtPalBank(GX_VRAM_OBJEXTPLTT_NONE);
    VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_NONE);
    VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_NONE, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0);
    VRAMSystem__SetupSubBGExtPalBank(GX_VRAM_SUB_BGEXTPLTT_NONE);
    VRAMSystem__SetupSubOBJExtPalBank(GX_VRAM_SUB_OBJEXTPLTT_NONE);
    VRAMSystem__SetupTextureBank(GX_VRAM_TEX_NONE);
    VRAMSystem__SetupTexturePalBank(GX_VRAM_TEXPLTT_NONE);

    // Init NitroSystem callbacks
    NNS_GfdDefaultFuncAllocTexVram = VRAMSystem__AllocTexVram;
    NNS_GfdDefaultFuncFreeTexVram  = VRAMSystem__FreeTexVram;

    NNS_GfdDefaultFuncAllocPlttVram = VRAMSystem__AllocPlttVram;
    NNS_GfdDefaultFuncFreePlttVram  = VRAMSystem__FreePlttVram;
}

void VRAMSystem__Init(VRAMMode mode)
{
    VRAMSystem__Reset();

    switch (mode)
    {
        case VRAM_MODE_0:
            VRAMSystem__SetupBGBank(GX_VRAM_BG_128_A);
            VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_128_B, GX_OBJVRAMMODE_CHAR_1D_128K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 1024);
            VRAMSystem__SetupBGExtPalBank(GX_VRAM_BGEXTPLTT_0123_E);
            VRAMSystem__SetupOBJExtPalBank(GX_VRAM_OBJEXTPLTT_0_F);
            VRAMSystem__InitSpriteBuffer(FALSE);

            VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_128_C);
            VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_128_D, GX_OBJVRAMMODE_CHAR_1D_128K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 1024);
            VRAMSystem__SetupSubBGExtPalBank(GX_VRAM_SUB_BGEXTPLTT_0123_H);
            VRAMSystem__SetupSubOBJExtPalBank(GX_VRAM_SUB_OBJEXTPLTT_0_I);
            VRAMSystem__InitSpriteBuffer(TRUE);
            break;

        case VRAM_MODE_1:
            VRAMSystem__SetupTextureBank(GX_VRAM_TEX_012_ABC);
            VRAMSystem__SetupTexturePalBank(GX_VRAM_TEXPLTT_0123_E);
            VRAMSystem__SetupBGBank(GX_VRAM_BG_128_D);
            VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_32_FG, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 1024);
            VRAMSystem__InitSpriteBuffer(FALSE);

            VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_32_H);
            VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_16_I, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 512);
            VRAMSystem__InitSpriteBuffer(TRUE);
            break;

        case VRAM_MODE_2:
            VRAMSystem__SetupTextureBank(GX_VRAM_TEX_0123_ABCD);
            VRAMSystem__SetupTexturePalBank(GX_VRAM_TEXPLTT_012345_EFG);
            VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_NONE, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0);
            VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_32_H);
            VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_16_I, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 512);
            VRAMSystem__InitSpriteBuffer(TRUE);
            break;
    }
}

void VRAMSystem__Reset(void)
{
    VRAMSystem__SetupBGBank(GX_VRAM_BG_NONE);
    VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_NONE, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0);
    VRAMSystem__SetupBGExtPalBank(GX_VRAM_BGEXTPLTT_NONE);
    VRAMSystem__SetupOBJExtPalBank(GX_VRAM_OBJEXTPLTT_NONE);
    VRAMSystem__SetupTextureBank(GX_VRAM_TEX_NONE);
    VRAMSystem__SetupTexturePalBank(GX_VRAM_TEXPLTT_NONE);
    GX_DisableBankForClearImage();

    VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_NONE);
    VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_NONE, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0);
    VRAMSystem__SetupSubBGExtPalBank(GX_VRAM_SUB_BGEXTPLTT_NONE);
    VRAMSystem__SetupSubOBJExtPalBank(GX_VRAM_SUB_OBJEXTPLTT_NONE);
    GX_DisableBankForARM7();
    GX_DisableBankForLCDC();
}

void VRAMSystem__SetupBGBank(GXVRamBG bank)
{
    MI_CpuClear32(&bgBankManager[0], sizeof(bgBankManager[0]));

    bgBankSize[0] = 0;
    switch (bank)
    {
        case GX_VRAM_BG_16_F:
            bgBankSize[0]                = 16;
            bgBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_F);
            break;

        case GX_VRAM_BG_16_G:
            bgBankSize[0]                = 16;
            bgBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_G);
            break;

        case GX_VRAM_BG_32_FG:
            bgBankSize[0]                = 32;
            bgBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_G);
            bgBankManager[0].location[1] = RAW_ADDRESS(HW_LCDC_VRAM_F);
            break;

        case GX_VRAM_BG_64_E:
            bgBankSize[0]                = 64;
            bgBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_E);
            break;

        case GX_VRAM_BG_96_EFG:
            bgBankSize[0]                = 96;
            bgBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_E);
            bgBankManager[0].location[1] = RAW_ADDRESS(HW_LCDC_VRAM_F);
            bgBankManager[0].location[2] = RAW_ADDRESS(HW_LCDC_VRAM_G);
            break;

        case GX_VRAM_BG_128_A:
            bgBankSize[0]                = 128;
            bgBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_A);
            break;

        case GX_VRAM_BG_128_B:
            bgBankSize[0]                = 128;
            bgBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_B);
            break;

        case GX_VRAM_BG_128_C:
            bgBankSize[0]                = 128;
            bgBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_C);
            break;

        case GX_VRAM_BG_128_D:
            bgBankSize[0]                = 128;
            bgBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_D);
            break;

        case GX_VRAM_BG_256_AB:
            bgBankSize[0]                = 256;
            bgBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_A);
            bgBankManager[0].location[1] = RAW_ADDRESS(HW_LCDC_VRAM_B);
            break;

        case GX_VRAM_BG_256_BC:
            bgBankSize[0]                = 256;
            bgBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_B);
            bgBankManager[0].location[1] = RAW_ADDRESS(HW_LCDC_VRAM_C);
            break;

        case GX_VRAM_BG_256_CD:
            bgBankSize[0]                = 256;
            bgBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_C);
            bgBankManager[0].location[1] = RAW_ADDRESS(HW_LCDC_VRAM_D);
            break;

        case GX_VRAM_BG_384_ABC:
            bgBankSize[0]                = 384;
            bgBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_A);
            bgBankManager[0].location[1] = RAW_ADDRESS(HW_LCDC_VRAM_B);
            bgBankManager[0].location[2] = RAW_ADDRESS(HW_LCDC_VRAM_C);
            break;

        case GX_VRAM_BG_384_BCD:
            bgBankSize[0]                = 384;
            bgBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_B);
            bgBankManager[0].location[1] = RAW_ADDRESS(HW_LCDC_VRAM_C);
            bgBankManager[0].location[2] = RAW_ADDRESS(HW_LCDC_VRAM_D);
            break;

        case GX_VRAM_BG_512_ABCD:
            bgBankSize[0]                = 512;
            bgBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_A);
            bgBankManager[0].location[1] = RAW_ADDRESS(HW_LCDC_VRAM_B);
            bgBankManager[0].location[2] = RAW_ADDRESS(HW_LCDC_VRAM_C);
            bgBankManager[0].location[3] = RAW_ADDRESS(HW_LCDC_VRAM_D);
            break;

        default:
            GX_DisableBankForBG();
            return;
    }

    GX_SetBankForBG(bank);
}

void VRAMSystem__SetupOBJBank(GXVRamOBJ bank, GXOBJVRamModeChar charMode, GXOBJVRamModeBmp bmpMode, u16 bankOffset, u16 tileCount)
{
    MI_CpuClear32(&objBankManager[0], sizeof(objBankManager[0]));

    objBankSize[0] = 0;
    switch (bank)
    {
        case GX_VRAM_OBJ_16_F:
            objBankSize[0]                = 16;
            objBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_F);
            break;

        case GX_VRAM_OBJ_16_G:
            objBankSize[0]                = 16;
            objBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_G);
            break;

        case GX_VRAM_OBJ_32_FG:
            objBankSize[0]                = 32;
            objBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_F);
            objBankManager[0].location[1] = RAW_ADDRESS(HW_LCDC_VRAM_G);
            break;

        case GX_VRAM_OBJ_64_E:
            objBankSize[0]                = 64;
            objBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_E);
            break;

        case GX_VRAM_OBJ_96_EFG:
            objBankSize[0]                = 96;
            objBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_E);
            objBankManager[0].location[1] = RAW_ADDRESS(HW_LCDC_VRAM_F);
            objBankManager[0].location[2] = RAW_ADDRESS(HW_LCDC_VRAM_G);
            break;

        case GX_VRAM_OBJ_128_A:
            objBankSize[0]                = 128;
            objBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_A);
            break;

        case GX_VRAM_OBJ_128_B:
            objBankSize[0]                = 128;
            objBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_B);
            break;

        case GX_VRAM_OBJ_256_AB:
            objBankSize[0]                = 256;
            objBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_A);
            objBankManager[0].location[1] = RAW_ADDRESS(HW_LCDC_VRAM_B);
            break;

        default:
            GX_DisableBankForOBJ();
            return;
    }

    GX_SetBankForOBJ(bank);

    switch (charMode)
    {
        case GX_OBJVRAMMODE_CHAR_1D_32K:
            objBankShift[0] = 0;
            break;

        case GX_OBJVRAMMODE_CHAR_1D_64K:
            objBankShift[0] = 1;
            break;

        case GX_OBJVRAMMODE_CHAR_1D_128K:
            objBankShift[0] = 2;
            break;

        case GX_OBJVRAMMODE_CHAR_1D_256K:
            objBankShift[0] = 3;
            break;

        case GX_OBJVRAMMODE_CHAR_2D:
            objBankShift[0] = 0;
            break;

        default:
            objBankShift[0] = 0;
            break;
    }

    GX_SetOBJVRamModeChar(charMode);

    switch (bmpMode)
    {
        case GX_OBJVRAMMODE_BMP_1D_128K:
            objBmpUse256K[0] = FALSE;
            break;

        case GX_OBJVRAMMODE_BMP_1D_256K:
            objBmpUse256K[0] = TRUE;
            break;

        case GX_OBJVRAMMODE_BMP_2D_W128:
        case GX_OBJVRAMMODE_BMP_2D_W256:
            objBmpUse256K[0] = FALSE;
            break;

        default:
            objBmpUse256K[0] = FALSE;
            break;
    }

    GX_SetOBJVRamModeBmp(bmpMode);

    objBankOffset[0]    = bankOffset;
    objBankTileCount[0] = tileCount;
}

void VRAMSystem__SetupBGExtPalBank(GXVRamBGExtPltt bank)
{
    MI_CpuClear32(&bgExtPalBankManager[0], sizeof(bgExtPalBankManager[0]));

    switch (bank)
    {
        case GX_VRAM_BGEXTPLTT_01_F:
            bgExtPalBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_F);
            bgExtPalBankManager[0].location[1] = RAW_ADDRESS(HW_LCDC_VRAM_F + (HW_VRAM_F_SIZE >> 1));
            break;

        case GX_VRAM_BGEXTPLTT_23_G:
            bgExtPalBankManager[0].location[2] = RAW_ADDRESS(HW_LCDC_VRAM_G);
            bgExtPalBankManager[0].location[3] = RAW_ADDRESS(HW_LCDC_VRAM_G + (HW_VRAM_G_SIZE >> 1));
            break;

        case GX_VRAM_BGEXTPLTT_0123_E:
            bgExtPalBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_E);
            bgExtPalBankManager[0].location[1] = RAW_ADDRESS(HW_LCDC_VRAM_E + (HW_VRAM_E_SIZE >> 3));
            bgExtPalBankManager[0].location[2] = RAW_ADDRESS(HW_LCDC_VRAM_E + (HW_VRAM_E_SIZE >> 3) + (HW_VRAM_E_SIZE >> 3));
            bgExtPalBankManager[0].location[3] = RAW_ADDRESS(HW_LCDC_VRAM_E + (HW_VRAM_E_SIZE >> 3) + (HW_VRAM_E_SIZE >> 3) + (HW_VRAM_E_SIZE >> 3));
            break;

        case GX_VRAM_BGEXTPLTT_0123_FG:
            bgExtPalBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_F);
            bgExtPalBankManager[0].location[1] = RAW_ADDRESS(HW_LCDC_VRAM_F + (HW_VRAM_F_SIZE >> 1));
            bgExtPalBankManager[0].location[2] = RAW_ADDRESS(HW_LCDC_VRAM_G);
            bgExtPalBankManager[0].location[3] = RAW_ADDRESS(HW_LCDC_VRAM_G + (HW_VRAM_G_SIZE >> 1));
            break;

        default:
            GX_DisableBankForBGExtPltt();
            return;
    }

    GX_SetBankForBGExtPltt(bank);
}

void VRAMSystem__SetupOBJExtPalBank(GXVRamOBJExtPltt bank)
{
    MI_CpuClear32(&objExtPalBankManager[0], sizeof(objExtPalBankManager[0]));

    switch (bank)
    {
        case GX_VRAM_OBJEXTPLTT_0_F:
            objExtPalBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_F);
            break;

        case GX_VRAM_OBJEXTPLTT_0_G:
            objExtPalBankManager[0].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_G);
            break;

        default:
            GX_DisableBankForOBJExtPltt();
            return;
    }

    GX_SetBankForOBJExtPltt(bank);
}

void VRAMSystem__SetupSubBGBank(GXVRamSubBG bank)
{
    MI_CpuClear32(&bgBankManager[1], sizeof(bgBankManager[1]));

    bgBankSize[1] = 0;
    switch (bank)
    {
        case GX_VRAM_SUB_BG_128_C:
            bgBankSize[1]                = 128;
            bgBankManager[1].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_C);
            break;

        case GX_VRAM_SUB_BG_32_H:
            bgBankSize[1]                = 32;
            bgBankManager[1].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_H);
            break;

        case GX_VRAM_SUB_BG_48_HI:
            bgBankSize[1]                = 48;
            bgBankManager[1].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_H);
            bgBankManager[1].location[1] = RAW_ADDRESS(HW_LCDC_VRAM_I);
            break;

        default:
            GX_DisableBankForSubBG();
            return;
    }

    GX_SetBankForSubBG(bank);
}

void VRAMSystem__SetupSubOBJBank(GXVRamSubOBJ bank, GXOBJVRamModeChar charMode, GXOBJVRamModeBmp bmpMode, u16 bankOffset, u16 tileCount)
{
    MI_CpuClear32(&objBankManager[1], sizeof(objBankManager[1]));

    objBankSize[1] = 0;
    switch (bank)
    {
        case GX_VRAM_SUB_OBJ_128_D:
            objBankSize[1]                = 128;
            objBankManager[1].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_D);
            break;

        case GX_VRAM_SUB_OBJ_16_I:
            objBankSize[1]                = 16;
            objBankManager[1].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_I);
            break;

        default:
            GX_DisableBankForSubOBJ();
            return;
    }

    GX_SetBankForSubOBJ(bank);

    switch (charMode)
    {
        case GX_OBJVRAMMODE_CHAR_1D_32K:
            objBankShift[1] = 0;
            break;

        case GX_OBJVRAMMODE_CHAR_1D_64K:
            objBankShift[1] = 1;
            break;

        case GX_OBJVRAMMODE_CHAR_1D_128K:
            objBankShift[1] = 2;
            break;

        case GX_OBJVRAMMODE_CHAR_2D:
            // why does this use engineA's slot?
            objBankShift[0] = 0;
            break;

        // case GX_OBJVRAMMODE_CHAR_1D_256K:
        default:
            objBankShift[1] = 0;
            break;
    }

    GXS_SetOBJVRamModeChar(charMode);

    switch (bmpMode)
    {
        case GX_OBJVRAMMODE_BMP_1D_128K:
            objBmpUse256K[1] = FALSE;
            break;

        case GX_OBJVRAMMODE_BMP_1D_256K:
            objBmpUse256K[1] = TRUE;
            break;

        case GX_OBJVRAMMODE_BMP_2D_W128:
        case GX_OBJVRAMMODE_BMP_2D_W256:
            // why does this use engineA's slot?
            objBmpUse256K[0] = FALSE;
            break;

        default:
            objBmpUse256K[1] = FALSE;
            break;
    }

    GXS_SetOBJVRamModeBmp(bmpMode);

    objBankOffset[1]    = bankOffset;
    objBankTileCount[1] = tileCount;
}

void VRAMSystem__SetupSubBGExtPalBank(GXVRamSubBGExtPltt bank)
{
    MI_CpuClear32(&bgExtPalBankManager[1], sizeof(bgExtPalBankManager[1]));

    switch (bank)
    {
        case GX_VRAM_SUB_BGEXTPLTT_0123_H:
            bgExtPalBankManager[1].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_H);
            bgExtPalBankManager[1].location[1] = RAW_ADDRESS(HW_LCDC_VRAM_H + (HW_VRAM_H_SIZE >> 2));
            bgExtPalBankManager[1].location[2] = RAW_ADDRESS(HW_LCDC_VRAM_H + (HW_VRAM_H_SIZE >> 2) + (HW_VRAM_H_SIZE >> 2));
            bgExtPalBankManager[1].location[3] = RAW_ADDRESS(HW_LCDC_VRAM_H + (HW_VRAM_H_SIZE >> 2) + (HW_VRAM_H_SIZE >> 2) + (HW_VRAM_H_SIZE >> 2));
            break;

        default:
            GX_DisableBankForSubBGExtPltt();
            return;
    }

    GX_SetBankForSubBGExtPltt(bank);
}

void VRAMSystem__SetupSubOBJExtPalBank(GXVRamSubOBJExtPltt bank)
{
    MI_CpuClear32(&objExtPalBankManager[1], sizeof(objExtPalBankManager[1]));

    switch (bank)
    {
        case GX_VRAM_SUB_OBJEXTPLTT_0_I:
            objExtPalBankManager[1].location[0] = RAW_ADDRESS(HW_LCDC_VRAM_I);
            break;

        default:
            GX_DisableBankForSubOBJExtPltt();
            return;
    }

    GX_SetBankForSubOBJExtPltt(bank);
}

void VRAMSystem__SetupTextureBank(GXVRamTex bank)
{
    MI_CpuClear32(&textureBankManager, sizeof(textureBankManager));

    switch (bank)
    {
        case GX_VRAM_TEX_0_A:
            textureBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_A);
            textureCount                   = 1;
            break;

        case GX_VRAM_TEX_0_B:
            textureBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_B);
            textureCount                   = 1;
            break;

        case GX_VRAM_TEX_0_C:
            textureBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_C);
            textureCount                   = 1;
            break;

        case GX_VRAM_TEX_0_D:
            textureBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_D);
            textureCount                   = 1;
            break;

        case GX_VRAM_TEX_01_AB:
            textureBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_A);
            textureBankManager.location[1] = RAW_ADDRESS(HW_LCDC_VRAM_B);
            textureCount                   = 2;
            break;

        case GX_VRAM_TEX_01_BC:
            textureBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_B);
            textureBankManager.location[1] = RAW_ADDRESS(HW_LCDC_VRAM_C);
            textureCount                   = 2;
            break;

        case GX_VRAM_TEX_01_CD:
            textureBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_C);
            textureBankManager.location[1] = RAW_ADDRESS(HW_LCDC_VRAM_D);
            textureCount                   = 2;
            break;

        case GX_VRAM_TEX_012_ABC:
            textureBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_A);
            textureBankManager.location[1] = RAW_ADDRESS(HW_LCDC_VRAM_B);
            textureBankManager.location[2] = RAW_ADDRESS(HW_LCDC_VRAM_C);
            textureCount                   = 3;
            break;

        case GX_VRAM_TEX_012_BCD:
            textureBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_B);
            textureBankManager.location[1] = RAW_ADDRESS(HW_LCDC_VRAM_C);
            textureBankManager.location[2] = RAW_ADDRESS(HW_LCDC_VRAM_D);
            textureCount                   = 3;
            break;

        case GX_VRAM_TEX_0123_ABCD:
            textureBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_A);
            textureBankManager.location[1] = RAW_ADDRESS(HW_LCDC_VRAM_B);
            textureBankManager.location[2] = RAW_ADDRESS(HW_LCDC_VRAM_C);
            textureBankManager.location[3] = RAW_ADDRESS(HW_LCDC_VRAM_D);
            textureCount                   = 4;
            break;

        case GX_VRAM_TEX_01_AC:
            textureBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_A);
            textureBankManager.location[1] = RAW_ADDRESS(HW_LCDC_VRAM_C);
            textureCount                   = 2;
            break;

        case GX_VRAM_TEX_01_AD:
            textureBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_A);
            textureBankManager.location[1] = RAW_ADDRESS(HW_LCDC_VRAM_D);
            textureCount                   = 2;
            break;

        case GX_VRAM_TEX_01_BD:
            textureBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_B);
            textureBankManager.location[1] = RAW_ADDRESS(HW_LCDC_VRAM_D);
            textureCount                   = 2;
            break;

        case GX_VRAM_TEX_012_ABD:
            textureBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_A);
            textureBankManager.location[1] = RAW_ADDRESS(HW_LCDC_VRAM_B);
            textureBankManager.location[2] = RAW_ADDRESS(HW_LCDC_VRAM_D);
            textureCount                   = 3;
            break;

        case GX_VRAM_TEX_012_ACD:
            textureBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_A);
            textureBankManager.location[1] = RAW_ADDRESS(HW_LCDC_VRAM_C);
            textureBankManager.location[2] = RAW_ADDRESS(HW_LCDC_VRAM_D);
            textureCount                   = 3;
            break;

        default:
            GX_DisableBankForTex();
            return;
    }

    GX_SetBankForTex(bank);
}

void VRAMSystem__SetupTexturePalBank(GXVRamTexPltt bank)
{
    MI_CpuClear32(&texturePalBankManager, sizeof(texturePalBankManager));

    switch (bank)
    {
        case GX_VRAM_TEXPLTT_0_F:
            texturePalBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_F);
            paletteCount                      = 1;
            break;

        case GX_VRAM_TEXPLTT_0_G:
            texturePalBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_G);
            paletteCount                      = 1;
            break;

        case GX_VRAM_TEXPLTT_01_FG:
            texturePalBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_F);
            texturePalBankManager.location[1] = RAW_ADDRESS(HW_LCDC_VRAM_G);
            paletteCount                      = 2;
            break;

        case GX_VRAM_TEXPLTT_0123_E:
            texturePalBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_E);
            texturePalBankManager.location[1] = RAW_ADDRESS(HW_LCDC_VRAM_E + (HW_VRAM_E_SIZE >> 2));
            texturePalBankManager.location[2] = RAW_ADDRESS(HW_LCDC_VRAM_E + (HW_VRAM_E_SIZE >> 2) + (HW_VRAM_E_SIZE >> 2));
            texturePalBankManager.location[3] = RAW_ADDRESS(HW_LCDC_VRAM_E + (HW_VRAM_E_SIZE >> 2) + (HW_VRAM_E_SIZE >> 2) + (HW_VRAM_E_SIZE >> 2));
            paletteCount                      = 4;
            break;

        case GX_VRAM_TEXPLTT_01234_EF:
            texturePalBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_E);
            texturePalBankManager.location[1] = RAW_ADDRESS(HW_LCDC_VRAM_E + (HW_VRAM_E_SIZE >> 2));
            texturePalBankManager.location[2] = RAW_ADDRESS(HW_LCDC_VRAM_E + (HW_VRAM_E_SIZE >> 2) + (HW_VRAM_E_SIZE >> 2));
            texturePalBankManager.location[3] = RAW_ADDRESS(HW_LCDC_VRAM_E + (HW_VRAM_E_SIZE >> 2) + (HW_VRAM_E_SIZE >> 2) + (HW_VRAM_E_SIZE >> 2));
            texturePalBankManager.location[4] = RAW_ADDRESS(HW_LCDC_VRAM_F);
            paletteCount                      = 5;
            break;

        case GX_VRAM_TEXPLTT_012345_EFG:
            texturePalBankManager.location[0] = RAW_ADDRESS(HW_LCDC_VRAM_E);
            texturePalBankManager.location[1] = RAW_ADDRESS(HW_LCDC_VRAM_E + (HW_VRAM_E_SIZE >> 2));
            texturePalBankManager.location[2] = RAW_ADDRESS(HW_LCDC_VRAM_E + (HW_VRAM_E_SIZE >> 2) + (HW_VRAM_E_SIZE >> 2));
            texturePalBankManager.location[3] = RAW_ADDRESS(HW_LCDC_VRAM_E + (HW_VRAM_E_SIZE >> 2) + (HW_VRAM_E_SIZE >> 2) + (HW_VRAM_E_SIZE >> 2));
            texturePalBankManager.location[4] = RAW_ADDRESS(HW_LCDC_VRAM_F);
            texturePalBankManager.location[5] = RAW_ADDRESS(HW_LCDC_VRAM_G);
            paletteCount                      = 6;
            break;

        default:
            GX_DisableBankForTexPltt();
            return;
    }

    GX_SetBankForTexPltt(bank);
}

void VRAMSystem__InitSpriteBuffer(BOOL useEngineB)
{
    MI_CpuClear16(vramSpriteAllocTable[useEngineB], sizeof(vramSpriteAllocTable[0]));
}

VRAMPixelKey VRAMSystem__AllocSpriteVram(BOOL useEngineB, size_t size)
{
    u32 count = objBankTileCount[useEngineB];

    u32 location = 0;
    while (location < count)
    {
        // only allocate sprites if the buffer entry hasn't been used of course!
        if (vramSpriteAllocTable[useEngineB][location] == 0)
        {
            // try to allocate 'size' entries sequentially
            u32 allocatedSize = 1;
            while (allocatedSize < size)
            {
                if (location + allocatedSize >= count)
                {
                    // we've gone outta bounds, no allocation for you!
                    return HeapNull;
                }

                if (vramSpriteAllocTable[useEngineB][location + allocatedSize] != 0)
                {
                    location += allocatedSize;
                    break;
                }

                allocatedSize++;
            }

            // only succeed if we're able to allocate every entry
            if (allocatedSize == size)
            {
                u8 *vram                                       = (u8 *)VRAMSystem__VRAM_OBJ[useEngineB];
                u32 id                                         = (objBankOffset[useEngineB] + location) << objBankShift[useEngineB];
                vramSpriteAllocTable[useEngineB][location] = size;

                return vram + (0x20 * id);
            }
        }

        // skip this sprite's children when advancing!
        location += vramSpriteAllocTable[useEngineB][location];
    }

    // generic failure
    return HeapNull;
}

void VRAMSystem__FreeSpriteVram(BOOL useEngineB, VRAMPixelKey key)
{
    if (key != HeapNull)
    {
        u32 spriteOffset = (size_t)key - (size_t)VRAMSystem__VRAM_OBJ[useEngineB];
        u32 bufferOffset = spriteOffset >> (5 + objBankShift[useEngineB]);

        vramSpriteAllocTable[useEngineB][bufferOffset - objBankOffset[useEngineB]] = 0;
    }
}

void VRAMSystem__InitTextureBuffer(void)
{
    MI_CpuClear16(vramTextureAllocTable, sizeof(vramTextureAllocTable));
    MI_CpuClear16(textureUnknown, sizeof(textureUnknown));
    MI_CpuClear16(vramPaletteAllocTable, sizeof(vramPaletteAllocTable));
}

VRAMPixelKey VRAMSystem__AllocTexture(size_t size, BOOL is4x4comp)
{
    u32 i;

    if (!size)
        return NULL;

    if (is4x4comp)
    {
        for (i = 0; i < 2; i++)
        {
            u32 id = vramTextureAllocBankID_4Pal_4x4Comp[i];
            if (id < textureCount)
            {
                VRAMPixelKey key = VRAMSystem__AllocTexFunc_4x4Comp(size, id);
                if (key != NULL)
                    return key;
            }
        }
    }
    else
    {
        for (i = 0; i < 4; i++)
        {
            u32 id = vramTextureAllocBankID_4Pal[i];
            if (id < textureCount)
            {
                VRAMPixelKey key = VRAMSystem__AllocTexFunc_Normal(size, id);
                if (key != NULL)
                    return key;
            }
        }
    }

    return NULL;
}

void VRAMSystem__FreeTexture(VRAMPixelKey key)
{
    if ((VRAMKEY_TO_KEY(key) & VRAMSYSTEM_FLAG_ALLOCATED) != 0)
    {
        u32 textureLocation = (VRAMKEY_TO_KEY(key) & 0x7FFFF) >> 9;

        if ((vramTextureAllocTable[textureLocation] & 0x8000) != 0)
        {
            u32 textureLocation2 = 0;
            if (textureLocation < VRAM_TEXTURE_BANK_SIZE)
                textureLocation2 = (textureLocation) >> 1;
            else
                textureLocation2 = (textureLocation - VRAM_TEXTURE_BANK_SIZE) >> 1;

            textureLocation2 += VRAM_TEXTURE_BANK_SIZE;
            vramTextureAllocTable[textureLocation2] = 0;
        }

        vramTextureAllocTable[textureLocation] = 0;
    }
}

u32 VRAMSystem__GetTextureUnknown(void)
{
    u32 spareTextureCount;
    u32 i;
    u32 t;

    spareTextureCount = 0;
    for (t = 0; t < textureCount; t++)
    {
        u16 *buffer = &vramTextureAllocTable[t * VRAM_TEXTURE_BANK_SIZE];

        for (i = 0; i < VRAM_TEXTURE_BANK_SIZE; i += buffer[i])
        {
            while (i < VRAM_TEXTURE_BANK_SIZE && buffer[i] == 0)
            {
                spareTextureCount++;
                i++;
            }
        }
    }

    return spareTextureCount << 9;
}

void VRAMSystem__InitPaletteBuffer(void)
{
    MI_CpuFill16(vramPaletteAllocTable, 0, sizeof(vramPaletteAllocTable));
}

VRAMPaletteKey VRAMSystem__AllocPalette(size_t size, BOOL is4pltt)
{
    const u8 *allocTable;
    u32 count;
    u32 i;

    if (!size)
        return NULL;

    if (is4pltt)
    {
        allocTable = vramPaletteAllocBankID_4Pal;
        count      = 4;
    }
    else
    {
        count      = 6;
        allocTable = vramPaletteAllocBankID;
    }

    for (i = 0; i < count; i++)
    {
        if (allocTable[i] < paletteCount)
        {
            VRAMPaletteKey key = VRAMSystem__AllocPalFunc(size, allocTable[i], &vramPaletteAllocTable[VRAM_PALETTE_BANK_SIZE * allocTable[i]], VRAM_PALETTE_BANK_SIZE, 4);
            if (key != NULL)
                return key;
        }
    }

    return NULL;
}

void VRAMSystem__FreePalette(VRAMPaletteKey key)
{
    if ((VRAMKEY_TO_KEY(key) & VRAMSYSTEM_FLAG_ALLOCATED) != 0)
    {
        u32 paletteLocation                             = VRAMKEY_TO_KEY(key) & 0x1FFFF;
        vramPaletteAllocTable[paletteLocation >> 5] = 0;
    }
}

u32 VRAMSystem__GetPaletteUnknown(void)
{
    u32 sparePaletteCount;
    u32 i;
    u32 p;

    sparePaletteCount = 0;
    for (p = 0; p < paletteCount; p++)
    {
        u16 *buffer = &vramPaletteAllocTable[p * VRAM_PALETTE_BANK_SIZE];

        for (i = 0; i < VRAM_PALETTE_BANK_SIZE; i += buffer[i])
        {
            while (i < VRAM_PALETTE_BANK_SIZE && buffer[i] == 0)
            {
                sparePaletteCount++;
                i++;
            }
        }
    }

    return sparePaletteCount << 5;
}

void *VRAMSystem__GetTexturePaletteAddr(s32 id)
{
    return texturePalBankManager.location[id];
}

NNSGfdTexKey VRAMSystem__AllocTexVram(u32 szByte, BOOL is4x4comp, u32 opt)
{
    VRAMPixelKey key = VRAMSystem__AllocTexture(szByte, is4x4comp);
    if (key == NULL)
        return 0;

    u32 size     = (szByte >> 4 << 16);
    u32 location = (VRAMKEY_TO_KEY(key) & 0x7FFFF) >> 3;
    u32 type     = is4x4comp ? (1 << 31) : (0 << 31);

    return location | size | type;
}

int VRAMSystem__FreeTexVram(NNSGfdTexKey texKey)
{
    VRAMSystem__FreeTexture(VRAMKEY_TO_ADDR(((texKey << 16) >> 13) | VRAMSYSTEM_FLAG_ALLOCATED));
    return 0;
}

NNSGfdPlttKey VRAMSystem__AllocPlttVram(u32 szByte, BOOL is4pltt, u32 opt)
{
    VRAMPaletteKey key = VRAMSystem__AllocPalette(szByte << 15 >> 16, is4pltt);
    if (key == NULL)
        return 0;

    return (szByte >> 3 << 16) | ((VRAMKEY_TO_KEY(key) & 0x1FFFF) >> 3);
}

int VRAMSystem__FreePlttVram(NNSGfdPlttKey plttKey)
{
    VRAMSystem__FreePalette(VRAMKEY_TO_ADDR(((plttKey << 16) >> 13) | VRAMSYSTEM_FLAG_ALLOCATED));
    return 0;
}

VRAMPixelKey VRAMSystem__AllocTexFunc_4x4Comp(size_t size, s32 id)
{
    u16 *textureBuffer  = &vramTextureAllocTable[VRAM_TEXTURE_BANK_SIZE * id];
    u16 *textureBuffer2 = &vramTextureAllocTable[(1 * VRAM_TEXTURE_BANK_SIZE)];

    u32 alignedSize = (u32)(size + 511) >> 9;

    for (u32 location = 0; location < VRAM_TEXTURE_BANK_SIZE; location += textureBuffer[location])
    {
        if (textureBuffer[location] == 0)
        {
            // try to allocate 'size' entries sequentially
            u32 allocatedSize = 1;
            while (allocatedSize < alignedSize)
            {
                if (location + allocatedSize >= VRAM_TEXTURE_BANK_SIZE)
                {
                    // we've gone outta bounds, no allocation for you!
                    return NULL;
                }

                if (textureBuffer[location + allocatedSize] != 0)
                {
                    location += allocatedSize;
                    break;
                }

                allocatedSize++;
            }

            // only succeed if we're able to allocate every entry
            if (allocatedSize == alignedSize)
            {
                BOOL isValid = FALSE;

                u32 location2 = location >> 1;
                if (id != 0)
                    location2 += VRAM_TEXTURE_BANK_SIZE;

                u32 offset2 = location2;
                while (offset2 != 0xFFFFFFFF)
                {
                    if (textureBuffer2[offset2] != 0)
                    {
                        if (textureBuffer2[offset2] <= location2 - offset2)
                        {
                            isValid = TRUE;
                        }

                        break;
                    }

                    offset2--;
                }

                if (offset2 == 0xFFFFFFFF)
                    isValid = TRUE;

                if (isValid)
                {
                    u32 alignedSize2   = (alignedSize + 1) >> 1;
                    u32 allocatedSize2 = 1;

                    while (allocatedSize2 < alignedSize2)
                    {
                        if (location2 + allocatedSize2 >= VRAM_TEXTURE_BANK_SIZE)
                            break;

                        if (textureBuffer2[location2 + allocatedSize2] != 0)
                            break;

                        allocatedSize2++;
                    }

                    if (allocatedSize2 == alignedSize2)
                    {
                        u32 key                   = ((id << 17) + (location << 9));
                        textureBuffer[location]   = alignedSize | 0x8000;
                        textureBuffer2[location2] = alignedSize2 | 0x8000;
                        return VRAMKEY_TO_ADDR(key | VRAMSYSTEM_FLAG_ALLOCATED);
                    }
                }

                location++;
            }
        }
    }

    // generic failure :(
    return NULL;
}

VRAMPixelKey VRAMSystem__AllocTexFunc_Normal(size_t size, s32 id)
{
    u16 *textureBuffer = &vramTextureAllocTable[VRAM_TEXTURE_BANK_SIZE * id];
    u32 alignedSize    = (u32)(size + 511) >> 9;

    for (u32 location = 0; location < VRAM_TEXTURE_BANK_SIZE; location += textureBuffer[location])
    {
        if (textureBuffer[location] == 0)
        {
            // try to allocate 'size' entries sequentially
            u32 allocatedSize = 1;
            while (allocatedSize < alignedSize)
            {
                if (location + allocatedSize >= VRAM_TEXTURE_BANK_SIZE)
                {
                    // we've gone outta bounds, no allocation for you!
                    return NULL;
                }

                if (textureBuffer[location + allocatedSize] != 0)
                {
                    location += allocatedSize;
                    break;
                }

                allocatedSize++;
            }

            // only succeed if we're able to allocate every entry
            if (allocatedSize == alignedSize)
            {
                u32 key                 = ((id << 17) + (location << 9));
                textureBuffer[location] = alignedSize;
                return VRAMKEY_TO_ADDR(key | VRAMSYSTEM_FLAG_ALLOCATED);
            }
        }
    }

    // generic failure :(
    return NULL;
}

VRAMPaletteKey VRAMSystem__AllocPalFunc(size_t size, s32 id, u16 *palettePtr, u32 paletteSize, u32 shift)
{
    u32 alignedSize = (u32)(size + (1 << shift) - 1) >> shift;

    for (u32 location = 0; location < paletteSize; location += palettePtr[location])
    {
        if (palettePtr[location] == 0)
        {
            // try to allocate 'size' entries sequentially
            u32 allocatedSize = 1;
            while (allocatedSize < alignedSize)
            {
                if (location + allocatedSize >= paletteSize)
                {
                    // we've gone outta bounds, no allocation for you!
                    return NULL;
                }

                if (palettePtr[location + allocatedSize] != 0)
                {
                    location += allocatedSize;
                    break;
                }

                allocatedSize++;
            }

            // only succeed if we're able to allocate every entry
            if (allocatedSize == alignedSize)
            {
                u32 key              = ((location << (shift + 1)) + (id << 14));
                palettePtr[location] = alignedSize;
                return VRAMKEY_TO_ADDR(key | VRAMSYSTEM_FLAG_ALLOCATED);
            }
        }
    }

    // generic failure :(
    return NULL;
}
