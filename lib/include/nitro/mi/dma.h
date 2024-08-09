#ifndef NITRO_MI_DMA_H
#define NITRO_MI_DMA_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// TYPES
// --------------------

typedef void (*MIDmaCallback)(void *);

#ifdef __cplusplus
}
#endif

// --------------------
// INCLUDES
// --------------------

#include <nitro/mi/dma_shared.h>
#include <nitro/hw/io_reg.h>
#include <nitro/hw/mmap.h>
#include <nitro/os/system.h>
#include <nitro/mi/dma_hblank.h>
#include <nitro/mi/dma_gxcommand.h>
#include <nitro/mi/dma_card.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// MACROS
// --------------------

#define MI_DMA_MAX_NUM 3

#define MI_DMA_ENABLE    (1UL << REG_MI_DMA0CNT_E_SHIFT)
#define MI_DMA_IF_ENABLE (1UL << REG_MI_DMA0CNT_I_SHIFT)

#ifdef SDK_ARM9

#define MI_DMA_TIMING_MASK      (REG_MI_DMA0CNT_MODE_MASK)
#define MI_DMA_TIMING_SHIFT     (REG_MI_DMA0CNT_MODE_SHIFT)
#define MI_DMA_TIMING_IMM       (0UL << REG_MI_DMA0CNT_MODE_SHIFT)
#define MI_DMA_TIMING_V_BLANK   (1UL << REG_MI_DMA0CNT_MODE_SHIFT)
#define MI_DMA_TIMING_H_BLANK   (2UL << REG_MI_DMA0CNT_MODE_SHIFT)
#define MI_DMA_TIMING_DISP      (3UL << REG_MI_DMA0CNT_MODE_SHIFT)
#define MI_DMA_TIMING_DISP_MMEM (4UL << REG_MI_DMA0CNT_MODE_SHIFT)
#define MI_DMA_TIMING_CARD      (5UL << REG_MI_DMA0CNT_MODE_SHIFT)
#define MI_DMA_TIMING_CARTRIDGE (6UL << REG_MI_DMA0CNT_MODE_SHIFT)
#define MI_DMA_TIMING_GXFIFO    (7UL << REG_MI_DMA0CNT_MODE_SHIFT)
#define MIi_DMA_TIMING_ANY      (u32)(~0)

#else

#define MI_DMA_TIMING_MASK      (REG_MI_DMA0CNT_TIMING_MASK)
#define MI_DMA_TIMING_SHIFT     (REG_MI_DMA0CNT_TIMING_SHIFT)
#define MI_DMA_TIMING_IMM       (0UL << REG_MI_DMA0CNT_TIMING_SHIFT)
#define MI_DMA_TIMING_V_BLANK   (1UL << REG_MI_DMA0CNT_TIMING_SHIFT)
#define MI_DMA_TIMING_CARD      (2UL << REG_MI_DMA0CNT_TIMING_SHIFT)
#define MI_DMA_TIMING_WIRELESS  (3UL << REG_MI_DMA0CNT_TIMING_SHIFT)
#define MI_DMA_TIMING_CARTRIDGE MI_DMA_TIMING_WIRELESS

#endif // SDK_ARM9

#define MI_DMA_16BIT_BUS (0UL << REG_MI_DMA0CNT_SB_SHIFT)
#define MI_DMA_32BIT_BUS (1UL << REG_MI_DMA0CNT_SB_SHIFT)

#define MI_DMA_CONTINUOUS_OFF (0UL << REG_MI_DMA0CNT_CM_SHIFT)
#define MI_DMA_CONTINUOUS_ON  (1UL << REG_MI_DMA0CNT_CM_SHIFT)

#define MI_DMA_SRC_INC     (0UL << REG_MI_DMA0CNT_SAR_SHIFT)
#define MI_DMA_SRC_DEC     (1UL << REG_MI_DMA0CNT_SAR_SHIFT)
#define MI_DMA_SRC_FIX     (2UL << REG_MI_DMA0CNT_SAR_SHIFT)
#define MI_DMA_DEST_INC    (0UL << REG_MI_DMA0CNT_DAR_SHIFT)
#define MI_DMA_DEST_DEC    (1UL << REG_MI_DMA0CNT_DAR_SHIFT)
#define MI_DMA_DEST_FIX    (2UL << REG_MI_DMA0CNT_DAR_SHIFT)
#define MI_DMA_DEST_RELOAD (3UL << REG_MI_DMA0CNT_DAR_SHIFT)

