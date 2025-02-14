
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

void _ZN11CViDockBackC1Ev(CViDockBack *work);
void _ZN11CViDockBackD0Ev(CViDockBack *work);
void _ZN11CViDockBackD1Ev(CViDockBack *work);

void ViDockBack__LoadAssets(CViDockBack *work, s32 areaID, BOOL a3, BOOL a4);
void ViDockBack__Func_2164918(CViDockBack *work, s32 area);
BOOL ViDockBack__Func_2164954(CViDockBack *work);
void ViDockBack__Func_2164968(CViDockBack *work);
void ViDockBack__Func_21649DC(CViDockBack *work);
void ViDockBack__SetShipPosition(CViDockBack *work, fx32 y);
void ViDockBack__SetShipScale(CViDockBack *work, fx32 scale);
void ViDockBack__DrawDock(CViDockBack *work, u16 rotationY, u16 rotationX, u16 rotationZ);
void ViDockBack__Func_2164B58(CViDockBack *work, VecFx32 *pos0, VecFx32 *pos1, VecFx32 *pos2, BOOL *flag0, BOOL *flag1, BOOL *flag2);
BOOL ViDockBack__Func_2164B9C(CViDockBack *work, VecFx32 pos);
fx32 ViDockBack__Func_2164BC8(CViDockBack *work, VecFx32 pos);
void ViDockBack__DrawShadow(CViDockBack *work, CViShadow *shadow, fx32 scale, fx32 x, fx32 z);
void ViDockBack__GetPlayerSpawnConfig(s32 id, VecFx32 *position, u16 *angle, s32 area);
void ViDockBack__Func_2164C44(CViDockBack *work);
void ViDockBack__Func_216509C(CViDockBack *work);
void ViDockBack__Func_2165268(CViDockBack *work);
void ViDockBack__Func_21654C8(CViDockBack *work);
void ViDockBack__Func_2165914(CViDockBack *work);
void ViDockBack__Func_2165D60(CViDockBack *work);
void ViDockBack__Func_2166158(CViDockBack *work);
void ViDockBack__Func_21662E8(CViDockBack *work);
void ViDockBack__Func_21662FC(CViDockBack *work);
void ViDockBack__Func_2166304(CViDockBack *work);
void ViDockBack__Func_2166318(CViDockBack *work);
void ViDockBack__Func_216632C(CViDockBack *work);
void ViDockBack__Func_2166340(CViDockBack *work);
void ViDockBack__Func_2166354(CViDockBack *work);
void ViDockBack__Func_2166368(CViDockBack *work);
void ViDockBack__Func_21663B4(CViDockBack *work);
void ViDockBack__Func_21663D8(CViDockBack *work);
void ViDockBack__Func_2166400(CViDockBack *work);
void ViDockBack__Func_2166420(CViDockBack *work);
void ViDockBack__Func_2166440(CViDockBack *work);
void ViDockBack__Func_2166460(CViDockBack *work);
void ViDockBack__Func_2166480(CViDockBack *work);
void ViDockBack__Func_2166488(CViDockBack *work);
void ViDockBack__Func_21664C0(CViDockBack *work);
void ViDockBack__Func_2166500(CViDockBack *work);
void ViDockBack__Func_2166540(CViDockBack *work);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIDOCKBACK_HPP