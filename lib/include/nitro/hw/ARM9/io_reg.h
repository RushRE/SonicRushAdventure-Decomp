#ifndef NITRO_HW_ARM9_IO_REG_H
#define NITRO_HW_ARM9_IO_REG_H

#define REG_SUBPINTF_ADDR     0x4000180
#define reg_PXI_SUBPINTF      (*(REGType16v *)REG_SUBPINTF_ADDR)
#define reg_PXI_SUBP_FIFO_CNT (*(REGType16v *)0x4000184)
#define reg_PXI_SEND_FIFO     (*(REGType32v *)0x4000188)

#define reg_PXI_RECV_FIFO (*(REGType32v *)0x4100000)

// ===========
// VCOUNT
// ===========

#define REG_GX_VCOUNT_VCOUNTER_SHIFT 0
#define REG_GX_VCOUNT_VCOUNTER_SIZE  9
#define REG_GX_VCOUNT_VCOUNTER_MASK  0x01ff

#ifndef SDK_ASM
#define REG_GX_VCOUNT_FIELD(vcounter) (u16)(((u32)(vcounter) << REG_GX_VCOUNT_VCOUNTER_SHIFT))
#endif

// ===========
// DISPCAPCNT
// ===========

#define REG_GX_DISPCAPCNT_E_SHIFT 31
#define REG_GX_DISPCAPCNT_E_SIZE  1
#define REG_GX_DISPCAPCNT_E_MASK  0x80000000

#define REG_GX_DISPCAPCNT_MOD_SHIFT 29
#define REG_GX_DISPCAPCNT_MOD_SIZE  2
#define REG_GX_DISPCAPCNT_MOD_MASK  0x60000000

#define REG_GX_DISPCAPCNT_COFS_SHIFT 26
#define REG_GX_DISPCAPCNT_COFS_SIZE  2
#define REG_GX_DISPCAPCNT_COFS_MASK  0x0c000000

#define REG_GX_DISPCAPCNT_SRCB_SHIFT 25
#define REG_GX_DISPCAPCNT_SRCB_SIZE  1
#define REG_GX_DISPCAPCNT_SRCB_MASK  0x02000000

#define REG_GX_DISPCAPCNT_SRCA_SHIFT 24
#define REG_GX_DISPCAPCNT_SRCA_SIZE  1
#define REG_GX_DISPCAPCNT_SRCA_MASK  0x01000000

#define REG_GX_DISPCAPCNT_WSIZE_SHIFT 20
#define REG_GX_DISPCAPCNT_WSIZE_SIZE  2
#define REG_GX_DISPCAPCNT_WSIZE_MASK  0x00300000

#define REG_GX_DISPCAPCNT_WOFS_SHIFT 18
#define REG_GX_DISPCAPCNT_WOFS_SIZE  2
#define REG_GX_DISPCAPCNT_WOFS_MASK  0x000c0000

#define REG_GX_DISPCAPCNT_DEST_SHIFT 16
#define REG_GX_DISPCAPCNT_DEST_SIZE  2
#define REG_GX_DISPCAPCNT_DEST_MASK  0x00030000

#define REG_GX_DISPCAPCNT_EVB_SHIFT 8
#define REG_GX_DISPCAPCNT_EVB_SIZE  5
#define REG_GX_DISPCAPCNT_EVB_MASK  0x00001f00

#define REG_GX_DISPCAPCNT_EVA_SHIFT 0
#define REG_GX_DISPCAPCNT_EVA_SIZE  5
#define REG_GX_DISPCAPCNT_EVA_MASK  0x0000001f

#ifndef SDK_ASM
#define REG_GX_DISPCAPCNT_FIELD(e, mod, cofs, srcb, srca, wsize, wofs, dest, evb, eva)                                                                                                                 \
    (u32)(((u32)(e) << REG_GX_DISPCAPCNT_E_SHIFT) | ((u32)(mod) << REG_GX_DISPCAPCNT_MOD_SHIFT) | ((u32)(cofs) << REG_GX_DISPCAPCNT_COFS_SHIFT) | ((u32)(srcb) << REG_GX_DISPCAPCNT_SRCB_SHIFT)        \
          | ((u32)(srca) << REG_GX_DISPCAPCNT_SRCA_SHIFT) | ((u32)(wsize) << REG_GX_DISPCAPCNT_WSIZE_SHIFT) | ((u32)(wofs) << REG_GX_DISPCAPCNT_WOFS_SHIFT)                                            \
          | ((u32)(dest) << REG_GX_DISPCAPCNT_DEST_SHIFT) | ((u32)(evb) << REG_GX_DISPCAPCNT_EVB_SHIFT) | ((u32)(eva) << REG_GX_DISPCAPCNT_EVA_SHIFT))
