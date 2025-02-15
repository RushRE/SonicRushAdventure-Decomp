#include <game/math/cppMath.hpp>
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
// FUNCTION DECLS
// --------------------

static void Unknown2085D08_InitUnknown5(void);
static void Unknown2085D08_InitUnknown1(void);
static void Unknown2085D08_InitUnknown4(void);
static void Unknown2085D08_InitUnknown3(void);

static void Unknown2085D08_InitUnknown6(void);
static void Unknown2085D08_InitUnknown2(void);

// --------------------
// FUNCTIONS
// --------------------

void InitUnknown2085D08System(void)
{
    Unknown2085D08_InitUnknown1();
    Unknown2085D08_InitUnknown2();
    Unknown2085D08_InitUnknown3();
    Unknown2085D08_InitUnknown4();
    Unknown2085D08_InitUnknown5();
    Unknown2085D08_InitUnknown6();
}

void Unknown2085D08_InitUnknown5(void)
{
    // Nothing.
}

void Unknown2085D08_InitUnknown1(void)
{
    // Nothing.
}

void Unknown2085D08_InitUnknown4(void)
{
    // Nothing.
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

void Unknown2085D08_InitUnknown3(void)
{
    // Nothing.
}

CMatrix33::CMatrix33()
{
    // do nothing.
}

CMatrix33 *CMatrix33::RotateY(fx32 *sin, fx32 *cos)
{
    MTX_RotY33(this->ToMtxFx33(), *sin, *cos);
    return this;
}

MtxFx33 *CMatrix33::ToMtxFx33() const
{
    return (MtxFx33 *)this;
}

const MtxFx33 *CMatrix33::ToConstMtxFx33() const
{
    return (const MtxFx33 *)this;
}

CVector3 *CMatrix33::MultiplyVector(CVector3 &lhs, const CMatrix33 *rhs)
{
    CMatrix33::MtxFx33_MultiplyVec(lhs.ToVecFx32Ref(), rhs->ToConstMtxFx33());
    return &lhs;
}

// TODO: figure what operator/function this _really_ is
// guess: CMatrix33::CopyTo43()
void CMatrix33::MtxFx33_Copy33To43(const MtxFx33 *src, MtxFx43 *dst)
{
    MTX_Copy33To43(src, dst);
}

// TODO: figure what operator/function this _really_ is
// guess: CMatrix33::MultiplyVector(VecFx32 vec, MtxFx33)
void CMatrix33::MtxFx33_MultiplyVec(VecFx32 &vec, const MtxFx33 *mtx)
{
    MtxFx43 mtx43;

    CMatrix33::MtxFx33_Copy33To43(mtx, &mtx43);
    MTX_MultVec43(&vec, &mtx43, &vec);
}

void Unknown2085D08_InitUnknown6(void)
{
    // Nothing.
}

void Unknown2085D08_InitUnknown2(void)
{
    // Nothing.
}

CVector3::CVector3()
{
    // do nothing.
}

// TODO: figure what operator/function this _really_ is
CVector3::CVector3(fx32 x, fx32 y, fx32 z)
{
    VecFx32 *vecPtr = this->ToVecFx32Ptr();

    vecPtr->x = x;
    vecPtr->y = y;
    vecPtr->z = z;
}

CVector3::CVector3(const CVector3 &other)
{
    fx32 x = other.x;
    fx32 y = other.y;
    fx32 z = other.z;

    VecFx32 *vecPtr = this->ToVecFx32Ptr();

    vecPtr->x = x;
    vecPtr->y = y;
    vecPtr->z = z;
}

CVector3::CVector3(const VecFx32 &other)
{
    fx32 x = other.x;
    fx32 y = other.y;
    fx32 z = other.z;

    VecFx32 *vecPtr = this->ToVecFx32Ptr();

    vecPtr->x = x;
    vecPtr->y = y;
    vecPtr->z = z;
}

CVector3 &CVector3::Normalize()
{
    VecFx32 *v    = this->ToVecFx32Ptr();
    VecFx32 *dest = this->ToVecFx32Ptr();

    VEC_Normalize(v, dest);

    return *this;
}

void CVector3::Magnitude(s32 *magnitude, const CVector3 *vec)
{
    const VecFx32 *v = vec->ToConstVecFx32Ptr();

    *magnitude = VEC_Mag(v);
}

VecFx32 &CVector3::ToVecFx32Ref() const
{
    return (VecFx32 &)*this;
}

const VecFx32 &CVector3::ToConstVecFx32Ref() const
{
    return (const VecFx32 &)*this;
}

VecFx32 *CVector3::ToVecFx32Ptr() const
{
    return (VecFx32 *)this;
}

const VecFx32 *CVector3::ToConstVecFx32Ptr() const
{
    return (const VecFx32 *)this;
}

const CVector3& CVector3::operator=(const CVector3 &other)
{
    CVector3::VecFx32_Set(this->ToVecFx32Ref(), other.ToConstVecFx32Ref());
    return *this;
}

const CVector3& CVector3::operator=(const VecFx32 &other)
{
    CVector3::VecFx32_Set(this->ToVecFx32Ref(), other);
    return *this;
}

CVector3& CVector3::operator+=(const CVector3& rhs)
{
    CVector3::VecFx32_Add(this->ToVecFx32Ref(), rhs.ToConstVecFx32Ref());
    return *this;
}

CVector3& CVector3::operator*=(const fx32 rhs)
{
    CVector3::VecFx32_Multiply(this->ToVecFx32Ref(), rhs);
    return *this;
}

CVector3 operator+(const CVector3& lhs, const VecFx32& rhs)
{    
    CVector3 result(lhs);
    
    CVector3::VecFx32_Add(result.ToVecFx32Ref(), rhs);
    
    return result;
}

CVector3 operator-(const CVector3& lhs, const CVector3& rhs)
{    
    CVector3 result(lhs);
    
    CVector3::VecFx32_Subtract(result.ToVecFx32Ref(), rhs.ToConstVecFx32Ref());
    
    return result;
}

VecFx32 &CVector3::VecFx32_Set(VecFx32 &lhs, const VecFx32 &rhs)
{
    VEC_Set(&lhs, rhs.x, rhs.y, rhs.z);
    return lhs;
}

VecFx32 &CVector3::VecFx32_Add(VecFx32 &lhs, const VecFx32 &rhs)
{
    VEC_Add(&lhs, &rhs, &lhs);
    return lhs;
}

VecFx32 &CVector3::VecFx32_Subtract(VecFx32 &lhs, const VecFx32 &rhs)
{
    VEC_Subtract(&lhs, &rhs, &lhs);
    return lhs;
}

VecFx32 &CVector3::VecFx32_Multiply(VecFx32 &lhs, fx32 value)
{
    lhs.x = MultiplyFX(lhs.x, value);
    lhs.y = MultiplyFX(lhs.y, value);
    lhs.z = MultiplyFX(lhs.z, value);
    return lhs;
}
