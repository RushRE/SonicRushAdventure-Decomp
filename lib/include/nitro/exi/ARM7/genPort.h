#ifndef NITRO_EXI_GENPORT_H
#define NITRO_EXI_GENPORT_H

#include <nitro/hw/ARM7/io_reg.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// ENUMS
// --------------------

typedef enum
{
    EXI_GPIOIF_SERIAL = 0x0000,
    EXI_GPIOIF_UNDEF  = REG_EXI_RCNT0_L_RE0_MASK,
    EXI_GPIOIF_GPIO   = REG_EXI_RCNT0_L_RE1_MASK,
    EXI_GPIOIF_JOY    = REG_EXI_RCNT0_L_RE1_MASK | REG_EXI_RCNT0_L_RE0_MASK
} EXIGpioIF;

// --------------------
// FUNCTIONS
// --------------------

// void EXIi_SetBitRcnt0L(u16 mask, u16 data);
// void EXIi_SelectRcnt(EXIGpioIF type);

#ifdef __cplusplus
}
#endif

#endif // NITRO_EXI_GENPORT_H
