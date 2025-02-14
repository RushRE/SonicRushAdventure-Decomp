#ifndef RUSH_CVIDOCKPLAYER_HPP
#define RUSH_CVIDOCKPLAYER_HPP

#include <hub/cvi3dObject.hpp>

// --------------------
// STRUCTS
// --------------------

class CViDockPlayer : public CVi3dObject
{
public:
    // CViDockPlayer();
    // virtual ~CViDockPlayer();

    // --------------------
    // ENUMS
    // --------------------

    enum AnimIDs
    {
        ANI_IDLE,
        ANI_WALK, 
        ANI_RUN,
        ANI_BORED_00,
        ANI_BORED_01,
    };

    enum MoveFlag
    {
        MOVEFLAG_WALKING,
        MOVEFLAG_RUNNING,
        MOVEFLAG_INVALID,
        MOVEFLAG_NO_INPUTS,
    };

    enum MoveState
    {
        MOVESTATE_IDLE,
        MOVESTATE_WALKING,
        MOVESTATE_RUNNING,
    };

    enum IdleState
    {
        IDLESTATE_ANIM_STARTING,
        IDLESTATE_BORED,
        IDLESTATE_UNUSED,
        IDLESTATE_INACTIVE,
    };

    // --------------------
    // VARIABLES
    // --------------------

    MoveState moveState;
    MoveState prevMoveState;
    IdleState idleState;
    u32 idleTimer;
    BOOL loadedAssets;
    BOOL allowBored;
    VecFx32 translationUnknown;
    fx32 velocity;
    u32 moveFlag;
    fx32 topSpeed;
    void *resModel;
    void *resAnims;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------
};

// --------------------
// FUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

void _ZN13CViDockPlayerC1Ev();
void _ZN13CViDockPlayerD0Ev();
void _ZN13CViDockPlayerD1Ev();

void ViDockPlayer__Init(CViDockPlayer *work);
void ViDockPlayer__Release(CViDockPlayer *work);
VecFx32 *ViDockPlayer__GetTranslationUnknown(CViDockPlayer *work);
void ViDockPlayer__SetTurnAngle(CViDockPlayer *work, u16 angle, BOOL snap);
void ViDockPlayer__SetMoveAngle(CViDockPlayer *work, u16 angle, BOOL isRunning);
void ViDockPlayer__Process(CViDockPlayer *work, fx32 speed);
void ViDockPlayer__AllowBored(CViDockPlayer *work, BOOL allowBored);
void ViDockPlayer__SetTopSpeed(CViDockPlayer *work, fx32 topSpeed);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIDOCKPLAYER_HPP
