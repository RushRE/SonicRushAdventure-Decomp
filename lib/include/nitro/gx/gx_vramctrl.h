#ifndef NITRO_GX_GX_VRAMCNT_H
#define NITRO_GX_GX_VRAMCNT_H

#include <nitro/gx/gxcommon.h>
#include <nitro/os/ARM9/vramExclusive.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// ENUMS
// --------------------

typedef enum
{
    GX_VRAM_A   = OS_VRAM_BANK_ID_A, // VRAM-A
    GX_VRAM_B   = OS_VRAM_BANK_ID_B, // VRAM-B
    GX_VRAM_C   = OS_VRAM_BANK_ID_C, // VRAM-C
    GX_VRAM_D   = OS_VRAM_BANK_ID_D, // VRAM-D
    GX_VRAM_E   = OS_VRAM_BANK_ID_E, // VRAM-E
    GX_VRAM_F   = OS_VRAM_BANK_ID_F, // VRAM-F
    GX_VRAM_G   = OS_VRAM_BANK_ID_G, // VRAM-G
    GX_VRAM_H   = OS_VRAM_BANK_ID_H, // VRAM-H
    GX_VRAM_I   = OS_VRAM_BANK_ID_I, // VRAM-I
    GX_VRAM_ALL = OS_VRAM_BANK_ID_ALL
} GXVRam;

typedef enum
{
    GX_VRAM_LCDC_NONE = 0x0000,
    GX_VRAM_LCDC_A    = GX_VRAM_A,
    GX_VRAM_LCDC_B    = GX_VRAM_B,
    GX_VRAM_LCDC_C    = GX_VRAM_C,
    GX_VRAM_LCDC_D    = GX_VRAM_D,
    GX_VRAM_LCDC_E    = GX_VRAM_E,
    GX_VRAM_LCDC_F    = GX_VRAM_F,
    GX_VRAM_LCDC_G    = GX_VRAM_G,
    GX_VRAM_LCDC_H    = GX_VRAM_H,
    GX_VRAM_LCDC_I    = GX_VRAM_I,
    GX_VRAM_LCDC_ALL  = GX_VRAM_ALL
} GXVRamLCDC;

typedef enum
{
    GX_VRAM_BG_NONE     = 0x0000,
    GX_VRAM_BG_16_F     = GX_VRAM_F,
    GX_VRAM_BG_16_G     = GX_VRAM_G,
    GX_VRAM_BG_32_FG    = GX_VRAM_F | GX_VRAM_G,
    GX_VRAM_BG_64_E     = GX_VRAM_E,
    GX_VRAM_BG_80_EF    = GX_VRAM_E | GX_VRAM_F,
    GX_VRAM_BG_96_EFG   = GX_VRAM_E | GX_VRAM_F | GX_VRAM_G,
    GX_VRAM_BG_128_A    = GX_VRAM_A,
    GX_VRAM_BG_128_B    = GX_VRAM_B,
    GX_VRAM_BG_128_C    = GX_VRAM_C,
    GX_VRAM_BG_128_D    = GX_VRAM_D,
    GX_VRAM_BG_256_AB   = GX_VRAM_A | GX_VRAM_B,
    GX_VRAM_BG_256_BC   = GX_VRAM_B | GX_VRAM_C,
    GX_VRAM_BG_256_CD   = GX_VRAM_C | GX_VRAM_D,
    GX_VRAM_BG_384_ABC  = GX_VRAM_A | GX_VRAM_B | GX_VRAM_C,
    GX_VRAM_BG_384_BCD  = GX_VRAM_B | GX_VRAM_C | GX_VRAM_D,
    GX_VRAM_BG_512_ABCD = GX_VRAM_A | GX_VRAM_B | GX_VRAM_C | GX_VRAM_D,
    GX_VRAM_BG_80_EG    = GX_VRAM_E | GX_VRAM_G,
    GX_VRAM_BG_256_AC   = GX_VRAM_A | GX_VRAM_C,
    GX_VRAM_BG_256_AD   = GX_VRAM_A | GX_VRAM_D,
    GX_VRAM_BG_256_BD   = GX_VRAM_B | GX_VRAM_D,
    GX_VRAM_BG_384_ABD  = GX_VRAM_A | GX_VRAM_B | GX_VRAM_D,
    GX_VRAM_BG_384_ACD  = GX_VRAM_A | GX_VRAM_C | GX_VRAM_D
} GXVRamBG;

