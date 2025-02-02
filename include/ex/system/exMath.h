#ifndef RUSH_EXMATH_H
#define RUSH_EXMATH_H

#include <global.h>

// --------------------
// STRUCTS
// --------------------

typedef struct Vec2Float_
{
    float x;
    float y;
} Vec2Float;

typedef struct VecFloat_
{
    float x;
    float y;
    float z;
} VecFloat;

// --------------------
// MACROS
// --------------------

#define MULTIPLY_FLOAT_FX(result, value)                                                                                                                                           \
    {                                                                                                                                                                              \
        if ((value) > 0.0f)                                                                                                                                                        \
        {                                                                                                                                                                          \
            (result) = ((float)FLOAT_TO_FX32(1.0) * (value)) + 0.5f;                                                                                                               \
        }                                                                                                                                                                          \
        else                                                                                                                                                                       \
        {                                                                                                                                                                          \
            (result) = ((float)FLOAT_TO_FX32(1.0) * (value)) - 0.5f;                                                                                                               \
        }                                                                                                                                                                          \
    }

#endif // RUSH_EXMATH_H
