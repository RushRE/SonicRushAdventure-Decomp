#define REG_DMA0SAD_OFFSET 0x0b0
#define REG_DMA0SAD_ADDR   (HW_REG_BASE + REG_DMA0SAD_OFFSET)
#define reg_MI_DMA0SAD     (*(REGType32v *)REG_DMA0SAD_ADDR)

#define REG_DMA0DAD_OFFSET 0x0b4
#define REG_DMA0DAD_ADDR   (HW_REG_BASE + REG_DMA0DAD_OFFSET)
#define reg_MI_DMA0DAD     (*(REGType32v *)REG_DMA0DAD_ADDR)

#define REG_DMA0CNT_OFFSET 0x0b8
#define REG_DMA0CNT_ADDR   (HW_REG_BASE + REG_DMA0CNT_OFFSET)
#define reg_MI_DMA0CNT     (*(REGType32v *)REG_DMA0CNT_ADDR)

#define REG_DMA1SAD_OFFSET 0x0bc
#define REG_DMA1SAD_ADDR   (HW_REG_BASE + REG_DMA1SAD_OFFSET)
#define reg_MI_DMA1SAD     (*(REGType32v *)REG_DMA1SAD_ADDR)

#define REG_DMA1DAD_OFFSET 0x0c0
#define REG_DMA1DAD_ADDR   (HW_REG_BASE + REG_DMA1DAD_OFFSET)
#define reg_MI_DMA1DAD     (*(REGType32v *)REG_DMA1DAD_ADDR)

#define REG_DMA1CNT_OFFSET 0x0c4
#define REG_DMA1CNT_ADDR   (HW_REG_BASE + REG_DMA1CNT_OFFSET)
#define reg_MI_DMA1CNT     (*(REGType32v *)REG_DMA1CNT_ADDR)

#define REG_DMA2SAD_OFFSET 0x0c8
#define REG_DMA2SAD_ADDR   (HW_REG_BASE + REG_DMA2SAD_OFFSET)
#define reg_MI_DMA2SAD     (*(REGType32v *)REG_DMA2SAD_ADDR)

#define REG_DMA2DAD_OFFSET 0x0cc
#define REG_DMA2DAD_ADDR   (HW_REG_BASE + REG_DMA2DAD_OFFSET)
#define reg_MI_DMA2DAD     (*(REGType32v *)REG_DMA2DAD_ADDR)

#define REG_DMA2CNT_OFFSET 0x0d0
#define REG_DMA2CNT_ADDR   (HW_REG_BASE + REG_DMA2CNT_OFFSET)
#define reg_MI_DMA2CNT     (*(REGType32v *)REG_DMA2CNT_ADDR)

#define REG_DMA3SAD_OFFSET 0x0d4
#define REG_DMA3SAD_ADDR   (HW_REG_BASE + REG_DMA3SAD_OFFSET)
#define reg_MI_DMA3SAD     (*(REGType32v *)REG_DMA3SAD_ADDR)

#define REG_DMA3DAD_OFFSET 0x0d8
#define REG_DMA3DAD_ADDR   (HW_REG_BASE + REG_DMA3DAD_OFFSET)
#define reg_MI_DMA3DAD     (*(REGType32v *)REG_DMA3DAD_ADDR)

#define REG_DMA3CNT_OFFSET 0x0dc
#define REG_DMA3CNT_ADDR   (HW_REG_BASE + REG_DMA3CNT_OFFSET)
#define reg_MI_DMA3CNT     (*(REGType32v *)REG_DMA3CNT_ADDR)

#define REG_DMA0_CLR_DATA_OFFSET 0x0e0
#define REG_DMA0_CLR_DATA_ADDR   (HW_REG_BASE + REG_DMA0_CLR_DATA_OFFSET)
#define reg_MI_DMA0_CLR_DATA     (*(REGType32v *)REG_DMA0_CLR_DATA_ADDR)