#endif

// ===========
// DISP_MMEM_FIFO
// ===========

#define REG_GX_DISP_MMEM_FIFO_EVEN_SHIFT 0
#define REG_GX_DISP_MMEM_FIFO_EVEN_SIZE  16
#define REG_GX_DISP_MMEM_FIFO_EVEN_MASK  0x0000ffff

#define REG_GX_DISP_MMEM_FIFO_ODD_SHIFT 16
#define REG_GX_DISP_MMEM_FIFO_ODD_SIZE  16
#define REG_GX_DISP_MMEM_FIFO_ODD_MASK  0xffff0000

#ifndef SDK_ASM
#define REG_GX_DISP_MMEM_FIFO_FIELD(even, odd) (u32)(((u32)(even) << REG_GX_DISP_MMEM_FIFO_EVEN_SHIFT) | ((u32)(odd) << REG_GX_DISP_MMEM_FIFO_ODD_SHIFT))
#endif

// ===========
// DISP_MMEM_FIFO_L
// ===========

#define REG_GX_DISP_MMEM_FIFO_L_RED_SHIFT 0
#define REG_GX_DISP_MMEM_FIFO_L_RED_SIZE  5
#define REG_GX_DISP_MMEM_FIFO_L_RED_MASK  0x001f

#define REG_GX_DISP_MMEM_FIFO_L_GREEN_SHIFT 5
#define REG_GX_DISP_MMEM_FIFO_L_GREEN_SIZE  5
#define REG_GX_DISP_MMEM_FIFO_L_GREEN_MASK  0x03e0

#define REG_GX_DISP_MMEM_FIFO_L_BLUE_SHIFT 10
#define REG_GX_DISP_MMEM_FIFO_L_BLUE_SIZE  5
#define REG_GX_DISP_MMEM_FIFO_L_BLUE_MASK  0x7c00

#ifndef SDK_ASM
#define REG_GX_DISP_MMEM_FIFO_L_FIELD(red, green, blue)                                                                                                                                                \
    (u16)(((u32)(red) << REG_GX_DISP_MMEM_FIFO_L_RED_SHIFT) | ((u32)(green) << REG_GX_DISP_MMEM_FIFO_L_GREEN_SHIFT) | ((u32)(blue) << REG_GX_DISP_MMEM_FIFO_L_BLUE_SHIFT))
#endif

// ===========
// DISP_MMEM_FIFO_H
// ===========

#define REG_GX_DISP_MMEM_FIFO_H_RED_SHIFT 0
#define REG_GX_DISP_MMEM_FIFO_H_RED_SIZE  5
#define REG_GX_DISP_MMEM_FIFO_H_RED_MASK  0x001f

#define REG_GX_DISP_MMEM_FIFO_H_GREEN_SHIFT 5
#define REG_GX_DISP_MMEM_FIFO_H_GREEN_SIZE  5
#define REG_GX_DISP_MMEM_FIFO_H_GREEN_MASK  0x03e0

#define REG_GX_DISP_MMEM_FIFO_H_BLUE_SHIFT 10
#define REG_GX_DISP_MMEM_FIFO_H_BLUE_SIZE  5
#define REG_GX_DISP_MMEM_FIFO_H_BLUE_MASK  0x7c00

#ifndef SDK_ASM
#define REG_GX_DISP_MMEM_FIFO_H_FIELD(red, green, blue)                                                                                                                                                \
    (u16)(((u32)(red) << REG_GX_DISP_MMEM_FIFO_H_RED_SHIFT) | ((u32)(green) << REG_GX_DISP_MMEM_FIFO_H_GREEN_SHIFT) | ((u32)(blue) << REG_GX_DISP_MMEM_FIFO_H_BLUE_SHIFT))
#endif

// ===========
// MASTER_BRIGHT
// ===========

#define REG_GX_MASTER_BRIGHT_E_MOD_SHIFT 14
#define REG_GX_MASTER_BRIGHT_E_MOD_SIZE  2
#define REG_GX_MASTER_BRIGHT_E_MOD_MASK  0xc000

