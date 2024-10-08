#ifndef NITRO_GX_GX_H
#define NITRO_GX_GX_H

#include <nitro/types.h>
#include <nitro/hw/io_reg.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// CONSTANTS
// --------------------

#define GX_LCD_SIZE_X HW_LCD_WIDTH
#define GX_LCD_SIZE_Y HW_LCD_HEIGHT

// --------------------
// STRUCTS
// --------------------

// Display control register (Main engine)
typedef union
{
    u32 raw;
    struct
    {
        u32 bgMode : 3;
        u32 bg0_2d3d : 1;
        u32 objMapChar : 1;
        u32 objMapBmp : 2;
        u32 blankScr : 1;
        u32 visiblePlane : 5;
        u32 visibleWnd : 3;
        u32 dispMode : 4;
        u32 extObjMapChar : 2;
        u32 extObjMapBmp : 1;
        u32 hBlankObjProc : 1;
        u32 bgCharOffset : 3;
        u32 bgScrOffset : 3;
        u32 bgExtPltt : 1;
        u32 objExtPltt : 1;
    };
} GXDispCnt;

// Display control register (Sub engine)
typedef union
{
    u32 raw;
    struct
    {
        u32 bgMode : 3;
        u32 _reserve1 : 1;
        u32 objMapChar : 1;
        u32 objMapBmp : 2;
        u32 blankScr : 1;
        u32 visiblePlane : 5;
        u32 visibleWnd : 3;
        u32 dispMode : 1;
        u32 _reserve2 : 3;
        u32 extObjMapChar : 2;
        u32 _reserve3 : 1;
        u32 hBlankObjProc : 1;
        u32 _reserve4 : 6;
        u32 bgExtPltt : 1;
        u32 objExtPltt : 1;
    };
} GXSDispCnt;

// --------------------
// ENUMS
// --------------------

typedef enum
{
    GX_DISPMODE_OFF      = 0x00,
    GX_DISPMODE_GRAPHICS = 0x01,
    GX_DISPMODE_VRAM_A   = 0x02,
    GX_DISPMODE_VRAM_B   = 0x06,
    GX_DISPMODE_VRAM_C   = 0x0a,
    GX_DISPMODE_VRAM_D   = 0x0e,
    GX_DISPMODE_MMEM     = 0x03
} GXDispMode;

typedef enum
{
    GX_BGMODE_0 = 0,
    GX_BGMODE_1 = 1,
    GX_BGMODE_2 = 2,
    GX_BGMODE_3 = 3,
    GX_BGMODE_4 = 4,
    GX_BGMODE_5 = 5,
    GX_BGMODE_6 = 6
} GXBGMode;

typedef enum
{
    GX_BG0_AS_2D = 0,
    GX_BG0_AS_3D = 1
} GXBG0As;

typedef enum
{
    GX_BGSCROFFSET_0x00000 = 0x00,
    GX_BGSCROFFSET_0x10000 = 0x01,
    GX_BGSCROFFSET_0x20000 = 0x02,
    GX_BGSCROFFSET_0x30000 = 0x03,
    GX_BGSCROFFSET_0x40000 = 0x04,
    GX_BGSCROFFSET_0x50000 = 0x05,
    GX_BGSCROFFSET_0x60000 = 0x06,
    GX_BGSCROFFSET_0x70000 = 0x07
} GXBGScrOffset;

typedef enum
{
    GX_BGCHAROFFSET_0x00000 = 0x00,
    GX_BGCHAROFFSET_0x10000 = 0x01,
    GX_BGCHAROFFSET_0x20000 = 0x02,
    GX_BGCHAROFFSET_0x30000 = 0x03,
    GX_BGCHAROFFSET_0x40000 = 0x04,
    GX_BGCHAROFFSET_0x50000 = 0x05,
    GX_BGCHAROFFSET_0x60000 = 0x06,
    GX_BGCHAROFFSET_0x70000 = 0x07
} GXBGCharOffset;