#define REG_DMA1_CLR_DATA_OFFSET 0x0e4
#define REG_DMA1_CLR_DATA_ADDR   (HW_REG_BASE + REG_DMA1_CLR_DATA_OFFSET)
#define reg_MI_DMA1_CLR_DATA     (*(REGType32v *)REG_DMA1_CLR_DATA_ADDR)

#define REG_DMA2_CLR_DATA_OFFSET 0x0e8
#define REG_DMA2_CLR_DATA_ADDR   (HW_REG_BASE + REG_DMA2_CLR_DATA_OFFSET)
#define reg_MI_DMA2_CLR_DATA     (*(REGType32v *)REG_DMA2_CLR_DATA_ADDR)

#define REG_DMA3_CLR_DATA_OFFSET 0x0ec
#define REG_DMA3_CLR_DATA_ADDR   (HW_REG_BASE + REG_DMA3_CLR_DATA_OFFSET)
#define reg_MI_DMA3_CLR_DATA     (*(REGType32v *)REG_DMA3_CLR_DATA_ADDR)

#define REG_MCCNT0_OFFSET 0x1a0
#define REG_MCCNT0_ADDR   (HW_REG_BASE + REG_MCCNT0_OFFSET)
#define reg_MI_MCCNT0     (*(REGType16v *)REG_MCCNT0_ADDR)

#define REG_MCD0_OFFSET 0x1a2
#define REG_MCD0_ADDR   (HW_REG_BASE + REG_MCD0_OFFSET)
#define reg_MI_MCD0     (*(REGType16v *)REG_MCD0_ADDR)

#define REG_MCD1_OFFSET 0x100010
#define REG_MCD1_ADDR   (HW_REG_BASE + REG_MCD1_OFFSET)
#define reg_MI_MCD1     (*(REGType32v *)REG_MCD1_ADDR)

#define REG_MCCNT1_OFFSET 0x1a4
#define REG_MCCNT1_ADDR   (HW_REG_BASE + REG_MCCNT1_OFFSET)
#define reg_MI_MCCNT1     (*(REGType32v *)REG_MCCNT1_ADDR)

#define REG_MCCMD0_OFFSET 0x1a8
#define REG_MCCMD0_ADDR   (HW_REG_BASE + REG_MCCMD0_OFFSET)
#define reg_MI_MCCMD0     (*(REGType32v *)REG_MCCMD0_ADDR)

#define REG_MCCMD1_OFFSET 0x1ac
#define REG_MCCMD1_ADDR   (HW_REG_BASE + REG_MCCMD1_OFFSET)
#define reg_MI_MCCMD1     (*(REGType32v *)REG_MCCMD1_ADDR)

#define REG_EXMEMCNT_OFFSET 0x204
#define REG_EXMEMCNT_ADDR   (HW_REG_BASE + REG_EXMEMCNT_OFFSET)
#define reg_MI_EXMEMCNT     (*(REGType16v *)REG_EXMEMCNT_ADDR)

#define REG_MI_DMA0SAD_DMASRC_SHIFT 0
#define REG_MI_DMA0SAD_DMASRC_SIZE  28
#define REG_MI_DMA0SAD_DMASRC_MASK  0x0fffffff

#ifndef SDK_ASM
#define REG_MI_DMA0SAD_FIELD(dmasrc) (u32)(((u32)(dmasrc) << REG_MI_DMA0SAD_DMASRC_SHIFT))
#endif

#define REG_MI_DMA0DAD_DMADEST_SHIFT 0
#define REG_MI_DMA0DAD_DMADEST_SIZE  28
#define REG_MI_DMA0DAD_DMADEST_MASK  0x0fffffff

#ifndef SDK_ASM
#define REG_MI_DMA0DAD_FIELD(dmadest) (u32)(((u32)(dmadest) << REG_MI_DMA0DAD_DMADEST_SHIFT))
#endif

