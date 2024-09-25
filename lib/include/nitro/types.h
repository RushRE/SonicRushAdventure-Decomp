#ifndef NITRO_TYPES_H
#define NITRO_TYPES_H

#ifndef SDK_ASM
typedef unsigned char u8;
typedef unsigned short int u16;
typedef unsigned long u32;

typedef signed char s8;
typedef signed short int s16;
typedef signed long s32;

typedef unsigned long long int u64;
typedef signed long long int s64;

typedef volatile u8 vu8;
typedef volatile u16 vu16;
typedef volatile u32 vu32;
typedef volatile u64 vu64;

typedef volatile s8 vs8;
typedef volatile s16 vs16;
typedef volatile s32 vs32;
typedef volatile s64 vs64;

typedef float f32;
typedef volatile f32 vf32;

typedef u8 REGType8;
typedef u16 REGType16;
typedef u32 REGType32;
typedef u64 REGType64;

typedef vu8 REGType8v;
typedef vu16 REGType16v;
typedef vu32 REGType32v;
typedef vu64 REGType64v;

typedef int BOOL;

// typedef unsigned int size_t;
#endif

#define TRUE  1
#define FALSE 0

#ifndef SDK_ASM
#ifndef NULL
#ifdef __cplusplus
#define NULL 0
#else // __cplusplus
#define NULL ((void *)0)
#endif // __cplusplus
#endif

#define SDK_FORCE_EXPORT __declspec(force_export)

#define SDK_INLINE static inline

#if defined(SDK_CW) || defined(__MWERKS__)
#ifndef ATTRIBUTE_ALIGN
#define ATTRIBUTE_ALIGN(num) __attribute__((aligned(num)))
#endif
#endif

// Weak symbol
#if defined(SDK_CW) || defined(__MWERKS__)
#define SDK_WEAK_SYMBOL __declspec(weak)
#else
#define SDK_WEAK_SYMBOL
#endif

#endif // SDK_ASM

#endif // NITRO_TYPES_H
