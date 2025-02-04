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

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIDOCKPLAYER_HPP
