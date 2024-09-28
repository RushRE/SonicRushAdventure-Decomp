#ifndef NITRO_OS_CACHE_H
#define NITRO_OS_CACHE_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

void DC_InvalidateAll(void);
void DC_StoreAll(void);
void DC_FlushAll(void);
void DC_InvalidateRange(void *startAddr, u32 nBytes);
void DC_StoreRange(const void *startAddr, u32 nBytes);
void DC_FlushRange(const void *startAddr, u32 nBytes);
void DC_WaitWriteBufferEmpty(void);
void IC_InvalidateAll(void);
void IC_InvalidateRange(void *startAddr, u32 nBytes);

#ifdef __cplusplus
}
#endif

#endif // NITRO_OS_CACHE_H
