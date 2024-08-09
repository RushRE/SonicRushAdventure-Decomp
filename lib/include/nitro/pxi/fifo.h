#ifndef NITRO_PXI_FIFO_H
#define NITRO_PXI_FIFO_H

#include <nitro/pxi/fifo_shared.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// ENUMS
// --------------------

typedef enum
{
    PXI_FIFO_SUCCESS           = 0,
    PXI_FIFO_FAIL_SEND_ERR     = -1,
    PXI_FIFO_FAIL_SEND_FULL    = -2,
    PXI_FIFO_FAIL_RECV_ERR     = -3,
    PXI_FIFO_FAIL_RECV_EMPTY   = -4,
    PXI_FIFO_NO_CALLBACK_ENTRY = -5
} PXIFifoStatus;

// --------------------
// TYPES
// --------------------

typedef void (*PXIFifoCallback)(PXIFifoTag tag, u32 data, BOOL err);

// --------------------
// STRUCTS
// --------------------

typedef union
{
    struct
    {
        u32 tag : 5;
        u32 err : 1;
        u32 data : 26;
    } e;
    u32 raw;
} PXIFifoMessage;

// --------------------
// FUNCTIONS
// --------------------

void PXI_InitFifo(void);
void PXI_SetFifoRecvCallback(int fifotag, PXIFifoCallback callback);
BOOL PXI_IsCallbackReady(int fifotag, PXIProc proc);
int PXI_SendWordByFifo(int fifotag, u32 data, BOOL err);
void PXIi_HandlerRecvFifoNotEmpty(void);

#ifdef __cplusplus
}
#endif

#endif // NITRO_PXI_FIFO_H