typedef enum
{
    GX_VRAM_OBJ_NONE   = 0x0000,
    GX_VRAM_OBJ_16_F   = GX_VRAM_F,
    GX_VRAM_OBJ_16_G   = GX_VRAM_G,
    GX_VRAM_OBJ_32_FG  = GX_VRAM_F | GX_VRAM_G,
    GX_VRAM_OBJ_64_E   = GX_VRAM_E,
    GX_VRAM_OBJ_80_EF  = GX_VRAM_E | GX_VRAM_F,
    GX_VRAM_OBJ_80_EG  = GX_VRAM_E | GX_VRAM_G,
    GX_VRAM_OBJ_96_EFG = GX_VRAM_E | GX_VRAM_F | GX_VRAM_G,
    GX_VRAM_OBJ_128_A  = GX_VRAM_A,
    GX_VRAM_OBJ_128_B  = GX_VRAM_B,
    GX_VRAM_OBJ_256_AB = GX_VRAM_A | GX_VRAM_B
} GXVRamOBJ;

typedef enum
{
    GX_VRAM_TEX_NONE      = 0x0000,
    GX_VRAM_TEX_0_A       = GX_VRAM_A,
    GX_VRAM_TEX_0_B       = GX_VRAM_B,
    GX_VRAM_TEX_0_C       = GX_VRAM_C,
    GX_VRAM_TEX_0_D       = GX_VRAM_D,
    GX_VRAM_TEX_01_AB     = GX_VRAM_A | GX_VRAM_B,
    GX_VRAM_TEX_01_BC     = GX_VRAM_B | GX_VRAM_C,
    GX_VRAM_TEX_01_CD     = GX_VRAM_C | GX_VRAM_D,
    GX_VRAM_TEX_012_ABC   = GX_VRAM_A | GX_VRAM_B | GX_VRAM_C,
    GX_VRAM_TEX_012_BCD   = GX_VRAM_B | GX_VRAM_C | GX_VRAM_D,
    GX_VRAM_TEX_0123_ABCD = GX_VRAM_A | GX_VRAM_B | GX_VRAM_C | GX_VRAM_D,
    GX_VRAM_TEX_01_AC     = GX_VRAM_A | GX_VRAM_C,
    GX_VRAM_TEX_01_AD     = GX_VRAM_A | GX_VRAM_D,
    GX_VRAM_TEX_01_BD     = GX_VRAM_B | GX_VRAM_D,
    GX_VRAM_TEX_012_ABD   = GX_VRAM_A | GX_VRAM_B | GX_VRAM_D,
    GX_VRAM_TEX_012_ACD   = GX_VRAM_A | GX_VRAM_C | GX_VRAM_D
} GXVRamTex;

typedef enum
{
    GX_VRAM_CLEARIMAGE_NONE   = 0x0000,
    GX_VRAM_CLEARIMAGE_256_AB = GX_VRAM_A | GX_VRAM_B,
    GX_VRAM_CLEARIMAGE_256_CD = GX_VRAM_C | GX_VRAM_D,
    GX_VRAM_CLEARDEPTH_128_A  = GX_VRAM_A,
    GX_VRAM_CLEARDEPTH_128_B  = GX_VRAM_B,
    GX_VRAM_CLEARDEPTH_128_C  = GX_VRAM_C,
    GX_VRAM_CLEARDEPTH_128_D  = GX_VRAM_D
} GXVRamClearImage;

