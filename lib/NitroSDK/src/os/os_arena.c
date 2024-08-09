#include <nitro.h>

// --------------------
// VARIABLES
// --------------------

extern void SDK_IRQ_STACKSIZE(void);
#define OSi_IRQ_STACKSIZE ((s32)SDK_IRQ_STACKSIZE)
extern void SDK_SYS_STACKSIZE(void);
#define OSi_SYS_STACKSIZE ((s32)SDK_SYS_STACKSIZE)

#ifdef SDK_ARM9
extern void SDK_SECTION_ARENA_DTCM_START(void);
#define OSi_DTCM_ARENA_LO_DEFAULT ((s32)SDK_SECTION_ARENA_DTCM_START)

extern void SDK_SECTION_ARENA_ITCM_START(void);
#define OSi_ITCM_ARENA_LO_DEFAULT ((s32)SDK_SECTION_ARENA_ITCM_START)

extern void SDK_MAIN_ARENA_LO(void);
#define OSi_MAIN_ARENA_LO_DEFAULT ((s32)SDK_MAIN_ARENA_LO)
#else
extern void SDK_SUBPRIV_ARENA_LO(void);
#define OSi_SUBPRIV_ARENA_LO_DEFAULT ((s32)SDK_SUBPRIV_ARENA_LO)

extern void SDK_WRAM_ARENA_LO(void);
#define OSi_WRAM_ARENA_LO_DEFAULT    ((s32)SDK_WRAM_ARENA_LO)

#define OSi_MAIN_SUBPRIV_ARENA_LO_DEFAULT ((u32)SDK_SUBPRIV_ARENA_LO)
#define OSi_MAIN_SUBPRIV_ARENA_HI_DEFAULT HW_MAIN_MEM_SUB_END

extern void SDK_WRAM_ARENA_LO(void);
#define OSi_WRAM_SUB_ARENA_LO_DEFAULT     ((u32)SDK_WRAM_ARENA_LO)
#define OSi_WRAM_SUB_ARENA_HI_DEFAULT     HW_WRAM_END

#define OSi_WRAM_SUBPRIV_ARENA_LO_DEFAULT HW_PRV_WRAM
#define OSi_WRAM_SUBPRIV_ARENA_HI_DEFAULT HW_PRV_WRAM_END
#endif // SDK_ARM9

static BOOL OSi_Initialized = FALSE;
BOOL OSi_MainExArenaEnabled = FALSE;

// --------------------
// FUNCTIONS
// --------------------

void OS_InitArena(void)
{
#ifdef SDK_ARM9
    // don't init arena if it's already initialized
    if (OSi_Initialized)
        return;

    OSi_Initialized = TRUE;

    OS_InitArenaHiAndLo(OS_ARENA_MAIN);

    // handled in OS_InitArenaEx
    OS_SetArenaLo(OS_ARENA_MAINEX, (void *)0);
    OS_SetArenaHi(OS_ARENA_MAINEX, (void *)0);

    OS_InitArenaHiAndLo(OS_ARENA_ITCM);
    OS_InitArenaHiAndLo(OS_ARENA_DTCM);
    OS_InitArenaHiAndLo(OS_ARENA_SHARED);
    OS_InitArenaHiAndLo(OS_ARENA_WRAM_MAIN);
#endif

#ifdef SDK_ARM7
    // don't init arena if it's already initialized
    if (OSi_Initialized)
        return;

    OSi_Initialized = TRUE;

    OS_InitArenaHiAndLo(OS_ARENA_MAIN_SUBPRIV);
    OS_InitArenaHiAndLo(OS_ARENA_WRAM_SUB);
    OS_InitArenaHiAndLo(OS_ARENA_WRAM_SUBPRIV);
#endif
}

#ifdef SDK_ARM9
void OS_InitArenaEx(void)
{
    OS_InitArenaHiAndLo(OS_ARENA_MAINEX);

    if (!OSi_MainExArenaEnabled || ((OS_GetConsoleType() & OS_CONSOLE_SIZE_MASK) == OS_CONSOLE_SIZE_4MB))
    {
        // init MainRam arena
        OS_SetProtectionRegion(1, HW_MAIN_MEM_MAIN, 4MB);

        // init exclusive area for ARM7
        OS_SetProtectionRegion(2, HW_MAIN_MEM_MAIN_END, 128KB);
    }
}
#endif

void *OS_GetArenaHi(OSArenaId id)
{
    return OSi_GetArenaInfo().hi[id];
}

void *OS_GetArenaLo(OSArenaId id)
{
    return OSi_GetArenaInfo().lo[id];
}

