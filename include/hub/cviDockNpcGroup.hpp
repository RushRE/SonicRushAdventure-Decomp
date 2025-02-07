#ifndef RUSH_CVIDOCKNPCGROUP_HPP
#define RUSH_CVIDOCKNPCGROUP_HPP

#include <hub/cvi3dObject.hpp>
#include <hub/cviDockNpc.hpp>

// --------------------
// TYPES
// --------------------

typedef void (*DockNpcGroupFunc)(s32 param);

// --------------------
// STRUCTS
// --------------------

struct CViDockNpcGroupTalk
{
    u32 action;
};

class CViDockNpcGroup
{
public:
    CViDockNpcGroup();
    virtual ~CViDockNpcGroup();

    // --------------------
    // VARIABLES
    // --------------------

    u32 npcListSize;
    CViDockNpc *npcListStart;
    CViDockNpc *npcListEnd;
    CVi3dArrow viArrow;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void ClearNpcList();
    CViDockNpc *AddNpc();
    void RemoveNpc(CViDockNpc *npc);
    CViDockNpc *GetNextNpc(CViDockNpc *npc);

    void LoadAssets();
    void Animate();
    void Draw(s32 a2);
    CViDockNpc *Func_2168608(VecFx32 *a2, VecFx32 *a3, VecFx32 *a4, fx32 a5);
    CViDockNpc *Func_2168674(VecFx32 *a2, s32 a3, s32 a4, BOOL *a5, CViDockNpc *startNpc);

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static void RunAction(s32 id, s32 param);
    static u32 GetTalkAction(void);
    static u32 GetSelection(void);
    static void SetTalkAction(u32 value);
    static void SetSelection(s32 value);

    static void Func_2168764(s32 param);
    static void Func_2168798(s32 param);
    static void Func_216879C(s32 param);
};

#endif // RUSH_CVIDOCKNPCGROUP_HPP
