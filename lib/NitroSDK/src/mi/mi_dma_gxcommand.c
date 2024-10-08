#include <nitro.h>

#ifdef SDK_ARM9

// --------------------
// CONSTANTS
// --------------------

#define MIi_GX_LENGTH_ONCE (118 * sizeof(u32))

// --------------------
// STRUCTS
// --------------------

typedef struct
{
    volatile BOOL isBusy;

    u32 dmaNo;
    u32 src;
    u32 length;
    MIDmaCallback callback;
    void *arg;

    GXFifoIntrCond fifoCond;
    void (*fifoFunc)(void);
} MIiGXDmaParams;

// --------------------
// VARIABLES
// --------------------

static MIiGXDmaParams MIi_GXDmaParams = {};

// --------------------
// FUNCTION DECLS
// --------------------

static void MIi_FIFOCallback(void);
static void MIi_DMACallback(void *);
static void MIi_DMAFastCallback(void *);

// --------------------
// FUNCTIONS
// --------------------

void MI_SendGXCommandAsync(u32 dmaNo, const void *src, u32 commandLength, MIDmaCallback callback, void *arg)
{
    if (commandLength == 0)
    {
        MIi_CallCallback(callback, arg);
        return;
    }

    // make sure the dma isn't busy
    while (MIi_GXDmaParams.isBusy)
    {
    }

    while (!(G3X_GetCommandFifoStatus() & GX_FIFOSTAT_UNDERHALF))
    {
    }

    // configure params
    MIi_GXDmaParams.isBusy   = TRUE;
    MIi_GXDmaParams.dmaNo    = dmaNo;
    MIi_GXDmaParams.src      = (u32)src;
    MIi_GXDmaParams.length   = commandLength;
    MIi_GXDmaParams.callback = callback;
    MIi_GXDmaParams.arg      = arg;

    MIi_CheckDma0SourceAddress(dmaNo, (u32)src, commandLength, MI_DMA_SRC_INC);

    MI_WaitDma(dmaNo);
    {
        OSIntrMode enabled = OS_DisableInterrupts();

        MIi_GXDmaParams.fifoCond = (GXFifoIntrCond)((reg_G3X_GXSTAT & REG_G3X_GXSTAT_FI_MASK) >> REG_G3X_GXSTAT_FI_SHIFT);
        MIi_GXDmaParams.fifoFunc = OS_GetIrqFunction(OS_IE_GXFIFO);

        G3X_SetFifoIntrCond(GX_FIFOINTR_COND_UNDERHALF);
        OS_SetIrqFunction(OS_IE_GXFIFO, MIi_FIFOCallback);
        (void) OS_EnableIrqMask(OS_IE_GXFIFO);

        MIi_FIFOCallback();

        (void) OS_RestoreInterrupts(enabled);
    }
}

static void MIi_FIFOCallback(void)
{
    u32 length;
    u32 src;

    if (MIi_GXDmaParams.length == 0)
        return;

    length = (MIi_GXDmaParams.length >= MIi_GX_LENGTH_ONCE) ? MIi_GX_LENGTH_ONCE : MIi_GXDmaParams.length;
    src    = MIi_GXDmaParams.src;

    MIi_GXDmaParams.length -= length;
    MIi_GXDmaParams.src += length;

    if (MIi_GXDmaParams.length == 0)
    {
        OSi_EnterDmaCallback(MIi_GXDmaParams.dmaNo, MIi_DMACallback, NULL);
        MIi_DmaSetParams(MIi_GXDmaParams.dmaNo, src, (u32)REG_GXFIFO_ADDR, MI_CNT_SEND32_IF(length));
        (void) OS_ResetRequestIrqMask(OS_IE_GXFIFO);
    }
    else
    {
        MIi_DmaSetParams(MIi_GXDmaParams.dmaNo, src, (u32)REG_GXFIFO_ADDR, MI_CNT_SEND32(length));
        (void) OS_ResetRequestIrqMask(OS_IE_GXFIFO);
    }
}

static void MIi_DMACallback(void *)
{
    (void) OS_DisableIrqMask(OS_IE_GXFIFO);

    G3X_SetFifoIntrCond(MIi_GXDmaParams.fifoCond);
    OS_SetIrqFunction(OS_IE_GXFIFO, MIi_GXDmaParams.fifoFunc);

    MIi_GXDmaParams.isBusy = FALSE;

    MIi_CallCallback(MIi_GXDmaParams.callback, MIi_GXDmaParams.arg);
}

void MI_SendGXCommandAsyncFast(u32 dmaNo, const void *src, u32 commandLength, MIDmaCallback callback, void *arg)
{
    if (commandLength == 0)
    {
        MIi_CallCallback(callback, arg);
        return;
    }

    // make sure the dma isn't busy
    while (MIi_GXDmaParams.isBusy)
    {
    }

    // configure params
    MIi_GXDmaParams.isBusy   = TRUE;
    MIi_GXDmaParams.dmaNo    = dmaNo;
    MIi_GXDmaParams.callback = callback;
    MIi_GXDmaParams.arg      = arg;

    MIi_CheckAnotherAutoDMA(dmaNo, MI_DMA_TIMING_GXFIFO);
    MIi_CheckDma0SourceAddress(dmaNo, (u32)src, commandLength, MI_DMA_SRC_INC);

    MI_WaitDma(dmaNo);

    OSi_EnterDmaCallback(dmaNo, MIi_DMAFastCallback, NULL);
    MIi_DmaSetParams(dmaNo, (u32)src, (u32)REG_GXFIFO_ADDR, MI_CNT_GXCOPY_IF(commandLength));
}

static void MIi_DMAFastCallback(void *)
{
    MIi_GXDmaParams.isBusy = FALSE;

    MIi_CallCallback(MIi_GXDmaParams.callback, MIi_GXDmaParams.arg);
}

#endif