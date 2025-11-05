#ifndef RUSH_CPPMATH_HPP
#define RUSH_CPPMATH_HPP

#include <game/math/mtMath.h>

// --------------------
// CFUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

void InitUnknown2085D08System(void);

#ifdef __cplusplus
}
#endif

#ifdef __cplusplus

// --------------------
// STRUCTS
// --------------------

struct CVector3
{

    // --------------------
    // VARIABLES
    // --------------------

    fx32 x;
    fx32 y;
    fx32 z;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    CVector3();
    CVector3(fx32 x, fx32 y, fx32 z);
    CVector3(const CVector3 &other);
    CVector3(const VecFx32 &other);

    CVector3 &Normalize();

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void Magnitude(s32 *magnitude, const CVector3 *vec);

    // --------------------
    // OPERATOR OVERLOADS
    // --------------------

    // These are probably typecast overloads. However, those don't appear to work with the compiler?
    // so for now, they're manual functions
    VecFx32 &ToVecFx32Ref() const;
    const VecFx32 &ToConstVecFx32Ref() const;
    VecFx32 *ToVecFx32Ptr() const;
    const VecFx32 *ToConstVecFx32Ptr() const;

    friend CVector3 operator+(const CVector3 &lhs, const VecFx32 &rhs);
    friend CVector3 operator-(const CVector3 &lhs, const CVector3 &rhs);

    CVector3 &operator+=(const CVector3 &rhs);

    CVector3 &operator*=(const fx32 rhs);

    const CVector3 &operator=(const CVector3 &other);
    const CVector3 &operator=(const VecFx32 &other);

private:
    static VecFx32 &VecFx32_Set(VecFx32 &lhs, const VecFx32 &rhs);
    static VecFx32 &VecFx32_Add(VecFx32 &lhs, const VecFx32 &rhs);
    static VecFx32 &VecFx32_Subtract(VecFx32 &lhs, const VecFx32 &rhs);
    static VecFx32 &VecFx32_Multiply(VecFx32 &lhs, fx32 value);
};

struct CMatrix33
{

    // --------------------
    // VARIABLES
    // --------------------

    fx32 m[3][3];

    // --------------------
    // CONSTRUCTORS
    // --------------------

    CMatrix33();

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    CMatrix33 *RotateY(fx32 *sin, fx32 *cos);

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static CVector3 *MultiplyVector(CVector3 &lhs, const CMatrix33 *rhs);

    static void FXMatrix33_Copy33To43(const FXMatrix33 *src, FXMatrix43 *dst);
    static void FXMatrix33_MultiplyVec(VecFx32 &vec, const FXMatrix33 *mtx);

    // --------------------
    // OPERATOR OVERLOADS
    // --------------------

    // These are probably typecast overloads. However, those don't appear to work with the compiler?
    // so for now, they're manual functions
    FXMatrix33 *ToFXMatrix33() const;
    const FXMatrix33 *ToConstFXMatrix33() const;
};

// --------------------
// FUNCTIONS
// --------------------

void *operator new(size_t size);
void *operator new(size_t, void *memory);
void operator delete(void *memory);

// "Allocate" memory where the address is already known
#define PlacementNew(memory, type) new (memory) type

#endif

#endif // RUSH_CPPMATH_HPP
