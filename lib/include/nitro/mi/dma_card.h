#ifndef NITRO_MI_DMA_CARD_H
#define NITRO_MI_DMA_CARD_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

void MIi_CardDmaCopy32(u32 dmaNo, const void *src, void *dest, u32 size);

#ifdef __cplusplus
}
#endif

#endif // NITRO_MI_DMA_CARD_H
