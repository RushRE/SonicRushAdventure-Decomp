#include <nitro.h>

#ifdef SDK_ARM9

void MI_HBlankDmaCopy32(u32 dmaNo, const void *src, void *dest, u32 size)
{
    MIi_CheckAnotherAutoDMA(dmaNo, MI_DMA_TIMING_H_BLANK);
    MIi_CheckDma0SourceAddress(dmaNo, (u32)src, size, MI_DMA_SRC_INC);

    if (size == 0)
        return;

    MI_WaitDma(dmaNo);
    MIi_DmaSetParams(dmaNo, (u32)src, (u32)dest, MI_CNT_HBCOPY32(size));
}

void MI_HBlankDmaCopy16(u32 dmaNo, const void *src, void *dest, u32 size)
{
    MIi_CheckAnotherAutoDMA(dmaNo, MI_DMA_TIMING_H_BLANK);
    MIi_CheckDma0SourceAddress(dmaNo, (u32)src, size, MI_DMA_SRC_INC);

    if (size == 0)
        return;

    MI_WaitDma(dmaNo);
    MIi_DmaSetParams(dmaNo, (u32)src, (u32)dest, MI_CNT_HBCOPY16(size));
}

#endif