#define REG_MI_DMA0CNT_E_SHIFT 31
#define REG_MI_DMA0CNT_E_SIZE  1
#define REG_MI_DMA0CNT_E_MASK  0x80000000

#define REG_MI_DMA0CNT_I_SHIFT 30
#define REG_MI_DMA0CNT_I_SIZE  1
#define REG_MI_DMA0CNT_I_MASK  0x40000000

#define REG_MI_DMA0CNT_MODE_SHIFT 27
#define REG_MI_DMA0CNT_MODE_SIZE  3
#define REG_MI_DMA0CNT_MODE_MASK  0x38000000

#define REG_MI_DMA0CNT_SB_SHIFT 26
#define REG_MI_DMA0CNT_SB_SIZE  1
#define REG_MI_DMA0CNT_SB_MASK  0x04000000

#define REG_MI_DMA0CNT_CM_SHIFT 25
#define REG_MI_DMA0CNT_CM_SIZE  1
#define REG_MI_DMA0CNT_CM_MASK  0x02000000

#define REG_MI_DMA0CNT_SAR_SHIFT 23
#define REG_MI_DMA0CNT_SAR_SIZE  2
#define REG_MI_DMA0CNT_SAR_MASK  0x01800000

#define REG_MI_DMA0CNT_DAR_SHIFT 21
#define REG_MI_DMA0CNT_DAR_SIZE  2
#define REG_MI_DMA0CNT_DAR_MASK  0x00600000

#define REG_MI_DMA0CNT_WORDCNT_SHIFT 0
#define REG_MI_DMA0CNT_WORDCNT_SIZE  21
#define REG_MI_DMA0CNT_WORDCNT_MASK  0x001fffff

#ifndef SDK_ASM
#define REG_MI_DMA0CNT_FIELD(e, i, mode, sb, cm, sar, dar, wordcnt)                                                                                                                                    \
    (u32)(((u32)(e) << REG_MI_DMA0CNT_E_SHIFT) | ((u32)(i) << REG_MI_DMA0CNT_I_SHIFT) | ((u32)(mode) << REG_MI_DMA0CNT_MODE_SHIFT) | ((u32)(sb) << REG_MI_DMA0CNT_SB_SHIFT)                            \
          | ((u32)(cm) << REG_MI_DMA0CNT_CM_SHIFT) | ((u32)(sar) << REG_MI_DMA0CNT_SAR_SHIFT) | ((u32)(dar) << REG_MI_DMA0CNT_DAR_SHIFT) | ((u32)(wordcnt) << REG_MI_DMA0CNT_WORDCNT_SHIFT))
#endif

#define REG_MI_DMA1SAD_DMASRC_SHIFT 0
#define REG_MI_DMA1SAD_DMASRC_SIZE  28
#define REG_MI_DMA1SAD_DMASRC_MASK  0x0fffffff

#ifndef SDK_ASM
#define REG_MI_DMA1SAD_FIELD(dmasrc) (u32)(((u32)(dmasrc) << REG_MI_DMA1SAD_DMASRC_SHIFT))
#endif

#define REG_MI_DMA1DAD_DMADEST_SHIFT 0
#define REG_MI_DMA1DAD_DMADEST_SIZE  28
#define REG_MI_DMA1DAD_DMADEST_MASK  0x0fffffff

#ifndef SDK_ASM
#define REG_MI_DMA1DAD_FIELD(dmadest) (u32)(((u32)(dmadest) << REG_MI_DMA1DAD_DMADEST_SHIFT))
#endif

#define REG_MI_DMA1CNT_E_SHIFT 31
#define REG_MI_DMA1CNT_E_SIZE  1
#define REG_MI_DMA1CNT_E_MASK  0x80000000

#define REG_MI_DMA1CNT_I_SHIFT 30
#define REG_MI_DMA1CNT_I_SIZE  1
#define REG_MI_DMA1CNT_I_MASK  0x40000000

