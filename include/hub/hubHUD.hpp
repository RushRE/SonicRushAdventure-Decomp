#ifndef RUSH_HUBHUD_HPP
#define RUSH_HUBHUD_HPP

#include <hub/hubTask.hpp>
#include <game/graphics/sprite.h>
#include <game/input/touchField.h>

// --------------------
// STRUCTS
// --------------------

class HubHUD
{
public:

    // --------------------
    // VARIABLES
    // --------------------

    s32 field_0;
    AnimatorSprite aniViewButton;
    AnimatorSprite aniViewCursor;
    s32 field_CC;
    s32 field_D0;
    AnimatorSprite aniMenuButtonA;
    AnimatorSprite aniMenuButtonB;
    TouchField field_19C;
    TouchArea field_1B4;
    TouchArea field_1EC;
    s32 field_224;
    s32 field_228;
    s32 field_22C;
    s32 field_230;
    s32 field_234;
    s32 openMainMenu;
    s32 field_23C;
    s32 field_240;
    s32 field_244;
    s32 field_248;
    void *sprViFix;
    void *sprViFixLoc;

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

void HubHUD__Create(void);
void HubHUD__CreateInternal(void);
void HubHUD__Func_21600E4(void);
void HubHUD__Func_2160110(s32 a1, s32 a2);
BOOL HubHUD__Func_216016C(void);
void HubHUD__Func_2160194(void);
BOOL HubHUD__Func_21601BC(void);
BOOL HubHUD__Func_21601FC(void);
BOOL HubHUD__Func_216023C(void);
BOOL HubHUD__Func_216027C(void);
BOOL HubHUD__Func_21602BC(void);
void HubHUD__Func_21602D8(s16 *x, s16 *y);
void HubHUD__Func_2160344(s16 *x, s16 *y);
void HubHUD__Func_21603B0(s32 x, s32 y);
BOOL HubHUD__Func_21603F0(void);
void HubHUD__Func_216040C(HubHUD *work);
void HubHUD__Func_2160450(void);
void HubHUD__Func_2160538(void);
void HubHUD__Func_216062C(void);
void HubHUD__Func_21606AC(HubHUD *work);
void HubHUD__Func_21606CC(void);
void HubHUD__Func_216070C(void);
void HubHUD__Func_216074C(void);
void HubHUD__Main(void);
void HubHUD__Main_21608DC(void);
void HubHUD__Destructor(Task *task);
void HubHUD__Func_2160AC4(void);
void HubHUD__Func_2160AE0(void);
void HubHUD__Func_2160AF4(void);
void HubHUD__Func_2160B58(void);
void HubHUD__Func_2160C08(void);
void HubHUD__Func_2160C68(void);
void HubHUD__Func_2160CA4(void);
void HubHUD__Func_2160CC4(void);
void HubHUD__Func_2160D10(void);
void HubHUD__Func_2160D40(void);
void HubHUD__Func_2160DCC(void);
void HubHUD__Func_2160EC0(void);
void HubHUD__Func_2160FC0(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_HUBHUD_HPP