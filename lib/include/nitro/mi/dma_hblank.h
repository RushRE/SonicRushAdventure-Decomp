#ifndef NITRO_MI_DMA_HBLANK_H
#define NITRO_MI_DMA_HBLANK_H

#ifdef __cplusplus
extern "C" {
#endif

void MI_HBlankDmaCopy32(u32 dmaNo, const void *src, void *dest, u32 size);
void MI_HBlankDmaCopy16(u32 dmaNo, const void *src, void *dest, u32 size);

#ifdef __cplusplus
}
#endif

#endif // NITRO_MI_DMA_HBLANK_H