#define REG_MI_DMA1CNT_MODE_SHIFT 27
#define REG_MI_DMA1CNT_MODE_SIZE  3
#define REG_MI_DMA1CNT_MODE_MASK  0x38000000

#define REG_MI_DMA1CNT_SB_SHIFT 26
#define REG_MI_DMA1CNT_SB_SIZE  1
#define REG_MI_DMA1CNT_SB_MASK  0x04000000

#define REG_MI_DMA1CNT_CM_SHIFT 25
#define REG_MI_DMA1CNT_CM_SIZE  1
#define REG_MI_DMA1CNT_CM_MASK  0x02000000

#define REG_MI_DMA1CNT_SAR_SHIFT 23
#define REG_MI_DMA1CNT_SAR_SIZE  2
#define REG_MI_DMA1CNT_SAR_MASK  0x01800000

#define REG_MI_DMA1CNT_DAR_SHIFT 21
#define REG_MI_DMA1CNT_DAR_SIZE  2
#define REG_MI_DMA1CNT_DAR_MASK  0x00600000

#define REG_MI_DMA1CNT_WORDCNT_SHIFT 0
#define REG_MI_DMA1CNT_WORDCNT_SIZE  21
#define REG_MI_DMA1CNT_WORDCNT_MASK  0x001fffff

#ifndef SDK_ASM
#define REG_MI_DMA1CNT_FIELD(e, i, mode, sb, cm, sar, dar, wordcnt)                                                                                                                                    \
    (u32)(((u32)(e) << REG_MI_DMA1CNT_E_SHIFT) | ((u32)(i) << REG_MI_DMA1CNT_I_SHIFT) | ((u32)(mode) << REG_MI_DMA1CNT_MODE_SHIFT) | ((u32)(sb) << REG_MI_DMA1CNT_SB_SHIFT)                            \
          | ((u32)(cm) << REG_MI_DMA1CNT_CM_SHIFT) | ((u32)(sar) << REG_MI_DMA1CNT_SAR_SHIFT) | ((u32)(dar) << REG_MI_DMA1CNT_DAR_SHIFT) | ((u32)(wordcnt) << REG_MI_DMA1CNT_WORDCNT_SHIFT))
#endif

#define REG_MI_DMA2SAD_DMASRC_SHIFT 0
#define REG_MI_DMA2SAD_DMASRC_SIZE  28
#define REG_MI_DMA2SAD_DMASRC_MASK  0x0fffffff

#ifndef SDK_ASM
#define REG_MI_DMA2SAD_FIELD(dmasrc) (u32)(((u32)(dmasrc) << REG_MI_DMA2SAD_DMASRC_SHIFT))
#endif

#define REG_MI_DMA2DAD_DMADEST_SHIFT 0
#define REG_MI_DMA2DAD_DMADEST_SIZE  28
#define REG_MI_DMA2DAD_DMADEST_MASK  0x0fffffff

#ifndef SDK_ASM
#define REG_MI_DMA2DAD_FIELD(dmadest) (u32)(((u32)(dmadest) << REG_MI_DMA2DAD_DMADEST_SHIFT))
#endif

#define REG_MI_DMA2CNT_E_SHIFT 31
#define REG_MI_DMA2CNT_E_SIZE  1
#define REG_MI_DMA2CNT_E_MASK  0x80000000

#define REG_MI_DMA2CNT_I_SHIFT 30
#define REG_MI_DMA2CNT_I_SIZE  1
#define REG_MI_DMA2CNT_I_MASK  0x40000000

#define REG_MI_DMA2CNT_MODE_SHIFT 27
#define REG_MI_DMA2CNT_MODE_SIZE  3
#define REG_MI_DMA2CNT_MODE_MASK  0x38000000