typedef enum
{
    GX_VRAM_TEXPLTT_NONE       = 0x0000,
    GX_VRAM_TEXPLTT_0_F        = GX_VRAM_F,
    GX_VRAM_TEXPLTT_0_G        = GX_VRAM_G,
    GX_VRAM_TEXPLTT_01_FG      = GX_VRAM_F | GX_VRAM_G,
    GX_VRAM_TEXPLTT_0123_E     = GX_VRAM_E,
    GX_VRAM_TEXPLTT_01234_EF   = GX_VRAM_E | GX_VRAM_F,
    GX_VRAM_TEXPLTT_012345_EFG = GX_VRAM_E | GX_VRAM_F | GX_VRAM_G
} GXVRamTexPltt;

typedef enum
{
    GX_VRAM_BGEXTPLTT_NONE    = 0x0000,
    GX_VRAM_BGEXTPLTT_01_F    = GX_VRAM_F,
    GX_VRAM_BGEXTPLTT_23_G    = GX_VRAM_G,
    GX_VRAM_BGEXTPLTT_0123_E  = GX_VRAM_E,
    GX_VRAM_BGEXTPLTT_0123_FG = GX_VRAM_F | GX_VRAM_G
} GXVRamBGExtPltt;

typedef enum
{
    GX_VRAM_OBJEXTPLTT_NONE = 0,
    GX_VRAM_OBJEXTPLTT_0_F  = GX_VRAM_F,
    GX_VRAM_OBJEXTPLTT_0_G  = GX_VRAM_G
} GXVRamOBJExtPltt;

typedef enum
{
    GX_VRAM_SUB_BG_NONE  = 0x0000,
    GX_VRAM_SUB_BG_128_C = GX_VRAM_C,
    GX_VRAM_SUB_BG_32_H  = GX_VRAM_H,
    GX_VRAM_SUB_BG_48_HI = GX_VRAM_H | GX_VRAM_I
} GXVRamSubBG;

typedef enum
{
    GX_VRAM_SUB_OBJ_NONE  = 0x0000,
    GX_VRAM_SUB_OBJ_128_D = GX_VRAM_D,
    GX_VRAM_SUB_OBJ_16_I  = GX_VRAM_I
} GXVRamSubOBJ;

typedef enum
{
    GX_VRAM_SUB_BGEXTPLTT_NONE   = 0x0000,
    GX_VRAM_SUB_BGEXTPLTT_0123_H = GX_VRAM_H
} GXVRamSubBGExtPltt;

typedef enum
{
    GX_VRAM_SUB_OBJEXTPLTT_NONE = 0x0000,
    GX_VRAM_SUB_OBJEXTPLTT_0_I  = GX_VRAM_I
} GXVRamSubOBJExtPltt;

typedef enum
{
    GX_VRAM_ARM7_NONE   = 0x0000,
    GX_VRAM_ARM7_128_C  = GX_VRAM_C,           
    GX_VRAM_ARM7_128_D  = GX_VRAM_D,           
    GX_VRAM_ARM7_256_CD = GX_VRAM_C | GX_VRAM_D
} GXVRamARM7;

// --------------------
// FUNCTIONS
// --------------------

void GX_SetBankForBG(GXVRamBG bg);
BOOL GX_TrySetBankForBG(GXVRamBG bg);
void GX_SetBankForBGEx(GXVRamBG bg1, GXVRamBG bg2);
BOOL GX_TrySetBankForBGEx(GXVRamBG bg1, GXVRamBG bg2);
void GX_SetBankForOBJ(GXVRamOBJ obj);
BOOL GX_TrySetBankForOBJ(GXVRamOBJ obj);
void GX_SetBankForBGExtPltt(GXVRamBGExtPltt bgExtPltt);
BOOL GX_TrySetBankForBGExtPltt(GXVRamBGExtPltt bgExtPltt);
void GX_SetBankForOBJExtPltt(GXVRamOBJExtPltt objExtPltt);
BOOL GX_TrySetBankForOBJExtPltt(GXVRamOBJExtPltt objExtPltt);
void GX_SetBankForTex(GXVRamTex tex);
BOOL GX_TrySetBankForTex(GXVRamTex tex);
void GX_SetBankForTexPltt(GXVRamTexPltt texPltt);
BOOL GX_TrySetBankForTexPltt(GXVRamTexPltt texPltt);
void GX_SetBankForClearImage(GXVRamClearImage clrImg);
BOOL GX_TrySetBankForClearImage(GXVRamClearImage clrImg);

