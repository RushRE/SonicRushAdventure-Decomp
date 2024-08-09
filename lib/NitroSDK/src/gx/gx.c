#include <nitro.h>

#ifdef SDK_ARM9
#include <nitro/os/ARM9/vramExclusive.h>
#endif

u32 GXi_DmaId = GX_DEFAULT_DMAID;

#ifdef SDK_ARM9
vu16 GXi_VRamLockId = 0;
#endif

void GX_Init(void)
{
    const u16 bg_mtx_elem_one = 1 << 8;

    reg_GX_POWCNT |= (1 << REG_GX_POWCNT_DSEL_SHIFT);
    GX_SetPower(GX_POWER_ALL);
    GXi_PowerLCD(TRUE);
    GX_InitGXState();

#ifdef SDK_ARM9
    {
        s32 lockResult;

        while (GXi_VRamLockId == 0)
        {
            lockResult = OS_GetLockID();
            if (lockResult == OS_LOCK_ID_ERROR)
            {
                OS_Panic("Could not get lock ID for VRAM exclusive.\n");
            }
            GXi_VRamLockId = (u16)lockResult;
        }
    }
#endif

    // Main engine
    reg_GX_DISPSTAT = 0;
    reg_GX_DISPCNT  = 0;
    if (GXi_DmaId != GX_DMA_NOT_USE)
    {
        MI_DmaFill32(GXi_DmaId, (void *)REG_BG0CNT_ADDR, 0, REG_DISP_MMEM_FIFO_ADDR - REG_BG0CNT_ADDR);
        reg_GX_MASTER_BRIGHT = 0;

        // Sub engine
        MI_DmaFill32(GXi_DmaId, (void *)REG_DB_DISPCNT_ADDR, 0, REG_DB_MASTER_BRIGHT_ADDR - REG_DB_DISPCNT_ADDR + 4);
    }
    else
    {
        MI_CpuFill32((void *)REG_BG0CNT_ADDR, 0, REG_DISP_MMEM_FIFO_ADDR - REG_BG0CNT_ADDR);
        reg_GX_MASTER_BRIGHT = 0;

        // Sub engine
        MI_CpuFill32((void *)REG_DB_DISPCNT_ADDR, 0, REG_DB_MASTER_BRIGHT_ADDR - REG_DB_DISPCNT_ADDR + 4);
    }

    reg_G2_BG2PA     = bg_mtx_elem_one;
    reg_G2_BG2PD     = bg_mtx_elem_one;
    reg_G2_BG3PA     = bg_mtx_elem_one;
    reg_G2_BG3PD     = bg_mtx_elem_one;
    reg_G2S_DB_BG2PA = bg_mtx_elem_one;
    reg_G2S_DB_BG2PD = bg_mtx_elem_one;
    reg_G2S_DB_BG3PA = bg_mtx_elem_one;
    reg_G2S_DB_BG3PD = bg_mtx_elem_one;
}

void GX_SetVCountEqVal(s32 val)
{
    reg_GX_DISPSTAT =
        (u16)((reg_GX_DISPSTAT & (REG_GX_DISPSTAT_VBLK_MASK | REG_GX_DISPSTAT_HBLK_MASK | REG_GX_DISPSTAT_LYC_MASK | REG_GX_DISPSTAT_VBI_MASK | REG_GX_DISPSTAT_HBI_MASK | REG_GX_DISPSTAT_VQI_MASK))
              | ((val & 0xff) << 8) | ((val & 0x100) >> 1));
}

s32 GX_HBlankIntr(BOOL enable)
{
    s32 rval = (reg_GX_DISPSTAT & REG_GX_DISPSTAT_HBI_MASK);
    if (enable)
    {
        reg_GX_DISPSTAT |= REG_GX_DISPSTAT_HBI_MASK;
    }
    else
    {
        reg_GX_DISPSTAT &= ~REG_GX_DISPSTAT_HBI_MASK;
    }
    return rval;
}

s32 GX_VBlankIntr(BOOL enable)
{
    s32 rval = (reg_GX_DISPSTAT & REG_GX_DISPSTAT_VBI_MASK);
    if (enable)
    {
        reg_GX_DISPSTAT |= REG_GX_DISPSTAT_VBI_MASK;
    }
    else
    {
        reg_GX_DISPSTAT &= ~REG_GX_DISPSTAT_VBI_MASK;
    }
    return rval;
}