#define REG_MI_DMA2CNT_SB_SHIFT 26
#define REG_MI_DMA2CNT_SB_SIZE  1
#define REG_MI_DMA2CNT_SB_MASK  0x04000000

#define REG_MI_DMA2CNT_CM_SHIFT 25
#define REG_MI_DMA2CNT_CM_SIZE  1
#define REG_MI_DMA2CNT_CM_MASK  0x02000000

#define REG_MI_DMA2CNT_SAR_SHIFT 23
#define REG_MI_DMA2CNT_SAR_SIZE  2
#define REG_MI_DMA2CNT_SAR_MASK  0x01800000

#define REG_MI_DMA2CNT_DAR_SHIFT 21
#define REG_MI_DMA2CNT_DAR_SIZE  2
#define REG_MI_DMA2CNT_DAR_MASK  0x00600000

#define REG_MI_DMA2CNT_WORDCNT_SHIFT 0
#define REG_MI_DMA2CNT_WORDCNT_SIZE  21
#define REG_MI_DMA2CNT_WORDCNT_MASK  0x001fffff

#ifndef SDK_ASM
#define REG_MI_DMA2CNT_FIELD(e, i, mode, sb, cm, sar, dar, wordcnt)                                                                                                                                    \
    (u32)(((u32)(e) << REG_MI_DMA2CNT_E_SHIFT) | ((u32)(i) << REG_MI_DMA2CNT_I_SHIFT) | ((u32)(mode) << REG_MI_DMA2CNT_MODE_SHIFT) | ((u32)(sb) << REG_MI_DMA2CNT_SB_SHIFT)                            \
          | ((u32)(cm) << REG_MI_DMA2CNT_CM_SHIFT) | ((u32)(sar) << REG_MI_DMA2CNT_SAR_SHIFT) | ((u32)(dar) << REG_MI_DMA2CNT_DAR_SHIFT) | ((u32)(wordcnt) << REG_MI_DMA2CNT_WORDCNT_SHIFT))
#endif

#define REG_MI_DMA3SAD_DMASRC_SHIFT 0
#define REG_MI_DMA3SAD_DMASRC_SIZE  28
#define REG_MI_DMA3SAD_DMASRC_MASK  0x0fffffff

#ifndef SDK_ASM
#define REG_MI_DMA3SAD_FIELD(dmasrc) (u32)(((u32)(dmasrc) << REG_MI_DMA3SAD_DMASRC_SHIFT))
#endif

#define REG_MI_DMA3DAD_DMADEST_SHIFT 0
#define REG_MI_DMA3DAD_DMADEST_SIZE  28
#define REG_MI_DMA3DAD_DMADEST_MASK  0x0fffffff

#ifndef SDK_ASM
#define REG_MI_DMA3DAD_FIELD(dmadest) (u32)(((u32)(dmadest) << REG_MI_DMA3DAD_DMADEST_SHIFT))
#endif

#define REG_MI_DMA3CNT_E_SHIFT 31
#define REG_MI_DMA3CNT_E_SIZE  1
#define REG_MI_DMA3CNT_E_MASK  0x80000000

#define REG_MI_DMA3CNT_I_SHIFT 30
#define REG_MI_DMA3CNT_I_SIZE  1
#define REG_MI_DMA3CNT_I_MASK  0x40000000

#define REG_MI_DMA3CNT_MODE_SHIFT 27
#define REG_MI_DMA3CNT_MODE_SIZE  3
#define REG_MI_DMA3CNT_MODE_MASK  0x38000000

#define REG_MI_DMA3CNT_SB_SHIFT 26
#define REG_MI_DMA3CNT_SB_SIZE  1
#define REG_MI_DMA3CNT_SB_MASK  0x04000000

#define REG_MI_DMA3CNT_CM_SHIFT 25
#define REG_MI_DMA3CNT_CM_SIZE  1
#define REG_MI_DMA3CNT_CM_MASK  0x02000000

