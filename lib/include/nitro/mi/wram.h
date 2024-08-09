#ifndef NITRO_MI_WRAM_H
#define NITRO_MI_WRAM_H

#include <nitro/hw/io_reg.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// ENUMS
// --------------------

#ifdef SDK_ARM9
typedef enum
{
    MI_WRAM_ARM9_ALL = 0 << REG_GX_VRAMCNT_WRAM_BANK_SHIFT,
    MI_WRAM_1616_1   = 1 << REG_GX_VRAMCNT_WRAM_BANK_SHIFT,
    MI_WRAM_1616_2   = 2 << REG_GX_VRAMCNT_WRAM_BANK_SHIFT,
    MI_WRAM_ARM7_ALL = 3 << REG_GX_VRAMCNT_WRAM_BANK_SHIFT
} MIWram;
#else // SDK_ARM9
typedef enum
{
    MI_WRAM_ARM9_ALL = (REG_MI_WVRAMSTAT_WRAM_1_MASK | REG_MI_WVRAMSTAT_WRAM_0_MASK),
    MI_WRAM_1616_1   = (REG_MI_WVRAMSTAT_WRAM_0_MASK),
    MI_WRAM_1616_2   = (REG_MI_WVRAMSTAT_WRAM_1_MASK),
    MI_WRAM_ARM7_ALL = 0
} MIWram;
#endif // SDK_ARM9

// --------------------
// FUNCTIONS
// --------------------

void MI_SetWramBank(MIWram cnt);

#ifdef __cplusplus
}
#endif

#endif // NITRO_MI_UNCOMPRESS_H
