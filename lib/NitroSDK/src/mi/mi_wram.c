#include <nitro.h>

#ifdef SDK_ARM9

void MI_SetWramBank(MIWram cnt)
{
    reg_GX_VRAMCNT_WRAM = (u8)cnt; // safe byte access
}

#endif // SDK_ARM9
