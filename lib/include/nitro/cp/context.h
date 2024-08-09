#ifndef NITRO_CP_CONTEXT_H
#define NITRO_CP_CONTEXT_H

#include <nitro/types.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// STRUCTS
// --------------------

typedef struct CPContext
{
    u64 div_numer;
    u64 div_denom;
    u64 sqrt;
    u16 div_mode;
    u16 sqrt_mode;
} CPContext;

// --------------------
// FUNCTIONS
// --------------------

void CP_SaveContext(CPContext *context);
void CPi_RestoreContext(const CPContext *context);

#ifdef __cplusplus
}
#endif

#endif // NITRO_CP_CONTEXT_H
