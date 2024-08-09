#ifndef NITRO_OS_PRINTF_H
#define NITRO_OS_PRINTF_H

#include <stdarg.h>
#include <stddef.h>
#include <nitro/std/string.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

int OS_SPrintf(char *dst, const char *fmt, ...);
int OS_VSPrintf(char *dst, const char *fmt, va_list vlist);
int OS_SNPrintf(char *dst, size_t len, const char *fmt, ...);
int OS_VSNPrintf(char *dst, size_t len, const char *fmt, va_list vlist);

// --------------------
// MACROS
// --------------------

#define OS_Panic(...) OS_Terminate()
#define OS_Printf(...)

#ifdef __cplusplus
}
#endif

#endif // NITRO_OS_PRINTF_H
