#include <game/util/cppHelpers.hpp>
#include <game/system/allocator.h>
#include <game/math/mtMath.h>

// --------------------
// VARIABLES
// --------------------

extern void *heapITCM_EndAddr;
extern void *heapUser_EndAddr;
extern void *heapDTCM_EndAddr;
extern void *heapSystem_StartAddr;
extern void *heapSystem_EndAddr;
extern void *heapUser_StartAddr;
extern void *heapITCM_StartAddr;
extern void *heapDTCM_StartAddr;

// --------------------
// FUNCTIONS
// --------------------

void CPPHelpers__InitSystem(void)
{
    CPPHelpers__Func_2085D2C();
    CPPHelpers__Func_2085EE4();
    CPPHelpers__Func_2085E3C();
    CPPHelpers__Func_2085D30();
    CPPHelpers__Func_2085D28();
    CPPHelpers__Func_2085EE0();
}

void CPPHelpers__Func_2085D28(void)
{
    // nothing?
}

void CPPHelpers__Func_2085D2C(void)
{
    // nothing?
}

void CPPHelpers__Func_2085D30(void)
{
    // nothing?
}

void *operator new(size_t size)
{
    return HeapAllocHead(HEAP_SYSTEM, size);
}

void *operator new(size_t, void *memory)
{
    return memory;
}

void operator delete(void *memory)
{
    u32 heap;

    if (memory >= heapSystem_StartAddr && memory < heapSystem_EndAddr)
    {
        heap = 0;
    }
    else if (memory >= heapUser_StartAddr && memory < heapUser_EndAddr)
    {
        heap = 1;
    }
    else if (memory >= heapDTCM_StartAddr && memory < heapDTCM_EndAddr)
    {
        heap = 3;
    }
    else if (memory >= heapITCM_StartAddr && memory < heapITCM_EndAddr)
    {
        heap = 2;
    }
    else
    {
        heap = 0;
    }

    switch (heap)
    {
        case 0:
            HeapFree(HEAP_SYSTEM, memory);
            break;

        case 1:
            HeapFree(HEAP_USER, memory);
            break;

        case 3:
            HeapFree(HEAP_DTCM, memory);
            break;

        case 2:
            HeapFree(HEAP_ITCM, memory);
            break;
    }
}

void CPPHelpers__Func_2085E3C(void)
{
    // nothing?
}

void CPPHelpers__Func_2085E40(MtxFx33 *mtx)
{
    // nothing?
}

MtxFx33 *CPPHelpers__MtxRotY33(MtxFx33 *mtx, fx32 *sin, fx32 *cos)
{
    MTX_RotY33(CPPHelpers__Func_2085E6C(mtx), *sin, *cos);
    return mtx;
}

MtxFx33 *CPPHelpers__Func_2085E6C(MtxFx33 *mtx)
{
    return mtx;
}

MtxFx33 *CPPHelpers__Func_2085E70(MtxFx33 *mtx)
{
    return mtx;
}

VecFx32 *CPPHelpers__Func_2085E74(VecFx32 *lhs, MtxFx33 *rhs)
{
    CPPHelpers__VEC_MultiplyMtx33(CPPHelpers__Func_2085F98(lhs), CPPHelpers__Func_2085E70(rhs));
    return lhs;
}

void CPPHelpers__MtxCopy33To43(MtxFx33 *src, MtxFx43 *dst)
{
    MTX_Copy33To43(src, dst);
}

void CPPHelpers__VEC_MultiplyMtx33(VecFx32 *vec, MtxFx33 *mtx)
{
    MtxFx43 mtx43;

    CPPHelpers__MtxCopy33To43(mtx, &mtx43);
    MTX_MultVec43(vec, &mtx43, vec);
}

void CPPHelpers__Func_2085EE0(void)
{
    // nothing?
}

void CPPHelpers__Func_2085EE4(void)
{
    // nothing?
}

// TODO: figure what operator/function this _really_ is
VecFx32 *CPPHelpers__Func_2085EE8(VecFx32 *vec)
{
    return vec;
}

// TODO: figure what operator/function this _really_ is
VecFx32 *CPPHelpers__VEC_Set(VecFx32 *vec, fx32 x, fx32 y, fx32 z)
{
    VecFx32 *vecPtr = CPPHelpers__Func_2085FA0(vec);

    vecPtr->x = x;
    vecPtr->y = y;
    vecPtr->z = z;

    return vec;
}

// TODO: figure what operator/function this _really_ is
VecFx32 *CPPHelpers__VEC_SetFromVec(VecFx32 *lhs, VecFx32 *rhs)
{
    fx32 x = rhs->x;
    fx32 y = rhs->y;
    fx32 z = rhs->z;

    VecFx32 *vecPtr = CPPHelpers__Func_2085FA0(lhs);

    vecPtr->x = x;
    vecPtr->y = y;
    vecPtr->z = z;

    return lhs;
}

// TODO: figure what operator/function this _really_ is
VecFx32 *CPPHelpers__VEC_SetFromVec_2(VecFx32 *lhs, VecFx32 *rhs)
{
    fx32 x = rhs->x;
    fx32 y = rhs->y;
    fx32 z = rhs->z;

    VecFx32 *vecPtr = CPPHelpers__Func_2085FA0(lhs);

    vecPtr->x = x;
    vecPtr->y = y;
    vecPtr->z = z;

    return lhs;
}

