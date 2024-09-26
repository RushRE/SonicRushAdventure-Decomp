#include <nitro.h>

// --------------------
// FUNCTION DECLS
// --------------------

void OSi_IrqCallback(s32 index);

void OSi_IrqDma0(void);
void OSi_IrqDma1(void);
void OSi_IrqDma2(void);
void OSi_IrqDma3(void);

void OSi_IrqTimer0(void);
void OSi_IrqTimer1(void);
void OSi_IrqTimer2(void);
void OSi_IrqTimer3(void);

#ifdef SDK_ARM7
void OSi_IrqVBlank(void);
#endif

// --------------------
// VARIABLES
// --------------------

OSIrqCallbackInfo OSi_IrqCallbackInfo[OSi_IRQCALLBACK_NUM] = {
    { NULL, 0, 0 }, // dma0
    { NULL, 0, 0 }, // dma1
    { NULL, 0, 0 }, // dma2
    { NULL, 0, 0 }, // dma3

    { NULL, 0, 0 }, // timer0
    { NULL, 0, 0 }, // timer1
    { NULL, 0, 0 }, // timer2
    { NULL, 0, 0 }, // timer3

#ifdef SDK_ARM7
    { NULL, 0, 0 } // vblank
#endif
};

// clang-format off
u16 OSi_IrqCallbackInfoIndex[] = {
    REG_OS_IE_D0_SHIFT, 
    REG_OS_IE_D1_SHIFT, 
    REG_OS_IE_D2_SHIFT, 
    REG_OS_IE_D3_SHIFT, 
    REG_OS_IE_T0_SHIFT, 
    REG_OS_IE_T1_SHIFT, 
    REG_OS_IE_T2_SHIFT, 
    REG_OS_IE_T3_SHIFT,
#ifdef SDK_ARM7
    REG_OS_IE_VB_SHIFT
#endif
};
// clang-format on

#ifdef SDK_ARM9
#include <nitro/dtcm_begin.h>
#endif

OSIrqFunction OS_IRQTable[OS_IRQ_TABLE_MAX] = {
#ifdef SDK_ARM9
    OS_IrqDummy, // VBlank
#else
    OSi_IrqVBlank, // VBlank
#endif
    OS_IrqDummy,   // HBlank
    OS_IrqDummy,   // VCounter
    OSi_IrqTimer0, // Timer0
    OSi_IrqTimer1, // Timer1
    OSi_IrqTimer2, // Timer2
    OSi_IrqTimer3, // Timer3
    OS_IrqDummy,   // serial communication (will not occur)
    OSi_IrqDma0,   // DMA0
    OSi_IrqDma1,   // DMA1
    OSi_IrqDma2,   // DMA2
    OSi_IrqDma3,   // DMA3
    OS_IrqDummy,   // Key
    OS_IrqDummy,   // Cartridge
    OS_IrqDummy,   // Unused.
    OS_IrqDummy,   // Unused.
    OS_IrqDummy,   // Sub processor
    OS_IrqDummy,   // Sub processor send FIFO empty
    OS_IrqDummy,   // Sub processor receive FIFO not empty
    OS_IrqDummy,   // card data transfer finish
    OS_IrqDummy,   // card IREQ
#ifdef SDK_ARM9
    OS_IrqDummy, // Geometry command FIFO
#else
    OS_IrqDummy, // Unused.
    OS_IrqDummy, // Power Management IC
    OS_IrqDummy, // SPI data transfer
    OS_IrqDummy  // Wireless module
#endif
};

#ifdef SDK_ARM9
#include <nitro/dtcm_end.h>
#endif

// --------------------
// FUNCTIONS
// --------------------

void OS_IrqDummy(void)
{
    // Nothin'
}

void OSi_IrqCallback(s32 index)
{
    OSIrqMask imask          = (1 << OSi_IrqCallbackInfoIndex[index]);
    void (*callback)(void *) = OSi_IrqCallbackInfo[index].func;

    // clear callback
    OSi_IrqCallbackInfo[index].func = NULL;

    // call prev callback
    if (callback)
        (callback)(OSi_IrqCallbackInfo[index].arg);

    // check IRQMask
    OS_SetIrqCheckFlag(imask);

    // restore IRQEnable
    if (!OSi_IrqCallbackInfo[index].enable)
        (void)OS_DisableIrqMask(imask);
}

void OSi_IrqDma0(void)
{
    OSi_IrqCallback(OSi_IRQCALLBACK_NO_DMA0);
}

void OSi_IrqDma1(void)
{
    OSi_IrqCallback(OSi_IRQCALLBACK_NO_DMA1);
}

void OSi_IrqDma2(void)
{
    OSi_IrqCallback(OSi_IRQCALLBACK_NO_DMA2);
}

void OSi_IrqDma3(void)
{
    OSi_IrqCallback(OSi_IRQCALLBACK_NO_DMA3);
}

void OSi_IrqTimer0(void)
{
    OSi_IrqCallback(OSi_IRQCALLBACK_NO_TIMER0);
}

void OSi_IrqTimer1(void)
{
    OSi_IrqCallback(OSi_IRQCALLBACK_NO_TIMER1);
}

void OSi_IrqTimer2(void)
{
    OSi_IrqCallback(OSi_IRQCALLBACK_NO_TIMER2);
}

void OSi_IrqTimer3(void)
{
    OSi_IrqCallback(OSi_IRQCALLBACK_NO_TIMER3);
}

#ifdef SDK_ARM7
void OSi_IrqVBlank(void)
{
    void (*callback)(void) = (void (*)(void))OSi_IrqCallbackInfo[OSi_IRQCALLBACK_NO_VBLANK].func;

    (*(u32 *)HW_VBLANK_COUNT_BUF)++;

    if (callback)
    {
        callback();
    }

    OS_SetIrqCheckFlag(1 << REG_OS_IE_VB_SHIFT);
}
#endif