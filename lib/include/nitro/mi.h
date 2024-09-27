#ifndef NITRO_MI_H
#define NITRO_MI_H

#include <nitro/mi/wram.h>
#include <nitro/mi/memory.h>
#include <nitro/mi/exMemory.h>
#include <nitro/mi/swap.h>
#include <nitro/mi/dma.h>
#include <nitro/mi/uncompress.h>
#include <nitro/mi/byteAccess.h>
#include <nitro/mi/endian.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

void MI_Init(void);

#ifdef __cplusplus
}
#endif

#endif // NITRO_MI_H
