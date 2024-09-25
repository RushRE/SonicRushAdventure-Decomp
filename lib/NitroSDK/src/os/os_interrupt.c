#include <nitro.h>
#include <nitro/code32.h>

// --------------------
// CONSTANTS
// --------------------

extern void SDK_IRQ_STACKSIZE(void);

#ifdef SDK_ARM9
#define OSi_IRQ_STACK_TOP    (HW_DTCM_SVC_STACK - ((s32)SDK_IRQ_STACKSIZE))
#define OSi_IRQ_STACK_BOTTOM HW_DTCM_SVC_STACK
#else
#define OSi_IRQ_STACK_TOP    (HW_PRV_WRAM_IRQ_STACK_END - ((s32)SDK_IRQ_STACKSIZE))
#define OSi_IRQ_STACK_BOTTOM HW_PRV_WRAM_IRQ_STACK_END
#endif

#ifdef SDK_ARM9
#define OSi_IRQ_STACK_CHECKNUM_BOTTOM 0xfddb597dUL
#define OSi_IRQ_STACK_CHECKNUM_TOP    0x7bf9dd5bUL
#define OSi_IRQ_STACK_CHECKNUM_WARN   0x597dfbd9UL
#else
#define OSi_IRQ_STACK_CHECKNUM_BOTTOM 0xd73bfdf7UL
#define OSi_IRQ_STACK_CHECKNUM_TOP    0xfbdd37bbUL
#define OSi_IRQ_STACK_CHECKNUM_WARN   0xbdf7db3dUL
#endif

// --------------------
// VARIABLES
// --------------------

extern OSThreadQueue OSi_IrqThreadQueue;

// --------------------
// FUNCTIONS
// --------------------

void OS_InitIrqTable(void)
{
    OS_InitThreadQueue(&OSi_IrqThreadQueue);
}

void OS_SetIrqFunction(OSIrqMask intrBit, OSIrqFunction function)
{
    int i;
    OSIrqCallbackInfo *info;

    for (i = 0; i < OS_IRQ_TABLE_MAX; i++)
    {
        if (intrBit & 1)
        {
            info = NULL;

            // check the interrupt type...

            // if it's dma type (0-3)
            if (REG_OS_IE_D0_SHIFT <= i && i <= REG_OS_IE_D3_SHIFT)
            {
                info = &OSi_IrqCallbackInfo[i - REG_OS_IE_D0_SHIFT];
            }
            // if it's a timer type (0-3)
            else if (REG_OS_IE_T0_SHIFT <= i && i <= REG_OS_IE_T3_SHIFT)
            {
                info = &OSi_IrqCallbackInfo[i - REG_OS_IE_T0_SHIFT + OSi_IRQCALLBACK_NO_TIMER0];
            }
#ifdef SDK_ARM7
            // if it's a vblank type (arm7 only!)
            else if (REG_OS_IE_VB_SHIFT == i)
            {
                info = &OSi_IrqCallbackInfo[OSi_IRQCALLBACK_NO_VBLANK];
            }
#endif
            // if it's any other interrupt type
            else
            {
                OS_IRQTable[i] = function;
            }

            if (info)
            {
                info->func   = (void (*)(void *))function;
                info->arg    = 0;
                info->enable = TRUE;
            }
        }
        intrBit >>= 1;
    }
}

OSIrqFunction OS_GetIrqFunction(OSIrqMask intrBit)
{
    int i;
    OSIrqFunction *funcPtr = &OS_IRQTable[0];

    for (i = 0; i < OS_IRQ_TABLE_MAX; i++)
    {
        if (intrBit & 1)
        {
            // check the interrupt type...

            // if it's dma type (0-3)
            if (REG_OS_IE_D0_SHIFT <= i && i <= REG_OS_IE_D3_SHIFT)
            {
                return (void (*)(void))OSi_IrqCallbackInfo[i - REG_OS_IE_D0_SHIFT].func;
            }
            // if it's a timer type (0-3)
            else if (REG_OS_IE_T0_SHIFT <= i && i <= REG_OS_IE_T3_SHIFT)
            {
                return (void (*)(void))OSi_IrqCallbackInfo[i - REG_OS_IE_T0_SHIFT + OSi_IRQCALLBACK_NO_TIMER0].func;
            }
#ifdef SDK_ARM7
            // if it's a vblank type (arm7 only!)
            else if (REG_OS_IE_VB_SHIFT == i)
            {
                return (void (*)(void))OSi_IrqCallbackInfo[OSi_IRQCALLBACK_NO_VBLANK].func;
            }
#endif

            // if it's any other interrupt type
            return *funcPtr;
        }
        intrBit >>= 1;
        funcPtr++;
    }

    return 0;
}

void OSi_EnterDmaCallback(u32 dmaNo, void (*callback)(void *arg), void *arg)
{
    OSIrqMask imask = (1 << (REG_OS_IE_D0_SHIFT + dmaNo));

    // prepare callback
    OSi_IrqCallbackInfo[dmaNo].func = callback;
    OSi_IrqCallbackInfo[dmaNo].arg  = arg;

    // store irq mask for later
    OSi_IrqCallbackInfo[dmaNo].enable = OS_EnableIrqMask(imask) & imask;
}

void OSi_EnterTimerCallback(u32 timerNo, void (*callback)(void *), void *arg)
{
    OSIrqMask imask = (1 << (REG_OS_IE_T0_SHIFT + timerNo));

    // prepare callback
    OSi_IrqCallbackInfo[timerNo + 4].func = callback;
    OSi_IrqCallbackInfo[timerNo + 4].arg  = arg;

    // store irq mask for later (it's forced to be enabled here!!)
    (void) OS_EnableIrqMask(imask);
    OSi_IrqCallbackInfo[timerNo + 4].enable = TRUE;
}

OSIrqMask OS_SetIrqMask(OSIrqMask intr)
{
    BOOL ime       = OS_DisableIrq(); // disable this for a sec..
    OSIrqMask prep = reg_OS_IE;

    reg_OS_IE = intr;

    (void) OS_RestoreIrq(ime); // we're done, so restore it!
    return prep;
}

OSIrqMask OS_EnableIrqMask(OSIrqMask intr)
{
    BOOL ime       = OS_DisableIrq(); // disable this for a sec..
    OSIrqMask prep = reg_OS_IE;

    reg_OS_IE = prep | intr;

    (void) OS_RestoreIrq(ime); // we're done, so restore it!
    return prep;
}

OSIrqMask OS_DisableIrqMask(OSIrqMask intr)
{
    BOOL ime       = OS_DisableIrq(); // disable this for a sec..
    OSIrqMask prep = reg_OS_IE;

    reg_OS_IE = prep & ~intr;

    (void) OS_RestoreIrq(ime); // we're done, so restore it!
    return prep;
}

OSIrqMask OS_ResetRequestIrqMask(OSIrqMask intr)
{
    BOOL ime       = OS_DisableIrq(); // disable this for a sec..
    OSIrqMask prep = reg_OS_IF;

    reg_OS_IF = intr;

    (void) OS_RestoreIrq(ime); // we're done, so restore it!
    return prep;
}

void OS_SetIrqStackChecker(void)
{
    *(u32 *)(OSi_IRQ_STACK_BOTTOM - sizeof(u32)) = OSi_IRQ_STACK_CHECKNUM_BOTTOM;
    *(u32 *)(OSi_IRQ_STACK_TOP)                  = OSi_IRQ_STACK_CHECKNUM_TOP;
}