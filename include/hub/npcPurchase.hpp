#ifndef RUSH_NPCPURCHASE_HPP
#define RUSH_NPCPURCHASE_HPP

#include <hub/hubTask.hpp>
#include <game/graphics/sprite.h>
#include <game/text/fontWindowAnimator.h>
#include <game/save/saveGame.h>

// --------------------
// STRUCTS
// --------------------

class NpcPurchase
{
public:
    // --------------------
    // ENUMS
    // --------------------

    enum State
    {
        STATE_INACTIVE,
        STATE_READY,
        STATE_OPENING_WINDOW,
        STATE_ACTIVE,
        STATE_CLOSING_WINDOW,
        STATE_CLOSED_WINDOW,
    };

    // --------------------
    // VARIABLES
    // --------------------

    s32 state;
    u16 backgroundID;
    u16 materialPaletteRow;
    FontWindowAnimator fontWindowAnimator;
    AnimatorSprite aniMaterialFrame;
    AnimatorSprite aniRingCountFrame;
    AnimatorSprite aniNumbers[2 * 10];
    GXRgb paletteColors[256];
    u16 aniMaterialNum[SAVE_MATERIAL_COUNT][2];
    u16 aniRingCountNum[6];

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void Init();
    void Load(u16 backgroundID, u16 a3, u16 a4, u16 a5, u16 hudPaletteRow, u16 materialPaletteRow);
    void Release();
    void Process();
    void ProcessGraphics();

    BOOL IsReady();
    void CloseWindow();
    BOOL IsActive();

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static BOOL HasMaterial(u16 type);
    static u32 GetMaterialCount(u16 type);
    static u32 GetRingCount(void);
};

#endif // RUSH_NPCPURCHASE_HPP