#define MI_DMA_COUNT_MASK  (REG_MI_DMA0CNT_WORDCNT_MASK)
#define MI_DMA_COUNT_SHIFT (REG_MI_DMA0CNT_WORDCNT_SHIFT)

#define MI_DMA_SINC_DINC_16 (MI_DMA_SRC_INC | MI_DMA_DEST_INC | MI_DMA_16BIT_BUS)
#define MI_DMA_SFIX_DINC_16 (MI_DMA_SRC_FIX | MI_DMA_DEST_INC | MI_DMA_16BIT_BUS)
#define MI_DMA_SINC_DFIX_16 (MI_DMA_SRC_INC | MI_DMA_DEST_FIX | MI_DMA_16BIT_BUS)
#define MI_DMA_SFIX_DFIX_16 (MI_DMA_SRC_FIX | MI_DMA_DEST_FIX | MI_DMA_16BIT_BUS)
#define MI_DMA_SINC_DINC_32 (MI_DMA_SRC_INC | MI_DMA_DEST_INC | MI_DMA_32BIT_BUS)
#define MI_DMA_SFIX_DINC_32 (MI_DMA_SRC_FIX | MI_DMA_DEST_INC | MI_DMA_32BIT_BUS)
#define MI_DMA_SINC_DFIX_32 (MI_DMA_SRC_INC | MI_DMA_DEST_FIX | MI_DMA_32BIT_BUS)
#define MI_DMA_SFIX_DFIX_32 (MI_DMA_SRC_FIX | MI_DMA_DEST_FIX | MI_DMA_32BIT_BUS)

#define MI_DMA_IMM16ENABLE (MI_DMA_ENABLE | MI_DMA_TIMING_IMM | MI_DMA_16BIT_BUS)
#define MI_DMA_IMM32ENABLE (MI_DMA_ENABLE | MI_DMA_TIMING_IMM | MI_DMA_32BIT_BUS)

#define MI_CNT_CLEAR16(size)    (MI_DMA_IMM16ENABLE | MI_DMA_SRC_FIX | MI_DMA_DEST_INC | ((size) / 2))
#define MI_CNT_CLEAR32(size)    (MI_DMA_IMM32ENABLE | MI_DMA_SRC_FIX | MI_DMA_DEST_INC | ((size) / 4))
#define MI_CNT_CLEAR16_IF(size) (MI_CNT_CLEAR16((size)) | MI_DMA_IF_ENABLE)
#define MI_CNT_CLEAR32_IF(size) (MI_CNT_CLEAR32((size)) | MI_DMA_IF_ENABLE)

#define MI_CNT_COPY16(size)    (MI_DMA_IMM16ENABLE | MI_DMA_SRC_INC | MI_DMA_DEST_INC | ((size) / 2))
#define MI_CNT_COPY32(size)    (MI_DMA_IMM32ENABLE | MI_DMA_SRC_INC | MI_DMA_DEST_INC | ((size) / 4))
#define MI_CNT_COPY16_IF(size) (MI_CNT_COPY16((size)) | MI_DMA_IF_ENABLE)
#define MI_CNT_COPY32_IF(size) (MI_CNT_COPY32((size)) | MI_DMA_IF_ENABLE)

#define MI_CNT_SEND16(size)    (MI_DMA_IMM16ENABLE | MI_DMA_SRC_INC | MI_DMA_DEST_FIX | ((size) / 2))
#define MI_CNT_SEND32(size)    (MI_DMA_IMM32ENABLE | MI_DMA_SRC_INC | MI_DMA_DEST_FIX | ((size) / 4))
#define MI_CNT_SEND16_IF(size) (MI_CNT_SEND16((size)) | MI_DMA_IF_ENABLE)
#define MI_CNT_SEND32_IF(size) (MI_CNT_SEND32((size)) | MI_DMA_IF_ENABLE)

#ifdef SDK_ARM9
#define MI_CNT_HBCOPY16(size)    (MI_DMA_ENABLE | MI_DMA_TIMING_H_BLANK | MI_DMA_SRC_INC | MI_DMA_DEST_RELOAD | MI_DMA_CONTINUOUS_ON | MI_DMA_16BIT_BUS | ((size) / 2))
#define MI_CNT_HBCOPY32(size)    (MI_DMA_ENABLE | MI_DMA_TIMING_H_BLANK | MI_DMA_SRC_INC | MI_DMA_DEST_RELOAD | MI_DMA_CONTINUOUS_ON | MI_DMA_32BIT_BUS | ((size) / 4))
#define MI_CNT_HBCOPY16_IF(size) (MI_CNT_HBCOPY16((size)) | MI_DMA_IF_ENABLE)
#define MI_CNT_HBCOPY32_IF(size) (MI_CNT_HBCOPY32((size)) | MI_DMA_IF_ENABLE)
#endif // SDK_ARM9

