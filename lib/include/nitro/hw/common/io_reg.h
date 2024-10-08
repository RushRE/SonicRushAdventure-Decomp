#ifndef NITRO_HW_IO_REG_SHARED_H
#define NITRO_HW_IO_REG_SHARED_H

#define HW_REG_BASE 0x04000000

#define reg_PAD_KEYINPUT (*(REGType16v *)0x4000130)
#define reg_PAD_KEYCNT   (*(REGType16v *)0x4000132)

#define REG_OS_IE_VB_SHIFT  0
#define REG_OS_IE_HB_SHIFT  1
#define REG_OS_IE_VE_SHIFT  2
#define REG_OS_IE_T0_SHIFT  3
#define REG_OS_IE_T1_SHIFT  4
#define REG_OS_IE_T2_SHIFT  5
#define REG_OS_IE_T3_SHIFT  6
#define REG_OS_IE_D0_SHIFT  8
#define REG_OS_IE_D1_SHIFT  9
#define REG_OS_IE_D2_SHIFT  10
#define REG_OS_IE_D3_SHIFT  11
#define REG_OS_IE_K_SHIFT   12
#define REG_OS_IE_I_D_SHIFT 13
#define REG_OS_IE_A7_SHIFT  16
#define REG_OS_IE_IFE_SHIFT 17
#define REG_OS_IE_IFN_SHIFT 18
#define REG_OS_IE_MC_SHIFT  19
#define REG_OS_IE_MI_SHIFT  20
#define REG_OS_IE_PM_SHIFT  22
#define REG_OS_IE_SPI_SHIFT 23
#define REG_OS_IE_WL_SHIFT  24

#define REG_PAD_KEYINPUT_L_SHIFT 9
#define REG_PAD_KEYINPUT_L_SIZE  1
#define REG_PAD_KEYINPUT_L_MASK  0x0200

#define REG_PAD_KEYINPUT_R_SHIFT 8
#define REG_PAD_KEYINPUT_R_SIZE  1
#define REG_PAD_KEYINPUT_R_MASK  0x0100

#define REG_PAD_KEYINPUT_DOWN_SHIFT 7
#define REG_PAD_KEYINPUT_DOWN_SIZE  1
#define REG_PAD_KEYINPUT_DOWN_MASK  0x0080

#define REG_PAD_KEYINPUT_UP_SHIFT 6
#define REG_PAD_KEYINPUT_UP_SIZE  1
#define REG_PAD_KEYINPUT_UP_MASK  0x0040

#define REG_PAD_KEYINPUT_LEFT_SHIFT 5
#define REG_PAD_KEYINPUT_LEFT_SIZE  1
#define REG_PAD_KEYINPUT_LEFT_MASK  0x0020

#define REG_PAD_KEYINPUT_RIGHT_SHIFT 4
#define REG_PAD_KEYINPUT_RIGHT_SIZE  1
#define REG_PAD_KEYINPUT_RIGHT_MASK  0x0010

#define REG_PAD_KEYINPUT_START_SHIFT 3
#define REG_PAD_KEYINPUT_START_SIZE  1
#define REG_PAD_KEYINPUT_START_MASK  0x0008

#define REG_PAD_KEYINPUT_SEL_SHIFT 2
#define REG_PAD_KEYINPUT_SEL_SIZE  1
#define REG_PAD_KEYINPUT_SEL_MASK  0x0004

#define REG_PAD_KEYINPUT_B_SHIFT 1
#define REG_PAD_KEYINPUT_B_SIZE  1
#define REG_PAD_KEYINPUT_B_MASK  0x0002

#define REG_PAD_KEYINPUT_A_SHIFT 0
#define REG_PAD_KEYINPUT_A_SIZE  1
#define REG_PAD_KEYINPUT_A_MASK  0x0001

#ifndef SDK_ASM
#define REG_PAD_KEYINPUT_FIELD(l, r, down, up, left, right, start, sel, b, a)                                                                                                      \
    (u16)(((u32)(l) << REG_PAD_KEYINPUT_L_SHIFT) | ((u32)(r) << REG_PAD_KEYINPUT_R_SHIFT) | ((u32)(down) << REG_PAD_KEYINPUT_DOWN_SHIFT)                                           \
          | ((u32)(up) << REG_PAD_KEYINPUT_UP_SHIFT) | ((u32)(left) << REG_PAD_KEYINPUT_LEFT_SHIFT) | ((u32)(right) << REG_PAD_KEYINPUT_RIGHT_SHIFT)                               \
          | ((u32)(start) << REG_PAD_KEYINPUT_START_SHIFT) | ((u32)(sel) << REG_PAD_KEYINPUT_SEL_SHIFT) | ((u32)(b) << REG_PAD_KEYINPUT_B_SHIFT)                                   \
          | ((u32)(a) << REG_PAD_KEYINPUT_A_SHIFT))
#endif

#define REG_PAD_KEYCNT_LOGIC_SHIFT 15
#define REG_PAD_KEYCNT_LOGIC_SIZE  1
#define REG_PAD_KEYCNT_LOGIC_MASK  0x8000

#define REG_PAD_KEYCNT_INTR_SHIFT 14
#define REG_PAD_KEYCNT_INTR_SIZE  1
#define REG_PAD_KEYCNT_INTR_MASK  0x4000

#define REG_PAD_KEYCNT_L_SHIFT 9
#define REG_PAD_KEYCNT_L_SIZE  1
#define REG_PAD_KEYCNT_L_MASK  0x0200

#define REG_PAD_KEYCNT_R_SHIFT 8
#define REG_PAD_KEYCNT_R_SIZE  1
#define REG_PAD_KEYCNT_R_MASK  0x0100

#define REG_PAD_KEYCNT_DOWN_SHIFT 7
#define REG_PAD_KEYCNT_DOWN_SIZE  1
#define REG_PAD_KEYCNT_DOWN_MASK  0x0080

