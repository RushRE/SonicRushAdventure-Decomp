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
    // ENUMS
    // --------------------

    enum ButtonFlags
    {
        BUTTONFLAG_NONE = 0x00,

        BUTTONFLAG_VISIBLE = 1 << 0,
        BUTTONFLAG_ACTIVE  = 1 << 1,
    };

    enum TouchAreaFlags
    {
        TOUCHAREAFLAG_NONE = 0x00,

        TOUCHAREAFLAG_ENABLED         = 1 << 0,
        TOUCHAREAFLAG_BUTTON_HELD     = 1 << 1,
        TOUCHAREAFLAG_BUTTON_RELEASED = 1 << 2,
    };

    // --------------------
    // STRUCTS
    // --------------------

    struct ViewButton
    {
        u32 flags;
        union
        {
            struct
            {
                AnimatorSprite aniButton;
                AnimatorSprite aniArrow;
            };

            AnimatorSprite animators[2];
        };
    };

    struct MenuButton
    {
        u32 flags;
        s32 unused;
        AnimatorSprite aniSprite[GRAPHICS_ENGINE_COUNT];
    };

    // --------------------
    // VARIABLES
    // --------------------

    ViewButton viewButton;
    MenuButton menuButton;
    TouchField touchField;
    TouchArea touchArea[2];
    BOOL touchAreaFlags[2];
    BOOL touchAreaEnabled[2];
    s32 unknown1;
    BOOL openMainMenu;
    s32 unknown2;
    TouchPos touchPos;
    BOOL touchHeld;
    Vec2Fx16 touchMove;
    void *sprViFix;
    void *sprViFixLoc;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void Create(void);
    static void Destroy(void);
    static void ConfigureViewButton(BOOL visible, BOOL enabled);
    static BOOL LookAroundEnabled(void);
    static void DisableLookAround(void);
    static BOOL GetLookAroundBtnLeft(void);
    static BOOL GetLookAroundBtnUp(void);
    static BOOL GetLookAroundBtnRight(void);
    static BOOL GetLookAroundBtnDown(void);
    static BOOL GetTouchHeld(void);
    static void GetTouchMove(s16 *x, s16 *y);
    static void GetTouchPos(s16 *x, s16 *y);
    static void ConfigureMenuButton(BOOL visible, BOOL enabled);
    static BOOL ShouldOpenMainMenu(void);
    static void InitGraphics(HubHUD *work);
    static void InitViewButtons(HubHUD *work);
    static void InitMenuButton(HubHUD *work);
    static void InitTouchField(HubHUD *work);
    static void Release(HubHUD *work);
    static void ReleaseViewButtons(HubHUD *work);
    static void ReleaseMenuButtons(HubHUD *work);
    static void ReleaseTouchField(HubHUD *work);
    static void Main_Idle(void);
    static void Main_LookAround(void);
    static void Destructor(Task *task);
    static void EnableViewCursor(HubHUD *work);
    static void ProcessViewButtons(HubHUD *work);
    static void DrawViewButtons(HubHUD *work);
    static void ProcessMenuButton(HubHUD *work);
    static void DrawMenuButton(HubHUD *work);
    static void SetAllTouchAreasDisabled(HubHUD *work);
    static void SetMenuButtonTouchAreaEnabled(HubHUD *work, BOOL enabled);
    static void SetViewButtonTouchAreaEnabled(HubHUD *work, BOOL enabled);
    static void ConfigureTouchArea(HubHUD *work, s32 id, BOOL enabled);
    static void TouchAreaCallback_ViewButton(TouchAreaResponse *response, TouchArea *area, void *userData);
    static void TouchAreaCallback_MenuButton(TouchAreaResponse *response, TouchArea *area, void *userData);
    static void SpriteCallback(BACFrameGroupBlockHeader *block, AnimatorSprite *animator, void *userData);
};

#endif // RUSH_HUBHUD_HPP