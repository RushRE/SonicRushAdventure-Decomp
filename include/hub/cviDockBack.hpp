
#ifndef RUSH_CVIDOCKBACK_HPP
#define RUSH_CVIDOCKBACK_HPP

#include <hub/dockCommon.h>
#include <hub/cvi3dObject.hpp>
#include <game/system/threadWorker.h>

// --------------------
// STRUCTS
// --------------------

class CViDockBack
{
public:
    CViDockBack();
    virtual ~CViDockBack();

    // --------------------
    // VARIABLES
    // --------------------

    DockArea areaID;
    CVi3dObject object1;
    CVi3dObject object2;
    CVi3dObject object3;
    s32 field_908;
    void *resModel2;
    void *resUnknown;
    void *resTextureAnim;
    void *resPatternAnim;
    s32 field_91C;
    CVi3dObject object4;
    s32 field_C20;
    void *resModel1;
    void *resJointAnim;
    Thread thread;
    s32 field_CF8;
    s32 field_CFC;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------
};

// --------------------
// FUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

void _ZN11CViDockBackC1Ev(void);
void _ZN11CViDockBackD0Ev(void);
void _ZN11CViDockBackD1Ev(void);

void ViDockBack__LoadAssets(void);
void ViDockBack__Func_2164918(void);
void ViDockBack__Func_2164954(void);
void ViDockBack__Func_2164968(CViDockBack *work);
void ViDockBack__Func_21649DC(void);
void ViDockBack__Func_2164A38(void);
void ViDockBack__Func_2164A8C(void);
void ViDockBack__Func_2164AB4(void);
void ViDockBack__Func_2164B58(void);
void ViDockBack__Func_2164B9C(void);
void ViDockBack__Func_2164BC8(void);
void ViDockBack__Func_2164BF4(void);
void ViDockBack__Func_2164C20(void);
void ViDockBack__Func_2164C44(void);
void ViDockBack__Func_216509C(void);
void ViDockBack__Func_2165268(void);
void ViDockBack__Func_21654C8(void);
void ViDockBack__Func_2165914(void);
void ViDockBack__Func_2165D60(void);
void ViDockBack__Func_2166158(void);
void ViDockBack__Func_21662E8(void);
void ViDockBack__Func_21662FC(void);
void ViDockBack__Func_2166304(void);
void ViDockBack__Func_2166318(void);
void ViDockBack__Func_216632C(void);
void ViDockBack__Func_2166340(void);
void ViDockBack__Func_2166354(void);
void ViDockBack__Func_2166368(void);
void ViDockBack__Func_21663B4(void);
void ViDockBack__Func_21663D8(void);
void ViDockBack__Func_2166400(void);
void ViDockBack__Func_2166420(void);
void ViDockBack__Func_2166440(void);
void ViDockBack__Func_2166460(void);
void ViDockBack__Func_2166480(void);
void ViDockBack__Func_2166488(void);
void ViDockBack__Func_21664C0(void);
void ViDockBack__Func_2166500(void);
void ViDockBack__Func_2166540(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIDOCKBACK_HPP