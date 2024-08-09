#include <nitro.h>

// --------------------
// VARIABLES
// --------------------

OSIrqCallbackInfo OSi_IrqCallbackInfo[OSi_IRQCALLBACK_NUM];

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
    REG_OS_IE_VB_SHIFT,
#endif
};

// --------------------
// VARIABLES (dtcm)
// --------------------

#ifdef SDK_ARM9
#include <nitro/dtcm_begin.h>
#endif

OSIrqFunction OS_IRQTable[OS_IRQ_TABLE_MAX] = {
    OS_IrqDummy,   // VBlank
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
    OS_IrqDummy,   // Geometry command FIFO
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
        (IGNORE_RETURN) OS_DisableIrqMask(imask);
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