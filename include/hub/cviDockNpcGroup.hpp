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

struct CViDockNpcGroupEntry
{
    CViDockNpc npc;
    CViDockNpcGroupEntry *next;
    CViDockNpcGroupEntry *prev;
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
    CViDockNpcGroupEntry *npcListStart;
    CViDockNpcGroupEntry *npcListEnd;
    CVi3dArrow viArrow;

    // --------------------
    // MEMBER FUNCTIONS
    // --------------------

    void ClearNpcList();
    CViDockNpcGroupEntry *AddNpc();
    void RemoveNpc(CViDockNpcGroupEntry *npc);

    inline CViDockNpcGroupEntry *GetFirstNpc()
    {
        CViDockNpcGroupEntry *start = npcListStart;

        if (start == NULL)
            return NULL;

        return start;
    }

    CViDockNpcGroupEntry *GetNextNpc(CViDockNpcGroupEntry *npc);

    void LoadAssets();
    void Animate();
    void Draw(VecFx32 *position);
    CViDockNpcGroupEntry *Func_2168608(VecFx32 *a2, VecFx32 *a3, VecFx32 *a4, fx32 a5);
    CViDockNpcGroupEntry *Func_2168674(VecFx32 *a2, s32 a3, s32 a4, BOOL *a5, CViDockNpcGroupEntry *startNpc);
};

#endif // RUSH_CVIDOCKNPCGROUP_HPP