#define REG_PAD_KEYCNT_UP_SHIFT 6
#define REG_PAD_KEYCNT_UP_SIZE  1
#define REG_PAD_KEYCNT_UP_MASK  0x0040

#define REG_PAD_KEYCNT_LEFT_SHIFT 5
#define REG_PAD_KEYCNT_LEFT_SIZE  1
#define REG_PAD_KEYCNT_LEFT_MASK  0x0020

#define REG_PAD_KEYCNT_RIGHT_SHIFT 4
#define REG_PAD_KEYCNT_RIGHT_SIZE  1
#define REG_PAD_KEYCNT_RIGHT_MASK  0x0010

#define REG_PAD_KEYCNT_START_SHIFT 3
#define REG_PAD_KEYCNT_START_SIZE  1
#define REG_PAD_KEYCNT_START_MASK  0x0008

#define REG_PAD_KEYCNT_SEL_SHIFT 2
#define REG_PAD_KEYCNT_SEL_SIZE  1
#define REG_PAD_KEYCNT_SEL_MASK  0x0004

#define REG_PAD_KEYCNT_B_SHIFT 1
#define REG_PAD_KEYCNT_B_SIZE  1
#define REG_PAD_KEYCNT_B_MASK  0x0002

#define REG_PAD_KEYCNT_A_SHIFT 0
#define REG_PAD_KEYCNT_A_SIZE  1
#define REG_PAD_KEYCNT_A_MASK  0x0001

#define REG_G2_WINOUT_OBJWININ_SHIFT 8
#define REG_G2_WINOUT_OBJWININ_SIZE  6
#define REG_G2_WINOUT_OBJWININ_MASK  0x3f00

#define REG_G2_WINOUT_WINOUT_SHIFT 0
#define REG_G2_WINOUT_WINOUT_SIZE  6
#define REG_G2_WINOUT_WINOUT_MASK  0x003f

#define REG_G2_WINOUT_FIELD(objwinin, winout) (u16)(((u32)(objwinin) << REG_G2_WINOUT_OBJWININ_SHIFT) | ((u32)(winout) << REG_G2_WINOUT_WINOUT_SHIFT))

#ifndef SDK_ASM
#define REG_PAD_KEYCNT_FIELD(logic, intr, l, r, down, up, left, right, start, sel, b, a)                                                                                           \
    (u16)(((u32)(logic) << REG_PAD_KEYCNT_LOGIC_SHIFT) | ((u32)(intr) << REG_PAD_KEYCNT_INTR_SHIFT) | ((u32)(l) << REG_PAD_KEYCNT_L_SHIFT) | ((u32)(r) << REG_PAD_KEYCNT_R_SHIFT)  \
          | ((u32)(down) << REG_PAD_KEYCNT_DOWN_SHIFT) | ((u32)(up) << REG_PAD_KEYCNT_UP_SHIFT) | ((u32)(left) << REG_PAD_KEYCNT_LEFT_SHIFT)                                       \
          | ((u32)(right) << REG_PAD_KEYCNT_RIGHT_SHIFT) | ((u32)(start) << REG_PAD_KEYCNT_START_SHIFT) | ((u32)(sel) << REG_PAD_KEYCNT_SEL_SHIFT)                                 \
          | ((u32)(b) << REG_PAD_KEYCNT_B_SHIFT) | ((u32)(a) << REG_PAD_KEYCNT_A_SHIFT))
#endif

#define REG_GX_POWCNT_GE_SHIFT 3
#define REG_GX_POWCNT_GE_SIZE  1
#define REG_GX_POWCNT_GE_MASK  0x0008

#define REG_GX_POWCNT_RE_SHIFT 2
#define REG_GX_POWCNT_RE_SIZE  1
#define REG_GX_POWCNT_RE_MASK  0x0004

#define REG_GX_POWCNT_E2DG_SHIFT 1
#define REG_GX_POWCNT_E2DG_SIZE  1
#define REG_GX_POWCNT_E2DG_MASK  0x0002

#define REG_GX_POWCNT_LCD_SHIFT 0
#define REG_GX_POWCNT_LCD_SIZE  1
#define REG_GX_POWCNT_LCD_MASK  0x0001

#define REG_GX_POWCNT_LCDB_SHIFT 8
#define REG_GX_POWCNT_LCDB_SIZE  1
#define REG_GX_POWCNT_LCDB_MASK  0x0100

#define REG_GX_POWCNT_E2DGB_SHIFT 9
#define REG_GX_POWCNT_E2DGB_SIZE  1
#define REG_GX_POWCNT_E2DGB_MASK  0x0200

#define REG_GX_POWCNT_DSEL_SHIFT 15
#define REG_GX_POWCNT_DSEL_SIZE  1
#define REG_GX_POWCNT_DSEL_MASK  0x8000

// GX_DISPCNT
#define REG_GX_DISPCNT_O_SHIFT 31
#define REG_GX_DISPCNT_O_SIZE  1
#define REG_GX_DISPCNT_O_MASK  0x80000000

#define REG_GX_DISPCNT_BG_SHIFT 30
#define REG_GX_DISPCNT_BG_SIZE  1
#define REG_GX_DISPCNT_BG_MASK  0x40000000

#define REG_GX_DISPCNT_BGSCREENOFFSET_SHIFT 27
#define REG_GX_DISPCNT_BGSCREENOFFSET_SIZE  3
#define REG_GX_DISPCNT_BGSCREENOFFSET_MASK  0x38000000

#define REG_GX_DISPCNT_BGCHAROFFSET_SHIFT 24
#define REG_GX_DISPCNT_BGCHAROFFSET_SIZE  3
#define REG_GX_DISPCNT_BGCHAROFFSET_MASK  0x07000000

#define REG_GX_DISPCNT_OH_SHIFT 23
#define REG_GX_DISPCNT_OH_SIZE  1
#define REG_GX_DISPCNT_OH_MASK  0x00800000

