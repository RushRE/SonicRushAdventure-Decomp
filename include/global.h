#ifndef RUSH_GLOBAL_H
#define RUSH_GLOBAL_H

#include <nitro.h>
#include <nitro/code32.h>
#include <nnsys.h>
#include <dwc.h>

#include <string.h>
#include <stddef.h>

// types
typedef u16 char16; // typedef u16 as char16 for readability

// non-matching macros
#include <nonmatching.h>

// unused variables
#define UNUSED(arg) (void)(arg)

// easier to read
#define RUSH_INLINE static inline

// Uncomment this line to enable misc bug fixes across the codebase
// Note: code will become non-matching if uncommented.
// #define RUSH_BUG_FIX

// TODO: probably put these in a neater place
#define ARRAY_COUNT(array) (sizeof(array) / sizeof((array)[0]))

#if defined(SDK_CW) || defined(__MWERKS__)
// Direct array assignment is NOT standard C, and this macro thus requires another implementation outside of MWCC
#define ARRAY_COPY(targetArr, srcArr) targetArr = srcArr
#else
#define ARRAY_COPY(targetArr, srcArr) memcpy(targetArr, srcArr, sizeof(srcArr))
#endif

#define FLOAT_TO_FX32(n)     ((fx32)((n) * FX32_ONE))
#define FX32_TO_FLOAT(value) ((value) / (float)FLOAT_TO_FX32(1.0))

#define SECONDS_TO_FRAMES(n) ((fx32)((n) * 60))

#define GX_COLOR_FROM_888(c)    ((c) >> 3)
#define GX_RGB_888(r, g, b)     GX_RGB(GX_COLOR_FROM_888(r), GX_COLOR_FROM_888(g), GX_COLOR_FROM_888(b))
#define GX_RGBA_888(r, g, b, a) GX_RGBA(GX_COLOR_FROM_888(r), GX_COLOR_FROM_888(g), GX_COLOR_FROM_888(b), (a) != 0 ? 1 : 0)

// simple C "static assert"

#define STATIC_ASSERT(COND, MSG) typedef char static_assertion_##MSG[(COND) ? 1 : -1]

// static assert only if we're matching
#ifndef NON_MATCHING
#define STATIC_ASSERT_MATCHING(COND, MSG) typedef char static_assertion_##MSG[(COND) ? 1 : -1];
#else
#define STATIC_ASSERT_MATCHING(COND, MSG) 
#endif

#include <config.h>

#endif // RUSH_GLOBAL_H