#define MI_CNT_VBCOPY16(size)    (MI_DMA_ENABLE | MI_DMA_TIMING_V_BLANK | MI_DMA_SRC_INC | MI_DMA_DEST_INC | MI_DMA_16BIT_BUS | ((size) / 2))
#define MI_CNT_VBCOPY32(size)    (MI_DMA_ENABLE | MI_DMA_TIMING_V_BLANK | MI_DMA_SRC_INC | MI_DMA_DEST_INC | MI_DMA_32BIT_BUS | ((size) / 4))
#define MI_CNT_VBCOPY16_IF(size) (MI_CNT_VBCOPY16((size)) | MI_DMA_IF_ENABLE)
#define MI_CNT_VBCOPY32_IF(size) (MI_CNT_VBCOPY32((size)) | MI_DMA_IF_ENABLE)

#define MI_CNT_CARDRECV32(size) (MI_DMA_ENABLE | MI_DMA_TIMING_CARD | MI_DMA_SRC_FIX | MI_DMA_DEST_INC | MI_DMA_32BIT_BUS | ((size) / 4))

#ifdef SDK_ARM9
#define MI_CNT_MMCOPY(size) (MI_DMA_ENABLE | MI_DMA_TIMING_DISP_MMEM | MI_DMA_SRC_INC | MI_DMA_DEST_FIX | MI_DMA_CONTINUOUS_ON | MI_DMA_32BIT_BUS | (4))
#endif // SDK_ARM9

#ifdef SDK_ARM9
#define MI_CNT_GXCOPY(size)    (MI_DMA_ENABLE | MI_DMA_TIMING_GXFIFO | MI_DMA_SRC_INC | MI_DMA_DEST_FIX | MI_DMA_32BIT_BUS | ((size) / 4))
#define MI_CNT_GXCOPY_IF(size) (MI_CNT_GXCOPY(size) | MI_DMA_IF_ENABLE)
#endif // SDK_ARM9

#define MIi_DUMMY_DMA_NO 0
#define MIi_DUMMY_SRC    0
#define MIi_DUMMY_DEST   0
#define MIi_DUMMY_CNT    (MI_DMA_ENABLE | MI_DMA_SRC_FIX | MI_DMA_DEST_FIX | MI_DMA_16BIT_BUS | 1)

#ifdef SDK_ARM9
#define MIi_DMA_CLEAR_DATA_BUF REG_DMA0_CLR_DATA_ADDR
#else
#define MIi_DMA_CLEAR_DATA_BUF HW_PRV_WRAM_DMA_CLEAR_DATA_BUF
#endif

// --------------------
// STRUCTS
// --------------------

typedef union
{
    u32 b32;
    u16 b16;
} MIiDmaClearSrc;

// --------------------
// FUNCTIONS
// --------------------

void MI_DmaFill32(u32 dmaNo, void *dest, u32 data, u32 size);
void MI_DmaCopy32(u32 dmaNo, const void *src, void *dest, u32 size);
void MI_DmaCopy16(u32 dmaNo, const void *src, void *dest, u32 size);
void MI_DmaFill32Async(u32 dmaNo, void *dest, u32 data, u32 size, MIDmaCallback callback, void *arg);
void MI_DmaCopy32Async(u32 dmaNo, const void *src, void *dest, u32 size, MIDmaCallback callback, void *arg);
void MI_WaitDma(u32 dmaNo);
void MI_StopDma(u32 dmaNo);
void MIi_CheckAnotherAutoDMA(u32 dmaNo, u32 dmaType);
void MIi_CheckDma0SourceAddress(u32 dmaNo, u32 src, u32 size, u32 dir);

// --------------------
// FUNCTIONS (ITCM)
// --------------------

#ifdef SDK_ARM9

void MIi_DmaSetParams(u32 dmaNo, u32 src, u32 dest, u32 ctrl);
void MIi_DmaSetParams_wait(u32 dmaNo, u32 src, u32 dest, u32 ctrl);
void MIi_DmaSetParams_noInt(u32 dmaNo, u32 src, u32 dest, u32 ctrl);
void MIi_DmaSetParams_wait_noInt(u32 dmaNo, u32 src, u32 dest, u32 ctrl);

