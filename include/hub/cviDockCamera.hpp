#ifndef RUSH_CVIDOCKDRAWSTATE_HPP
#define RUSH_CVIDOCKDRAWSTATE_HPP

#include <game/graphics/swapBuffer3D.h>
#include <hub/hubConfig.h>

struct CViDockCamera
{

    // --------------------
    // ENUMS
    // --------------------

    enum Type
    {
        TYPE_DOCK,
        TYPE_PREVIEW,
        TYPE_CONSTRUCTION_CUTSCENE,
    };

    enum Flags
    {
        FLAG_NONE = 0x00,

        FLAG_MOVE_TO_NEW       = 1 << 0,
        FLAG_RETURN_TO_INITIAL = 1 << 1,
    };

    // --------------------
    // STRUCTS
    // --------------------

    struct State
    {
        VecFx32 camTarget;
        u32 camPosZ;
        u16 angle1;
        u16 angle2;
        u16 fov;
    };

    // --------------------
    // VARIABLES
    // --------------------

    s32 type;
    DockArea area;
    State initialState;
    VecFx32 unknown1;
    s32 flags;
    State state1;
    State state2;
    State targetState;
    u16 lerpDuration;
    u16 lerpTimer;
    CViDockCameraBounds bounds;
    VecFx32 camPos;
    VecFx32 camTarget;
    VecFx32 camUp;
    u16 fov;
    u16 unknown2;
    DirLight lights[4];
    void *drawState;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void Init(DockArea dockArea, s32 type);
    void Release();
    void SetType(s32 type);
    void SetCamTarget(const VecFx32 *camTarget);
    void MoveToPosition(VecFx32 *camTarget, u16 duration, VecFx32 *camDirection, fx32 scale, BOOL flag);
    void ReturnToInitialPosition(u16 duration);
    void Process();
    void SetDrawPipeline();

private:
    u16 GetFOV();
    void ApplyBounds(State *state);

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void InitState(State *work, DockArea dockArea, s32 type);
    static void InitLights(DirLight *lights, DockArea dockArea, void *drawState, s32 type);
    static void InitBounds(CViDockCameraBounds *work, DockArea dockArea);
    static void HandleLerp(State *state1, State *state2, s32 angleProgress, fx32 posProgress, fx32 duration, State *targetState);
};

#endif // RUSH_CVIDOCKDRAWSTATE_HPP