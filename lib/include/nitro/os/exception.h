#ifndef NITRO_OS_EXCEPTION_H
#define NITRO_OS_EXCEPTION_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// TYPES
// --------------------

typedef void (*OSExceptionHandler)(u32, void *);

// --------------------
// FUNCTIONS
// --------------------

void OS_InitException(void);

#ifdef __cplusplus
}
#endif

#endif // NITRO_OS_EXCEPTION_H