#else
static inline void MIi_DmaSetParams(u32 dmaNo, u32 src, u32 dest, u32 ctrl)
{
    OSIntrMode enabled = OS_DisableInterrupts();

    vu32 *p  = (vu32 *)((u32)REG_DMA0SAD_ADDR + dmaNo * 12);
    *p       = (vu32)src;
    *(p + 1) = (vu32)dest;
    *(p + 2) = (vu32)ctrl;

    (IGNORE_RETURN) OS_RestoreInterrupts(enabled);
}

static inline void MIi_DmaSetParams_wait(u32 dmaNo, u32 src, u32 dest, u32 ctrl)
{
    OSIntrMode enabled = OS_DisableInterrupts();

    vu32 *p  = (vu32 *)((u32)REG_DMA0SAD_ADDR + dmaNo * 12);
    *p       = (vu32)src;
    *(p + 1) = (vu32)dest;
    *(p + 2) = (vu32)ctrl;

    // ARM7 has to wait 2 cycles (load is 3 cycle)
    {
        u32 dummy = reg_MI_DMA0SAD;
    }

    (IGNORE_RETURN) OS_RestoreInterrupts(enabled);
}

static inline void MIi_DmaSetParams_noInt(u32 dmaNo, u32 src, u32 dest, u32 ctrl)
{
    vu32 *p  = (vu32 *)((u32)REG_DMA0SAD_ADDR + dmaNo * 12);
    *p       = (vu32)src;
    *(p + 1) = (vu32)dest;
    *(p + 2) = (vu32)ctrl;
}

static inline void MIi_DmaSetParams_wait_noInt(u32 dmaNo, u32 src, u32 dest, u32 ctrl)
{
    vu32 *p  = (vu32 *)((u32)REG_DMA0SAD_ADDR + dmaNo * 12);
    *p       = (vu32)src;
    *(p + 1) = (vu32)dest;
    *(p + 2) = (vu32)ctrl;

    // ARM7 has to wait 2 cycles (load is 3 cycle)
    {
        u32 dummy = reg_MI_DMA0SAD;
    }
}
#endif

// --------------------
// FUNCTIONS (INLINE)
// --------------------

static inline void MIi_DmaSetParams_wait_src32(u32 dmaNo, u32 data, u32 dest, u32 ctrl)
{
    OSIntrMode lastIntrMode = OS_DisableInterrupts();

    MIiDmaClearSrc *scrp = (MIiDmaClearSrc *)((u32)MIi_DMA_CLEAR_DATA_BUF + dmaNo * 4);
    scrp->b32            = data;
    MIi_DmaSetParams_wait_noInt(dmaNo, (u32)scrp, dest, ctrl);

    (IGNORE_RETURN) OS_RestoreInterrupts(lastIntrMode);
}

static inline void MIi_DmaSetParams_src32(u32 dmaNo, u32 data, u32 dest, u32 ctrl)
{
    OSIntrMode lastIntrMode = OS_DisableInterrupts();

    MIiDmaClearSrc *srcp = (MIiDmaClearSrc *)((u32)MIi_DMA_CLEAR_DATA_BUF + dmaNo * 4);
    srcp->b32            = data;
    MIi_DmaSetParams_noInt(dmaNo, (u32)srcp, dest, ctrl);

    (IGNORE_RETURN) OS_RestoreInterrupts(lastIntrMode);
}

static inline void MIi_CallCallback(MIDmaCallback callback, void *arg)
{
    if (callback)
        callback(arg);
}

// --------------------
// FUNCTIONS (MACROS)
// --------------------

#define MIi_Wait_BeforeDMA(dmaCntp, dmaNo)                                                                                                                                                             \
    do                                                                                                                                                                                                 \
    {                                                                                                                                                                                                  \
        dmaCntp = &((vu32 *)REG_DMA0SAD_ADDR)[dmaNo * 3 + 2];                                                                                                                                          \
        while (*dmaCntp & REG_MI_DMA0CNT_E_MASK)                                                                                                                                                       \
        {                                                                                                                                                                                              \
        }                                                                                                                                                                                              \
    } while (0)

#define MIi_Wait_AfterDMA(dmaCntp)                                                                                                                                                                     \
    do                                                                                                                                                                                                 \
    {                                                                                                                                                                                                  \
        while (*dmaCntp & REG_MI_DMA0CNT_E_MASK)                                                                                                                                                       \
        {                                                                                                                                                                                              \
        }                                                                                                                                                                                              \
    } while (0)

#ifdef __cplusplus
}
#endif

#endif // NITRO_MI_DMA_H