typedef enum
{
    GX_OBJVRAMMODE_CHAR_2D      = (0 << REG_GX_DISPCNT_OBJMAP_SHIFT) | (0 << REG_GX_DISPCNT_EXOBJ_SHIFT),
    GX_OBJVRAMMODE_CHAR_1D_32K  = (1 << REG_GX_DISPCNT_OBJMAP_SHIFT) | (0 << REG_GX_DISPCNT_EXOBJ_SHIFT),
    GX_OBJVRAMMODE_CHAR_1D_64K  = (1 << REG_GX_DISPCNT_OBJMAP_SHIFT) | (1 << REG_GX_DISPCNT_EXOBJ_SHIFT),
    GX_OBJVRAMMODE_CHAR_1D_128K = (1 << REG_GX_DISPCNT_OBJMAP_SHIFT) | (2 << REG_GX_DISPCNT_EXOBJ_SHIFT),
    GX_OBJVRAMMODE_CHAR_1D_256K = (1 << REG_GX_DISPCNT_OBJMAP_SHIFT) | (3 << REG_GX_DISPCNT_EXOBJ_SHIFT)
} GXOBJVRamModeChar;

typedef enum
{
    GX_OBJVRAMMODE_BMP_2D_W128 = (0 << (REG_GX_DISPCNT_OBJMAP_SHIFT + 1)) | (0 << (REG_GX_DISPCNT_EXOBJ_SHIFT + 2)),
    GX_OBJVRAMMODE_BMP_2D_W256 = (1 << (REG_GX_DISPCNT_OBJMAP_SHIFT + 1)) | (0 << (REG_GX_DISPCNT_EXOBJ_SHIFT + 2)),
    GX_OBJVRAMMODE_BMP_1D_128K = (2 << (REG_GX_DISPCNT_OBJMAP_SHIFT + 1)) | (0 << (REG_GX_DISPCNT_EXOBJ_SHIFT + 2)),
    GX_OBJVRAMMODE_BMP_1D_256K = (2 << (REG_GX_DISPCNT_OBJMAP_SHIFT + 1)) | (1 << (REG_GX_DISPCNT_EXOBJ_SHIFT + 2))
} GXOBJVRamModeBmp;

typedef enum
{
    GX_POWER_OFF = 0,

    GX_POWER_2D_MAIN = 1 << REG_GX_POWCNT_E2DG_SHIFT,
    GX_POWER_2D_SUB  = 1 << REG_GX_POWCNT_E2DGB_SHIFT,

    GX_POWER_RE = 1 << REG_GX_POWCNT_RE_SHIFT,
    GX_POWER_GE = 1 << REG_GX_POWCNT_GE_SHIFT,

    GX_POWER_2D = GX_POWER_2D_MAIN | GX_POWER_2D_SUB,
    GX_POWER_3D = GX_POWER_RE | GX_POWER_GE,

    GX_POWER_ALL = GX_POWER_2D | GX_POWER_3D
} GXPower;

typedef enum
{
    GX_DISP_SELECT_SUB_MAIN = 0,
    GX_DISP_SELECT_MAIN_SUB = 1
} GXDispSelect;

typedef enum
{
    GX_PLANEMASK_NONE = 0,

    GX_PLANEMASK_BG0 = (1 << 0),
    GX_PLANEMASK_BG1 = (1 << 1),
    GX_PLANEMASK_BG2 = (1 << 2),
    GX_PLANEMASK_BG3 = (1 << 3),
    GX_PLANEMASK_OBJ = (1 << 4),

    GX_PLANEMASK_ALL = GX_PLANEMASK_BG0 | GX_PLANEMASK_BG1 | GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3 | GX_PLANEMASK_OBJ,
} GXPlaneMask;

typedef enum
{
    GX_WNDMASK_NONE = 0x00,
    GX_WNDMASK_W0   = 0x01,
    GX_WNDMASK_W1   = 0x02,
    GX_WNDMASK_OW   = 0x04
} GXWndMask;

// --------------------
// FUNCTIONS
// --------------------

// reg_GX_POWCNT
static void GX_SetPower(int gxbit_power /* GXPower*/);
static GXPower GX_GetPower(void);

static void GX_Power2DMain(BOOL enable);
static void GX_Power2DSub(BOOL enable);

static void GX_PowerRender(BOOL enable);
static void GX_PowerGeometry(BOOL enable);