#define REG_MI_DMA3CNT_SAR_SHIFT 23
#define REG_MI_DMA3CNT_SAR_SIZE  2
#define REG_MI_DMA3CNT_SAR_MASK  0x01800000

#define REG_MI_DMA3CNT_DAR_SHIFT 21
#define REG_MI_DMA3CNT_DAR_SIZE  2
#define REG_MI_DMA3CNT_DAR_MASK  0x00600000

#define REG_MI_DMA3CNT_WORDCNT_SHIFT 0
#define REG_MI_DMA3CNT_WORDCNT_SIZE  21
#define REG_MI_DMA3CNT_WORDCNT_MASK  0x001fffff

#ifndef SDK_ASM
#define REG_MI_DMA3CNT_FIELD(e, i, mode, sb, cm, sar, dar, wordcnt)                                                                                                                                    \
    (u32)(((u32)(e) << REG_MI_DMA3CNT_E_SHIFT) | ((u32)(i) << REG_MI_DMA3CNT_I_SHIFT) | ((u32)(mode) << REG_MI_DMA3CNT_MODE_SHIFT) | ((u32)(sb) << REG_MI_DMA3CNT_SB_SHIFT)                            \
          | ((u32)(cm) << REG_MI_DMA3CNT_CM_SHIFT) | ((u32)(sar) << REG_MI_DMA3CNT_SAR_SHIFT) | ((u32)(dar) << REG_MI_DMA3CNT_DAR_SHIFT) | ((u32)(wordcnt) << REG_MI_DMA3CNT_WORDCNT_SHIFT))
#endif

#define REG_MI_MCCNT0_E_SHIFT 15
#define REG_MI_MCCNT0_E_SIZE  1
#define REG_MI_MCCNT0_E_MASK  0x8000

#define REG_MI_MCCNT0_I_SHIFT 14
#define REG_MI_MCCNT0_I_SIZE  1
#define REG_MI_MCCNT0_I_MASK  0x4000

#define REG_MI_MCCNT0_SEL_SHIFT 13
#define REG_MI_MCCNT0_SEL_SIZE  1
#define REG_MI_MCCNT0_SEL_MASK  0x2000

#define REG_MI_MCCNT0_BUSY_SHIFT 7
#define REG_MI_MCCNT0_BUSY_SIZE  1
#define REG_MI_MCCNT0_BUSY_MASK  0x0080

#define REG_MI_MCCNT0_MODE_SHIFT 6
#define REG_MI_MCCNT0_MODE_SIZE  1
#define REG_MI_MCCNT0_MODE_MASK  0x0040

#define REG_MI_MCCNT0_BAUDRATE_SHIFT 0
#define REG_MI_MCCNT0_BAUDRATE_SIZE  2
#define REG_MI_MCCNT0_BAUDRATE_MASK  0x0003

#ifndef SDK_ASM
#define REG_MI_MCCNT0_FIELD(e, i, sel, busy, mode, baudrate)                                                                                                                                           \
    (u16)(((u32)(e) << REG_MI_MCCNT0_E_SHIFT) | ((u32)(i) << REG_MI_MCCNT0_I_SHIFT) | ((u32)(sel) << REG_MI_MCCNT0_SEL_SHIFT) | ((u32)(busy) << REG_MI_MCCNT0_BUSY_SHIFT)                              \
          | ((u32)(mode) << REG_MI_MCCNT0_MODE_SHIFT) | ((u32)(baudrate) << REG_MI_MCCNT0_BAUDRATE_SHIFT))
#endif

#define REG_MI_MCD0_DATA_SHIFT 0
#define REG_MI_MCD0_DATA_SIZE  8
#define REG_MI_MCD0_DATA_MASK  0x00ff

#ifndef SDK_ASM
#define REG_MI_MCD0_FIELD(data) (u16)(((u32)(data) << REG_MI_MCD0_DATA_SHIFT))
#endif

