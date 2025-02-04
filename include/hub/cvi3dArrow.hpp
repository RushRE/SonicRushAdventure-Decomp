#ifndef RUSH_VI3DARROW_HPP
#define RUSH_VI3DARROW_HPP

#include <hub/cvi3dObject.hpp>

// --------------------
// STRUCTS
// --------------------

#ifdef __cplusplus

class CVi3dArrow : public CVi3dObject
{

public:
    void *materialAnimFile;
    void *modelFile;
};

#endif

// --------------------
// FUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

NOT_DECOMPILED void Vi3dArrow__Constructor(CVi3dArrow *work);
NOT_DECOMPILED void Vi3dArrow__VTableFunc_2168268(CVi3dArrow *work);
NOT_DECOMPILED void Vi3dArrow__VTableFunc_2168290(CVi3dArrow *work);
NOT_DECOMPILED void Vi3dArrow__LoadAssets(CVi3dArrow *work);
NOT_DECOMPILED void Vi3dArrow__Func_2168358(CVi3dArrow *work);

#ifdef __cplusplus
}
#endif

#endif // RUSH_VI3DARROW_HPP