static void GXi_PowerLCD(BOOL enable);
static void GX_Power2D(BOOL enable);
static void GX_Power3D(BOOL enable);

static void GX_SetDispSelect(GXDispSelect sel);
static GXDispSelect GX_GetDispSelect(void);

// reg_GX_DISPSTAT
static s32 GX_IsHBlank(void);
s32 GX_HBlankIntr(BOOL enable);
static s32 GX_IsVBlank(void);
s32 GX_VBlankIntr(BOOL enable);
static s32 GX_IsVCountEq(void);
static void GX_VCountEqIntr(BOOL enable);
void GX_SetVCountEqVal(s32 val);
static s32 GX_GetVCountEqVal(void);

#define GX_IsVCounterEq     GX_IsVCountEq
#define GX_VCounterEqIntr   GX_VCountEqIntr
#define GX_SetVCounterEqVal GX_SetVCountEqVal
#define GX_GetVCounterEqVal GX_GetVCountEqVal

// reg_GX_VCOUNT
static s32 GX_GetVCount(void);
static void GX_SetVCount(s32 count);

void GX_Init(void);
static void GX_InitEx(u32 dma_no);
u32 GX_SetDefaultDMA(u32 dma_no);
static u32 GX_GetDefaultDMA(void);

// Main 2D Engine

// reg_GX_DISPCNT
void GX_SetGraphicsMode(GXDispMode dispMode, GXBGMode bgMode, GXBG0As bg0_2d3d);
void GX_DispOff(void);
void GX_DispOn(void);
BOOL GX_IsDispOn(void);

static void GX_SetVisiblePlane(int plane /* GXPlaneMask*/);
static void GX_SetVisibleWnd(int window /* GXWndMask*/);
static void GX_BlankScr(BOOL blank);

static GXBGScrOffset GX_GetBGScrOffset();
static void GX_SetBGScrOffset(GXBGScrOffset offset);

static GXBGCharOffset GX_GetBGCharOffset();
static void GX_SetBGCharOffset(GXBGCharOffset offset);

static void GX_SetOBJVRamModeChar(GXOBJVRamModeChar mode);
static void GX_SetOBJVRamModeBmp(GXOBJVRamModeBmp mode);

static void GX_HBlankOBJProc(BOOL proc);

// reg_GX_MASTER_BRIGHT
static void GX_SetMasterBrightness(int brightness);

// Sub 2D Engine

void GXS_SetGraphicsMode(GXBGMode bgMode);
static void GXS_DispOff(void);
static void GXS_DispOn(void);

static void GXS_SetVisiblePlane(int plane /* GXPlaneMask*/);
static void GXS_SetVisibleWnd(int window /* GXWndMask*/);

static void GXS_SetOBJVRamModeChar(GXOBJVRamModeChar mode);
static void GXS_SetOBJVRamModeBmp(GXOBJVRamModeBmp mode);

static void GXS_HBlankOBJProc(BOOL proc);

static void GXS_SetMasterBrightness(int brightness);

// --------------------
// INTERNAL FUNCTIONS
// --------------------

void GXx_SetMasterBrightness_(vu16 *reg, int brightness);
int GXx_GetMasterBrightness_(vu16 *reg);

// --------------------
// INLINE FUNCTIONS
// --------------------

static inline GXDispCnt GX_GetDispCnt(void)
{
    return *(volatile GXDispCnt *)REG_DISPCNT_ADDR;
}

static inline GXSDispCnt GXS_GetDispCnt(void)
{
    return *(volatile GXSDispCnt *)REG_DB_DISPCNT_ADDR;
}

static inline GXBGScrOffset GX_GetBGScrOffset(void)
{
    return (GXBGScrOffset)((reg_GX_DISPCNT & REG_GX_DISPCNT_BGSCREENOFFSET_MASK) >> REG_GX_DISPCNT_BGSCREENOFFSET_SHIFT);
}

static inline void GX_SetBGScrOffset(GXBGScrOffset offset)
{
    reg_GX_DISPCNT = (u32)((reg_GX_DISPCNT & ~REG_GX_DISPCNT_BGSCREENOFFSET_MASK) | (offset << REG_GX_DISPCNT_BGSCREENOFFSET_SHIFT));
}