// TODO: figure what operator/function this _really_ is
VecFx32 *CPPHelpers__VEC_Normalize(VecFx32 *vec)
{
    VecFx32 *v    = CPPHelpers__Func_2085FA0(vec);
    VecFx32 *dest = CPPHelpers__Func_2085FA0(vec);

    VEC_Normalize(v, dest);

    return vec;
}

// TODO: figure what operator/function this _really_ is
void CPPHelpers__VEC_Magnitude(s32 *magnitude, VecFx32 *vec)
{
    VecFx32 *v = CPPHelpers__Func_2085FA4(vec);

    *magnitude = VEC_Mag(v);
}

// TODO: figure what operator this is
VecFx32 *CPPHelpers__Func_2085F98(VecFx32 *vec)
{
    return vec;
}

// TODO: figure what operator this is
VecFx32 *CPPHelpers__Func_2085F9C(VecFx32 *vec)
{
    return vec;
}

// TODO: figure what operator this is
VecFx32 *CPPHelpers__Func_2085FA0(VecFx32 *vec)
{
    return vec;
}

// TODO: figure what operator this is
VecFx32 *CPPHelpers__Func_2085FA4(VecFx32 *vec)
{
    return vec;
}

// TODO: figure what operator this is
VecFx32 *CPPHelpers__Func_2085FA8(VecFx32 *lhs, VecFx32 *rhs)
{
    CPPHelpers__VEC_Copy(CPPHelpers__Func_2085F98(lhs), CPPHelpers__Func_2085F9C(rhs));
    return lhs;
}

// TODO: figure what operator this is
VecFx32 *CPPHelpers__VEC_Copy_Alt(VecFx32 *lhs, VecFx32 *rhs)
{
    CPPHelpers__VEC_Copy(CPPHelpers__Func_2085F98(lhs), rhs);
    return lhs;
}

// TODO: figure what operator this is
VecFx32 *CPPHelpers__VEC_Add_Alt(VecFx32 *lhs, VecFx32 *rhs)
{
    CPPHelpers__VEC_Add(CPPHelpers__Func_2085F98(lhs), CPPHelpers__Func_2085F9C(rhs));
    return lhs;
}

// TODO: figure what operator this is
VecFx32 *CPPHelpers__VEC_Multiply_Alt(VecFx32 *lhs, fx32 value)
{
    CPPHelpers__VEC_Multiply(CPPHelpers__Func_2085F98(lhs), value);
    return lhs;
}

// TODO: figure what operator this is
void CPPHelpers__VEC_Add_Alt2(VecFx32 *lhs, VecFx32 *rhs, VecFx32 *dest)
{
    CPPHelpers__VEC_SetFromVec(lhs, rhs);
    CPPHelpers__VEC_Add(CPPHelpers__Func_2085F98(lhs), dest);
}

// TODO: figure what operator this is
void CPPHelpers__VEC_Subtract_Alt(VecFx32 *lhs, VecFx32 *rhs, VecFx32 *dest)
{
    CPPHelpers__VEC_SetFromVec(lhs, rhs);
    CPPHelpers__VEC_Subtract(CPPHelpers__Func_2085F98(lhs), CPPHelpers__Func_2085F9C(dest));
}

// TODO: figure what operator this is
void CPPHelpers__VEC_Copy(VecFx32 *lhs, VecFx32 *rhs)
{
    VEC_Set(lhs, rhs->x, rhs->y, rhs->z);
}

VecFx32 *CPPHelpers__VEC_Add(const VecFx32 *lhs, const VecFx32 *rhs)
{
    VEC_Add(lhs, rhs, (VecFx32 *)lhs);
    return (VecFx32 *)lhs;
}

// TODO: replace CPPHelpers__VEC_Add with this
VecFx32 &operator+(VecFx32 &lhs, VecFx32 &rhs)
{
    VEC_Add(&lhs, &rhs, &lhs);
    return lhs;
}

VecFx32 *CPPHelpers__VEC_Subtract(VecFx32 *lhs, VecFx32 *rhs)
{
    VEC_Subtract(lhs, rhs, lhs);
    return lhs;
}

// TODO: replace CPPHelpers__VEC_Subtract with this
VecFx32 &operator-(VecFx32 &lhs, VecFx32 &rhs)
{
    VEC_Subtract(&lhs, &rhs, &lhs);
    return lhs;
}

void CPPHelpers__VEC_Multiply(VecFx32 *lhs, fx32 value)
{
    lhs->x = MultiplyFX(lhs->x, value);
    lhs->y = MultiplyFX(lhs->y, value);
    lhs->z = MultiplyFX(lhs->z, value);
}

// TODO: replace CPPHelpers__VEC_Multiply with this
void operator*=(VecFx32 &lhs, fx32 value)
{
    lhs.x = MultiplyFX(lhs.x, value);
    lhs.y = MultiplyFX(lhs.y, value);
    lhs.z = MultiplyFX(lhs.z, value);
}
