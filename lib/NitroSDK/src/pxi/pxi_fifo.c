#include <nitro.h>

// --------------------
// VARIABLES
// --------------------

static u16 FifoCtrlInit = 0;
static PXIFifoCallback FifoRecvCallbackTable[PXI_MAX_FIFO_TAG];

// --------------------
// FUNCTION DECLS
// --------------------

static inline PXIFifoStatus PXIi_GetFromFifo(u32 *data_buf);
static inline PXIFifoStatus PXIi_SetToFifo(u32 data);

// --------------------
// FUNCTIONS
// --------------------

void PXI_InitFifo(void)
{
    int i;
    OSIntrMode enabled;
    OSSystemWork *p = OS_GetSystemWork();

    enabled = OS_DisableInterrupts();

    if (!FifoCtrlInit)
    {
        FifoCtrlInit = TRUE;

        p->pxiHandleChecker[PXI_PROC_ARM] = 0UL;

        for (i = 0; i < PXI_MAX_FIFO_TAG; i++)
        {
            FifoRecvCallbackTable[i] = NULL;
        }

        reg_PXI_FIFO_CNT = (REG_PXI_FIFO_CNT_SEND_CL_MASK | REG_PXI_FIFO_CNT_RECV_RI_MASK | REG_PXI_FIFO_CNT_E_MASK | REG_PXI_FIFO_CNT_ERR_MASK);

        (void)OS_ResetRequestIrqMask(OS_IE_FIFO_RECV);
        (void)OS_SetIrqFunction(OS_IE_FIFO_RECV, PXIi_HandlerRecvFifoNotEmpty);
        (void)OS_EnableIrqMask(OS_IE_FIFO_RECV);

#ifdef SDK_ARM7
        {
            for (i = 8; i >= 0; i--)
            {
                reg_PXI_INTF = (u16)(i << 8);
                OS_SpinWait(1000);

                if ((reg_PXI_INTF & 15) != i)
                {
                    i = 8;
                }
            }
        }
#else
        {
            int timeout;
            s32 c;

            for (i = 0;; i++)
            {
                c            = reg_PXI_INTF & 15;
                reg_PXI_INTF = (u16)(c << 8);

                if (c == 0 && i > 4)
                {
                    break;
                }

                for (timeout = 1000; (reg_PXI_INTF & 15) == c; timeout--)
                {
                    if (timeout == 0)
                    {
                        i = 0;
                        break;
                    }
                }
            }
        }
#endif
    }

    (void)OS_RestoreInterrupts(enabled);
}

void PXI_SetFifoRecvCallback(int fifotag, PXIFifoCallback callback)
{
    OSIntrMode enabled;
    OSSystemWork *p = OS_GetSystemWork();

    enabled = OS_DisableInterrupts();

    FifoRecvCallbackTable[fifotag] = callback;
    if (callback)
    {
        p->pxiHandleChecker[PXI_PROC_ARM] |= (1UL << fifotag);
    }
    else
    {
        p->pxiHandleChecker[PXI_PROC_ARM] &= ~(1UL << fifotag);
    }

    (void)OS_RestoreInterrupts(enabled);
}

BOOL PXI_IsCallbackReady(int fifotag, PXIProc proc)
{
    OSSystemWork *p = OS_GetSystemWork();

    return (p->pxiHandleChecker[proc] & (1UL << fifotag)) ? TRUE : FALSE;
}

int PXI_SendWordByFifo(int fifotag, u32 data, BOOL err)
{
    PXIFifoMessage fifomsg;

    fifomsg.e.tag  = (PXIFifoTag)fifotag;
    fifomsg.e.err  = (u32)err;
    fifomsg.e.data = data;

    return PXIi_SetToFifo(fifomsg.raw);
}

static inline PXIFifoStatus PXIi_SetToFifo(u32 data)
{
    OSIntrMode enabled;

    if (reg_PXI_FIFO_CNT & REG_PXI_FIFO_CNT_ERR_MASK)
    {
        reg_PXI_FIFO_CNT |= (REG_PXI_FIFO_CNT_E_MASK | REG_PXI_FIFO_CNT_ERR_MASK);
        return PXI_FIFO_FAIL_SEND_ERR;
    }

    enabled = OS_DisableInterrupts();
    if (reg_PXI_FIFO_CNT & REG_PXI_FIFO_CNT_SEND_FULL_MASK)
    {
        (void)OS_RestoreInterrupts(enabled);
        return PXI_FIFO_FAIL_SEND_FULL;
    }

    reg_PXI_SEND_FIFO = data;
    (void)OS_RestoreInterrupts(enabled);
    return PXI_FIFO_SUCCESS;
}

static inline PXIFifoStatus PXIi_GetFromFifo(u32 *data_buf)
{
    OSIntrMode enabled;

    if (reg_PXI_FIFO_CNT & REG_PXI_FIFO_CNT_ERR_MASK)
    {
        reg_PXI_FIFO_CNT |= (REG_PXI_FIFO_CNT_E_MASK | REG_PXI_FIFO_CNT_ERR_MASK);
        return PXI_FIFO_FAIL_RECV_ERR;
    }

    enabled = OS_DisableInterrupts();
    if (reg_PXI_FIFO_CNT & REG_PXI_FIFO_CNT_RECV_EMP_MASK)
    {
        (void)OS_RestoreInterrupts(enabled);
        return PXI_FIFO_FAIL_RECV_EMPTY;
    }

    *data_buf = reg_PXI_RECV_FIFO;
    (void)OS_RestoreInterrupts(enabled);

    return PXI_FIFO_SUCCESS;
}

void PXIi_HandlerRecvFifoNotEmpty(void)
{
    PXIFifoMessage fifomsg;
    PXIFifoStatus ret_code;
    PXIFifoTag tag;

    while (1)
    {
        ret_code = PXIi_GetFromFifo(&fifomsg.raw);

        if (ret_code == PXI_FIFO_FAIL_RECV_EMPTY)
            break;
        if (ret_code == PXI_FIFO_FAIL_RECV_ERR)
            continue;

        tag = (PXIFifoTag)fifomsg.e.tag;

        if (tag)
        {
            if (FifoRecvCallbackTable[tag])
            {
                (FifoRecvCallbackTable[tag])(tag, fifomsg.e.data, (BOOL)fifomsg.e.err);
            }
            else
            {
                if (fifomsg.e.err)
                {
                }
                else
                {
                    fifomsg.e.err = TRUE;
                    (void)PXIi_SetToFifo(fifomsg.raw);
                }
            }
        }
    }
}