// Use u16 to avoid byte access problem (thumb mode)
static u16 sDispMode = 0;
static u16 sIsDispOn = TRUE;

BOOL GX_IsDispOn(void)
{
    return sIsDispOn;
}

void GX_DispOff(void)
{
    u32 tmp = reg_GX_DISPCNT;

    sIsDispOn = FALSE;
    sDispMode = (u16)((tmp & REG_GX_DISPCNT_MODE_MASK) >> REG_GX_DISPCNT_MODE_SHIFT);

    reg_GX_DISPCNT = tmp & ~REG_GX_DISPCNT_MODE_MASK;
}

void GX_DispOn(void)
{
    sIsDispOn = TRUE;
    if (sDispMode != (u16)GX_DISPMODE_OFF)
    {
        // restore
        reg_GX_DISPCNT = ((reg_GX_DISPCNT & ~REG_GX_DISPCNT_MODE_MASK) | (sDispMode << REG_GX_DISPCNT_MODE_SHIFT));
    }
    else
    {
        // GX_DISPMODE_GRAPHICS if sDispMode is GX_DISPMODE_OFF
        reg_GX_DISPCNT = ((reg_GX_DISPCNT | (GX_DISPMODE_GRAPHICS << REG_GX_DISPCNT_MODE_SHIFT)));
    }
}

void GX_SetGraphicsMode(GXDispMode dispMode, GXBGMode bgMode, GXBG0As bg0_2d3d)
{
    u32 cnt = reg_GX_DISPCNT;

    sDispMode = (u16)dispMode;
    if (!sIsDispOn)
    {
        dispMode = GX_DISPMODE_OFF;
    }

    cnt &= ~(REG_GX_DISPCNT_BGMODE_MASK | REG_GX_DISPCNT_BG02D3D_MASK | REG_GX_DISPCNT_MODE_MASK | REG_GX_DISPCNT_VRAM_MASK);

    reg_GX_DISPCNT = (u32)(cnt | (dispMode << REG_GX_DISPCNT_MODE_SHIFT) | (bgMode << REG_GX_DISPCNT_BGMODE_SHIFT) | (bg0_2d3d << REG_GX_DISPCNT_BG02D3D_SHIFT));

    // needless when GX_DISPMODE_OFF is removed.
    if (sDispMode == GX_DISPMODE_OFF)
    {
        sIsDispOn = FALSE;
    }
}

void GXS_SetGraphicsMode(GXBGMode bgMode)
{
    reg_GXS_DB_DISPCNT = ((reg_GXS_DB_DISPCNT & ~REG_GXS_DB_DISPCNT_BGMODE_MASK) | (bgMode << REG_GXS_DB_DISPCNT_BGMODE_SHIFT));
}

void GXx_SetMasterBrightness_(vu16 *reg, int brightness)
{
    if (brightness == 0)
    {
        *reg = 0;
    }
    else if (brightness > 0)
    {
        *reg = (u16)((1 << REG_GX_MASTER_BRIGHT_E_MOD_SHIFT) | brightness);
    }
    else
    {
        *reg = (u16)((2 << REG_GX_MASTER_BRIGHT_E_MOD_SHIFT) | (-brightness));
    }
}

int GXx_GetMasterBrightness_(vu16 *reg)
{
    u16 mode = (u16)(*reg & REG_GX_MASTER_BRIGHT_E_MOD_MASK);

    if (mode == 0)
    {
        return 0;
    }
    else if (mode == (1 << REG_GX_MASTER_BRIGHT_E_MOD_SHIFT))
    {
        return *reg & REG_GX_MASTER_BRIGHT_E_VALUE_MASK;
    }
    else if (mode == (2 << REG_GX_MASTER_BRIGHT_E_MOD_SHIFT))
    {
        return -(*reg & REG_GX_MASTER_BRIGHT_E_VALUE_MASK);
    }
    else
    {
        return 0;
    }
}

u32 GX_SetDefaultDMA(u32 dma_no)
{
    u32 previous = GXi_DmaId;
    OSIntrMode enabled;

    if (GXi_DmaId != GX_DMA_NOT_USE)
    {
        MI_WaitDma(GXi_DmaId);
    }

    enabled = OS_DisableInterrupts();

    GXi_DmaId = dma_no;

    (IGNORE_RETURN)OS_RestoreInterrupts(enabled);

    return previous;
}