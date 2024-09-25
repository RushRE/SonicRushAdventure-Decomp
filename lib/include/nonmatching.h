#ifndef SDK_NONMATCHING_H
#define SDK_NONMATCHING_H

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

#endif // ! SDK_NONMATCHING_H