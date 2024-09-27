#ifndef NITRO_FS_MW_DTOR_H
#define NITRO_FS_MW_DTOR_H

#include <nitro/misc.h>
#include <nitro/types.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// TYPES
// --------------------

typedef void (*MWI_DESTRUCTOR_FUNC)(void *);

// --------------------
// STRUCTS
// --------------------

typedef struct MWiDestructorChain
{
    struct MWiDestructorChain *next;
    MWI_DESTRUCTOR_FUNC dtor;
    void *obj;
} MWiDestructorChain;

// --------------------
// VARIABLES
// --------------------

extern MWiDestructorChain *__global_destructor_chain;

// --------------------
// FUNCTIONS
// --------------------

void __register_global_object(void *obj, MWI_DESTRUCTOR_FUNC dtor, MWiDestructorChain *chain);

#ifdef __cplusplus
}
#endif

#endif // NITRO_FS_MW_DTOR_H