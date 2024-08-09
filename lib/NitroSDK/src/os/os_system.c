#include <nitro.h>
#include <nitro/code32.h>

// --------------------
// FUNCTIONS
// --------------------

asm OSIntrMode OS_EnableInterrupts(void)
{
    // clang-format off
    mrs r0, cpsr
	bic r1, r0, #HW_PSR_IRQ_DISABLE
	msr cpsr_c, r1
	and r0, r0, #HW_PSR_IRQ_DISABLE

	bx lr
    // clang-format on
}

asm OSIntrMode OS_DisableInterrupts(void)
{
    // clang-format off
    mrs r0, cpsr
	orr r1, r0, #HW_PSR_IRQ_DISABLE
	msr cpsr_c, r1
	and r0, r0, #HW_PSR_IRQ_DISABLE

	bx lr
    // clang-format on
}

asm OSIntrMode OS_RestoreInterrupts(OSIntrMode state)
{
    // clang-format off
    mrs r1, cpsr
	bic r2, r1, #HW_PSR_IRQ_DISABLE
	orr r2, r2, r0
	msr cpsr_c, r2
	and r0, r1, #HW_PSR_IRQ_DISABLE

	bx lr
    // clang-format on
}

asm OSIntrMode OS_DisableInterrupts_IrqAndFiq(void)
{
    // clang-format off
    mrs r0, cpsr
	orr r1, r0, #HW_PSR_IRQ_FIQ_DISABLE
	msr cpsr_c, r1
	and r0, r0, #HW_PSR_IRQ_FIQ_DISABLE

	bx lr
    // clang-format on
}

asm OSIntrMode OS_RestoreInterrupts_IrqAndFiq(OSIntrMode state)
{
    // clang-format off
    mrs r1, cpsr
	bic r2, r1, #HW_PSR_IRQ_FIQ_DISABLE
	orr r2, r2, r0
	msr cpsr_c, r2
	and r0, r1, #HW_PSR_IRQ_FIQ_DISABLE

	bx lr
    // clang-format on
}

asm OSIntrMode_Irq OS_GetCpsrIrq(void)
{
    // clang-format off
    mrs r0, cpsr
	and r0, r0, #HW_PSR_IRQ_DISABLE

	bx lr
    // clang-format on
}

asm OSProcMode OS_GetProcMode(void)
{
    // clang-format off
    mrs r0, cpsr
	and r0, r0, #HW_PSR_CPU_MODE_MASK

	bx lr
    // clang-format on
}

asm void OS_SpinWait(u32 cycles)
{
    // clang-format off
loop:
    subs r0, r0, #4
	bhs loop
	bx lr
    // clang-format on
}

void OS_WaitVBlankIntr(void)
{
    SVC_WaitByLoop(1);
    OS_WaitIrq(TRUE, OS_IE_V_BLANK);
}