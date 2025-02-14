#ifndef RUSH_CVIMAPICON_HPP
#define RUSH_CVIMAPICON_HPP

#include <game/graphics/sprite.h>

// --------------------
// STRUCTS
// --------------------

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

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIMAPICON_HPP