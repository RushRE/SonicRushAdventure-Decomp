#define REG_SPICNT_OFFSET 0x1c0
#define REG_SPICNT_ADDR   (HW_REG_BASE + REG_SPICNT_OFFSET)
#define reg_SPI_SPICNT    (*(REGType16v *)REG_SPICNT_ADDR)

#define REG_SPID_OFFSET 0x1c2
#define REG_SPID_ADDR   (HW_REG_BASE + REG_SPID_OFFSET)
#define reg_SPI_SPID    (*(REGType16v *)REG_SPID_ADDR)

#define REG_SPI_SPICNT_E_SHIFT 15
#define REG_SPI_SPICNT_E_SIZE  1
#define REG_SPI_SPICNT_E_MASK  0x8000

#define REG_SPI_SPICNT_I_SHIFT 14
#define REG_SPI_SPICNT_I_SIZE  1
#define REG_SPI_SPICNT_I_MASK  0x4000

#define REG_SPI_SPICNT_SEL_SHIFT 13
#define REG_SPI_SPICNT_SEL_SIZE  1
#define REG_SPI_SPICNT_SEL_MASK  0x2000

#define REG_SPI_SPICNT_MODE_SHIFT 12
#define REG_SPI_SPICNT_MODE_SIZE  1
#define REG_SPI_SPICNT_MODE_MASK  0x1000

#define REG_SPI_SPICNT_BUSY_SHIFT 7
#define REG_SPI_SPICNT_BUSY_SIZE  1
#define REG_SPI_SPICNT_BUSY_MASK  0x0080

#define REG_SPI_SPICNT_BAUDRATE_SHIFT 0
#define REG_SPI_SPICNT_BAUDRATE_SIZE  2
#define REG_SPI_SPICNT_BAUDRATE_MASK  0x0003

#ifndef SDK_ASM
#define REG_SPI_SPICNT_FIELD(e, i, sel, mode, busy, baudrate)                                                                                                                      \
    (u16)(((u32)(e) << REG_SPI_SPICNT_E_SHIFT) | ((u32)(i) << REG_SPI_SPICNT_I_SHIFT) | ((u32)(sel) << REG_SPI_SPICNT_SEL_SHIFT) | ((u32)(mode) << REG_SPI_SPICNT_MODE_SHIFT)      \
          | ((u32)(busy) << REG_SPI_SPICNT_BUSY_SHIFT) | ((u32)(baudrate) << REG_SPI_SPICNT_BAUDRATE_SHIFT))
#endif

#define REG_SPI_SPID_DATA_SHIFT 0
#define REG_SPI_SPID_DATA_SIZE  8
#define REG_SPI_SPID_DATA_MASK  0x00ff

#ifndef SDK_ASM
#define REG_SPI_SPID_FIELD(data) (u16)(((u32)(data) << REG_SPI_SPID_DATA_SHIFT))
#endif