#define REG_GX_MASTER_BRIGHT_E_VALUE_SHIFT 0
#define REG_GX_MASTER_BRIGHT_E_VALUE_SIZE  5
#define REG_GX_MASTER_BRIGHT_E_VALUE_MASK  0x001f

#ifndef SDK_ASM
#define REG_GX_MASTER_BRIGHT_FIELD(e_mod, e_value) (u16)(((u32)(e_mod) << REG_GX_MASTER_BRIGHT_E_MOD_SHIFT) | ((u32)(e_value) << REG_GX_MASTER_BRIGHT_E_VALUE_SHIFT))
#endif

// ===========
// TVOUTCNT
// ===========

#define REG_GX_TVOUTCNT_COMMAND3_SHIFT 8
#define REG_GX_TVOUTCNT_COMMAND3_SIZE  4
#define REG_GX_TVOUTCNT_COMMAND3_MASK  0x0f00

#define REG_GX_TVOUTCNT_COMMAND2_SHIFT 4
#define REG_GX_TVOUTCNT_COMMAND2_SIZE  4
#define REG_GX_TVOUTCNT_COMMAND2_MASK  0x00f0

#define REG_GX_TVOUTCNT_COMMAND_SHIFT 0
#define REG_GX_TVOUTCNT_COMMAND_SIZE  4
#define REG_GX_TVOUTCNT_COMMAND_MASK  0x000f

#ifndef SDK_ASM
#define REG_GX_TVOUTCNT_FIELD(command3, command2, command)                                                                                                                                             \
    (u16)(((u32)(command3) << REG_GX_TVOUTCNT_COMMAND3_SHIFT) | ((u32)(command2) << REG_GX_TVOUTCNT_COMMAND2_SHIFT) | ((u32)(command) << REG_GX_TVOUTCNT_COMMAND_SHIFT))
#endif

// ===========
// VRAMCNT_A
// ===========

#define REG_GX_VRAMCNT_A_E_SHIFT 7
#define REG_GX_VRAMCNT_A_E_SIZE  1
#define REG_GX_VRAMCNT_A_E_MASK  0x80

#define REG_GX_VRAMCNT_A_OFS_SHIFT 3
#define REG_GX_VRAMCNT_A_OFS_SIZE  2
#define REG_GX_VRAMCNT_A_OFS_MASK  0x18

#define REG_GX_VRAMCNT_A_MST_SHIFT 0
#define REG_GX_VRAMCNT_A_MST_SIZE  2
#define REG_GX_VRAMCNT_A_MST_MASK  0x03

#ifndef SDK_ASM
#define REG_GX_VRAMCNT_A_FIELD(e, ofs, mst) (u8)(((u32)(e) << REG_GX_VRAMCNT_A_E_SHIFT) | ((u32)(ofs) << REG_GX_VRAMCNT_A_OFS_SHIFT) | ((u32)(mst) << REG_GX_VRAMCNT_A_MST_SHIFT))
#endif

// ===========
// VRAMCNT_B
// ===========

#define REG_GX_VRAMCNT_B_E_SHIFT 7
#define REG_GX_VRAMCNT_B_E_SIZE  1
#define REG_GX_VRAMCNT_B_E_MASK  0x80

#define REG_GX_VRAMCNT_B_OFS_SHIFT 3
#define REG_GX_VRAMCNT_B_OFS_SIZE  2
#define REG_GX_VRAMCNT_B_OFS_MASK  0x18

#define REG_GX_VRAMCNT_B_MST_SHIFT 0
#define REG_GX_VRAMCNT_B_MST_SIZE  2
#define REG_GX_VRAMCNT_B_MST_MASK  0x03

#ifndef SDK_ASM
#define REG_GX_VRAMCNT_B_FIELD(e, ofs, mst) (u8)(((u32)(e) << REG_GX_VRAMCNT_B_E_SHIFT) | ((u32)(ofs) << REG_GX_VRAMCNT_B_OFS_SHIFT) | ((u32)(mst) << REG_GX_VRAMCNT_B_MST_SHIFT))
#endif

// ===========
// VRAMCNT_C
// ===========

#define REG_GX_VRAMCNT_C_E_SHIFT 7
#define REG_GX_VRAMCNT_C_E_SIZE  1
#define REG_GX_VRAMCNT_C_E_MASK  0x80