#define REG_GX_DISPCNT_EXOBJ_SHIFT 20
#define REG_GX_DISPCNT_EXOBJ_SIZE  3
#define REG_GX_DISPCNT_EXOBJ_MASK  0x00700000

#define REG_GX_DISPCNT_VRAM_SHIFT 18
#define REG_GX_DISPCNT_VRAM_SIZE  2
#define REG_GX_DISPCNT_VRAM_MASK  0x000c0000

#define REG_GX_DISPCNT_MODE_SHIFT 16
#define REG_GX_DISPCNT_MODE_SIZE  2
#define REG_GX_DISPCNT_MODE_MASK  0x00030000

#define REG_GX_DISPCNT_OW_SHIFT 15
#define REG_GX_DISPCNT_OW_SIZE  1
#define REG_GX_DISPCNT_OW_MASK  0x00008000

#define REG_GX_DISPCNT_W1_SHIFT 14
#define REG_GX_DISPCNT_W1_SIZE  1
#define REG_GX_DISPCNT_W1_MASK  0x00004000

#define REG_GX_DISPCNT_W0_SHIFT 13
#define REG_GX_DISPCNT_W0_SIZE  1
#define REG_GX_DISPCNT_W0_MASK  0x00002000

#define REG_GX_DISPCNT_DISPLAY_SHIFT 8
#define REG_GX_DISPCNT_DISPLAY_SIZE  5
#define REG_GX_DISPCNT_DISPLAY_MASK  0x00001f00

#define REG_GX_DISPCNT_BLANK_SHIFT 7
#define REG_GX_DISPCNT_BLANK_SIZE  1
#define REG_GX_DISPCNT_BLANK_MASK  0x00000080

#define REG_GX_DISPCNT_OBJMAP_SHIFT 4
#define REG_GX_DISPCNT_OBJMAP_SIZE  3
#define REG_GX_DISPCNT_OBJMAP_MASK  0x00000070

#define REG_GX_DISPCNT_BG02D3D_SHIFT 3
#define REG_GX_DISPCNT_BG02D3D_SIZE  1
#define REG_GX_DISPCNT_BG02D3D_MASK  0x00000008

#define REG_GX_DISPCNT_BGMODE_SHIFT 0
#define REG_GX_DISPCNT_BGMODE_SIZE  3
#define REG_GX_DISPCNT_BGMODE_MASK  0x00000007

#define REG_GX_DISPCNT_OBJMAP_CH_SHIFT 4
#define REG_GX_DISPCNT_OBJMAP_CH_SIZE  1
#define REG_GX_DISPCNT_OBJMAP_CH_MASK  0x00000010

#define REG_GX_DISPCNT_OBJMAP_BM_SHIFT 5
#define REG_GX_DISPCNT_OBJMAP_BM_SIZE  2
#define REG_GX_DISPCNT_OBJMAP_BM_MASK  0x00000060

#define REG_GX_DISPCNT_EXOBJ_CH_SHIFT 20
#define REG_GX_DISPCNT_EXOBJ_CH_SIZE  2
#define REG_GX_DISPCNT_EXOBJ_CH_MASK  0x00300000

#define REG_GX_DISPCNT_EXOBJ_BM_SHIFT 22
#define REG_GX_DISPCNT_EXOBJ_BM_SIZE  1
#define REG_GX_DISPCNT_EXOBJ_BM_MASK  0x00400000

// GXS_DB_DISPCNT
#define REG_GXS_DB_DISPCNT_O_SHIFT 31
#define REG_GXS_DB_DISPCNT_O_SIZE  1
#define REG_GXS_DB_DISPCNT_O_MASK  0x80000000

#define REG_GXS_DB_DISPCNT_BG_SHIFT 30
#define REG_GXS_DB_DISPCNT_BG_SIZE  1
#define REG_GXS_DB_DISPCNT_BG_MASK  0x40000000

#define REG_GXS_DB_DISPCNT_OH_SHIFT 23
#define REG_GXS_DB_DISPCNT_OH_SIZE  1
#define REG_GXS_DB_DISPCNT_OH_MASK  0x00800000

#define REG_GXS_DB_DISPCNT_EXOBJ_SHIFT 20
#define REG_GXS_DB_DISPCNT_EXOBJ_SIZE  2
#define REG_GXS_DB_DISPCNT_EXOBJ_MASK  0x00300000

#define REG_GXS_DB_DISPCNT_MODE_SHIFT 16
#define REG_GXS_DB_DISPCNT_MODE_SIZE  1
#define REG_GXS_DB_DISPCNT_MODE_MASK  0x00010000

#define REG_GXS_DB_DISPCNT_OW_SHIFT 15
#define REG_GXS_DB_DISPCNT_OW_SIZE  1
#define REG_GXS_DB_DISPCNT_OW_MASK  0x00008000

#define REG_GXS_DB_DISPCNT_W1_SHIFT 14
#define REG_GXS_DB_DISPCNT_W1_SIZE  1
#define REG_GXS_DB_DISPCNT_W1_MASK  0x00004000

#define REG_GXS_DB_DISPCNT_W0_SHIFT 13
#define REG_GXS_DB_DISPCNT_W0_SIZE  1
#define REG_GXS_DB_DISPCNT_W0_MASK  0x00002000

#define REG_GXS_DB_DISPCNT_DISPLAY_SHIFT 8
#define REG_GXS_DB_DISPCNT_DISPLAY_SIZE  5
#define REG_GXS_DB_DISPCNT_DISPLAY_MASK  0x00001f00

#define REG_GXS_DB_DISPCNT_BLANK_SHIFT 7
#define REG_GXS_DB_DISPCNT_BLANK_SIZE  1
#define REG_GXS_DB_DISPCNT_BLANK_MASK  0x00000080