static inline GXBGCharOffset GX_GetBGCharOffset(void)
{
    return (GXBGCharOffset)((reg_GX_DISPCNT & REG_GX_DISPCNT_BGCHAROFFSET_MASK) >> REG_GX_DISPCNT_BGCHAROFFSET_SHIFT);
}

static inline void GX_SetBGCharOffset(GXBGCharOffset offset)
{
    reg_GX_DISPCNT = (u32)((reg_GX_DISPCNT & ~REG_GX_DISPCNT_BGCHAROFFSET_MASK) | (offset << REG_GX_DISPCNT_BGCHAROFFSET_SHIFT));
}

static inline void GX_SetVisiblePlane(int plane)
{
    reg_GX_DISPCNT = (u32)((reg_GX_DISPCNT & ~REG_GX_DISPCNT_DISPLAY_MASK) | (plane << REG_GX_DISPCNT_DISPLAY_SHIFT));
}

static inline int GX_GetVisiblePlane(void)
{
    return (int)((reg_GX_DISPCNT & REG_GX_DISPCNT_DISPLAY_MASK) >> REG_GX_DISPCNT_DISPLAY_SHIFT);
}

static inline void GXS_SetVisiblePlane(int plane)
{
    reg_GXS_DB_DISPCNT = (u32)((reg_GXS_DB_DISPCNT & ~REG_GXS_DB_DISPCNT_DISPLAY_MASK) | (plane << REG_GXS_DB_DISPCNT_DISPLAY_SHIFT));
}

static inline int GXS_GetVisiblePlane(void)
{
    return (int)((reg_GXS_DB_DISPCNT & REG_GXS_DB_DISPCNT_DISPLAY_MASK) >> REG_GXS_DB_DISPCNT_DISPLAY_SHIFT);
}

static inline void GX_SetVisibleWnd(int window)
{
    reg_GX_DISPCNT = (u32)((reg_GX_DISPCNT & ~(REG_GX_DISPCNT_W0_MASK | REG_GX_DISPCNT_W1_MASK | REG_GX_DISPCNT_OW_MASK)) | (window << REG_GX_DISPCNT_W0_SHIFT));
}

static inline int GX_GetVisibleWnd(void)
{
    return (int)((reg_GX_DISPCNT & (REG_GX_DISPCNT_W0_MASK | REG_GX_DISPCNT_W1_MASK | REG_GX_DISPCNT_OW_MASK)) >> REG_GX_DISPCNT_W0_SHIFT);
}

static inline void GXS_SetVisibleWnd(int window)
{
    reg_GXS_DB_DISPCNT = (u32)((reg_GXS_DB_DISPCNT & ~(REG_GXS_DB_DISPCNT_W0_MASK | REG_GXS_DB_DISPCNT_W1_MASK | REG_GXS_DB_DISPCNT_OW_MASK)) | (window << REG_GXS_DB_DISPCNT_W0_SHIFT));
}

static inline int GXS_GetVisibleWnd(void)
{
    return (int)((reg_GXS_DB_DISPCNT & (REG_GXS_DB_DISPCNT_W0_MASK | REG_GXS_DB_DISPCNT_W1_MASK | REG_GXS_DB_DISPCNT_OW_MASK)) >> REG_GXS_DB_DISPCNT_W0_SHIFT);
}

static inline void GX_SetOBJVRamModeChar(GXOBJVRamModeChar mode)
{
    reg_GX_DISPCNT = (u32)(reg_GX_DISPCNT & ~(REG_GX_DISPCNT_EXOBJ_CH_MASK | REG_GX_DISPCNT_OBJMAP_CH_MASK) | mode);
}

static inline GXOBJVRamModeChar GX_GetOBJVRamModeChar(void)
{
    return (GXOBJVRamModeChar)(reg_GX_DISPCNT & (REG_GX_DISPCNT_EXOBJ_CH_MASK | REG_GX_DISPCNT_OBJMAP_CH_MASK));
}

static inline void GXS_SetOBJVRamModeChar(GXOBJVRamModeChar mode)
{
    reg_GXS_DB_DISPCNT = (u32)(reg_GXS_DB_DISPCNT & ~(REG_GXS_DB_DISPCNT_EXOBJ_CH_MASK | REG_GXS_DB_DISPCNT_OBJMAP_CH_MASK) | mode);
}

