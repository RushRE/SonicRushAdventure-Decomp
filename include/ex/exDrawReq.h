#ifndef RUSH_EXDRAWREQ_H
#define RUSH_EXDRAWREQ_H

#include <ex/exTask.h>
#include <game/graphics/sprite.h>
#include <game/graphics/paletteAnimation.h>
#include <game/graphics/drawReqTask.h>
#include <ex/exHitCheck.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

typedef struct exPlayerUnknown2161BC0_
{
    u16 animID;
    u16 field_2;
    AnimatorMDL animator;
    PaletteAnimator paletteAnimator[15];
    NNSG3dAnmObj *field_328;
    u16 field_32C;
    VecU16 angle;
    VecFx32 translation;
    VecFx32 translation3;
    VecFx32 scale;
    VecFx32 translation2;
    VecFx32 field_364;
} exPlayerUnknown2161BC0;

typedef struct exDrawReqTaskConfig_
{
    u8 field_0;
    u8 flags;
    u8 field_2;
    u8 field_3;
    u16 priority;
    u8 __padding1;
    u8 __padding2;
} exDrawReqTaskConfig;

typedef struct exDrawFadeUnknown_
{
    Camera3D camera;
    Camera3D camera2;
    u16 useEngineB;
    u16 field_A2;
} exDrawFadeUnknown;

typedef struct EX_ACTION_NN_WORK_
{
    exHitCheck hitChecker;
    exPlayerUnknown2161BC0 model;
    exDrawReqTaskConfig config;
    exDrawFadeUnknown field_394[2];
} EX_ACTION_NN_WORK;

