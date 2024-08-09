#include <nitro.h>

// --------------------
// VARIABLES
// --------------------

static u32 OSi_ConsoleTypeCache = OSi_CONSOLE_NOT_DETECT;

// --------------------
// FUNCTIONS DECLS
// --------------------

u32 OSi_GetDeviceType(void);
BOOL OSi_IsRunOnDebugger(void);

// --------------------
// FUNCTIONS
// --------------------

BOOL OS_IsRunOnEmulator(void)
{
#ifdef SDK_ARM9
    // always false in arm9... in the final rom!!!
    return FALSE;
#endif

#ifdef SDK_ARM7
    // always false in arm7
    return FALSE;
#endif
}

u32 OS_GetConsoleType(void)
{
    OSi_ConsoleTypeCache = OS_CONSOLE_NITRO | OS_CONSOLE_DEV_CARD | OS_CONSOLE_SIZE_4MB;

    return OSi_ConsoleTypeCache;
}