#ifndef NITRO_MI_MEMORY_H
#define NITRO_MI_MEMORY_H

#include <nitro/types.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

void MIi_CpuClear16(u16 data, void *destp, u32 size);
void MIi_CpuCopy16(const void *srcp, void *destp, u32 size);

void MIi_CpuClear32(u32 data, void *destp, u32 size);
void MIi_CpuCopy32(const void *srcp, void *destp, u32 size);

void MIi_CpuSend32(const void *srcp, volatile void *destp, u32 size);

void MIi_CpuClearFast(u32 data, void *destp, u32 size);
void MIi_CpuCopyFast(const void *srcp, void *destp, u32 size);

void MI_Copy32B(const void *pSrc, void *pDest);
void MI_Copy36B(const void *pSrc, void *pDest);
void MI_Copy48B(const void *pSrc, void *pDest);
void MI_Copy64B(const void *pSrc, void *pDest);

void MI_CpuFill8(void *dstp, u8 data, u32 size);
void MI_CpuCopy8(const void *srcp, void *dstp, u32 size);

void MI_Zero36B(void *pDest);

// --------------------
// INLINE FUNCTIONS
// --------------------

SDK_INLINE void MI_CpuCopy16(const void *src, void *dest, u32 size)
{
    MIi_CpuCopy16(src, dest, size);
}

SDK_INLINE void MI_CpuFill16(void *dest, u16 data, u32 size)
{
    MIi_CpuClear16(data, dest, size);
}

SDK_INLINE void MI_CpuClear16(void *dest, u32 size)
{
    MI_CpuFill16(dest, 0, size);
}

SDK_INLINE void MI_CpuCopy32(const void *src, void *dest, u32 size)
{
    MIi_CpuCopy32(src, dest, size);
}

SDK_INLINE void MI_CpuFill32(void *dest, u32 data, u32 size)
{
    MIi_CpuClear32(data, dest, size);
}

SDK_INLINE void MI_CpuClear32(void *dest, u32 size)
{
    MI_CpuFill32(dest, 0, size);
}

SDK_INLINE void MI_CpuCopyFast(const void *src, void *dest, u32 size)
{
    MIi_CpuCopyFast(src, dest, size);
}

SDK_INLINE void MI_CpuFillFast(void *dest, u32 data, u32 size)
{
    MIi_CpuClearFast(data, dest, size);
}

SDK_INLINE void MI_CpuClearFast(void *dest, u32 size)
{
    MI_CpuFillFast(dest, 0, size);
}

SDK_INLINE void MI_CpuClear8(void *dest, u32 size)
{
    MI_CpuFill8(dest, 0, size);
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_MI_MEMORY_H
