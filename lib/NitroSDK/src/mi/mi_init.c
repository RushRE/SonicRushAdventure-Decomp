#include <nitro.h>

// --------------------
// FUNCTIONS
// --------------------

void MI_Init(void)
{
#ifdef SDK_ARM9
    // Init Work RAM
    MI_SetWramBank(MI_WRAM_ARM7_ALL);
#endif

    // dummy DMA
    MI_StopDma(0);
}
