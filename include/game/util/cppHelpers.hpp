#ifndef RUSH_CPPHELPERS_HPP
#define RUSH_CPPHELPERS_HPP

#include <global.h>

// --------------------
// CFUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

void CPPHelpers__InitSystem(void);

#ifdef __cplusplus
}
#endif

#ifdef __cplusplus

// --------------------
// STRUCTS
// --------------------

struct CVector3
{
    fx32 x;
    fx32 y;
    fx32 z;
};

union CMatrix33
{
    struct
    {
        fx32 _00, _01, _02;
        fx32 _10, _11, _12;
        fx32 _20, _21, _22;
    };
    fx32 m[3][3];
    fx32 a[9];
};

// --------------------
// FUNCTIONS
// --------------------

void *operator new(size_t size);
void *operator new(size_t, void *memory);
void operator delete(void *memory);

// "Allocate" memory where the address is already known
#define PlacementNew(memory, type) new (memory) type

VecFx32 &operator+(VecFx32 &lhs, VecFx32 &rhs);
VecFx32 &operator-(VecFx32 &lhs, VecFx32 &rhs);
void operator*=(VecFx32 &lhs, fx32 value);

// Under-documented functions
// these functions are likely using incorrect signatures or names, so lots of research needs to be done so that no functions with "CPPHelpers" prefix exist!
extern "C"
{

void CPPHelpers__Func_2085D28(void);
void CPPHelpers__Func_2085D2C(void);
void CPPHelpers__Func_2085D30(void);
void CPPHelpers__Func_2085E3C(void);
void CPPHelpers__Func_2085E40(MtxFx33 *mtx);
MtxFx33 *CPPHelpers__MtxRotY33(MtxFx33 *mtx, fx32 *sin, fx32 *cos);
MtxFx33 *CPPHelpers__Func_2085E6C(MtxFx33 *mtx);
MtxFx33 *CPPHelpers__Func_2085E70(MtxFx33 *mtx);
VecFx32 *CPPHelpers__Func_2085E74(VecFx32 *lhs, MtxFx33 *rhs);
void CPPHelpers__MtxCopy33To43(MtxFx33 *src, MtxFx43 *dst);
void CPPHelpers__VEC_MultiplyMtx33(VecFx32 *vec, MtxFx33 *mtx);
void CPPHelpers__Func_2085EE0(void);
void CPPHelpers__Func_2085EE4(void);
VecFx32 *CPPHelpers__Func_2085EE8(VecFx32 *vec);
VecFx32 *CPPHelpers__VEC_Set(VecFx32 *vec, fx32 x, fx32 y, fx32 z);
VecFx32 *CPPHelpers__VEC_SetFromVec(VecFx32 *lhs, VecFx32 *rhs);
VecFx32 *CPPHelpers__VEC_SetFromVec_2(VecFx32 *lhs, VecFx32 *rhs);
VecFx32 *CPPHelpers__VEC_Normalize(VecFx32 *vec);
s32 CPPHelpers__VEC_Magnitude(s32 *magnitude, VecFx32 *vec);
VecFx32 *CPPHelpers__Func_2085F98(VecFx32 *vec);
VecFx32 *CPPHelpers__Func_2085F9C(VecFx32 *vec);
VecFx32 *CPPHelpers__Func_2085FA0(VecFx32 *vec);
VecFx32 *CPPHelpers__Func_2085FA4(VecFx32 *vec);
VecFx32 *CPPHelpers__Func_2085FA8(VecFx32 *lhs, VecFx32 *rhs);
VecFx32 *CPPHelpers__VEC_Copy_Alt(VecFx32 *lhs, VecFx32 *rhs);
VecFx32 *CPPHelpers__VEC_Add_Alt(VecFx32 *lhs, VecFx32 *rhs);
VecFx32 *CPPHelpers__VEC_Multiply_Alt(VecFx32 *lhs, fx32 value);
void CPPHelpers__VEC_Add_Alt2(VecFx32 *lhs, VecFx32 *rhs, VecFx32 *dest);
void CPPHelpers__VEC_Subtract_Alt(VecFx32 *lhs, VecFx32 *rhs, VecFx32 *dest);
void CPPHelpers__VEC_Copy(VecFx32 *lhs, VecFx32 *rhs);
VecFx32 *CPPHelpers__VEC_Add(const VecFx32 *lhs, const VecFx32 *rhs);
VecFx32 *CPPHelpers__VEC_Subtract(VecFx32 *lhs, VecFx32 *rhs);
void CPPHelpers__VEC_Multiply(VecFx32 *lhs, fx32 value);
}

#endif

#endif // RUSH_CPPHELPERS_HPP
