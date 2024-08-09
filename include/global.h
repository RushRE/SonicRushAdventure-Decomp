#ifndef RUSH2_GLOBAL_H
#define RUSH2_GLOBAL_H

#include <nitro.h>
#include <nitro/code32.h>
#include <nnsys.h>
#include <dwc.h>

#include <string.h>
#include <stddef.h>

// types
typedef u16 char16; // typedef u16 as char16 for readability

// helper macros

#ifdef NON_MATCHING
#define NONMATCH_FUNC
#else
#define NONMATCH_FUNC asm
#endif

// simple macro to visualize what "extern" instances are intended and what's temp
#define NOT_DECOMPILED extern

// denote the address isn't decompiled yet
#define RAW_ADDRESS(addr) ((void *)(addr))

// forcefully include a variable via deadstripping a function when compiling a matching rom
#ifndef NON_MATCHING
#define FORCE_INCLUDE_VARIABLE(type, name, value)                                                                                                                                  \
    void __FORCEINCLUDE_##name(void);                                                                                                                                              \
    void __FORCEINCLUDE_##name(void)                                                                                                                                               \
    {                                                                                                                                                                              \
        type name = value;                                                                                                                                                         \
                                                                                                                                                                                   \
        (void)name;                                                                                                                                                                \
    }

#define FORCE_INCLUDE_ARRAY(type, name, arraySize, ...)                                                                                                                                  \
    void __FORCEINCLUDE_##name(void);                                                                                                                                              \
    void __FORCEINCLUDE_##name(void)                                                                                                                                               \
    {                                                                                                                                                                              \
        type name[arraySize] = __VA_ARGS__;                                                                                                                                                         \
                                                                                                                                                                                   \
        (void)name;                                                                                                                                                                \
    }
#else
#define FORCE_INCLUDE_VARIABLE(type, name, value)
#define FORCE_INCLUDE_ARRAY(type, name, arraySize, value)
#endif

// easier to read
#define RUSH_INLINE static inline

// TODO: prolly put these in a neater place
#define ARRAY_COUNT(array) (sizeof(array) / sizeof((array)[0]))

#define FLOAT_TO_FX32(n) ((fx32)((n)*0x1000))

#define SECONDS_TO_FRAMES(n) ((fx32)((n)*60))

#define GX_COLOR_FROM_888(c)    ((c) >> 3)
#define GX_RGB_888(r, g, b)     GX_RGB(GX_COLOR_FROM_888(r), GX_COLOR_FROM_888(g), GX_COLOR_FROM_888(b))
#define GX_RGBA_888(r, g, b, a) GX_RGBA(GX_COLOR_FROM_888(r), GX_COLOR_FROM_888(g), GX_COLOR_FROM_888(b), (a) != 0 ? 1 : 0)

// simple C "static assert"

#define STATIC_ASSERT(COND, MSG) typedef char static_assertion_##MSG[(COND) ? 1 : -1]
// static assert only if we're matching
#ifndef NON_MATCHING
#define STATIC_ASSERT_MATCHING(COND, MSG) typedef char static_assertion_##MSG[(COND) ? 1 : -1]
#endif

#include <config.h>

#endif // RUSH2_GLOBAL_H
