#ifndef NITRO_SUB_OS_INTERRUPT_H
#define NITRO_SUB_OS_INTERRUPT_H

#include <nitro/os/common/interrupt_shared.h>
#include <nitro/hw/consts.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define OS_IME_DISABLE (0UL << REG_OS_IME_IME_SHIFT)
#define OS_IME_ENABLE  (1UL << REG_OS_IME_IME_SHIFT)

#define OSi_IRQCALLBACK_NO_DMA0   0
#define OSi_IRQCALLBACK_NO_DMA1   1
#define OSi_IRQCALLBACK_NO_DMA2   2
#define OSi_IRQCALLBACK_NO_DMA3   3
#define OSi_IRQCALLBACK_NO_TIMER0 4
#define OSi_IRQCALLBACK_NO_TIMER1 5
#define OSi_IRQCALLBACK_NO_TIMER2 6
#define OSi_IRQCALLBACK_NO_TIMER3 7
#ifdef SDK_ARM7
#define OSi_IRQCALLBACK_NO_VBLANK 8
#endif // SDK_ARM7

#ifdef SDK_ARM9
#define OSi_IRQCALLBACK_NUM (7 + 1)
#else // SDK_ARM7
#define OSi_IRQCALLBACK_NUM (8 + 1)
#endif // SDK_ARM9 SDK_ARM7
#define OS_IME_DISABLE (0UL << REG_OS_IME_IME_SHIFT)
#define OS_IME_ENABLE  (1UL << REG_OS_IME_IME_SHIFT)

#define OS_IE_V_BLANK     (1UL << REG_OS_IE_VB_SHIFT)
#define OS_IE_H_BLANK     (1UL << REG_OS_IE_HB_SHIFT)
#define OS_IE_V_COUNT     (1UL << REG_OS_IE_VE_SHIFT)
#define OS_IE_TIMER0      (1UL << REG_OS_IE_T0_SHIFT)
#define OS_IE_TIMER1      (1UL << REG_OS_IE_T1_SHIFT)
#define OS_IE_TIMER2      (1UL << REG_OS_IE_T2_SHIFT)
#define OS_IE_TIMER3      (1UL << REG_OS_IE_T3_SHIFT)
#define OS_IE_SIO         (1UL << 7)
#define OS_IE_DMA0        (1UL << REG_OS_IE_D0_SHIFT)
#define OS_IE_DMA1        (1UL << REG_OS_IE_D1_SHIFT)
#define OS_IE_DMA2        (1UL << REG_OS_IE_D2_SHIFT)
#define OS_IE_DMA3        (1UL << REG_OS_IE_D3_SHIFT)
#define OS_IE_KEY         (1UL << REG_OS_IE_K_SHIFT)
#define OS_IE_CARTRIDGE   (1UL << REG_OS_IE_I_D_SHIFT)
#define OS_IE_SUBP        (1UL << REG_OS_IE_A7_SHIFT)
#define OS_IE_SPFIFO_SEND (1UL << REG_OS_IE_IFE_SHIFT)
#define OS_IE_SPFIFO_RECV (1UL << REG_OS_IE_IFN_SHIFT)
#define OS_IE_CARD_DATA   (1UL << REG_OS_IE_MC_SHIFT)
#define OS_IE_CARD_IREQ   (1UL << REG_OS_IE_MI_SHIFT)

#ifdef SDK_ARM9

#define OS_IE_GXFIFO     (1UL << REG_OS_IE_GF_SHIFT) // geometry command FIFO
#define OS_IRQ_TABLE_MAX 22

#else
#include <nitro/os/ARM7/interrupt.h>

#define OS_IE_POWERMAN     (1UL << REG_OS_IE_PM_SHIFT)
#define OS_IE_SPI          (1UL << REG_OS_IE_SPI_SHIFT)
#define OS_IE_WIRELESS     (1UL << REG_OS_IE_WL_SHIFT)
#define OS_IRQ_TABLE_MAX   25

// Aliases to SUBP->MAINP
#define OS_IE_MAINP        OS_IE_SUBP
#define OS_IE_MPFIFO_SEND  OS_IE_SPFIFO_SEND
#define OS_IE_MPFIFO_RECV  OS_IE_SPFIFO_RECV
#define REG_OS_IE_A9_SHIFT REG_OS_IE_A7_SHIFT

#endif

// Aliases to common naming
#define OS_IE_FIFO_SEND OS_IE_SPFIFO_SEND
#define OS_IE_FIFO_RECV OS_IE_SPFIFO_RECV

// --------------------
// VARIABLES
// --------------------

extern OSIrqFunction OS_IRQTable[];
extern OSIrqCallbackInfo OSi_IrqCallbackInfo[OSi_IRQCALLBACK_NUM];

// --------------------
// INLINE FUNCTIONS
// --------------------

static inline vu32 OS_GetVBlankCount (void)
{
	return *(vu32 *)HW_VBLANK_COUNT_BUF;
}

static inline void OSi_SetVBlankCount(u32 count)
{
    *(u32 *)HW_VBLANK_COUNT_BUF = count;
}

static inline void OS_ClearIrqCheckFlag(OSIrqMask intr)
{
    *(vu32 *)HW_INTR_CHECK_BUF &= (u32)~intr;
}

static inline u32 OS_GetIrqCheckFlag(void)
{
    return *(vu32 *)HW_INTR_CHECK_BUF;
}

static inline void OS_SetIrqCheckFlag(OSIrqMask intr)
{
    *(vu32 *)HW_INTR_CHECK_BUF |= (u32)intr;
}

static inline BOOL OS_EnableIrq(void)
{
    u16 prep   = reg_OS_IME;
    reg_OS_IME = OS_IME_ENABLE;
    return (BOOL)prep;
}

static inline BOOL OS_DisableIrq(void)
{
    u16 prep   = reg_OS_IME;
    reg_OS_IME = OS_IME_DISABLE;
    return (BOOL)prep;
}

static inline BOOL OS_RestoreIrq(BOOL enable)
{
    BOOL ime   = reg_OS_IME;
    reg_OS_IME = enable;
    return ime;
}

static inline OSIrqMask OS_GetIrqMask(void)
{
    return reg_OS_IE;
}

static inline OSIrqMask OS_GetRequestIrqMask(void)
{
    return reg_OS_IF;
}

// --------------------
// FUNCTIONS
// --------------------

void OS_InitIrqTable(void);
void OS_SetIrqFunction(OSIrqMask intrBit, OSIrqFunction function);
OSIrqFunction OS_GetIrqFunction(OSIrqMask intrBit);
void OSi_EnterDmaCallback(u32 dmaNo, void (*callback)(void *arg), void *arg);
void OSi_EnterTimerCallback(u32 timerNo, void (*callback)(void *), void *arg);
OSIrqMask OS_SetIrqMask(OSIrqMask mask);
OSIrqMask OS_EnableIrqMask(OSIrqMask mask);
OSIrqMask OS_DisableIrqMask(OSIrqMask mask);
OSIrqMask OS_ResetRequestIrqMask(OSIrqMask mask);
void OS_SetIrqStackChecker(void);

#ifdef __cplusplus
}
#endif

#endif // NITRO_SUB_OS_INTERRUPT_H
