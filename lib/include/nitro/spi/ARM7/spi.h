#ifndef NITRO_SPI_SPI_H
#define NITRO_SPI_SPI_H

#ifdef __cplusplus
extern "C"
{
#endif

#include <nitro/hw/io_reg.h>
#include <nitro/misc.h>

// --------------------
// ENUMS
// --------------------

typedef enum
{
    SPI_BAUDRATE_4MHZ   = 0,
    SPI_BAUDRATE_2MHZ   = 1,
    SPI_BAUDRATE_1MHZ   = 2,
    SPI_BAUDRATE_512KHZ = 3
} SPIBaudRate;

typedef enum
{
    SPI_TRANSMODE_1BYTE      = 0,
    SPI_TRANSMODE_CONTINUOUS = 1
} SPITransMode;

typedef enum
{
    SPI_COMMPARTNER_PMIC   = 0,
    SPI_COMMPARTNER_EEPROM = 1
} SPICommPartner;

#define SPI_COMMPARTNER_TP (SPI_COMMPARTNER_PMIC)

// --------------------
// INLINE 
// --------------------

static inline BOOL SPI_Enable(void)
{
    BOOL pre       = (reg_SPI_SPICNT & ~REG_SPI_SPICNT_E_MASK) >> REG_SPI_SPICNT_E_SHIFT;
    reg_SPI_SPICNT = (u16)((reg_SPI_SPICNT & ~REG_SPI_SPICNT_E_MASK) | (1UL << REG_SPI_SPICNT_E_SHIFT));
    return pre;
}

static inline BOOL SPI_Disable(void)
{
    BOOL pre       = (reg_SPI_SPICNT & ~REG_SPI_SPICNT_E_MASK) >> REG_SPI_SPICNT_E_SHIFT;
    reg_SPI_SPICNT = (u16)((reg_SPI_SPICNT & ~REG_SPI_SPICNT_E_MASK));
    return pre;
}

static inline BOOL SPI_Restore(BOOL flag)
{
    BOOL pre       = (reg_SPI_SPICNT & ~REG_SPI_SPICNT_E_MASK) >> REG_SPI_SPICNT_E_SHIFT;
    reg_SPI_SPICNT = (u16)((reg_SPI_SPICNT & ~REG_SPI_SPICNT_E_MASK) | (flag ? 1UL << REG_SPI_SPICNT_E_SHIFT : 0));
    return pre;
}

static inline void SPI_SetInterrupt(BOOL e)
{
    reg_SPI_SPICNT = (u16)((reg_SPI_SPICNT & REG_SPI_SPICNT_I_MASK) | (e ? 1UL << REG_SPI_SPICNT_I_SHIFT : 0));
}

static inline BOOL SPI_GetInterrupt(void)
{
    return (BOOL)((reg_SPI_SPICNT & REG_SPI_SPICNT_I_MASK) >> REG_SPI_SPICNT_I_SHIFT);
}

static inline void SPI_SetCommPartner(SPICommPartner p)
{
    reg_SPI_SPICNT = (u16)((reg_SPI_SPICNT & REG_SPI_SPICNT_SEL_MASK) | (p << REG_SPI_SPICNT_SEL_SHIFT));
}

static inline SPICommPartner SPI_GetCommPartner(void)
{
    return (SPICommPartner)((reg_SPI_SPICNT & REG_SPI_SPICNT_SEL_MASK) >> REG_SPI_SPICNT_SEL_SHIFT);
}

static inline void SPI_SetTransMode(SPITransMode mode)
{
    reg_SPI_SPICNT = (u16)((reg_SPI_SPICNT & REG_SPI_SPICNT_MODE_MASK) | (mode << REG_SPI_SPICNT_MODE_SHIFT));
}

static inline SPITransMode SPI_GetTransMode(void)
{
    return (SPITransMode)((reg_SPI_SPICNT & REG_SPI_SPICNT_MODE_MASK) >> REG_SPI_SPICNT_MODE_SHIFT);
}

static inline BOOL SPI_IsBusy(void)
{
    return (BOOL)((reg_SPI_SPICNT & REG_SPI_SPICNT_BUSY_MASK) >> REG_SPI_SPICNT_BUSY_SHIFT);
}

static inline void SPI_SetBaudRate(SPIBaudRate baud)
{
    reg_SPI_SPICNT = (u16)((reg_SPI_SPICNT & REG_SPI_SPICNT_BAUDRATE_MASK) | (baud << REG_SPI_SPICNT_BAUDRATE_SHIFT));
}

static inline SPIBaudRate SPI_GetBaudRate(void)
{
    return (SPIBaudRate)((reg_SPI_SPICNT & REG_SPI_SPICNT_BAUDRATE_MASK) >> REG_SPI_SPICNT_BAUDRATE_SHIFT);
}

static inline void SPI_SendData(u8 data)
{
    reg_SPI_SPID = (u16)data;
}

static inline u8 SPI_GetData(void)
{
    return (u8)(reg_SPI_SPICNT & 0xff);
}

// --------------------
// FUNCTIONS
// --------------------

void SPI_Init(u32 prio);

#ifdef __cplusplus
}
#endif

#endif // NITRO_SPI_SPI_H