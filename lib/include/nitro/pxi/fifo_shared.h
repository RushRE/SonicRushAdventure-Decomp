/*
 * NOTE:
 * This file is shared between ARM9 and ARM7
 * DO NOT PUT PROC SPECIFIC CODE IN HERE
 * Thank You!
 */

/*
 * DO NOT INCLUDE THIS FILE DIRECTLY
 * Include PXI_fifo.h from the specific proc's lib
 */

#ifndef NITRO_PXI_FIFO_SHARED_H
#define NITRO_PXI_FIFO_SHARED_H

#include <nitro/pxi/regname.h>

// --------------------
// ENUMS
// --------------------

typedef enum
{
    PXI_FIFO_TAG_EX = 0,
    PXI_FIFO_TAG_USER_0,
    PXI_FIFO_TAG_USER_1,
    PXI_FIFO_TAG_SYSTEM,
    PXI_FIFO_TAG_NVRAM,
    PXI_FIFO_TAG_RTC,
    PXI_FIFO_TAG_TOUCHPANEL,
    PXI_FIFO_TAG_SOUND,
    PXI_FIFO_TAG_PM,
    PXI_FIFO_TAG_MIC,
    PXI_FIFO_TAG_WM,
    PXI_FIFO_TAG_FS,
    PXI_FIFO_TAG_OS,
    PXI_FIFO_TAG_CTRDG,
    PXI_FIFO_TAG_CARD,
    PXI_FIFO_TAG_WVR,
    PXI_FIFO_TAG_CTRDG_Ex,
    PXI_FIFO_TAG_CTRDG_PHI,

    PXI_MAX_FIFO_TAG = 32
} PXIFifoTag;

#endif // NITRO_PXI_FIFO_SHARED_H
