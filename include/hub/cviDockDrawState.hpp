#ifndef RUSH_CVIDOCKDRAWSTATE_HPP
#define RUSH_CVIDOCKDRAWSTATE_HPP

#include <game/graphics/drawReqTask.h>
#include <hub/hubConfig.h>

// --------------------
// STRUCTS
// --------------------

struct CViDockDrawStateUnknown
{
    VecFx32 camTarget;
    u32 camPosZ;
    u16 angle1;
    u16 angle2;
    u16 projFOV;
};

struct CViDockDrawState
{
    BOOL flag;
    u32 area;
    CViDockDrawStateUnknown field_8;
    s32 field_20;
    s32 field_24;
    s32 field_28;
    s32 field_2C;
    CViDockDrawStateUnknown field_30;
    CViDockDrawStateUnknown field_48;
    CViDockDrawStateUnknown field_60;
    u16 field_78;
    u16 field_7A;
    CViDockCameraBounds bounds;
    VecFx32 camPos;
    VecFx32 camTarget;
    VecFx32 camUp;
    u16 projFOV;
    u16 field_BA;
    DirLight lights[4];
    void *drawState;
};

// --------------------
// FUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

void ViDockDrawState__Func_21639A4(CViDockDrawState *work, s32 area, s32 a3);
void ViDockDrawState__Func_2163A50(CViDockDrawState *work);
void ViDockDrawState__Func_2163A7C(CViDockDrawState *work, s32 a2);
void ViDockDrawState__SetCamTarget(CViDockDrawState *work, const VecFx32 *a2);
void ViDockDrawState__Func_2163AA0(CViDockDrawState *work, VecFx32 *pos, u16 a3, VecFx32 *a4, fx32 a5, BOOL a6);
void ViDockDrawState__Func_2163C3C(CViDockDrawState *work, u16 a2);
void ViDockDrawState__Func_2163C80(CViDockDrawState *work);
void ViDockDrawState__Func_2163EBC(CViDockDrawState *work);
void ViDockDrawState__Func_216400C(CViDockDrawStateUnknown *work, s32 id, s32 a3);
void ViDockDrawState__Func_21640F4(DirLight *lights, u16 area, void *drawState, BOOL flag);
void ViDockDrawState__Func_2164224(CViDockDrawState *work, s32 id);
u16 ViDockDrawState__Func_216428C(CViDockDrawState *work);
void ViDockDrawState__Func_21642AC(CViDockDrawStateUnknown *unknown1, CViDockDrawStateUnknown *unknown2, s32 a3, s32 a4, s32 a5, CViDockDrawStateUnknown *unknown3);
void ViDockDrawState__Func_21643AC(CViDockDrawState *work, CViDockDrawStateUnknown *unknown);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIDOCKDRAWSTATE_HPP