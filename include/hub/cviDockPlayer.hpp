#ifndef RUSH_CVIDOCKPLAYER_HPP
#define RUSH_CVIDOCKPLAYER_HPP

#include <hub/cviDockNpc.hpp>

// --------------------
// STRUCTS
// --------------------

class CViDockPlayer : public CViDockNpc
{
public:
    CViDockPlayer();
    virtual ~CViDockPlayer();

    // --------------------
    // VARIABLES
    // --------------------

    s32 walkAnim;
    s32 lastWalkAnim;
    s32 idleAnim;
    s32 idleTimer;
    s32 field_310;
    s32 field_314;
    VecFx32 translationUnknown;
    fx32 velocity;
    u32 moveFlag;
    fx32 topSpeed;
    NNSG3dResFileHeader *resModel;
    u8 *resAnims;

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

NOT_DECOMPILED void ViDockPlayer__Constructor(void);
NOT_DECOMPILED void ViDockPlayer__VTableFunc_21665AC(void);
NOT_DECOMPILED void ViDockPlayer__VTableFunc_21665D4(void);
NOT_DECOMPILED void ViDockPlayer__LoadAssets(void);
NOT_DECOMPILED void ViDockPlayer__Func_2166748(void);
NOT_DECOMPILED void ViDockPlayer__Func_21667A0(void);
NOT_DECOMPILED void ViDockPlayer__Func_21667A8(void);
NOT_DECOMPILED void ViDockPlayer__Func_21667BC(void);
NOT_DECOMPILED void ViDockPlayer__Func_21667D4(void);
NOT_DECOMPILED void ViDockPlayer__Func_2166B80(void);
NOT_DECOMPILED void ViDockPlayer__Func_2166B90(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIDOCKPLAYER_HPP
