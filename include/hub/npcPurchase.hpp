#ifndef RUSH_NPCOPTIONS_HPP
#define RUSH_NPCOPTIONS_HPP

#include <game/graphics/sprite.h>
#include <game/text/fontWindowAnimator.h>

// --------------------
// STRUCTS
// --------------------

class NpcPurchase
{
public:
    // --------------------
    // VARIABLES
    // --------------------

    s32 state;
    u16 activePlane;
    u16 paletteRow;
    FontWindowAnimator fontWindowAnimator;
    AnimatorSprite aniMaterialFrame;
    AnimatorSprite aniRingCountFrame;
    AnimatorSprite aniNumbers[20];
    u16 paletteColors[256];
    u16 aniMaterialNum[9][2];
    u16 aniRingCountNum[5];

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

// NpcPurchase
NOT_DECOMPILED void NpcPurchase__Init(NpcPurchase *work);
NOT_DECOMPILED void NpcPurchase__Load(NpcPurchase *work, u16 activePlane, u16 a3, u16 a4, u8 a12, u16 a6, u16 paletteRow);
NOT_DECOMPILED void NpcPurchase__Release(NpcPurchase *work);
NOT_DECOMPILED void NpcPurchase__Process(NpcPurchase *work);
NOT_DECOMPILED void NpcPurchase__ProcessGraphics(NpcPurchase *work);
NOT_DECOMPILED BOOL NpcPurchase__Func_216ED10(NpcPurchase *work);
NOT_DECOMPILED void NpcPurchase__Func_216ED24(NpcPurchase *work);
NOT_DECOMPILED BOOL NpcPurchase__Func_216ED60(NpcPurchase *work);
NOT_DECOMPILED BOOL NpcPurchase__HasMaterial(u8 type);
NOT_DECOMPILED u32 NpcPurchase__GetMaterialCount(u8 type);
NOT_DECOMPILED u32 NpcPurchase__GetRingCount(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_NPCOPTIONS_HPP