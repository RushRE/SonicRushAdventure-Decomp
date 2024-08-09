#include <nitro.h>

#ifdef SDK_ARM9

// --------------------
// VARIABLES
// --------------------

static u32 OSi_vramExclusive;
static u16 OSi_vramLockId[OS_VRAM_BANK_KINDS];

// --------------------
// FUNCTIONS
// --------------------

#include <nitro/code32.h>
asm u32 OsCountZeroBits(u32 bitmap)
{
    // clang-format off
    clz r0, r0 
    bx lr
    // clang-format on
}
#include <nitro/codereset.h>

void OSi_InitVramExclusive(void)
{
    OSi_vramExclusive = 0x0000;

    for (s32 i = 0; i < OS_VRAM_BANK_KINDS; i++)
    {
        OSi_vramLockId[i] = 0;
    }
}

void OSi_UnlockVram(u16 bank, u16 lockId)
{
    u32 workMap;
    s32 zeroBits;

    OSIntrMode enabled = OS_DisableInterrupts();

    workMap = (u32)(bank & OSi_vramExclusive & OS_VRAM_BANK_ID_ALL);
    while (TRUE)
    {
        zeroBits = (s32)(31 - OsCountZeroBits((u32)workMap));
        if (zeroBits < 0)
        {
            break;
        }
        workMap &= ~(0x00000001 << zeroBits);
        if (OSi_vramLockId[zeroBits] == lockId)
        {
            OSi_vramLockId[zeroBits] = 0;
            OSi_vramExclusive &= ~(0x00000001 << zeroBits);
        }
    }

    (IGNORE_RETURN) OS_RestoreInterrupts(enabled);
}

#endif