void *OS_GetInitArenaHi(OSArenaId id)
{
    switch (id)
    {
#ifdef SDK_ARM9
        case OS_ARENA_MAIN:
            return (void *)OSi_MAIN_ARENA_HI_DEFAULT;

        case OS_ARENA_MAINEX:
            if (!OSi_MainExArenaEnabled || ((OS_GetConsoleType() & OS_CONSOLE_SIZE_MASK) == OS_CONSOLE_SIZE_4MB))
                return (void *)0;
            else
                return (void *)OSi_MAINEX_ARENA_HI_DEFAULT;

        case OS_ARENA_ITCM:
            return (void *)HW_ITCM_ARENA_HI_DEFAULT;

        case OS_ARENA_DTCM: {
            u32 irqStackLo;
            u32 sysStackLo;

            irqStackLo = (u32)HW_DTCM_IRQ_STACK_END - OSi_IRQ_STACKSIZE;

            if (OSi_SYS_STACKSIZE == 0)
            {
                sysStackLo = HW_DTCM;
                if (sysStackLo < OSi_DTCM_ARENA_LO_DEFAULT)
                    sysStackLo = OSi_DTCM_ARENA_LO_DEFAULT;
            }
            else if (OSi_SYS_STACKSIZE < 0)
            {
                sysStackLo = OSi_DTCM_ARENA_LO_DEFAULT - OSi_SYS_STACKSIZE;
            }
            else
            {
                sysStackLo = irqStackLo - OSi_SYS_STACKSIZE;
            }

            return (void *)sysStackLo;
        }

        case OS_ARENA_SHARED:
            return (void *)HW_SHARED_ARENA_HI_DEFAULT;

        case OS_ARENA_WRAM_MAIN:
            return (void *)(void *)OSi_WRAM_MAIN_ARENA_HI_DEFAULT;
#else
        case OS_ARENA_MAIN_SUBPRIV:
            return (void *)OSi_MAIN_SUBPRIV_ARENA_HI_DEFAULT;

        case OS_ARENA_WRAM_SUB:
            return (void *)OSi_WRAM_SUB_ARENA_HI_DEFAULT;

        case OS_ARENA_WRAM_SUBPRIV: {
            u32 irqStackLo;
            u32 sysStackLo;

            irqStackLo = (u32)HW_PRV_WRAM_IRQ_STACK_END - OSi_IRQ_STACKSIZE;
            sysStackLo = (u32)HW_PRV_WRAM;

            if ((u32)SDK_WRAM_ARENA_LO > (u32)HW_PRV_WRAM)
            {
                sysStackLo = (u32)SDK_WRAM_ARENA_LO;
            }

            if (OSi_SYS_STACKSIZE == 0)
            {
                // Nothin'
            }
            else if (OSi_SYS_STACKSIZE < 0)
            {
                sysStackLo -= OSi_SYS_STACKSIZE;
            }
            else
            {
                sysStackLo = irqStackLo - OSi_SYS_STACKSIZE;
            }

            return (void *)sysStackLo;
        }
#endif
        default:
            break;
    }

    return NULL;
}

void *OS_GetInitArenaLo(OSArenaId id)
{
    switch (id)
    {
#ifdef SDK_ARM9
        case OS_ARENA_MAIN:
            return (void *)OSi_MAIN_ARENA_LO_DEFAULT;

        case OS_ARENA_MAINEX:
            if (!OSi_MainExArenaEnabled || ((OS_GetConsoleType() & OS_CONSOLE_SIZE_MASK) == OS_CONSOLE_SIZE_4MB))
                return (void *)0;
            else
                return (void *)OSi_MAINEX_ARENA_LO_DEFAULT;

        case OS_ARENA_ITCM:
            return (void *)OSi_ITCM_ARENA_LO_DEFAULT;

        case OS_ARENA_DTCM:
            return (void *)OSi_DTCM_ARENA_LO_DEFAULT;

        case OS_ARENA_SHARED:
            return (void *)HW_SHARED_ARENA_LO_DEFAULT;

        case OS_ARENA_WRAM_MAIN:
            return (void *)OSi_WRAM_MAIN_ARENA_LO_DEFAULT;
#else
        case OS_ARENA_MAIN_SUBPRIV:
            return (void *)OSi_MAIN_SUBPRIV_ARENA_LO_DEFAULT;

        case OS_ARENA_WRAM_SUB: {
            u32 wramSubLo = OSi_WRAM_SUB_ARENA_LO_DEFAULT;
            if ((u32)HW_WRAM_END < (u32)wramSubLo)
            {
                wramSubLo = (u32)HW_WRAM_END;
            }
            return (void *)wramSubLo;
        }

        case OS_ARENA_WRAM_SUBPRIV: {
            u32 privWramLo = OSi_WRAM_SUBPRIV_ARENA_LO_DEFAULT;
            if ((u32)SDK_WRAM_ARENA_LO > (u32)privWramLo)
            {
                privWramLo = (u32)SDK_WRAM_ARENA_LO;
            }
            return (void *)privWramLo;
        }
#endif
        default:
            break;
    }

    return NULL;
}

void OS_SetArenaHi(OSArenaId id, void *newHi)
{
    OSi_GetArenaInfo().hi[id] = newHi;
}

void OS_SetArenaLo(OSArenaId id, void *newLo)
{
    OSi_GetArenaInfo().lo[id] = newLo;
}

void *OS_AllocFromArenaLo(OSArenaId id, u32 size, u32 align)
{
    void *ptr;
    u8 *arenaLo;

    ptr = OS_GetArenaLo(id);
    if (!ptr)
    {
        return NULL;
    }

    arenaLo = ptr = (void *)OSi_ROUND(ptr, align);
    arenaLo += size;
    arenaLo = (u8 *)OSi_ROUND(arenaLo, align);

    if (arenaLo > OS_GetArenaHi(id))
    {
        return NULL;
    }

    OS_SetArenaLo(id, arenaLo);

    return ptr;
}

void *OS_AllocFromArenaHi(OSArenaId id, u32 size, u32 align)
{
    void *ptr;
    u8 *arenaHi;

    arenaHi = OS_GetArenaHi(id);
    if (!arenaHi)
    {
        return NULL;
    }

    arenaHi = (u8 *)OSi_TRUNC(arenaHi, align);
    arenaHi -= size;
    arenaHi = ptr = (void *)OSi_TRUNC(arenaHi, align);

    if (arenaHi < OS_GetArenaLo(id))
    {
        return NULL;
    }

    OS_SetArenaHi(id, arenaHi);

    return ptr;
}