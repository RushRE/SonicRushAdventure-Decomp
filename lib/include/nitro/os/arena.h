#ifndef NITRO_OS_ARENA_H
#define NITRO_OS_ARENA_H

#include <nitro/os/common/arena_shared.h>
#include <nitro/types.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// FUNCTIONS
// --------------------

void OS_InitArena(void);
void OS_InitArenaEx(void);
void *OS_GetArenaHi(OSArenaId id);
void *OS_GetArenaLo(OSArenaId id);
void *OS_GetInitArenaHi(OSArenaId id);
void *OS_GetInitArenaLo(OSArenaId id);
void OS_SetArenaHi(OSArenaId id, void *newHi);
void OS_SetArenaLo(OSArenaId id, void *newLo);

void *OS_AllocFromArenaLo(OSArenaId id, u32 size, u32 align);
void *OS_AllocFromArenaHi(OSArenaId id, u32 size, u32 align);

// --------------------
// INLINE FUNCTIONS
// --------------------

SDK_INLINE void OS_InitArenaHi(OSArenaId id)
{
    OS_SetArenaHi(id, OS_GetInitArenaHi(id));
}

SDK_INLINE void OS_InitArenaLo(OSArenaId id)
{
    OS_SetArenaLo(id, OS_GetInitArenaLo(id));
}

SDK_INLINE void OS_InitArenaHiAndLo(OSArenaId id)
{
    (void)OS_InitArenaHi(id);
    (void)OS_InitArenaLo(id);
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_OS_ARENA_H