#define REG_MI_MCCNT1_START_SHIFT 31
#define REG_MI_MCCNT1_START_SIZE  1
#define REG_MI_MCCNT1_START_MASK  0x80000000

#define REG_MI_MCCNT1_WR_SHIFT 30
#define REG_MI_MCCNT1_WR_SIZE  1
#define REG_MI_MCCNT1_WR_MASK  0x40000000

#define REG_MI_MCCNT1_CT_SHIFT 27
#define REG_MI_MCCNT1_CT_SIZE  1
#define REG_MI_MCCNT1_CT_MASK  0x08000000

#define REG_MI_MCCNT1_PC_SHIFT 24
#define REG_MI_MCCNT1_PC_SIZE  3
#define REG_MI_MCCNT1_PC_MASK  0x07000000

#define REG_MI_MCCNT1_RDY_SHIFT 23
#define REG_MI_MCCNT1_RDY_SIZE  1
#define REG_MI_MCCNT1_RDY_MASK  0x00800000

#define REG_MI_MCCNT1_L2_SHIFT 16
#define REG_MI_MCCNT1_L2_SIZE  6
#define REG_MI_MCCNT1_L2_MASK  0x003f0000

#define REG_MI_MCCNT1_L1_SHIFT 0
#define REG_MI_MCCNT1_L1_SIZE  13
#define REG_MI_MCCNT1_L1_MASK  0x00001fff

#ifndef SDK_ASM
#define REG_MI_MCCNT1_FIELD(start, wr, ct, pc, rdy, l2, l1)                                                                                                                                            \
    (u32)(((u32)(start) << REG_MI_MCCNT1_START_SHIFT) | ((u32)(wr) << REG_MI_MCCNT1_WR_SHIFT) | ((u32)(ct) << REG_MI_MCCNT1_CT_SHIFT) | ((u32)(pc) << REG_MI_MCCNT1_PC_SHIFT)                          \
          | ((u32)(rdy) << REG_MI_MCCNT1_RDY_SHIFT) | ((u32)(l2) << REG_MI_MCCNT1_L2_SHIFT) | ((u32)(l1) << REG_MI_MCCNT1_L1_SHIFT))
#endif

#define REG_MI_MCCMD0_CMD3_SHIFT 24
#define REG_MI_MCCMD0_CMD3_SIZE  8
#define REG_MI_MCCMD0_CMD3_MASK  0xff000000

#define REG_MI_MCCMD0_CMD2_SHIFT 16
#define REG_MI_MCCMD0_CMD2_SIZE  8
#define REG_MI_MCCMD0_CMD2_MASK  0x00ff0000

#define REG_MI_MCCMD0_CMD1_SHIFT 8
#define REG_MI_MCCMD0_CMD1_SIZE  8
#define REG_MI_MCCMD0_CMD1_MASK  0x0000ff00

#define REG_MI_MCCMD0_CMD0_SHIFT 0
#define REG_MI_MCCMD0_CMD0_SIZE  8
#define REG_MI_MCCMD0_CMD0_MASK  0x000000ff

#ifndef SDK_ASM
#define REG_MI_MCCMD0_FIELD(cmd3, cmd2, cmd1, cmd0)                                                                                                                                                    \
    (u32)(((u32)(cmd3) << REG_MI_MCCMD0_CMD3_SHIFT) | ((u32)(cmd2) << REG_MI_MCCMD0_CMD2_SHIFT) | ((u32)(cmd1) << REG_MI_MCCMD0_CMD1_SHIFT) | ((u32)(cmd0) << REG_MI_MCCMD0_CMD0_SHIFT))
#endif

#define REG_MI_MCCMD1_CMD7_SHIFT 24
#define REG_MI_MCCMD1_CMD7_SIZE  8
#define REG_MI_MCCMD1_CMD7_MASK  0xff000000

