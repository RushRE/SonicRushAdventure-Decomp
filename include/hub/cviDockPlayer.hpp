#ifndef RUSH_CVIDOCKPLAYER_HPP
#define RUSH_CVIDOCKPLAYER_HPP

#include <hub/cvi3dObject.hpp>

// --------------------
// STRUCTS
// --------------------

class CViDockPlayer : public CVi3dObject
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

void ViDockPlayer__LoadAssets(CViDockPlayer *work);
void ViDockPlayer__Func_2166748(CViDockPlayer *work);
void ViDockPlayer__Func_21667A0(CViDockPlayer *work);
void ViDockPlayer__Func_21667A8(CViDockPlayer *work);
void ViDockPlayer__Func_21667BC(CViDockPlayer *work);
void ViDockPlayer__Func_21667D4(CViDockPlayer *work);
void ViDockPlayer__Func_2166B80(CViDockPlayer *work);
void ViDockPlayer__Func_2166B90(CViDockPlayer *work);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIDOCKPLAYER_HPP
