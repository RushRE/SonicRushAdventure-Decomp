#include <nnsys/g3d/gecom.h>

// --------------------
// VARIABLES
// --------------------

static volatile int NNS_G3dFlagGXDmaAsync = 0;

static NNSG3dGeBuffer *NNS_G3dGeBuffer = NULL;

#ifdef NNS_G3D_USE_FASTGXDMA
static BOOL NNS_G3dFlagUseFastDma = TRUE;
#else
static BOOL NNS_G3dFlagUseFastDma = FALSE;
#endif

// --------------------
// FUNCTIONS
// --------------------

BOOL NNS_G3dGeIsSendDLBusy(void)
{
    return NNS_G3dFlagGXDmaAsync;
}

BOOL NNS_G3dGeIsBufferExist(void)
{
    return (NNS_G3dGeBuffer != NULL);
}

void NNS_G3dGeSetBuffer(NNSG3dGeBuffer *p)
{
    if (NNS_G3dGeBuffer == NULL)
    {
        p->idx          = 0;
        NNS_G3dGeBuffer = p;
    }
}

NNSG3dGeBuffer *NNS_G3dGeReleaseBuffer(void)
{
    NNSG3dGeBuffer *p;

    NNS_G3dGeFlushBuffer();

    p               = NNS_G3dGeBuffer;
    NNS_G3dGeBuffer = NULL;

    return p;
}

static NNS_G3D_INLINE void sendNB(const void *src, void *dst, u32 szByte)
{
    MI_CpuSend32(src, dst, szByte);
}

void NNS_G3dGeFlushBuffer(void)
{
    if (NNS_G3dFlagGXDmaAsync)
    {
        NNS_G3dGeWaitSendDL();
    }

    if (NNS_G3dGeBuffer && NNS_G3dGeBuffer->idx > 0)
    {
        sendNB(&NNS_G3dGeBuffer->data[0], (void *)&reg_G3X_GXFIFO, NNS_G3dGeBuffer->idx << 2);
        NNS_G3dGeBuffer->idx = 0;
    }
}

void NNS_G3dGeWaitSendDL(void)
{
    while (NNS_G3dFlagGXDmaAsync)
        ;
}

BOOL NNS_G3dGeIsImmOK(void)
{
    return (NNS_G3dGeBuffer == NULL || NNS_G3dGeBuffer->idx == 0) && !NNS_G3dGeIsSendDLBusy();
}

BOOL NNS_G3dGeIsBufferOK(u32 numWord)
{
    return (NNS_G3dGeBuffer != NULL) && (NNS_G3dGeBuffer->idx + numWord <= NNS_G3D_SIZE_COMBUFFER);
}

static void simpleUnlock_(void *arg)
{
    *((volatile int *)arg) = 0;
}

void NNS_G3dGeUseFastDma(BOOL cond)
{
    NNS_G3dFlagUseFastDma = (cond);
}

void NNS_G3dGeSendDL(const void *src, u32 szByte)
{
    if (szByte < 256 || GXi_DmaId == GX_DMA_NOT_USE)
    {
        NNS_G3dGeBufferOP_N(*(const u32 *)src, (const u32 *)src + 1, (szByte >> 2) - 1);
    }
    else
    {
        NNS_G3dGeFlushBuffer();
        NNS_G3dFlagGXDmaAsync = 1;

        if (NNS_G3dFlagUseFastDma)
        {
            MI_SendGXCommandAsyncFast(GXi_DmaId, src, szByte, &simpleUnlock_, (void *)&NNS_G3dFlagGXDmaAsync);
        }
        else
        {
            MI_SendGXCommandAsync(GXi_DmaId, src, szByte, &simpleUnlock_, (void *)&NNS_G3dFlagGXDmaAsync);
        }
    }
}

void NNS_G3dGeBufferOP_N(u32 op, const u32 *args, u32 num)
{
    if (NNS_G3dGeBuffer)
    {
        if (NNS_G3dFlagGXDmaAsync)
        {
            if (NNS_G3dGeBuffer->idx + 1 + num <= NNS_G3D_SIZE_COMBUFFER)
            {
                NNS_G3dGeBuffer->data[NNS_G3dGeBuffer->idx++] = op;
                if (num > 0)
                {
                    MI_CpuCopyFast(args, &NNS_G3dGeBuffer->data[NNS_G3dGeBuffer->idx], num << 2);
                    NNS_G3dGeBuffer->idx += num;
                }

                return;
            }
        }

        if (NNS_G3dGeBuffer->idx != 0)
        {
            NNS_G3dGeFlushBuffer();
        }
        else
        {
            if (NNS_G3dFlagGXDmaAsync)
            {
                NNS_G3dGeWaitSendDL();
            }
        }
    }
    else
    {
        if (NNS_G3dFlagGXDmaAsync)
        {
            NNS_G3dGeWaitSendDL();
        }
    }

    reg_G3X_GXFIFO = op;
    sendNB(args, (void *)&reg_G3X_GXFIFO, num << 2);
}
