#include <nitro.h>
#include <nitro/code32.h>

#ifdef SDK_ARM9
#include <nitro/dtcm_begin.h>
#endif

OSThreadQueue OSi_IrqThreadQueue = { NULL, NULL };

#ifdef SDK_ARM9
#include <nitro/dtcm_end.h>
#endif

#ifdef SDK_ARM9
#include <nitro/itcm_begin.h>
#endif

asm void OS_IrqHandler(void)
{
    // clang-format off
    stmdb sp!, {lr}

    mov r12, #HW_REG_BASE
    add r12, r12, #REG_IE_OFFSET

    ldr r1, [r12, #REG_IME_ADDR - REG_IE_ADDR]

    cmp r1, #0
    ldmeqia sp!, {pc}

    ldmia r12, {r1, r2}
    ands r1, r1, r2

    ldmeqia sp!, {pc}

#if defined(SDK_ARM9) && !defined(SDK_CWBUG_PROC_OPT)
    mov r3, #1<<31

@1:
    clz r0, r1
    bics r1, r1, r3, lsr r0
    bne @1

    mov r1, r3, lsr r0
    str r1, [r12, #4]

    rsbs r0, r0, #0x1F
#else
    mov r3, #1
    mov r0, #0

@1: 
    ands    r2, r1, r3, LSL r0
    addeq   r0, r0, #1
    beq     @1

    str r2, [ r12, #REG_IF_ADDR - REG_IE_ADDR ]
#endif // defined(SDK_ARM9) && !defined(SDK_CWBUG_PROC_OPT)

    ldr r1, =OS_IRQTable
    ldr r0, [r1, r0, lsl #2]
    
    ldr lr, =OS_IrqHandler_ThreadSwitch
    bx r0
    // clang-format on
}

asm void OS_IrqHandler_ThreadSwitch(void)
{
    // clang-format off
	ldr r12, =OSi_IrqThreadQueue
	mov r3, #0
	ldr r12, [r12, #OSThreadQueue.head]
	mov r2, #OS_THREAD_STATE_READY
	cmp r12, #0
	beq @2

@1:
	str r2, [r12, #OSThread.state]
	str r3, [r12, #OSThread.queue]
	str r3, [r12, #OSThread.link.prev]
	ldr r0, [r12, #OSThread.link.next]
	str r3, [r12, #OSThread.link.next]
	mov r12, r0

	cmp r12, #0
	bne @1

	ldr r12, =OSi_IrqThreadQueue
	str r3, [r12, #OSThreadQueue.head]
	str r3, [r12, #OSThreadQueue.tail]

	ldr r12, =OSi_ThreadInfo
	mov r1, #1
	strh r1, [r12, #OS_THREADINFO_OFFSET_ISNEEDRESCHEDULING]

@2:
	ldr r12, =OSi_ThreadInfo
	ldrh r1, [r12]
	cmp r1, #OS_THREADINFO_OFFSET_ISNEEDRESCHEDULING
	ldreq pc, [sp], #4

	mov r1, #OS_THREADINFO_OFFSET_ISNEEDRESCHEDULING
	strh r1, [r12]

	mov r3, #HW_PSR_IRQ_MODE|HW_PSR_FIQ_DISABLE|HW_PSR_IRQ_DISABLE|HW_PSR_ARM_STATE
	msr cpsr_c, r3

	add r2, r12, #OS_THREADINFO_OFFSET_LIST
	ldr r1, [r2]

@3:
	cmp r1, #0
	ldrneh r0, [r1, #OS_THREAD_OFFSET_STATE]
	cmpne r0, #OS_THREAD_STATE_READY
	ldrne r1, [r1, #OS_THREAD_OFFSET_NEXT]
	bne @3

	cmp r1, #0
	bne @5

@4:
	mov r3, #HW_PSR_IRQ_MODE|HW_PSR_IRQ_DISABLE|HW_PSR_ARM_STATE
	msr cpsr_c, r3
	ldr pc, [sp], #4

@5:
	ldr r0, [r12, #OS_THREADINFO_OFFSET_CURRENT]
	cmp r1, r0
	beq @4

	ldr r3, [r12, #OS_THREADINFO_OFFSET_SWITCHCALLBACK]
	cmp r3, #0
	beq @6
	stmdb sp!, {r0, r1, r12}
	mov lr, pc
	bx r3
	ldmia sp!, {r0, r1, r12}

@6:
	str r1, [r12, #OS_THREADINFO_OFFSET_CURRENT]

	mrs r2, spsr
	str r2, [r0, #OS_THREAD_OFFSET_CONTEXT]!

#if defined(SDK_ARM9)
	stmdb sp!, {r0, r1}
	add r0, r0, #OS_THREAD_OFFSET_CONTEXT
	add r0, r0, #OS_CONTEXT_CP_CONTEXT
	ldr r1, =CP_SaveContext
	blx r1
	ldmia sp!, {r0, r1}
#endif

	ldmib sp!, {r2, r3}
	stmib r0!, {r2, r3}

	ldmib sp!, {r2, r3, r12, lr}
	stmib r0!, {r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, sp, lr} ^
	stmib r0!, {lr}

#ifdef  SDK_CONTEXT_HAS_SP_SVC
	mov r3, #HW_PSR_SVC_MODE|HW_PSR_FIQ_DISABLE|HW_PSR_IRQ_DISABLE|HW_PSR_ARM_STATE
	msr cpsr_c, r3
	stmib r0!, {sp}
#endif

#if defined(SDK_ARM9)
	stmdb sp!, {r1}
	add r0, r1, #OS_THREAD_OFFSET_CONTEXT
	add r0, r0, #OS_CONTEXT_CP_CONTEXT
	ldr r1, =CPi_RestoreContext
	blx r1
	ldmia sp!, {r1}
#endif
    
#ifdef  SDK_CONTEXT_HAS_SP_SVC
	ldr sp, [r1, #OS_THREAD_OFFSET_CONTEXT+OS_CONTEXT_SP_SVC]
	mov r3, #HW_PSR_IRQ_MODE|HW_PSR_FIQ_DISABLE|HW_PSR_IRQ_DISABLE|HW_PSR_ARM_STATE
	msr cpsr_c, r3
#endif

	ldr r2, [r1, #OS_THREAD_OFFSET_CONTEXT]!
	msr spsr_fc, r2

	ldr lr, [r1, #OS_CONTEXT_PC_PLUS4 - OS_CONTEXT_CPSR]
	ldmib r1!, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, sp, lr} ^
	nop
	stmda sp!, {r0, r1, r2, r3, r12, lr}

	ldmia sp!, {pc}
    // clang-format on
}

#ifdef SDK_ARM9
#include <nitro/itcm_end.h>
#endif

void OS_WaitIrq(BOOL clear, OSIrqMask irqFlags)
{
    OSIntrMode enabled = OS_DisableInterrupts();

    // clear irq flags
    if (clear)
        (void) OS_ClearIrqCheckFlag(irqFlags);

    (void) OS_RestoreInterrupts(enabled);

    // sleep till required interrupts
    while (!(OS_GetIrqCheckFlag() & irqFlags))
    {
        OS_SleepThread(&OSi_IrqThreadQueue);
    }
}