static inline GXOBJVRamModeChar GXS_GetOBJVRamModeChar(void)
{
    return (GXOBJVRamModeChar)(reg_GXS_DB_DISPCNT & (REG_GXS_DB_DISPCNT_EXOBJ_CH_MASK | REG_GXS_DB_DISPCNT_OBJMAP_CH_MASK));
}

static inline void GX_SetOBJVRamModeBmp(GXOBJVRamModeBmp mode)
{
    reg_GX_DISPCNT = (u32)(reg_GX_DISPCNT & ~(REG_GX_DISPCNT_EXOBJ_BM_MASK | REG_GX_DISPCNT_OBJMAP_BM_MASK) | mode);
}

static inline GXOBJVRamModeBmp GX_GetOBJVRamModeBmp(void)
{
    return (GXOBJVRamModeBmp)(reg_GX_DISPCNT & (REG_GX_DISPCNT_EXOBJ_BM_MASK | REG_GX_DISPCNT_OBJMAP_BM_MASK));
}

static inline void GXS_SetOBJVRamModeBmp(GXOBJVRamModeBmp mode)
{
    reg_GXS_DB_DISPCNT = (u32)(reg_GXS_DB_DISPCNT & ~(REG_GXS_DB_DISPCNT_OBJMAP_BM_MASK) | mode);
}

static inline GXOBJVRamModeBmp GXS_GetOBJVRamModeBmp(void)
{
    return (GXOBJVRamModeBmp)(reg_GXS_DB_DISPCNT & REG_GXS_DB_DISPCNT_OBJMAP_BM_MASK);
}

static inline void GX_BlankScr(BOOL blank)
{
    if (blank)
    {
        reg_GX_DISPCNT |= REG_GX_DISPCNT_BLANK_MASK;
    }
    else
    {
        reg_GX_DISPCNT &= ~REG_GX_DISPCNT_BLANK_MASK;
    }
}

static inline void GXS_DispOff(void)
{
    reg_GXS_DB_DISPCNT &= ~REG_GXS_DB_DISPCNT_MODE_MASK;
}

static inline void GXS_DispOn(void)
{
    reg_GXS_DB_DISPCNT |= REG_GXS_DB_DISPCNT_MODE_MASK;
}

static inline void GX_HBlankOBJProc(BOOL proc)
{
    if (proc)
    {
        reg_GX_DISPCNT |= REG_GX_DISPCNT_OH_MASK;
    }
    else
    {
        reg_GX_DISPCNT &= ~REG_GX_DISPCNT_OH_MASK;
    }
}

static inline void GXS_HBlankOBJProc(BOOL proc)
{
    if (proc)
    {
        reg_GXS_DB_DISPCNT |= REG_GXS_DB_DISPCNT_OH_MASK;
    }
    else
    {
        reg_GXS_DB_DISPCNT &= ~REG_GXS_DB_DISPCNT_OH_MASK;
    }
}

static inline void GX_SetMasterBrightness(int brightness)
{
    GXx_SetMasterBrightness_(&reg_GX_MASTER_BRIGHT, brightness);
}

static inline int GX_GetMasterBrightness(void)
{
    return GXx_GetMasterBrightness_(&reg_GX_MASTER_BRIGHT);
}

static inline void GXS_SetMasterBrightness(int brightness)
{
    GXx_SetMasterBrightness_(&reg_GXS_DB_MASTER_BRIGHT, brightness);
}

static inline int GXS_GetMasterBrightness(void)
{
    return GXx_GetMasterBrightness_(&reg_GXS_DB_MASTER_BRIGHT);
}

static inline s32 GX_IsHBlank(void)
{
    return (reg_GX_DISPSTAT & REG_GX_DISPSTAT_HBLK_MASK);
}

static inline s32 GX_IsVBlank(void)
{
    return (reg_GX_DISPSTAT & REG_GX_DISPSTAT_VBLK_MASK);
}

static inline s32 GX_IsVCountEq(void)
{
    return (reg_GX_DISPSTAT & REG_GX_DISPSTAT_LYC_MASK);
}

