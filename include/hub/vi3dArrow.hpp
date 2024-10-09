#ifndef RUSH2_VI3DARROW_HPP
#define RUSH2_VI3DARROW_HPP

#include <hub/vi3dObject.hpp>

// --------------------
// STRUCTS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

class Vi3dArrow : public Vi3dObject
{

public:
    void *materialAnimFile;
    void *modelFile;
};

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void Vi3dArrow__Constructor(Vi3dArrow *work);
NOT_DECOMPILED void Vi3dArrow__VTableFunc_2168268(Vi3dArrow *work);
NOT_DECOMPILED void Vi3dArrow__VTableFunc_2168290(Vi3dArrow *work);
NOT_DECOMPILED void Vi3dArrow__LoadAssets(Vi3dArrow *work);
NOT_DECOMPILED void Vi3dArrow__Func_2168358(Vi3dArrow *work);



#ifdef __cplusplus
}
#endif

#endif // RUSH2_VI3DARROW_HPP