#define REG_GX_VRAMCNT_C_OFS_SHIFT 3
#define REG_GX_VRAMCNT_C_OFS_SIZE  2
#define REG_GX_VRAMCNT_C_OFS_MASK  0x18

#define REG_GX_VRAMCNT_C_MST_SHIFT 0
#define REG_GX_VRAMCNT_C_MST_SIZE  3
#define REG_GX_VRAMCNT_C_MST_MASK  0x07

#ifndef SDK_ASM
#define REG_GX_VRAMCNT_C_FIELD(e, ofs, mst) (u8)(((u32)(e) << REG_GX_VRAMCNT_C_E_SHIFT) | ((u32)(ofs) << REG_GX_VRAMCNT_C_OFS_SHIFT) | ((u32)(mst) << REG_GX_VRAMCNT_C_MST_SHIFT))
#endif

// ===========
// VRAMCNT_D
// ===========

#define REG_GX_VRAMCNT_D_E_SHIFT 7
#define REG_GX_VRAMCNT_D_E_SIZE  1
#define REG_GX_VRAMCNT_D_E_MASK  0x80

#define REG_GX_VRAMCNT_D_OFS_SHIFT 3
#define REG_GX_VRAMCNT_D_OFS_SIZE  2
#define REG_GX_VRAMCNT_D_OFS_MASK  0x18

#define REG_GX_VRAMCNT_D_MST_SHIFT 0
#define REG_GX_VRAMCNT_D_MST_SIZE  3
#define REG_GX_VRAMCNT_D_MST_MASK  0x07

#ifndef SDK_ASM
#define REG_GX_VRAMCNT_D_FIELD(e, ofs, mst) (u8)(((u32)(e) << REG_GX_VRAMCNT_D_E_SHIFT) | ((u32)(ofs) << REG_GX_VRAMCNT_D_OFS_SHIFT) | ((u32)(mst) << REG_GX_VRAMCNT_D_MST_SHIFT))
#endif

// ===========
// VRAMCNT_E
// ===========

#define REG_GX_VRAMCNT_E_E_SHIFT 7
#define REG_GX_VRAMCNT_E_E_SIZE  1
#define REG_GX_VRAMCNT_E_E_MASK  0x80

#define REG_GX_VRAMCNT_E_MST_SHIFT 0
#define REG_GX_VRAMCNT_E_MST_SIZE  3
#define REG_GX_VRAMCNT_E_MST_MASK  0x07

#ifndef SDK_ASM
#define REG_GX_VRAMCNT_E_FIELD(e, mst) (u8)(((u32)(e) << REG_GX_VRAMCNT_E_E_SHIFT) | ((u32)(mst) << REG_GX_VRAMCNT_E_MST_SHIFT))
#endif

// ===========
// VRAMCNT_F
// ===========

#define REG_GX_VRAMCNT_F_E_SHIFT 7
#define REG_GX_VRAMCNT_F_E_SIZE  1
#define REG_GX_VRAMCNT_F_E_MASK  0x80

#define REG_GX_VRAMCNT_F_OFS_SHIFT 3
#define REG_GX_VRAMCNT_F_OFS_SIZE  2
#define REG_GX_VRAMCNT_F_OFS_MASK  0x18

#define REG_GX_VRAMCNT_F_MST_SHIFT 0
#define REG_GX_VRAMCNT_F_MST_SIZE  3
#define REG_GX_VRAMCNT_F_MST_MASK  0x07

#ifndef SDK_ASM
#define REG_GX_VRAMCNT_F_FIELD(e, ofs, mst) (u8)(((u32)(e) << REG_GX_VRAMCNT_F_E_SHIFT) | ((u32)(ofs) << REG_GX_VRAMCNT_F_OFS_SHIFT) | ((u32)(mst) << REG_GX_VRAMCNT_F_MST_SHIFT))
#endif

// ===========
// VRAMCNT_G
// ===========

#define REG_GX_VRAMCNT_G_E_SHIFT 7
#define REG_GX_VRAMCNT_G_E_SIZE  1
#define REG_GX_VRAMCNT_G_E_MASK  0x80

#define REG_GX_VRAMCNT_G_OFS_SHIFT 3
#define REG_GX_VRAMCNT_G_OFS_SIZE  2
#define REG_GX_VRAMCNT_G_OFS_MASK  0x18

