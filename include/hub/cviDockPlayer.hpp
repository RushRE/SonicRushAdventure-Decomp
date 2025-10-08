#ifndef RUSH_CVIDOCKPLAYER_HPP
#define RUSH_CVIDOCKPLAYER_HPP

#include <hub/cvi3dObject.hpp>

// --------------------
// STRUCTS
// --------------------

class CViDockPlayer : public CVi3dObject
{
#ifdef NON_MATCHING
public:
    CViDockPlayer();
    virtual ~CViDockPlayer();
#else
    // TODO: remove this when constructor/destructors are decompiled properly
public:
#endif

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
    VecFx32 prevPos;
    fx32 velocity;
    u32 moveFlag;
    fx32 topSpeed;
    void *resModel;
    void *resAnims;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void Init();
    void Release();
    VecFx32 *GetPrevPosition();
    void SetTurnAngle(u16 angle, BOOL snap);
    void SetMoveAngle(u16 angle, BOOL isRunning);
    void Process(fx32 speed);
    void AllowBored(BOOL allowBored);
    void SetTopSpeed(fx32 topSpeed);
};

// --------------------
// FUNCTIONS
// --------------------

#ifndef NON_MATCHING

#ifdef __cplusplus
extern "C"
{
#endif

void _ZN13CViDockPlayerC1Ev();
void _ZN13CViDockPlayerD0Ev();
void _ZN13CViDockPlayerD1Ev();

#ifdef __cplusplus
}
#endif

#endif

#endif // RUSH_CVIDOCKPLAYER_HPP