#define REG_GXS_DB_DISPCNT_OBJMAP_SHIFT 4
#define REG_GXS_DB_DISPCNT_OBJMAP_SIZE  3
#define REG_GXS_DB_DISPCNT_OBJMAP_MASK  0x00000070

#define REG_GXS_DB_DISPCNT_BGMODE_SHIFT 0
#define REG_GXS_DB_DISPCNT_BGMODE_SIZE  3
#define REG_GXS_DB_DISPCNT_BGMODE_MASK  0x00000007

#define REG_GXS_DB_DISPCNT_OBJMAP_CH_SHIFT 4
#define REG_GXS_DB_DISPCNT_OBJMAP_CH_SIZE  1
#define REG_GXS_DB_DISPCNT_OBJMAP_CH_MASK  0x00000010

#define REG_GXS_DB_DISPCNT_OBJMAP_BM_SHIFT 5
#define REG_GXS_DB_DISPCNT_OBJMAP_BM_SIZE  2
#define REG_GXS_DB_DISPCNT_OBJMAP_BM_MASK  0x00000060

#define REG_GXS_DB_DISPCNT_EXOBJ_CH_SHIFT 20
#define REG_GXS_DB_DISPCNT_EXOBJ_CH_SIZE  2
#define REG_GXS_DB_DISPCNT_EXOBJ_CH_MASK  0x00300000

// MASTER BRIGHT
#define REG_GX_MASTER_BRIGHT_E_MOD_SHIFT 14
#define REG_GX_MASTER_BRIGHT_E_MOD_SIZE  2
#define REG_GX_MASTER_BRIGHT_E_MOD_MASK  0xc000

#define REG_GX_MASTER_BRIGHT_E_VALUE_SHIFT 0
#define REG_GX_MASTER_BRIGHT_E_VALUE_SIZE  5
#define REG_GX_MASTER_BRIGHT_E_VALUE_MASK  0x001f

// DISPSTAT
#define REG_GX_DISPSTAT_VCOUNTER_SHIFT 7
#define REG_GX_DISPSTAT_VCOUNTER_SIZE  9
#define REG_GX_DISPSTAT_VCOUNTER_MASK  0xff80

#define REG_GX_DISPSTAT_VQI_SHIFT 5
#define REG_GX_DISPSTAT_VQI_SIZE  1
#define REG_GX_DISPSTAT_VQI_MASK  0x0020

#define REG_GX_DISPSTAT_HBI_SHIFT 4
#define REG_GX_DISPSTAT_HBI_SIZE  1
#define REG_GX_DISPSTAT_HBI_MASK  0x0010

#define REG_GX_DISPSTAT_VBI_SHIFT 3
#define REG_GX_DISPSTAT_VBI_SIZE  1
#define REG_GX_DISPSTAT_VBI_MASK  0x0008

#define REG_GX_DISPSTAT_LYC_SHIFT 2
#define REG_GX_DISPSTAT_LYC_SIZE  1
#define REG_GX_DISPSTAT_LYC_MASK  0x0004

#define REG_GX_DISPSTAT_HBLK_SHIFT 1
#define REG_GX_DISPSTAT_HBLK_SIZE  1
#define REG_GX_DISPSTAT_HBLK_MASK  0x0002

#define REG_GX_DISPSTAT_VBLK_SHIFT 0
#define REG_GX_DISPSTAT_VBLK_SIZE  1
#define REG_GX_DISPSTAT_VBLK_MASK  0x0001

// G2_BG0CNT
#define REG_G2_BG0CNT_SCREENSIZE_SHIFT 14
#define REG_G2_BG0CNT_SCREENSIZE_SIZE  2
#define REG_G2_BG0CNT_SCREENSIZE_MASK  0xc000

#define REG_G2_BG0CNT_BGPLTTSLOT_SHIFT 13
#define REG_G2_BG0CNT_BGPLTTSLOT_SIZE  1
#define REG_G2_BG0CNT_BGPLTTSLOT_MASK  0x2000

#define REG_G2_BG0CNT_SCREENBASE_SHIFT 8
#define REG_G2_BG0CNT_SCREENBASE_SIZE  5
#define REG_G2_BG0CNT_SCREENBASE_MASK  0x1f00

#define REG_G2_BG0CNT_COLORMODE_SHIFT 7
#define REG_G2_BG0CNT_COLORMODE_SIZE  1
#define REG_G2_BG0CNT_COLORMODE_MASK  0x0080

#define REG_G2_BG0CNT_MOSAIC_SHIFT 6
#define REG_G2_BG0CNT_MOSAIC_SIZE  1
#define REG_G2_BG0CNT_MOSAIC_MASK  0x0040

#define REG_G2_BG0CNT_CHARBASE_SHIFT 2
#define REG_G2_BG0CNT_CHARBASE_SIZE  4
#define REG_G2_BG0CNT_CHARBASE_MASK  0x003c

#define REG_G2_BG0CNT_PRIORITY_SHIFT 0
#define REG_G2_BG0CNT_PRIORITY_SIZE  2
#define REG_G2_BG0CNT_PRIORITY_MASK  0x0003

// G2_BG1CNT
#define REG_G2_BG1CNT_SCREENSIZE_SHIFT 14
#define REG_G2_BG1CNT_SCREENSIZE_SIZE  2
#define REG_G2_BG1CNT_SCREENSIZE_MASK  0xc000

#define REG_G2_BG1CNT_BGPLTTSLOT_SHIFT 13
#define REG_G2_BG1CNT_BGPLTTSLOT_SIZE  1
#define REG_G2_BG1CNT_BGPLTTSLOT_MASK  0x2000

#define REG_G2_BG1CNT_SCREENBASE_SHIFT 8
#define REG_G2_BG1CNT_SCREENBASE_SIZE  5
#define REG_G2_BG1CNT_SCREENBASE_MASK  0x1f00