GXVRamBG GX_GetBankForBG(void);
GXVRamOBJ GX_GetBankForOBJ(void);
GXVRamBGExtPltt GX_GetBankForBGExtPltt(void);
GXVRamOBJExtPltt GX_GetBankForOBJExtPltt(void);
GXVRamTex GX_GetBankForTex(void);
GXVRamTexPltt GX_GetBankForTexPltt(void);
GXVRamClearImage GX_GetBankForClearImage(void);

GXVRamBG GX_ResetBankForBG(void);
GXVRamOBJ GX_ResetBankForOBJ(void);
GXVRamBGExtPltt GX_ResetBankForBGExtPltt(void);
GXVRamOBJExtPltt GX_ResetBankForOBJExtPltt(void);
GXVRamTex GX_ResetBankForTex(void);
GXVRamTexPltt GX_ResetBankForTexPltt(void);
GXVRamClearImage GX_ResetBankForClearImage(void);

GXVRamBG GX_DisableBankForBG(void);
GXVRamOBJ GX_DisableBankForOBJ(void);
GXVRamBGExtPltt GX_DisableBankForBGExtPltt(void);
GXVRamOBJExtPltt GX_DisableBankForOBJExtPltt(void);
GXVRamTex GX_DisableBankForTex(void);
GXVRamTexPltt GX_DisableBankForTexPltt(void);
GXVRamClearImage GX_DisableBankForClearImage(void);

u32 GX_GetSizeOfBG(void);
u32 GX_GetSizeOfOBJ(void);
u32 GX_GetSizeOfBGExtPltt(void);
u32 GX_GetSizeOfOBJExtPltt(void);
u32 GX_GetSizeOfTex(void);
u32 GX_GetSizeOfTexPltt(void);
u32 GX_GetSizeOfClearImage(void);

void GX_SetBankForSubBG(GXVRamSubBG sub_bg);
void GX_SetBankForSubOBJ(GXVRamSubOBJ sub_obj);
void GX_SetBankForSubBGExtPltt(GXVRamSubBGExtPltt sub_bgExtPltt);
void GX_SetBankForSubOBJExtPltt(GXVRamSubOBJExtPltt sub_objExtPltt);

GXVRamSubBG GX_GetBankForSubBG(void);
GXVRamSubOBJ GX_GetBankForSubOBJ(void);
GXVRamSubBGExtPltt GX_GetBankForSubBGExtPltt(void);
GXVRamSubOBJExtPltt GX_GetBankForSubOBJExtPltt(void);

GXVRamSubBG GX_ResetBankForSubBG(void);
GXVRamSubOBJ GX_ResetBankForSubOBJ(void);
GXVRamSubBGExtPltt GX_ResetBankForSubBGExtPltt(void);
GXVRamSubOBJExtPltt GX_ResetBankForSubOBJExtPltt(void);

GXVRamSubBG GX_DisableBankForSubBG(void);
GXVRamSubOBJ GX_DisableBankForSubOBJ(void);
GXVRamSubBGExtPltt GX_DisableBankForSubBGExtPltt(void);
GXVRamSubOBJExtPltt GX_DisableBankForSubOBJExtPltt(void);

u32 GX_GetSizeOfSubBG(void);
u32 GX_GetSizeOfSubOBJ(void);
u32 GX_GetSizeOfSubBGExtPltt(void);
u32 GX_GetSizeOfSubOBJExtPltt(void);

void GX_SetBankForARM7(GXVRamARM7 arm7);
void GX_SetBankForLCDC(int lcdc);

GXVRamARM7 GX_GetBankForARM7(void);
GXVRamLCDC GX_GetBankForLCDC(void);

GXVRamARM7 GX_ResetBankForARM7(void);

GXVRamARM7 GX_DisableBankForARM7(void);
GXVRamLCDC GX_DisableBankForLCDC(void);

u32 GX_GetSizeOfARM7(void);

#ifdef __cplusplus
}
#endif

#endif // NITRO_GX_GX_VRAMCNT_H
