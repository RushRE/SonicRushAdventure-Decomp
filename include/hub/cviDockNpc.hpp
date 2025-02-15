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
    s32 talkActionType;
    s32 talkActionParam;
    s32 talkCount;
    u16 initialAngle;
    u16 type;
    void *model;
    void *aniJoints;
    void *aniMaterial;
    void *aniVisibility;
    void *aniTexture;
    VecFx32 size;
    BOOL snapToAngle;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void Init(s32 type, VecFx32 *position, u16 angle, BOOL snapToAngle);
    void Release();
    void SetAngleForTalking(u16 angle);
    void SetAngleForIdle();
    BOOL HandlePlayerSolidCollisions(VecFx32 *prevPlayerPos, VecFx32 *curPlayerPos, VecFx32 *newPlayerPos, fx32 scale);
    BOOL CheckPlayerInTalkRange(VecFx32 *playerPos, u16 playerAngle, fx32 scale, BOOL *canTalk);
    BOOL Allow3dArrow(VecFx32 *position);
};

// --------------------
// FUNCTIONS
// --------------------

#ifdef __cplusplus
extern "C"
{
#endif

NOT_DECOMPILED void _ZN10CViDockNpcC1Ev(CViDockNpc *work);
NOT_DECOMPILED void _ZN10CViDockNpcD0Ev(CViDockNpc *work);
NOT_DECOMPILED void _ZN10CViDockNpcD1Ev(CViDockNpc *work);

#ifdef __cplusplus
}
#endif

#endif // RUSH_CVIDOCKNPC_HPP