#define REG_G2_BG1CNT_COLORMODE_SHIFT 7
#define REG_G2_BG1CNT_COLORMODE_SIZE  1
#define REG_G2_BG1CNT_COLORMODE_MASK  0x0080

#define REG_G2_BG1CNT_MOSAIC_SHIFT 6
#define REG_G2_BG1CNT_MOSAIC_SIZE  1
#define REG_G2_BG1CNT_MOSAIC_MASK  0x0040

#define REG_G2_BG1CNT_CHARBASE_SHIFT 2
#define REG_G2_BG1CNT_CHARBASE_SIZE  4
#define REG_G2_BG1CNT_CHARBASE_MASK  0x003c

#define REG_G2_BG1CNT_PRIORITY_SHIFT 0
#define REG_G2_BG1CNT_PRIORITY_SIZE  2
#define REG_G2_BG1CNT_PRIORITY_MASK  0x0003

// G2_BG2CNT
#define REG_G2_BG2CNT_SCREENSIZE_SHIFT 14
#define REG_G2_BG2CNT_SCREENSIZE_SIZE  2
#define REG_G2_BG2CNT_SCREENSIZE_MASK  0xc000

#define REG_G2_BG2CNT_AREAOVER_SHIFT 13
#define REG_G2_BG2CNT_AREAOVER_SIZE  1
#define REG_G2_BG2CNT_AREAOVER_MASK  0x2000

#define REG_G2_BG2CNT_SCREENBASE_SHIFT 8
#define REG_G2_BG2CNT_SCREENBASE_SIZE  5
#define REG_G2_BG2CNT_SCREENBASE_MASK  0x1f00

#define REG_G2_BG2CNT_COLORMODE_SHIFT 7
#define REG_G2_BG2CNT_COLORMODE_SIZE  1
#define REG_G2_BG2CNT_COLORMODE_MASK  0x0080

#define REG_G2_BG2CNT_MOSAIC_SHIFT 6
#define REG_G2_BG2CNT_MOSAIC_SIZE  1
#define REG_G2_BG2CNT_MOSAIC_MASK  0x0040

#define REG_G2_BG2CNT_CHARBASE_SHIFT 2
#define REG_G2_BG2CNT_CHARBASE_SIZE  4
#define REG_G2_BG2CNT_CHARBASE_MASK  0x003c

#define REG_G2_BG2CNT_PRIORITY_SHIFT 0
#define REG_G2_BG2CNT_PRIORITY_SIZE  2
#define REG_G2_BG2CNT_PRIORITY_MASK  0x0003

// G2_BG3CNT
#define REG_G2_BG3CNT_SCREENSIZE_SHIFT 14
#define REG_G2_BG3CNT_SCREENSIZE_SIZE  2
#define REG_G2_BG3CNT_SCREENSIZE_MASK  0xc000

#define REG_G2_BG3CNT_AREAOVER_SHIFT 13
#define REG_G2_BG3CNT_AREAOVER_SIZE  1
#define REG_G2_BG3CNT_AREAOVER_MASK  0x2000

#define REG_G2_BG3CNT_SCREENBASE_SHIFT 8
#define REG_G2_BG3CNT_SCREENBASE_SIZE  5
#define REG_G2_BG3CNT_SCREENBASE_MASK  0x1f00

#define REG_G2_BG3CNT_COLORMODE_SHIFT 7
#define REG_G2_BG3CNT_COLORMODE_SIZE  1
#define REG_G2_BG3CNT_COLORMODE_MASK  0x0080

#define REG_G2_BG3CNT_MOSAIC_SHIFT 6
#define REG_G2_BG3CNT_MOSAIC_SIZE  1
#define REG_G2_BG3CNT_MOSAIC_MASK  0x0040

#define REG_G2_BG3CNT_CHARBASE_SHIFT 2
#define REG_G2_BG3CNT_CHARBASE_SIZE  4
#define REG_G2_BG3CNT_CHARBASE_MASK  0x003c

#define REG_G2_BG3CNT_PRIORITY_SHIFT 0
#define REG_G2_BG3CNT_PRIORITY_SIZE  2
#define REG_G2_BG3CNT_PRIORITY_MASK  0x0003

// G2S_DB_BG0CNT
#define REG_G2S_DB_BG0CNT_SCREENSIZE_SHIFT 14
#define REG_G2S_DB_BG0CNT_SCREENSIZE_SIZE  2
#define REG_G2S_DB_BG0CNT_SCREENSIZE_MASK  0xc000

#define REG_G2S_DB_BG0CNT_BGPLTTSLOT_SHIFT 13
#define REG_G2S_DB_BG0CNT_BGPLTTSLOT_SIZE  1
#define REG_G2S_DB_BG0CNT_BGPLTTSLOT_MASK  0x2000

#define REG_G2S_DB_BG0CNT_SCREENBASE_SHIFT 8
#define REG_G2S_DB_BG0CNT_SCREENBASE_SIZE  5
#define REG_G2S_DB_BG0CNT_SCREENBASE_MASK  0x1f00

#define REG_G2S_DB_BG0CNT_COLORMODE_SHIFT 7
#define REG_G2S_DB_BG0CNT_COLORMODE_SIZE  1
#define REG_G2S_DB_BG0CNT_COLORMODE_MASK  0x0080

#define REG_G2S_DB_BG0CNT_MOSAIC_SHIFT 6
#define REG_G2S_DB_BG0CNT_MOSAIC_SIZE  1
#define REG_G2S_DB_BG0CNT_MOSAIC_MASK  0x0040

#define REG_G2S_DB_BG0CNT_CHARBASE_SHIFT 2
#define REG_G2S_DB_BG0CNT_CHARBASE_SIZE  4
#define REG_G2S_DB_BG0CNT_CHARBASE_MASK  0x003c

