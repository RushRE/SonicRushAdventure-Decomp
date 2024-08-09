#include <nitro.h>

// --------------------
// FUNCTIONS
// --------------------

void MIi_CardDmaCopy32(u32 dmaNo, const void *src, void *dest, u32 size)
{
    vu32 *dmaCntp;

    UNUSED(size);

#ifdef SDK_ARM9
    MIi_CheckAnotherAutoDMA(dmaNo, MIi_DMA_TIMING_ANY);
#endif

    // check DMA0 source address
    MIi_CheckDma0SourceAddress(dmaNo, (u32)src, size, MI_DMA_SRC_FIX);

    if (size == 0)
        return;

    MIi_Wait_BeforeDMA(dmaCntp, dmaNo);
    MIi_DmaSetParams(dmaNo, (u32)src, (u32)dest, (u32)(MI_CNT_CARDRECV32(4) | MI_DMA_CONTINUOUS_ON));
}