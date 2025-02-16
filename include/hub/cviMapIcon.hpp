#ifndef RUSH_CVIMAPICON_HPP
#define RUSH_CVIMAPICON_HPP

#include <game/graphics/sprite.h>
#include <game/math/mtMath.h>
#include <hub/dockCommon.h>

class CViMapIcon
{
public:
    CViMapIcon();
    virtual ~CViMapIcon();

    // --------------------
    // ENUMS
    // --------------------

    enum Flags
    {
        FLAG_SHOW_PLAYER_ICON,
        FLAG_SHOW_ISLAND_ICONS,
    };

    // --------------------
    // STRUCTS
    // --------------------

    struct Icon
    {

        // --------------------
        // ENUMS
        // --------------------

        enum Flags
        {
            FLAG_NONE = 0x00,

            FLAG_ENABLED = 1 << 0,
        };

        // --------------------
        // VARIABLES
        // --------------------

        u32 flags;
        Vec2U16 pos;
    };

    // --------------------
    // VARIABLES
    // --------------------

    u32 flags;
    void *sprIcon;
    Vec2U16 worldPosition;
    AnimatorSprite aniIconOutline;
    AnimatorSprite aniIconCenter;
    AnimatorSprite aniSonicMarker;
    u32 mapArea;
    Vec2U16 prevMarkerPos;
    u32 markerMoveDuration;
    u32 markerMoveTimer;
    Icon iconList[MAPAREA_COUNT];
    AnimatorSprite aniCursor;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void Init(BOOL useEngineB);
    void Release();
    void Configure(u8 id, BOOL enabled);
    void SetWorldPosition(u16 x, u16 y);
    void GetIconPosition(MapArea mapArea, u16 *x, u16 *y);
    void WarpToArea(MapArea mapArea);
    void TravelToArea(MapArea mapArea);
    MapArea GetCurrentArea();
    void ProcessPlayerIcon();
    void Draw();
    MapArea GetAreaFromTouchInput();
    MapArea GetAreaFromPadInput();
    BOOL IsMoving();
    void InitIcons();
    void DrawCursor(s16 x, s16 y);
    void LoadIconConfig();
    void DrawIcon(s16 x, s16 y);
    void GetSonicMarkerPos(u16 *x, u16 *y);
    void DrawSonicMarker(s16 x, s16 y);

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

private:
    static void InitIconPosition(MapArea mapArea, u16 *x, u16 *y);
    static MapArea PadMove_Left(MapArea mapArea, u16 next);
    static MapArea PadMove_Up(MapArea mapArea, u16 next);
    static MapArea PadMove_Right(MapArea mapArea, u16 next);
    static MapArea PadMove_Down(MapArea mapArea, u16 next);
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

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIMAPICON_HPP