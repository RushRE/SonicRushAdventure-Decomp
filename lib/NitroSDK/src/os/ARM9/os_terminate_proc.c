#include <nitro.h>

#ifdef SDK_ARM9

SDK_WEAK_SYMBOL void OS_Terminate(void)
{
    while (TRUE)
    {
        (IGNORE_RETURN) OS_DisableInterrupts();
        OS_Halt();
    }
}

#include <nitro/code32.h>
SDK_WEAK_SYMBOL asm void OS_Halt(void)
{
    // clang-format off
    mov r0, #0 
    mcr p15, 0, r0, c7, c0, 4

    bx lr
    // clang-format on
}
#include <nitro/codereset.h>

#endif