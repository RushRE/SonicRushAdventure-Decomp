#ifndef NITRO_LIBRARY_CTRDG_WORK_H
#define NITRO_LIBRARY_CTRDG_WORK_H

#include <nitro/types.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// STRUCTS
// --------------------

typedef struct CTRDGWork
{
    vu16 subpInitialized;
    u16 lockID;
} CTRDGWork;

#ifdef __cplusplus
}
#endif

#endif // NITRO_LIBRARY_CTRDG_WORK_H