// --------------------
// VARIABLES
// --------------------

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void ovl09_216078C(void);
NOT_DECOMPILED void ovl09_21607EC(void);
NOT_DECOMPILED void ovl09_216083C(void);
NOT_DECOMPILED void ovl09_2160874(void);
NOT_DECOMPILED void ovl09_21608C4(void);
NOT_DECOMPILED void ovl09_2160904(void);
NOT_DECOMPILED void ovl09_21609D8(void);
NOT_DECOMPILED void ovl09_2160A84(void);
NOT_DECOMPILED void ovl09_2160AD4(void);
NOT_DECOMPILED void ovl09_2160CBC(void);
NOT_DECOMPILED void ovl09_2160DD8(void);
NOT_DECOMPILED void ovl09_2160E04(void);
NOT_DECOMPILED void ovl09_2160E28(void);
NOT_DECOMPILED void ovl09_2160E50(void);
NOT_DECOMPILED void ovl09_2160E78(void);
NOT_DECOMPILED void ovl09_2160EB0(void);
NOT_DECOMPILED void ovl09_2160F8C(void);
NOT_DECOMPILED void ovl09_2160FA0(void);
NOT_DECOMPILED void ovl09_216109C(void);
NOT_DECOMPILED void ovl09_21610F0(void);
NOT_DECOMPILED void ovl09_21611C0(void);
NOT_DECOMPILED void ovl09_2161314(void);
NOT_DECOMPILED void ovl09_21613A8(void);
NOT_DECOMPILED void ovl09_216143C(void);
NOT_DECOMPILED void ovl09_21614EC(void);
NOT_DECOMPILED void ovl09_21615A4(void);
NOT_DECOMPILED void ovl09_2161698(void);
NOT_DECOMPILED void ovl09_21616A4(void);
NOT_DECOMPILED void ovl09_21616B0(void);
NOT_DECOMPILED void ovl09_21616BC(void);
NOT_DECOMPILED void ovl09_21616F4(void);
NOT_DECOMPILED void ovl09_2161768(void);
NOT_DECOMPILED void ovl09_2161780(void);
NOT_DECOMPILED void ovl09_21617DC(void);
NOT_DECOMPILED void ovl09_2161908(void);
NOT_DECOMPILED void ovl09_216197C(void);
NOT_DECOMPILED void ovl09_21619A0(void);
NOT_DECOMPILED void ovl09_2161B1C(void);
NOT_DECOMPILED void ovl09_2161B44(void);
NOT_DECOMPILED void ovl09_2161B6C(void);
NOT_DECOMPILED void ovl09_2161B80(void);
NOT_DECOMPILED void ovl09_2161B94(void);
NOT_DECOMPILED void ovl09_2161BC0(void);
NOT_DECOMPILED void ovl09_2161C24(void);
NOT_DECOMPILED void ovl09_2161CB0(void);
NOT_DECOMPILED void ovl09_2161CD4(void);
NOT_DECOMPILED void ovl09_2161DE4(void);
NOT_DECOMPILED void ovl09_2161FAC(void);
NOT_DECOMPILED void ovl09_2162164(void);
NOT_DECOMPILED void ovl09_2162230(void);
NOT_DECOMPILED void ovl09_216239C(void);
NOT_DECOMPILED void ovl09_21623C4(void);
NOT_DECOMPILED void ovl09_21623F8(void);
NOT_DECOMPILED void ovl09_216241C(void);
NOT_DECOMPILED void ovl09_21624F4(void);
NOT_DECOMPILED void ovl09_2162724(void);
NOT_DECOMPILED void ovl09_2162AB4(void);
NOT_DECOMPILED void ovl09_2162CC8(void);
NOT_DECOMPILED void ovl09_2162E8C(void);
NOT_DECOMPILED void ovl09_2162FDC(void);
NOT_DECOMPILED void ovl09_2163238(void);
NOT_DECOMPILED void ovl09_21635E0(void);
NOT_DECOMPILED void ovl09_216363C(void);
NOT_DECOMPILED void ovl09_21636BC(void);
NOT_DECOMPILED void ovl09_21636E0(void);
NOT_DECOMPILED void ovl09_21637F0(void);
NOT_DECOMPILED void ovl09_2163924(void);
NOT_DECOMPILED void ovl09_2163ADC(void);
NOT_DECOMPILED void ovl09_2163B64(void);
NOT_DECOMPILED void ovl09_2163BC0(void);
NOT_DECOMPILED void ovl09_2163BF4(void);
NOT_DECOMPILED void exDrawFadeTask__Main(void);
NOT_DECOMPILED void exDrawFadeTask__Func8(void);
NOT_DECOMPILED void exDrawFadeTask__Destructor(void);
NOT_DECOMPILED void ovl09_2163C48(void);
NOT_DECOMPILED void exDrawFadeTask__Create(void);
NOT_DECOMPILED void exDrawReqTask__Main(void);
NOT_DECOMPILED void exDrawReqTask__Func8(void);
NOT_DECOMPILED void exDrawReqTask__Destructor(void);
NOT_DECOMPILED void ovl09_2163EC4(void);
NOT_DECOMPILED void exDrawReqTask__Create(void);
NOT_DECOMPILED void ovl09_2164034(void);
NOT_DECOMPILED void ovl09_2164174(void);
NOT_DECOMPILED void ovl09_21641AC(void);
NOT_DECOMPILED void ovl09_21641C8(void);
NOT_DECOMPILED void exDrawReqTask__SetConfigPriority(exDrawReqTaskConfig *work, u16 priority);
NOT_DECOMPILED void ovl09_21641F0(void);
NOT_DECOMPILED void exDrawReqTask__Func_2164218(exDrawReqTaskConfig *config);
NOT_DECOMPILED void ovl09_2164238(void);
NOT_DECOMPILED void ovl09_2164260(void);
NOT_DECOMPILED void ovl09_216426C(void);
NOT_DECOMPILED void ovl09_2164288(void);
NOT_DECOMPILED void ovl09_21642BC(void);
NOT_DECOMPILED void ovl09_21642F0(void);

#endif // RUSH_EXDRAWREQ_H
