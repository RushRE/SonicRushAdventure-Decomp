
#ifndef RUSH_CVIDOCKBACK_HPP
#define RUSH_CVIDOCKBACK_HPP

#include <hub/dockCommon.h>
#include <hub/cvi3dObject.hpp>
#include <game/system/threadWorker.h>

// --------------------
// STRUCTS
// --------------------

class CViDockBack
{
public:
    CViDockBack();
    virtual ~CViDockBack();

    // --------------------
    // STRUCTS
    // --------------------

    struct ThreadWorker
    {
        Thread thread;
        CViDockBack *parent;
        DockArea area;
    };

    // --------------------
    // VARIABLES
    // --------------------

    DockArea dockArea;
    CVi3dObject dockObj[3];
    BOOL dockVisible;
    void *resModelDock;
    void *resJointAnimDock;
    void *resTextureAnim;
    void *resPatternAnim;
    BOOL shipLoaded;
    CVi3dObject shipObj;
    BOOL shipVisible;
    void *resModelShip;
    void *resJointAnimShip;
    ThreadWorker threadWorker;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------
    
    void Init(s32 dockArea, BOOL noAssetRelease, BOOL disableAnimations);
    void SetArea(s32 area);
    BOOL IsThreadIdle();
    void Release();
    void Process();
    void SetShipPosition(fx32 y);
    void SetShipScale(fx32 scale);
    void DrawDock(u16 rotationY, u16 rotationX, u16 rotationZ);
    BOOL ProcessCollision(VecFx32 *prevPlayerPos, VecFx32 *curPlayerPos, VecFx32 *newPlayerPos, BOOL *isSailPrompt, BOOL *a5, u32 *area);
    BOOL DidExitArea(VecFx32 pos);
    fx32 GetFloorPosition(VecFx32 pos);
    void DrawShadow(CViShadow *shadow, fx32 scale, fx32 x, fx32 z);

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void GetPlayerSpawnConfig(s32 id, VecFx32 *position, u16 *angle, s32 area);

    static BOOL Collide_Base(VecFx32 *pos0, VecFx32 *pos1, VecFx32 *pos2, BOOL *isSailPrompt, BOOL *a5, u32 *area);
    static BOOL Collide_BaseNext(VecFx32 *pos0, VecFx32 *pos1, VecFx32 *pos2, BOOL *isSailPrompt, BOOL *a5, u32 *area);
    static BOOL Collide_Jet(VecFx32 *pos0, VecFx32 *pos1, VecFx32 *pos2, BOOL *isSailPrompt, BOOL *a5, u32 *area);
    static BOOL Collide_Boat(VecFx32 *pos0, VecFx32 *pos1, VecFx32 *pos2, BOOL *isSailPrompt, BOOL *a5, u32 *area);
    static BOOL Collide_Hover(VecFx32 *pos0, VecFx32 *pos1, VecFx32 *pos2, BOOL *isSailPrompt, BOOL *a5, u32 *area);
    static BOOL Collide_Submarine(VecFx32 *pos0, VecFx32 *pos1, VecFx32 *pos2, BOOL *isSailPrompt, BOOL *a5, u32 *area);
    static BOOL Collide_Beach(VecFx32 *pos0, VecFx32 *pos1, VecFx32 *pos2, BOOL *isSailPrompt, BOOL *a5, u32 *area);

    static BOOL CheckExitArea_Base(VecFx32 *pos);
    static BOOL CheckExitArea_BaseNext(VecFx32 *pos);
    static BOOL CheckExitArea_Jet(VecFx32 *pos);
    static BOOL CheckExitArea_Boat(VecFx32 *pos);
    static BOOL CheckExitArea_Hover(VecFx32 *pos);
    static BOOL CheckExitArea_Submarine(VecFx32 *pos);
    static BOOL CheckExitArea_Beach(VecFx32 *pos);

    static void PlayerSpawnConfig_Base(VecFx32 *position, u16 *angle, s32 area);
    static void PlayerSpawnConfig_BaseNext(VecFx32 *position, u16 *angle, s32 area);
    static void PlayerSpawnConfig_Jet(VecFx32 *position, u16 *angle, s32 area);
    static void PlayerSpawnConfig_Boat(VecFx32 *position, u16 *angle, s32 area);
    static void PlayerSpawnConfig_Hover(VecFx32 *position, u16 *angle, s32 area);
    static void PlayerSpawnConfig_Submarine(VecFx32 *position, u16 *angle, s32 area);
    static void PlayerSpawnConfig_Beach(VecFx32 *position, u16 *angle, s32 area);

    static fx32 GetGroundPos_Common(VecFx32 *pos);
    static fx32 GetGroundPos_Submarine(VecFx32 *pos);

    static void DrawShadow_Common(CViShadow *work, fx32 scale, fx32 x, fx32 z);
    static void DrawShadow_Submarine(CViShadow *work, fx32 scale, fx32 x, fx32 z);

    static void ThreadFunc(void *arg);
};

#ifdef __cplusplus
extern "C"
{
#endif

void _ZN11CViDockBackC1Ev(CViDockBack *work);
void _ZN11CViDockBackD0Ev(CViDockBack *work);
void _ZN11CViDockBackD1Ev(CViDockBack *work);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIDOCKBACK_HPP