#ifndef RUSH_CVIMAPICON_HPP
#define RUSH_CVIMAPICON_HPP

#include <game/graphics/sprite.h>
#include <game/graphics/drawReqTask.h>

// --------------------
// STRUCTS
// --------------------

struct CViDockDrawState
{
    s32 field_0;
    u32 area;
    u32 dword8;
    s32 field_C;
    s32 field_10;
    s32 field_14;
    s32 field_18;
    u16 word1C;
    u16 field_1E;
    s32 field_20;
    s32 field_24;
    s32 field_28;
    s32 field_2C;
    s32 field_30;
    s32 field_34;
    s32 field_38;
    s32 field_3C;
    s32 field_40;
    s32 field_44;
    s32 field_48;
    s32 field_4C;
    s32 field_50;
    s32 field_54;
    s32 field_58;
    s32 field_5C;
    VecFx32 field_60;
    s32 field_6C;
    u16 field_70;
    u16 field_72;
    s32 field_74;
    u16 field_78;
    u16 field_7A;
    s32 field_7C;
    s32 field_80;
    s32 field_84;
    s32 field_88;
    s32 field_8C;
    s32 field_90;
    VecFx32 field_94;
    VecFx32 field_A0;
    VecFx32 field_AC;
    u16 field_B8;
    u16 field_BA;
    DirLight lights[4];
    void *drawState;
};

struct CViMapIconUnknown
{
    u32 flags;
    Vec2Fx16 pos;
};

class CViMapIcon
{
public:
    CViMapIcon();
    virtual ~CViMapIcon();

    // --------------------
    // VARIABLES
    // --------------------

    u32 flags;
    void *sprIcon;
    Vec2Fx16 wordC;
    AnimatorSprite aniIconOutline;
    AnimatorSprite aniIconCenter;
    AnimatorSprite aniSonicMarker;
    u32 iconID;
    Vec2Fx16 field_140;
    u32 dword144;
    u32 dword148;
    CViMapIconUnknown iconList[8];
    AnimatorSprite aniCursor;

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

NOT_DECOMPILED void _ZN10CViMapIconC1Ev(CViMapIcon *work);
NOT_DECOMPILED void _ZN10CViMapIconD0Ev(CViMapIcon *work);
NOT_DECOMPILED void _ZN10CViMapIconD1Ev(CViMapIcon *work);

void ViMapIcon__Func_2163058(CViMapIcon *work, BOOL useEngineB);
void ViMapIcon__Release(CViMapIcon *work);
void ViMapIcon__Func_2163340(CViMapIcon *work, u8 id, BOOL enabled);
void ViMapIcon__Func_2163364(CViMapIcon *work, u16 x, u16 y);
void ViMapIcon__GetIconPosition(CViMapIcon *work, u32 area, u16 *x, u16 *y);
void ViMapIcon__SetIconID2(CViMapIcon *work, u32 icon);
void ViMapIcon__SetIconID(CViMapIcon *work, u32 icon);
s32 ViMapIcon__GetCurrentIcon(CViMapIcon *work);
void ViMapIcon__Func_2163400(CViMapIcon *work);
void ViMapIcon__Func_2163440(CViMapIcon *work);
s32 ViMapIcon__GetIconFromTouchPos(CViMapIcon *work);
s32 ViMapIcon__Func_21635DC(CViMapIcon *work);
BOOL ViMapIcon__IsMoving(CViMapIcon *work);
void ViMapIcon__Func_21636A0(CViMapIcon *work);
void ViMapIcon__Func_21636AC(CViMapIcon *work, s16 x, s16 y);
void ViMapIcon__Func_21636C8(CViMapIcon *work);
void ViMapIcon__Func_2163738(CViMapIcon *work);
void ViMapIcon__Func_21637A0(CViMapIcon *work);
void ViMapIcon__Func_21638A4(CViMapIcon *work);
void ViMapIcon__Func_21638D0(CViMapIcon *work);
void ViMapIcon__Func_2163904(CViMapIcon *work);
void ViMapIcon__Func_216392C(CViMapIcon *work);
void ViMapIcon__Func_2163954(CViMapIcon *work);
void ViMapIcon__Func_216397C(CViMapIcon *work);


void ViMapIcon__Func_21639A4(CViMapIcon *work);
void ViMapIcon__Func_2163A50(CViMapIcon *work);
void ViMapIcon__Func_2163A7C(CViMapIcon *work);
void ViMapIcon__Func_2163A84(CViMapIcon *work);
void ViMapIcon__Func_2163AA0(CViMapIcon *work);
void ViMapIcon__Func_2163C3C(CViMapIcon *work);
void ViMapIcon__Func_2163C80(CViMapIcon *work);
void ViMapIcon__Func_2163EBC(CViMapIcon *work);
void ViMapIcon__Func_216400C(CViMapIcon *work);
void ViMapIcon__Func_21640F4(CViMapIcon *work);
void ViMapIcon__Func_2164224(CViMapIcon *work);
void ViMapIcon__Func_216428C(CViMapIcon *work);
void ViMapIcon__Func_21642AC(CViMapIcon *work);
void ViMapIcon__Func_21643AC(CViMapIcon *work);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIMAPICON_HPP