#include <nitro.h>

// --------------------
// CONSTANTS
// --------------------

#define HW_EXCP_VECTOR_BUF_FOR_DEBUGGER 0x027ffd9c
#define HW_ITCM_END_ARM7                0x3806000

// --------------------
// STRUCTS
// --------------------

typedef struct
{
    OSContext context;
    u32 cp15;
    u32 spsr;
    u32 exinfo;
    u32 debug[4];
} OSiExContext;

// --------------------
// VARIABLES
// --------------------

static void *OSi_UserExceptionHandlerArg;
static OSExceptionHandler OSi_UserExceptionHandler;

static void *OSi_DebuggerHandler = NULL;

static OSiExContext OSi_ExContext;

// --------------------
// FUNCTION DECLS
// --------------------

static asm void OSi_ExceptionHandler(void);
static asm void OSi_GetAndDisplayContext(void);
static asm void OSi_SetExContext(void);
static void OSi_DisplayExContext(void);

// --------------------
// FUNCTIONS
// --------------------

void OS_InitException(void)
{
    if (0x2600000 <= *(u32 *)HW_EXCP_VECTOR_BUF_FOR_DEBUGGER && *(u32 *)HW_EXCP_VECTOR_BUF_FOR_DEBUGGER < 0x2800000)
    {
        OSi_DebuggerHandler = *(void **)HW_EXCP_VECTOR_BUF_FOR_DEBUGGER;
    }
    else
    {
        OSi_DebuggerHandler = NULL;
    }

    if (OSi_DebuggerHandler == NULL)
    {
        *(u32 *)(HW_EXCP_VECTOR_BUF_FOR_DEBUGGER) = (u32)OSi_ExceptionHandler;

        *(u32 *)(HW_EXCP_VECTOR_BUF) = (u32)OSi_ExceptionHandler;
    }

    OSi_UserExceptionHandler = NULL;
}

#include <nitro/code32.h>
asm void OSi_ExceptionHandler(void)
{
    // clang-format off
    ldr r12, =OSi_DebuggerHandler
	ldr r12, [r12]
	cmp r12, #0
	movne lr, pc
	bxne r12
    
#ifdef SDK_ARM9
	ldr r12, =HW_ITCM_END
#else // SDK_ARM7
    ldr r12, =HW_ITCM_END_ARM7
#endif
	stmdb r12!, {r0, r1, r2, r3, sp, lr}

	and r0, sp, #1
	mov sp, r12

	mrs r1, cpsr
	and r1, r1, #0x1f

	teq r1, #0x17
	bne @1
	bl OSi_GetAndDisplayContext
	b usr_return

@1:
	teq r1, #0x1b
	bne usr_return
	bl OSi_GetAndDisplayContext

usr_return:
	ldr r12, =OSi_DebuggerHandler
	ldr r12, [r12]
	cmp r12, #0

@2:
	beq @2

@3:
	mov r0, r0 // nop
	b @3
    
@4:
	ldmia sp!, {r0, r1, r2, r3, r12, lr}
	mov sp, r12
	bx lr
    // clang-format on
}

static asm void OSi_GetAndDisplayContext(void)
{
    // clang-format off
    stmdb sp!, {r0, lr}

	bl OSi_SetExContext
	bl OSi_DisplayExContext

	ldmia sp!, {r0, lr}
	bx lr
    // clang-format on
}

static asm void OSi_SetExContext(void)
{
    // clang-format off
    ldr r1, =OSi_ExContext

	mrs r2, cpsr
	str r2, [r1, #OSiExContext.debug[1]]

	str r0, [r1, #OSiExContext.exinfo]
	ldr r0, [r12, #0]
	str r0, [r1, #OS_CONTEXT_R0]
	ldr r0, [r12, #4]
	str r0, [r1, #OS_CONTEXT_R1]
	ldr r0, [r12, #8]
	str r0, [r1, #OS_CONTEXT_R2]
	ldr r0, [r12, #0xc]
	str r0, [r1, #OS_CONTEXT_R3]
	ldr r2, [r12, #0x10]
	bic r2, r2, #1

	add r0, r1, #OS_CONTEXT_R4
	stmia r0, {r4, r5, r6, r7, r8, r9, r10, r11}

	str r12, [r1, #OSiExContext.debug[0]]

#ifdef SDK_ARM9
	ldr r0, [r2, #0]
	str r0, [r1, #OSiExContext.cp15]
	ldr r3, [r2, #4]
	str r3, [r1, #OS_CONTEXT_CPSR]
	ldr r0, [r2, #8]
	str r0, [r1, #OS_CONTEXT_R12]
	ldr r0, [r2, #0xc]
	str r0, [r1, #OS_CONTEXT_PC_PLUS4]
#else // SDK_ARM7
    mov r0, #0
    str r0, [r1, #OSiExContext.cp15]
    ldr r3, [r2, #0]
    str r3, [r1, #OS_CONTEXT_CPSR]
    ldr r0, [r2, #4]
    str r0, [r1, #OS_CONTEXT_R12]
    ldr r0, [r2, #8]
    str r0, [r1, #OS_CONTEXT_PC_PLUS4]
#endif

	mrs r0, cpsr
	orr r3, r3, #0x80
	bic r3, r3, #0x20
	msr cpsr_fsxc, r3

	str sp, [r1, #OS_CONTEXT_R13]
	str lr, [r1, #OS_CONTEXT_R14]
	mrs r2, spsr

	str r2, [r1, #OSiExContext.debug[3]]

	msr cpsr_fsxc, r0
	bx lr
    // clang-format on
}
#include <nitro/codereset.h>

static void OSi_DisplayExContext(void)
{
    if (OSi_UserExceptionHandler)
    {
        asm
        {
            /* *INDENT-OFF**/
          mov      r0, sp
          ldr      r1, =0x9f
          msr      CPSR_cxsf, r1
          mov      sp, r0
            /* *INDENT-ON**/
        }

#ifdef SDK_ARM9
        OS_EnableProtectionUnit();
#endif

        ((void (*)(u32, void *))OSi_UserExceptionHandler)((u32)&OSi_ExContext, OSi_UserExceptionHandlerArg);

#ifdef SDK_ARM9
        OS_DisableProtectionUnit();
#endif
    }
}