static inline void GX_VCountEqIntr(BOOL enable)
{
    if (enable)
    {
        reg_GX_DISPSTAT |= REG_GX_DISPSTAT_VQI_MASK;
    }
    else
    {
        reg_GX_DISPSTAT &= ~REG_GX_DISPSTAT_VQI_MASK;
    }
}

static inline s32 GX_GetVCount(void)
{
    return reg_GX_VCOUNT;
}

static inline void GX_SetVCount(s32 count)
{
    reg_GX_VCOUNT = (u16)count;
}

static inline s32 GX_GetVCountEqVal(void)
{
    u16 val = reg_GX_DISPSTAT;
    return ((val >> 8) & 0x00ff) | ((val << 1) & 0x0100);
}

static inline void GX_SetPower(int gxbit_power)
{
    reg_GX_POWCNT = (u16)((reg_GX_POWCNT & ~GX_POWER_ALL) | gxbit_power);
}

static inline GXPower GX_GetPower(void)
{
    return (GXPower)(reg_GX_POWCNT & GX_POWER_ALL);
}

static inline void GXi_PowerLCD(BOOL enable)
{
    if (enable)
    {
        reg_GX_POWCNT |= REG_GX_POWCNT_LCD_MASK;
    }
    else
    {
        reg_GX_POWCNT &= ~REG_GX_POWCNT_LCD_MASK;
    }
}

static inline void GX_Power2D(BOOL enable)
{
    if (enable)
    {
        reg_GX_POWCNT |= (REG_GX_POWCNT_E2DG_MASK | REG_GX_POWCNT_E2DGB_MASK);
    }
    else
    {
        reg_GX_POWCNT &= ~(REG_GX_POWCNT_E2DG_MASK | REG_GX_POWCNT_E2DGB_MASK);
    }
}

static inline void GX_Power2DMain(BOOL enable)
{
    if (enable)
    {
        reg_GX_POWCNT |= REG_GX_POWCNT_E2DG_MASK;
    }
    else
    {
        reg_GX_POWCNT &= ~REG_GX_POWCNT_E2DG_MASK;
    }
}

static inline void GX_Power2DSub(BOOL enable)
{
    if (enable)
    {
        reg_GX_POWCNT |= REG_GX_POWCNT_E2DGB_MASK;
    }
    else
    {
        reg_GX_POWCNT &= ~REG_GX_POWCNT_E2DGB_MASK;
    }
}

static inline void GX_PowerRender(BOOL enable)
{
    if (enable)
    {
        reg_GX_POWCNT |= REG_GX_POWCNT_RE_MASK;
    }
    else
    {
        reg_GX_POWCNT &= ~REG_GX_POWCNT_RE_MASK;
    }
}

static inline void GX_PowerGeometry(BOOL enable)
{
    if (enable)
    {
        reg_GX_POWCNT |= REG_GX_POWCNT_GE_MASK;
    }
    else
    {
        reg_GX_POWCNT &= ~REG_GX_POWCNT_GE_MASK;
    }
}

static inline void GX_Power3D(BOOL enable)
{
    if (enable)
    {
        reg_GX_POWCNT |= (REG_GX_POWCNT_GE_MASK | REG_GX_POWCNT_RE_MASK);
    }
    else
    {
        reg_GX_POWCNT &= ~(REG_GX_POWCNT_GE_MASK | REG_GX_POWCNT_RE_MASK);
    }
}

static inline void GX_SetDispSelect(GXDispSelect sel)
{
    reg_GX_POWCNT = (u16)((reg_GX_POWCNT & ~REG_GX_POWCNT_DSEL_MASK) | (sel << REG_GX_POWCNT_DSEL_SHIFT));
}

static inline GXDispSelect GX_GetDispSelect(void)
{
    return (GXDispSelect)((reg_GX_POWCNT & REG_GX_POWCNT_DSEL_MASK) >> REG_GX_POWCNT_DSEL_SHIFT);
}

static inline void GX_InitEx(u32 dma_no)
{
    GXi_DmaId = dma_no;
    GX_Init();
}

static inline u32 GX_GetDefaultDMA(void)
{
    return GXi_DmaId;
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_GX_GX_H
