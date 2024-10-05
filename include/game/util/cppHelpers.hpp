#ifndef RUSH2_CPPHELPERS_HPP
#define RUSH2_CPPHELPERS_HPP

#include <global.h>

// --------------------
// FUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

void CPPHelpers__InitSystem(void);
void CPPHelpers__Func_2085D28(void);
void CPPHelpers__Func_2085D2C(void);
void CPPHelpers__Func_2085D30(void);
void *CPPHelpers__HeapAllocHead_System(u32 size);
void *CPPHelpers__Alloc(u32 size, void *memory);
void CPPHelpers__Free(void *memory);
void CPPHelpers__Func_2085E3C(void);
void CPPHelpers__Func_2085E40(void);
MtxFx33 *CPPHelpers__MtxRotY33(MtxFx33 *mtx, fx32 *sin, fx32 *cos);
MtxFx33 *CPPHelpers__Func_2085E6C(MtxFx33 *mtx);
MtxFx33 *CPPHelpers__Func_2085E70(VecFx32 *vec);
VecFx32 *CPPHelpers__Func_2085E74(VecFx32 *lhs, VecFx32 *rhs);
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
VecFx32 *CPPHelpers__VEC_Add(VecFx32 *lhs, VecFx32 *rhs);
VecFx32 *CPPHelpers__VEC_Subtract(VecFx32 *lhs, VecFx32 *rhs);
void CPPHelpers__VEC_Multiply(VecFx32 *lhs, fx32 value);

#ifdef __cplusplus
}
#endif

#endif // RUSH2_CPPHELPERS_HPP
