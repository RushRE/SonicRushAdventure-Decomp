#include <nitro.h>

asm u32 MI_SwapWord(register u32 setData, register vu32* destp)
{
// clang-format off
    swp r0, r0, [r1]
    bx  lr
// clang-format on
}