#define REG_MI_MCCMD1_CMD6_SHIFT 16
#define REG_MI_MCCMD1_CMD6_SIZE  8
#define REG_MI_MCCMD1_CMD6_MASK  0x00ff0000

#define REG_MI_MCCMD1_CMD5_SHIFT 8
#define REG_MI_MCCMD1_CMD5_SIZE  8
#define REG_MI_MCCMD1_CMD5_MASK  0x0000ff00

#define REG_MI_MCCMD1_CMD4_SHIFT 0
#define REG_MI_MCCMD1_CMD4_SIZE  8
#define REG_MI_MCCMD1_CMD4_MASK  0x000000ff

#ifndef SDK_ASM
#define REG_MI_MCCMD1_FIELD(cmd7, cmd6, cmd5, cmd4)                                                                                                                                                    \
    (u32)(((u32)(cmd7) << REG_MI_MCCMD1_CMD7_SHIFT) | ((u32)(cmd6) << REG_MI_MCCMD1_CMD6_SHIFT) | ((u32)(cmd5) << REG_MI_MCCMD1_CMD5_SHIFT) | ((u32)(cmd4) << REG_MI_MCCMD1_CMD4_SHIFT))
#endif

#define REG_MI_EXMEMCNT_EP_SHIFT 15
#define REG_MI_EXMEMCNT_EP_SIZE  1
#define REG_MI_EXMEMCNT_EP_MASK  0x8000

#define REG_MI_EXMEMCNT_IFM_SHIFT 14
#define REG_MI_EXMEMCNT_IFM_SIZE  1
#define REG_MI_EXMEMCNT_IFM_MASK  0x4000

#define REG_MI_EXMEMCNT_MP_SHIFT 11
#define REG_MI_EXMEMCNT_MP_SIZE  1
#define REG_MI_EXMEMCNT_MP_MASK  0x0800

#define REG_MI_EXMEMCNT_CP_SHIFT 7
#define REG_MI_EXMEMCNT_CP_SIZE  1
#define REG_MI_EXMEMCNT_CP_MASK  0x0080

#define REG_MI_EXMEMCNT_PHI_SHIFT 5
#define REG_MI_EXMEMCNT_PHI_SIZE  2
#define REG_MI_EXMEMCNT_PHI_MASK  0x0060

#define REG_MI_EXMEMCNT_ROM2nd_SHIFT 4
#define REG_MI_EXMEMCNT_ROM2nd_SIZE  1
#define REG_MI_EXMEMCNT_ROM2nd_MASK  0x0010

#define REG_MI_EXMEMCNT_ROM1st_SHIFT 2
#define REG_MI_EXMEMCNT_ROM1st_SIZE  2
#define REG_MI_EXMEMCNT_ROM1st_MASK  0x000c

#define REG_MI_EXMEMCNT_RAM_SHIFT 0
#define REG_MI_EXMEMCNT_RAM_SIZE  2
#define REG_MI_EXMEMCNT_RAM_MASK  0x0003

#ifndef SDK_ASM
#define REG_MI_EXMEMCNT_FIELD(ep, ifm, mp, cp, phi, rom2nd, rom1st, ram)                                                                                                                               \
    (u16)(((u32)(ep) << REG_MI_EXMEMCNT_EP_SHIFT) | ((u32)(ifm) << REG_MI_EXMEMCNT_IFM_SHIFT) | ((u32)(mp) << REG_MI_EXMEMCNT_MP_SHIFT) | ((u32)(cp) << REG_MI_EXMEMCNT_CP_SHIFT)                      \
          | ((u32)(phi) << REG_MI_EXMEMCNT_PHI_SHIFT) | ((u32)(rom2nd) << REG_MI_EXMEMCNT_ROM2nd_SHIFT) | ((u32)(rom1st) << REG_MI_EXMEMCNT_ROM1st_SHIFT) | ((u32)(ram) << REG_MI_EXMEMCNT_RAM_SHIFT))
#endif