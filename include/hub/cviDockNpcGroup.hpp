#ifndef RUSH2_CVIDOCKNPCGROUP_HPP
#define RUSH2_CVIDOCKNPCGROUP_HPP

#include <hub/vi3dArrow.hpp>
#include <hub/cviDockNpc.hpp>

// --------------------
// STRUCTS
// --------------------

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
    Vi3dArrow viArrow;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void ClearNpcList();
    void AddNpc();
    void RemoveNpc(CViDockNpc *npc);
    CViDockNpc *GetNextNpc(CViDockNpc *npc);

    void LoadAssets();
    void Func_216854C();
    void Func_2168590(s32 a2);
    CViDockNpc *Func_2168608(VecFx32 *a2, VecFx32 *a3, VecFx32 *a4, fx32 a5);
    CViDockNpc *Func_2168674(VecFx32 *a2, s32 a3, s32 a4, BOOL *a5, CViDockNpc *npc);

    // --------------------
    // STATIC FUNCTIONS
    // --------------------

    static s32 Func_21686F8(s32 id, s32 param);
    static u32 Func_2168724(void);
    static s32 Func_2168734(void);
    static void Func_2168744(u32 value);
    static void Func_2168754(s32 value);
    static void Func_2168764(void);
    static void Func_2168798(void);
    static void Func_216879C(u32 value);
};

#endif // RUSH2_CVIDOCKNPCGROUP_HPP
