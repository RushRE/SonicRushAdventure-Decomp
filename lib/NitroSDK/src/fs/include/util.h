#ifndef NITRO_FS_UTIL_H
#define NITRO_FS_UTIL_H

#include <nitro/misc.h>
#include <nitro/types.h>
#include <nitro/fs/file.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// MACROS
// --------------------

#if !defined(SDK_ARM7) || defined(SDK_ARM7FS)
#define FS_IMPLEMENT
#endif

#define BIT_MASK(n)      ((1 << (n)) - 1)
#define ALIGN_MASK(a)    ((a) - 1)
#define ALIGN_BYTE(n, a) (((u32)(n) + ALIGN_MASK(a)) & ~ALIGN_MASK(a))

// --------------------
// INLINE FUNCTIONS
// --------------------

#ifdef FS_IMPLEMENT

static inline void FSi_CutFromListCore(FSFileLink *trg)
{
    FSFile *const pr = trg->prev;
    FSFile *const nx = trg->next;
    if (pr)
        pr->link.next = nx;
    if (nx)
        nx->link.prev = pr;
}

static inline void FSi_CutFromList(FSFile *elem)
{
    FSFileLink *const trg = &elem->link;
    FSi_CutFromListCore(trg);
    trg->next = trg->prev = NULL;
}

static inline void FSi_AppendToList(FSFile *elem, FSFile *list)
{
    FSFileLink *const trg = &elem->link;
    FSi_CutFromListCore(trg);
    {
        while (list->link.next)
            list = list->link.next;
        list->link.next = elem;
        trg->prev       = list;
        trg->next       = NULL;
    }
}

#endif

static inline BOOL FSi_IsSlash(u32 c)
{
    return (c == '/') || (c == '\\');
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_FS_UTIL_H