#ifndef RUSH_CVIDOCKNPC_HPP
#define RUSH_CVIDOCKNPC_HPP

#include <hub/cvi3dObject.hpp>

// --------------------
// STRUCTS
// --------------------

class CViDockNpc : public CVi3dObject
{

public:
    // CViDockNpc();
    // virtual ~CViDockNpc();

    // --------------------
    // ENUMS
    // --------------------

    enum AnimIDs
    {
        ANI_IDLE,
        ANI_TALK, // Not all NPCs have this anim, but all NPCs that _do_ will have this one

        // Only used for blaze
        ANI_TAIL_IDLE,
        ANI_TAIL_TALK,
    };

    // --------------------
    // VARIABLES
    // --------------------

    s32 npcType;
    s32 field_304;
    s32 field_308;
    s32 field_30C;
    u16 initialAngle;
    u16 resConfigTableIndex;
    void *model;
    void *aniJoints;
    void *aniMaterial;
    void *aniVisibility;
    void *aniTexture;
    VecFx32 size;
    BOOL snapToAngle;
    CViDockNpc *next;
    CViDockNpc *prev;

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

NOT_DECOMPILED void _ZN10CViDockNpcC1Ev();
NOT_DECOMPILED void _ZN10CViDockNpcD0Ev();
NOT_DECOMPILED void _ZN10CViDockNpcD1Ev();

void ViDockNpc__LoadAssets(CViDockNpc *work, s32 type, VecFx32 *position, u16 angle, BOOL snapToAngle);
void ViDockNpc__ReleaseAssets(CViDockNpc *work);
void ViDockNpc__SetState1(CViDockNpc *work, u16 angle);
void ViDockNpc__SetState2(CViDockNpc *work);
BOOL ViDockNpc__Func_216710C(CViDockNpc *work, VecFx32 *a2, VecFx32 *a3, VecFx32 *a4, fx32 a5);
BOOL ViDockNpc__Func_2167244(CViDockNpc *work, VecFx32 *position, s32 a3, s32 a4, BOOL *flag);
BOOL ViDockNpc__Func_216737C(CViDockNpc *work, VecFx32 *position);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIDOCKNPC_HPP
