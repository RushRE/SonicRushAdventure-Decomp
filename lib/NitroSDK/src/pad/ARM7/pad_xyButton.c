#include <nitro.h>

// --------------------
// CONSTANTS
// --------------------

#define PAD_XY_BUTTON_SHIFT 10
#define PAD_XY_BUTTON_MASK (EXI_GPIO_PADX | EXI_GPIO_PADY | EXI_GPIO_PADDEBUG)

// --------------------
// VARIABLES
// --------------------

BOOL PADi_XYButtonAvailable;

static OSAlarm PADi_XYButtonAlarm;

// --------------------
// FUNCTION DECLS
// --------------------

static void PADi_XYButton_Callback(void *arg);

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC void PADi_XYButton_Callback(void *arg)
{
    // https://decomp.me/scratch/Zouwl -> 85.63%
#ifdef NON_MATCHING
    u16 foldMask = 0x0000;
    
    EXIi_SelectRcnt(EXI_GPIOIF_GPIO);

    u16 mask = EXIi_GetRcnt0H();
    if ((mask & EXI_GPIO_PADFOLD) != 0)
        foldMask = PAD_DETECT_FOLD_MASK;

    (*(vu16 *)HW_BUTTON_XY_BUF) = ((mask & PAD_XY_BUTTON_MASK) << PAD_XY_BUTTON_SHIFT) | foldMask;
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, #0
	mov r0, #EXI_GPIOIF_GPIO
	bl EXIi_SelectRcnt
	ldr r0, =REG_RCNT0_H_ADDR
	ldrh r1, [r0, #0]
	ands r0, r1, #EXI_GPIO_PADFOLD
	movne r4, #PAD_DETECT_FOLD_MASK
	and r0, r1, #PAD_XY_BUTTON_MASK
	orr r1, r4, r0, lsl #10
	ldr r0, =HW_BUTTON_XY_BUF
	strh r1, [r0]
	ldmia sp!, {r4, lr}
	bx lr
// clang-format on
#endif
}

BOOL PAD_InitXYButton(void)
{
    if (!OS_IsTickAvailable() || !OS_IsAlarmAvailable())
        return FALSE;

    if (PADi_XYButtonAvailable)
        return FALSE;

    OS_CreateAlarm(&PADi_XYButtonAlarm);
    OS_SetPeriodicAlarm(&PADi_XYButtonAlarm, OS_GetTick() + 2094, 2094, PADi_XYButton_Callback, NULL);

    PADi_XYButtonAvailable = TRUE;

    return TRUE;
}