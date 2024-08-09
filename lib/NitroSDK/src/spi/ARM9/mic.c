#include <nitro.h>

// --------------------
// ENUMS
// --------------------

typedef enum MICLock
{
    MIC_LOCK_OFF = 0,
    MIC_LOCK_ON,
    MIC_LOCK_MAX
} MICLock;

// --------------------
// STRUCTS
// --------------------

typedef struct MICWork
{
    MICLock lock;
    MICCallback callback;
    void *callbackArg;
    MICResult commonResult;
    MICCallback full;
    void *fullArg;
    void *dst_buf;

} MICWork;

// --------------------
// VARIABLES
// --------------------

static u16 micInitialized;
static MICWork micWork;

// --------------------
// FUNCTION DECLS
// --------------------

static void MicCommonCallback(PXIFifoTag tag, u32 data, BOOL err);

// --------------------
// FUNCTIONS
// --------------------

void MIC_Init(void)
{
    if (micInitialized)
        return;

    micInitialized = TRUE;

    micWork.lock     = MIC_LOCK_OFF;
    micWork.callback = NULL;

    PXI_Init();
    while (!PXI_IsCallbackReady(PXI_FIFO_TAG_MIC, PXI_PROC_ARM7))
    {
    }

    OS_GetSystemWork()->mic_last_address = 0;

    PXI_SetFifoRecvCallback(PXI_FIFO_TAG_MIC, MicCommonCallback);
}

void *MIC_GetLastSamplingAddress(void)
{
    return (void *)(OS_GetSystemWork()->mic_last_address);
}

static void MicCommonCallback(PXIFifoTag tag, u32 data, BOOL err)
{
    u16 command;
    u16 pxiresult;
    MICResult result;
    MICCallback cb;

    if (err)
    {
        if (micWork.lock != MIC_LOCK_OFF)
        {
            micWork.lock = MIC_LOCK_OFF;
        }
        if (micWork.callback)
        {
            cb               = micWork.callback;
            micWork.callback = NULL;
            cb(MIC_RESULT_FATAL_ERROR, micWork.callbackArg);
        }
    }

    command   = (u16)((data & SPI_PXI_RESULT_COMMAND_MASK) >> SPI_PXI_RESULT_COMMAND_SHIFT);
    pxiresult = (u16)((data & SPI_PXI_RESULT_DATA_MASK) >> SPI_PXI_RESULT_DATA_SHIFT);

    switch (pxiresult)
    {
        case SPI_PXI_RESULT_SUCCESS:
            result = MIC_RESULT_SUCCESS;
            break;
        case SPI_PXI_RESULT_INVALID_COMMAND:
            result = MIC_RESULT_INVALID_COMMAND;
            break;
        case SPI_PXI_RESULT_INVALID_PARAMETER:
            result = MIC_RESULT_ILLEGAL_PARAMETER;
            break;
        case SPI_PXI_RESULT_ILLEGAL_STATUS:
            result = MIC_RESULT_ILLEGAL_STATUS;
            break;
        case SPI_PXI_RESULT_EXCLUSIVE:
            result = MIC_RESULT_BUSY;
            break;
        default:
            result = MIC_RESULT_FATAL_ERROR;
    }

    if (command == SPI_PXI_COMMAND_MIC_BUFFER_FULL)
    {
        if (micWork.full)
        {
            micWork.full(result, micWork.fullArg);
        }
    }
    else
    {
        if (command == SPI_PXI_COMMAND_MIC_SAMPLING)
        {
            if (micWork.dst_buf)
            {
                *(u16 *)(micWork.dst_buf) = OS_GetSystemWork()->mic_sampling_data;
            }
        }

        if (micWork.lock != MIC_LOCK_OFF)
        {
            micWork.lock = MIC_LOCK_OFF;
        }

        if (micWork.callback)
        {
            cb               = micWork.callback;
            micWork.callback = NULL;
            cb(result, micWork.callbackArg);
        }
    }
}