#define REG_G2S_DB_BG0CNT_PRIORITY_SHIFT 0
#define REG_G2S_DB_BG0CNT_PRIORITY_SIZE  2
#define REG_G2S_DB_BG0CNT_PRIORITY_MASK  0x0003

// G2S_DB_BG1CNT
#define REG_G2S_DB_BG1CNT_SCREENSIZE_SHIFT 14
#define REG_G2S_DB_BG1CNT_SCREENSIZE_SIZE  2
#define REG_G2S_DB_BG1CNT_SCREENSIZE_MASK  0xc000

#define REG_G2S_DB_BG1CNT_BGPLTTSLOT_SHIFT 13
#define REG_G2S_DB_BG1CNT_BGPLTTSLOT_SIZE  1
#define REG_G2S_DB_BG1CNT_BGPLTTSLOT_MASK  0x2000

#define REG_G2S_DB_BG1CNT_SCREENBASE_SHIFT 8
#define REG_G2S_DB_BG1CNT_SCREENBASE_SIZE  5
#define REG_G2S_DB_BG1CNT_SCREENBASE_MASK  0x1f00

#define REG_G2S_DB_BG1CNT_COLORMODE_SHIFT 7
#define REG_G2S_DB_BG1CNT_COLORMODE_SIZE  1
#define REG_G2S_DB_BG1CNT_COLORMODE_MASK  0x0080

#define REG_G2S_DB_BG1CNT_MOSAIC_SHIFT 6
#define REG_G2S_DB_BG1CNT_MOSAIC_SIZE  1
#define REG_G2S_DB_BG1CNT_MOSAIC_MASK  0x0040

#define REG_G2S_DB_BG1CNT_CHARBASE_SHIFT 2
#define REG_G2S_DB_BG1CNT_CHARBASE_SIZE  4
#define REG_G2S_DB_BG1CNT_CHARBASE_MASK  0x003c

#define REG_G2S_DB_BG1CNT_PRIORITY_SHIFT 0
#define REG_G2S_DB_BG1CNT_PRIORITY_SIZE  2
#define REG_G2S_DB_BG1CNT_PRIORITY_MASK  0x0003

// G2S_DB_BG2CNT
#define REG_G2S_DB_BG2CNT_SCREENSIZE_SHIFT 14
#define REG_G2S_DB_BG2CNT_SCREENSIZE_SIZE  2
#define REG_G2S_DB_BG2CNT_SCREENSIZE_MASK  0xc000

#define REG_G2S_DB_BG2CNT_AREAOVER_SHIFT 13
#define REG_G2S_DB_BG2CNT_AREAOVER_SIZE  1
#define REG_G2S_DB_BG2CNT_AREAOVER_MASK  0x2000

#define REG_G2S_DB_BG2CNT_SCREENBASE_SHIFT 8
#define REG_G2S_DB_BG2CNT_SCREENBASE_SIZE  5
#define REG_G2S_DB_BG2CNT_SCREENBASE_MASK  0x1f00

#define REG_G2S_DB_BG2CNT_COLORMODE_SHIFT 7
#define REG_G2S_DB_BG2CNT_COLORMODE_SIZE  1
#define REG_G2S_DB_BG2CNT_COLORMODE_MASK  0x0080

#define REG_G2S_DB_BG2CNT_MOSAIC_SHIFT 6
#define REG_G2S_DB_BG2CNT_MOSAIC_SIZE  1
#define REG_G2S_DB_BG2CNT_MOSAIC_MASK  0x0040

#define REG_G2S_DB_BG2CNT_CHARBASE_SHIFT 2
#define REG_G2S_DB_BG2CNT_CHARBASE_SIZE  4
#define REG_G2S_DB_BG2CNT_CHARBASE_MASK  0x003c

#define REG_G2S_DB_BG2CNT_PRIORITY_SHIFT 0
#define REG_G2S_DB_BG2CNT_PRIORITY_SIZE  2
#define REG_G2S_DB_BG2CNT_PRIORITY_MASK  0x0003

// G2S_DB_BG3CNT
#define REG_G2S_DB_BG3CNT_SCREENSIZE_SHIFT 14
#define REG_G2S_DB_BG3CNT_SCREENSIZE_SIZE  2
#define REG_G2S_DB_BG3CNT_SCREENSIZE_MASK  0xc000

#define REG_G2S_DB_BG3CNT_AREAOVER_SHIFT 13
#define REG_G2S_DB_BG3CNT_AREAOVER_SIZE  1
#define REG_G2S_DB_BG3CNT_AREAOVER_MASK  0x2000

#define REG_G2S_DB_BG3CNT_SCREENBASE_SHIFT 8
#define REG_G2S_DB_BG3CNT_SCREENBASE_SIZE  5
#define REG_G2S_DB_BG3CNT_SCREENBASE_MASK  0x1f00

#define REG_G2S_DB_BG3CNT_COLORMODE_SHIFT 7
#define REG_G2S_DB_BG3CNT_COLORMODE_SIZE  1
#define REG_G2S_DB_BG3CNT_COLORMODE_MASK  0x0080

#define REG_G2S_DB_BG3CNT_MOSAIC_SHIFT 6
#define REG_G2S_DB_BG3CNT_MOSAIC_SIZE  1
#define REG_G2S_DB_BG3CNT_MOSAIC_MASK  0x0040

#define REG_G2S_DB_BG3CNT_CHARBASE_SHIFT 2
#define REG_G2S_DB_BG3CNT_CHARBASE_SIZE  4
#define REG_G2S_DB_BG3CNT_CHARBASE_MASK  0x003c

#define REG_G2S_DB_BG3CNT_PRIORITY_SHIFT 0
#define REG_G2S_DB_BG3CNT_PRIORITY_SIZE  2
#define REG_G2S_DB_BG3CNT_PRIORITY_MASK  0x0003

// G2_BG0OFS
#define REG_G2_BG0OFS_VOFFSET_SHIFT 16
#define REG_G2_BG0OFS_VOFFSET_SIZE  9
#define REG_G2_BG0OFS_VOFFSET_MASK  0x01ff0000

