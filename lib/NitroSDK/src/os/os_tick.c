#include <nitro.h>

// --------------------
// CONSTANTS
// --------------------

#define OSi_TICK_TIMERCONTROL (REG_OS_TM0CNT_H_E_MASK | REG_OS_TM0CNT_H_I_MASK | OS_TIMER_PRESCALER_64)
#define OSi_TICK_TIMER        OS_TIMER_0
#define OSi_TICK_IE_TIMER     OS_IE_TIMER0

// --------------------
// VARIABLES
// --------------------

static u16 OSi_UseTick         = FALSE;
static BOOL OSi_NeedResetTimer = FALSE;
vu64 OSi_TickCounter;

// --------------------
// FUNCTION DECLS
// --------------------

static void OSi_CountUpTick(void);

// --------------------
// FUNCTIONS
// --------------------

void OS_InitTick(void)
{
    if (!OSi_UseTick)
    {
        OSi_UseTick = TRUE;

        OSi_SetTimerReserved(OSi_TICK_TIMER);

        OSi_TickCounter = 0;
        OS_SetTimerControl(OSi_TICK_TIMER, 0);
        OS_SetTimerCount((OSTimer)OSi_TICK_TIMER, (u16)0);
        OS_SetTimerControl(OSi_TICK_TIMER, (u16)OSi_TICK_TIMERCONTROL);

        OS_SetIrqFunction(OSi_TICK_IE_TIMER, OSi_CountUpTick);

        (void)OS_EnableIrqMask(OSi_TICK_IE_TIMER);

        OSi_NeedResetTimer = FALSE;
    }
}

BOOL OS_IsTickAvailable(void)
{
    return OSi_UseTick;
}

static void OSi_CountUpTick(void)
{
    OSi_TickCounter++;

    if (OSi_NeedResetTimer)
    {
        OS_SetTimerControl(OSi_TICK_TIMER, 0);
        OS_SetTimerCount((OSTimer)OSi_TICK_TIMER, (u16)0);
        OS_SetTimerControl(OSi_TICK_TIMER, (u16)OSi_TICK_TIMERCONTROL);

        OSi_NeedResetTimer = FALSE;
    }

    OSi_EnterTimerCallback(OSi_TICK_TIMER, (void (*)(void *))OSi_CountUpTick, 0);
}

OSTick OS_GetTick(void)
{
    vu16 countL;
    vu64 countH;

    OSIntrMode prev = OS_DisableInterrupts();

    countL = *(REGType16 *)((u32)REG_TM0CNT_L_ADDR + OSi_TICK_TIMER * 4);
    countH = OSi_TickCounter & 0xffffffffffffULL;

    if (reg_OS_IF & OSi_TICK_IE_TIMER && !(countL & 0x8000))
        countH++;

    (void) OS_RestoreInterrupts(prev);

    return (countH << 16) | countL;
}

u16 OS_GetTickLo(void)
{
    return *(REGType16 *)((u32)REG_TM0CNT_L_ADDR + OSi_TICK_TIMER * 4);
}