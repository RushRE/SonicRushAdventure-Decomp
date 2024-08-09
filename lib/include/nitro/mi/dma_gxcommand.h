#ifndef NITRO_MI_DMA_GXCOMMAND_H
#define NITRO_MI_DMA_GXCOMMAND_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

void MI_SendGXCommandAsyncFast(u32 dmaNo, const void *src, u32 commandLength, MIDmaCallback callback, void *arg);
void MI_SendGXCommandAsync(u32 dmaNo, const void *src, u32 commandLength, MIDmaCallback callback, void *arg);

#ifdef __cplusplus
}
#endif

#endif // NITRO_MI_DMA_GXCOMMAND_H