#define REG_G2_BG0OFS_HOFFSET_SHIFT 0
#define REG_G2_BG0OFS_HOFFSET_SIZE  9
#define REG_G2_BG0OFS_HOFFSET_MASK  0x000001ff

// G2_BG1OFS
#define REG_G2_BG1OFS_VOFFSET_SHIFT 16
#define REG_G2_BG1OFS_VOFFSET_SIZE  9
#define REG_G2_BG1OFS_VOFFSET_MASK  0x01ff0000

#define REG_G2_BG1OFS_HOFFSET_SHIFT 0
#define REG_G2_BG1OFS_HOFFSET_SIZE  9
#define REG_G2_BG1OFS_HOFFSET_MASK  0x000001ff

// G2_BG2OFS
#define REG_G2_BG2OFS_VOFFSET_SHIFT 16
#define REG_G2_BG2OFS_VOFFSET_SIZE  9
#define REG_G2_BG2OFS_VOFFSET_MASK  0x01ff0000

#define REG_G2_BG2OFS_HOFFSET_SHIFT 0
#define REG_G2_BG2OFS_HOFFSET_SIZE  9
#define REG_G2_BG2OFS_HOFFSET_MASK  0x000001ff

// G2_BG3OFS
#define REG_G2_BG3OFS_VOFFSET_SHIFT 16
#define REG_G2_BG3OFS_VOFFSET_SIZE  9
#define REG_G2_BG3OFS_VOFFSET_MASK  0x01ff0000

#define REG_G2_BG3OFS_HOFFSET_SHIFT 0
#define REG_G2_BG3OFS_HOFFSET_SIZE  9
#define REG_G2_BG3OFS_HOFFSET_MASK  0x000001ff

// G2S_DB_BG0OFS
#define REG_G2S_DB_BG0OFS_VOFFSET_SHIFT 16
#define REG_G2S_DB_BG0OFS_VOFFSET_SIZE  9
#define REG_G2S_DB_BG0OFS_VOFFSET_MASK  0x01ff0000

#define REG_G2S_DB_BG0OFS_HOFFSET_SHIFT 0
#define REG_G2S_DB_BG0OFS_HOFFSET_SIZE  9
#define REG_G2S_DB_BG0OFS_HOFFSET_MASK  0x000001ff

// G2S_DB_BG1OFS
#define REG_G2S_DB_BG1OFS_VOFFSET_SHIFT 16
#define REG_G2S_DB_BG1OFS_VOFFSET_SIZE  9
#define REG_G2S_DB_BG1OFS_VOFFSET_MASK  0x01ff0000

#define REG_G2S_DB_BG1OFS_HOFFSET_SHIFT 0
#define REG_G2S_DB_BG1OFS_HOFFSET_SIZE  9
#define REG_G2S_DB_BG1OFS_HOFFSET_MASK  0x000001ff

// G2S_DB_BG2OFS
#define REG_G2S_DB_BG2OFS_VOFFSET_SHIFT 16
#define REG_G2S_DB_BG2OFS_VOFFSET_SIZE  9
#define REG_G2S_DB_BG2OFS_VOFFSET_MASK  0x01ff0000

#define REG_G2S_DB_BG2OFS_HOFFSET_SHIFT 0
#define REG_G2S_DB_BG2OFS_HOFFSET_SIZE  9
#define REG_G2S_DB_BG2OFS_HOFFSET_MASK  0x000001ff

// G2S_DB_BG3OFS
#define REG_G2S_DB_BG3OFS_VOFFSET_SHIFT 16
#define REG_G2S_DB_BG3OFS_VOFFSET_SIZE  9
#define REG_G2S_DB_BG3OFS_VOFFSET_MASK  0x01ff0000

#define REG_G2S_DB_BG3OFS_HOFFSET_SHIFT 0
#define REG_G2S_DB_BG3OFS_HOFFSET_SIZE  9
#define REG_G2S_DB_BG3OFS_HOFFSET_MASK  0x000001ff

// Timer control

#define REG_OS_TM0CNT_L_TIMER0CNT_SHIFT 0
#define REG_OS_TM0CNT_L_TIMER0CNT_SIZE  16
#define REG_OS_TM0CNT_L_TIMER0CNT_MASK  0xffff

#define REG_OS_TM0CNT_H_E_SHIFT 7
#define REG_OS_TM0CNT_H_E_SIZE  1
#define REG_OS_TM0CNT_H_E_MASK  0x0080

#define REG_OS_TM0CNT_H_I_SHIFT 6
#define REG_OS_TM0CNT_H_I_SIZE  1
#define REG_OS_TM0CNT_H_I_MASK  0x0040

#define REG_OS_TM0CNT_H_PS_SHIFT 0
#define REG_OS_TM0CNT_H_PS_SIZE  2
#define REG_OS_TM0CNT_H_PS_MASK  0x0003

#define REG_OS_TM1CNT_L_TIMER0CNT_SHIFT 0
#define REG_OS_TM1CNT_L_TIMER0CNT_SIZE  16
#define REG_OS_TM1CNT_L_TIMER0CNT_MASK  0xffff

#define REG_OS_TM1CNT_H_E_SHIFT 7
#define REG_OS_TM1CNT_H_E_SIZE  1
#define REG_OS_TM1CNT_H_E_MASK  0x0080

#define REG_OS_TM1CNT_H_I_SHIFT 6
#define REG_OS_TM1CNT_H_I_SIZE  1
#define REG_OS_TM1CNT_H_I_MASK  0x0040

#define REG_OS_TM1CNT_H_PS_SHIFT 0
#define REG_OS_TM1CNT_H_PS_SIZE  2
#define REG_OS_TM1CNT_H_PS_MASK  0x0003