#define REG_GX_VRAMCNT_G_MST_SHIFT 0
#define REG_GX_VRAMCNT_G_MST_SIZE  3
#define REG_GX_VRAMCNT_G_MST_MASK  0x07

#ifndef SDK_ASM
#define REG_GX_VRAMCNT_G_FIELD(e, ofs, mst) (u8)(((u32)(e) << REG_GX_VRAMCNT_G_E_SHIFT) | ((u32)(ofs) << REG_GX_VRAMCNT_G_OFS_SHIFT) | ((u32)(mst) << REG_GX_VRAMCNT_G_MST_SHIFT))
#endif

// ===========
// VRAMCNT_WRAM
// ===========

#define REG_GX_VRAMCNT_WRAM_BANK_SHIFT 0
#define REG_GX_VRAMCNT_WRAM_BANK_SIZE  2
#define REG_GX_VRAMCNT_WRAM_BANK_MASK  0x03

#ifndef SDK_ASM
#define REG_GX_VRAMCNT_WRAM_FIELD(bank) (u8)(((u32)(bank) << REG_GX_VRAMCNT_WRAM_BANK_SHIFT))
#endif

// ===========
// VRAMCNT_H
// ===========

#define REG_GX_VRAMCNT_H_E_SHIFT 7
#define REG_GX_VRAMCNT_H_E_SIZE  1
#define REG_GX_VRAMCNT_H_E_MASK  0x80

#define REG_GX_VRAMCNT_H_MST_SHIFT 0
#define REG_GX_VRAMCNT_H_MST_SIZE  2
#define REG_GX_VRAMCNT_H_MST_MASK  0x03

#ifndef SDK_ASM
#define REG_GX_VRAMCNT_H_FIELD(e, mst) (u8)(((u32)(e) << REG_GX_VRAMCNT_H_E_SHIFT) | ((u32)(mst) << REG_GX_VRAMCNT_H_MST_SHIFT))
#endif

// ===========
// VRAMCNT_I
// ===========

#define REG_GX_VRAMCNT_I_E_SHIFT 7
#define REG_GX_VRAMCNT_I_E_SIZE  1
#define REG_GX_VRAMCNT_I_E_MASK  0x80

#define REG_GX_VRAMCNT_I_MST_SHIFT 0
#define REG_GX_VRAMCNT_I_MST_SIZE  2
#define REG_GX_VRAMCNT_I_MST_MASK  0x03

#ifndef SDK_ASM
#define REG_GX_VRAMCNT_I_FIELD(e, mst) (u8)(((u32)(e) << REG_GX_VRAMCNT_I_E_SHIFT) | ((u32)(mst) << REG_GX_VRAMCNT_I_MST_SHIFT))
#endif

// ===========
// POWCNT
// ===========

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

#ifndef SDK_ASM
#define REG_GX_POWCNT_FIELD(ge, re, e2dg, lcd, lcdb, e2dgb, dsel)                                                                                                                                      \
    (u16)(((u32)(ge) << REG_GX_POWCNT_GE_SHIFT) | ((u32)(re) << REG_GX_POWCNT_RE_SHIFT) | ((u32)(e2dg) << REG_GX_POWCNT_E2DG_SHIFT) | ((u32)(lcd) << REG_GX_POWCNT_LCD_SHIFT)                          \
          | ((u32)(lcdb) << REG_GX_POWCNT_LCDB_SHIFT) | ((u32)(e2dgb) << REG_GX_POWCNT_E2DGB_SHIFT) | ((u32)(dsel) << REG_GX_POWCNT_DSEL_SHIFT))
#endif

#include <nitro/hw/ARM9/io_reg_cp.h>
#include <nitro/hw/ARM9/io_reg_mi.h>
#include <nitro/hw/ARM9/io_reg_gx.h>
#include <nitro/hw/ARM9/io_reg_gxs.h>
#include <nitro/hw/ARM9/io_reg_g2.h>
#include <nitro/hw/ARM9/io_reg_g2s.h>
#include <nitro/hw/ARM9/io_reg_g3.h>
#include <nitro/hw/ARM9/io_reg_g3x.h>
#include <nitro/hw/ARM9/io_reg_os.h>

#endif // NITRO_HW_ARM9_IO_REG_H