#define REG_OS_TM2CNT_L_TIMER0CNT_SHIFT 0
#define REG_OS_TM2CNT_L_TIMER0CNT_SIZE  16
#define REG_OS_TM2CNT_L_TIMER0CNT_MASK  0xffff

#define REG_OS_TM2CNT_H_E_SHIFT 7
#define REG_OS_TM2CNT_H_E_SIZE  1
#define REG_OS_TM2CNT_H_E_MASK  0x0080

#define REG_OS_TM2CNT_H_I_SHIFT 6
#define REG_OS_TM2CNT_H_I_SIZE  1
#define REG_OS_TM2CNT_H_I_MASK  0x0040

#define REG_OS_TM2CNT_H_PS_SHIFT 0
#define REG_OS_TM2CNT_H_PS_SIZE  2
#define REG_OS_TM2CNT_H_PS_MASK  0x0003

#define REG_OS_TM3CNT_L_TIMER0CNT_SHIFT 0
#define REG_OS_TM3CNT_L_TIMER0CNT_SIZE  16
#define REG_OS_TM3CNT_L_TIMER0CNT_MASK  0xffff

#define REG_OS_TM3CNT_H_E_SHIFT 7
#define REG_OS_TM3CNT_H_E_SIZE  1
#define REG_OS_TM3CNT_H_E_MASK  0x0080

#define REG_OS_TM3CNT_H_I_SHIFT 6
#define REG_OS_TM3CNT_H_I_SIZE  1
#define REG_OS_TM3CNT_H_I_MASK  0x0040

#define REG_OS_TM3CNT_H_PS_SHIFT 0
#define REG_OS_TM3CNT_H_PS_SIZE  2
#define REG_OS_TM3CNT_H_PS_MASK  0x0003

#define REG_G3X_DISP3DCNT_PRI_SHIFT 14
#define REG_G3X_DISP3DCNT_PRI_SIZE  1
#define REG_G3X_DISP3DCNT_PRI_MASK  0x4000

#define REG_G3X_DISP3DCNT_GO_SHIFT 13
#define REG_G3X_DISP3DCNT_GO_SIZE  1
#define REG_G3X_DISP3DCNT_GO_MASK  0x2000

#define REG_G3X_DISP3DCNT_RO_SHIFT 12
#define REG_G3X_DISP3DCNT_RO_SIZE  1
#define REG_G3X_DISP3DCNT_RO_MASK  0x1000

#define REG_G3X_DISP3DCNT_FOG_SHIFT_SHIFT 8
#define REG_G3X_DISP3DCNT_FOG_SHIFT_SIZE  4
#define REG_G3X_DISP3DCNT_FOG_SHIFT_MASK  0x0f00

#define REG_G3X_DISP3DCNT_FME_SHIFT 7
#define REG_G3X_DISP3DCNT_FME_SIZE  1
#define REG_G3X_DISP3DCNT_FME_MASK  0x0080

#define REG_G3X_DISP3DCNT_FMOD_SHIFT 6
#define REG_G3X_DISP3DCNT_FMOD_SIZE  1
#define REG_G3X_DISP3DCNT_FMOD_MASK  0x0040

#define REG_G3X_DISP3DCNT_EME_SHIFT 5
#define REG_G3X_DISP3DCNT_EME_SIZE  1
#define REG_G3X_DISP3DCNT_EME_MASK  0x0020

#define REG_G3X_DISP3DCNT_AAE_SHIFT 4
#define REG_G3X_DISP3DCNT_AAE_SIZE  1
#define REG_G3X_DISP3DCNT_AAE_MASK  0x0010

#define REG_G3X_DISP3DCNT_ABE_SHIFT 3
#define REG_G3X_DISP3DCNT_ABE_SIZE  1
#define REG_G3X_DISP3DCNT_ABE_MASK  0x0008

#define REG_G3X_DISP3DCNT_ATE_SHIFT 2
#define REG_G3X_DISP3DCNT_ATE_SIZE  1
#define REG_G3X_DISP3DCNT_ATE_MASK  0x0004

#define REG_G3X_DISP3DCNT_THS_SHIFT 1
#define REG_G3X_DISP3DCNT_THS_SIZE  1
#define REG_G3X_DISP3DCNT_THS_MASK  0x0002

#define REG_G3X_DISP3DCNT_TME_SHIFT 0
#define REG_G3X_DISP3DCNT_TME_SIZE  1
#define REG_G3X_DISP3DCNT_TME_MASK  0x0001

#ifndef SDK_ASM
#define REG_G3X_DISP3DCNT_FIELD(pri, go, ro, fog_shift, fme, fmod, eme, aae, abe, ate, ths, tme)                                                                                   \
    (u16)(((u32)(pri) << REG_G3X_DISP3DCNT_PRI_SHIFT) | ((u32)(go) << REG_G3X_DISP3DCNT_GO_SHIFT) | ((u32)(ro) << REG_G3X_DISP3DCNT_RO_SHIFT)                                      \
          | ((u32)(fog_shift) << REG_G3X_DISP3DCNT_FOG_SHIFT_SHIFT) | ((u32)(fme) << REG_G3X_DISP3DCNT_FME_SHIFT) | ((u32)(fmod) << REG_G3X_DISP3DCNT_FMOD_SHIFT)                  \
          | ((u32)(eme) << REG_G3X_DISP3DCNT_EME_SHIFT) | ((u32)(aae) << REG_G3X_DISP3DCNT_AAE_SHIFT) | ((u32)(abe) << REG_G3X_DISP3DCNT_ABE_SHIFT)                                \
          | ((u32)(ate) << REG_G3X_DISP3DCNT_ATE_SHIFT) | ((u32)(ths) << REG_G3X_DISP3DCNT_THS_SHIFT) | ((u32)(tme) << REG_G3X_DISP3DCNT_TME_SHIFT))
#endif

#endif // NITRO_HW_IO_REG_SHARED_H
